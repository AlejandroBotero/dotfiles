#!/bin/bash

if ! systemctl is-active --quiet bluetooth; then
    echo "󰂲 OFF"
    exit 0
fi

rfkill_state=$(cat /sys/class/bluetooth/hci0/rfkill*/state 2>/dev/null | head -1)
if [ "$rfkill_state" = "0" ]; then
    echo "󰂲 OFF"
    exit 0
fi

connected=$(timeout 2 bluetoothctl devices Connected 2>/dev/null | grep "^Device")
if [ -n "$connected" ]; then
    name=$(echo "$connected" | head -1 | cut -d' ' -f3-)
    echo "󰂱 $name"
else
    echo "󰂯 ON"
fi
