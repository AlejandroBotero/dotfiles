#!/bin/bash

# Battery notification script for dotfiles

THRESHOLD=15
BATTERY_DEVICE="BAT0"
INTERVAL=60 # seconds

# Flag to prevent multiple notifications for the same event
NOTIFIED=false

while true; do
    # Get battery level and status using upower
    CHARGE=$(upower -i /org/freedesktop/UPower/devices/battery_${BATTERY_DEVICE} | grep percentage | awk '{print $2}' | tr -d '%')
    STATUS=$(upower -i /org/freedesktop/UPower/devices/battery_${BATTERY_DEVICE} | grep state | awk '{print $2}')

    if [ -z "$CHARGE" ]; then
        echo "Error: Could not get battery charge." >&2
        exit 1
    fi

    if [ "$CHARGE" -le "$THRESHOLD" ] && [ "$STATUS" = "discharging" ]; then
        if [ "$NOTIFIED" = false ]; then
            notify-send -u critical "Battery Low" "Battery charge is at ${CHARGE}%"
            NOTIFIED=true
        fi
    elif [ "$STATUS" = "charging" ] || [ "$CHARGE" -gt "$THRESHOLD" ]; then
        # Reset notification flag if charging or above threshold
        NOTIFIED=false
    fi

    sleep $INTERVAL
done
