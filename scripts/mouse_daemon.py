#!/usr/bin/env python3
"""
Mouse movement daemon.
Monitors keyd virtual keyboard via xinput for F13-F16 press/release.
Moves mouse while key(s) held, supports simultaneous directions.
Start from i3: exec --no-startup-id python3 ~/dotfiles/scripts/mouse_daemon.py
"""
import os, re, subprocess, sys, threading, time

DISPLAY = ':0'
env = {**os.environ, 'DISPLAY': DISPLAY}

# X11 keycode = evdev keycode + 8
# F13=191 F14=192 F15=193 F16=194
DIRECTIONS = {
    191: (-1, 0),  # F13 left
    192: (0,  1),  # F14 down
    193: (0, -1),  # F15 up
    194: (1,  0),  # F16 right
}

SPEED_BASE = 2.0
SPEED_MAX  = 38.0
RAMP_TIME  = 0.4
TICK       = 0.016

TAP_THRESHOLD = 0.12   # seconds — shorter press = tap
TAP_PIXELS    = 3      # pixels moved on a tap

held = set()
lock = threading.Lock()
move_stop = None
move_thread = None
press_times = {}


def move_loop(stop):
    press_time = time.monotonic()
    while not stop.is_set():
        with lock:
            dirs = frozenset(held)
        if not dirs:
            break
        elapsed = time.monotonic() - press_time
        speed = SPEED_BASE + (SPEED_MAX - SPEED_BASE) * min(elapsed / RAMP_TIME, 1.0)
        dx = sum(DIRECTIONS[k][0] for k in dirs)
        dy = sum(DIRECTIONS[k][1] for k in dirs)
        px = round(dx * speed)
        py = round(dy * speed)
        if px != 0 or py != 0:
            subprocess.run(
                ['xdotool', 'mousemove_relative', '--', str(px), str(py)],
                env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )
        stop.wait(TICK)


def update_move():
    global move_stop, move_thread
    with lock:
        has_dirs = bool(held)
    if has_dirs:
        if move_thread is None or not move_thread.is_alive():
            move_stop = threading.Event()
            move_thread = threading.Thread(target=move_loop, args=(move_stop,), daemon=True)
            move_thread.start()
    else:
        if move_stop:
            move_stop.set()
        move_stop = None
        move_thread = None


def find_keyd_xinput_id():
    r = subprocess.run(['xinput', 'list'], capture_output=True, text=True, env=env)
    for line in r.stdout.splitlines():
        if 'keyd virtual keyboard' in line.lower():
            m = re.search(r'id=(\d+)', line)
            if m:
                return m.group(1)
    return None


def run(device_id):
    print(f'monitoring xinput device {device_id}', file=sys.stderr, flush=True)
    with lock:
        held.clear()
    proc = subprocess.Popen(
        ['xinput', 'test', device_id],
        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, env=env
    )
    release_timers = {}

    def delayed_stop(keycode):
        with lock:
            release_timers.pop(keycode, None)
            held.discard(keycode)
        update_move()

    for line in proc.stdout:
        m = re.match(r'key (press|release)\s+(\d+)', line.strip())
        if not m:
            continue
        action, keycode = m.group(1), int(m.group(2))
        if keycode not in DIRECTIONS:
            continue
        if action == 'press':
            with lock:
                if keycode in release_timers:
                    release_timers.pop(keycode).cancel()
                was_held = keycode in held
                held.add(keycode)
            press_times[keycode] = time.monotonic()
            if not was_held:
                update_move()
        elif action == 'release':
            elapsed = time.monotonic() - press_times.pop(keycode, 0)
            if elapsed < TAP_THRESHOLD:
                with lock:
                    if keycode in release_timers:
                        release_timers.pop(keycode).cancel()
                    held.discard(keycode)
                update_move()
                dx, dy = DIRECTIONS[keycode]
                subprocess.run(
                    ['xdotool', 'mousemove_relative', '--', str(dx * TAP_PIXELS), str(dy * TAP_PIXELS)],
                    env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
                )
            else:
                t = threading.Timer(0.05, delayed_stop, args=(keycode,))
                with lock:
                    release_timers[keycode] = t
                t.start()


print('daemon starting', file=sys.stderr, flush=True)

while True:
    device_id = find_keyd_xinput_id()
    if not device_id:
        print('keyd virtual keyboard not found, retrying...', file=sys.stderr, flush=True)
        time.sleep(2)
        continue
    try:
        run(device_id)
    except Exception as e:
        print(f'error: {e}, restarting...', file=sys.stderr, flush=True)
        time.sleep(1)
