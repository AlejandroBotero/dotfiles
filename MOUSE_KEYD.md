# Mouse movement via keyd — session notes

**Goal:** map keys in keyd's `[mousemode]` layer to move mouse cursor, with hold-to-repeat.

---

## Problems solved along the way

1. **keyd runs as root** → no `DISPLAY` env → xdotool can't find X server. Fixed: `DISPLAY=:0`.
2. **X auth cookie** → root still rejected. Fixed: installed `xorg-xhost`, added `xhost +local:` to i3 startup.
3. **keyd `command()` fires only on keydown, never on key repeat** → hold does nothing. Required architecture change.

---

## Files created

**`~/dotfiles/scripts/mouse_move.sh`**
Background loop approach (intermediate). Each direction key kills previous loop, starts new one. Used while we still thought `command()` could solve it.

**`~/dotfiles/scripts/mouse_daemon.py`**
Python daemon for true hold-to-move. Instead of using `command()` in keyd, maps movement keys to F13-F16 (which keyd forwards to the virtual keyboard). Daemon monitors the keyd virtual keyboard via `xinput test`, detects press/release, moves mouse in a thread while held. Started by i3 at login.

---

## Files modified

| File | Change |
|------|--------|
| `keyd5layer.conf` | Added `u/k/l/semicolon = f13/f14/f15/f16` in `[mousemode]` |
| `i3.config` | Added `xhost +local:` and `exec mouse_daemon.py` at startup |

---

## Status

Still in progress: confirming correct X11 keycodes for F13-F16 — daemon prints every keycode so we can verify/fix the mapping.
