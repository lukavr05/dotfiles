#!/bin/bash

# Toggle Bluetooth with error handling and user feedback

# Get current bluetooth status
get_bluetooth_status() {
    bluetoothctl show 2>/dev/null | grep -q "Powered: yes"
    return $?
}

# Send notification
notify() {
    if command -v notify-send &>/dev/null; then
        notify-send -i "bluetooth" -t 2000 "$1" "$2"
    fi
}

# Main toggle logic
status_output=$(bluetoothctl show 2>/dev/null)

if [[ -z "$status_output" ]]; then
    notify "Bluetooth Error" "Could not get bluetooth status"
    exit 1
fi

if echo "$status_output" | grep -q "Powered: yes"; then
    # Turn off
    if bluetoothctl power off >/dev/null 2>&1; then
        notify "Bluetooth" "Bluetooth turned off"
        exit 0
    else
        notify "Bluetooth Error" "Failed to turn off bluetooth"
        exit 1
    fi
else
    # Turn on
    if bluetoothctl power on >/dev/null 2>&1; then
        notify "Bluetooth" "Bluetooth turned on"
        exit 0
    else
        notify "Bluetooth Error" "Failed to turn on bluetooth"
        exit 1
    fi
fi
