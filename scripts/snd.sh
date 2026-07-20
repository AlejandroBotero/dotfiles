#!/bin/bash
SOUNDS_DIR="/usr/share/sounds/freedesktop/stereo"

declare -A SOUNDS=(
    [login]="service-login.oga"
    [error]="dialog-error.oga"
    [complete]="complete.oga"
    [cd]="audio-volume-change.oga"
    [nvim-open]="device-added.oga"
    [insert-enter]="message-new-instant.oga"
    [insert-leave]="bell.oga"
    [visual]="window-attention.oga"
    [save]="camera-shutter.oga"
    [nvim-close]="device-removed.oga"
)

event="${1:-login}"
file="${SOUNDS[$event]}"

[[ -n "$file" ]] && paplay "$SOUNDS_DIR/$file" &>/dev/null &
