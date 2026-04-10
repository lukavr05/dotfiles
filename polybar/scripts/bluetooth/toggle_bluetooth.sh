#!/bin/bash

# Toggle Bluetooth with error handling and user feedback

# Get current bluetooth status
get_bluetooth_status() {
    bluetoothctl show 2>/dev/null | grep -q "Powered: yes"
    return $?
}

# Send notification via dunst
notify() {
    if command -v notify-send &>/dev/null && ! dunstctl is-paused 2>/dev/null; then
        notify-send -i bluetooth -t 2000 "$1" "$2"
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
        sleep 1
        connected=false
        for device in $(bluetoothctl devices Paired | cut -d' ' -f2); do
            if bluetoothctl connect "$device" >/dev/null 2>&1; then
                device_name=$(bluetoothctl devices Paired | grep "$device" | cut -d' ' -f3-)
                notify "Bluetooth" "Connected to $device_name"
                connected=true
                break
            fi
        done
        if ! $connected; then
            notify "Bluetooth" "Bluetooth turned on"
        fi
        exit 0
    else
        notify "Bluetooth Error" "Failed to turn on bluetooth"
        exit 1
    fi
fi
