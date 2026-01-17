#!/bin/bash

BT_CONNECTED_ICON=""
BT_DISCONNECTED_ICON=""
BT_POWERED_OFF_ICON=""

# Get current Bluetooth status
status_output=$(bluetoothctl show 2>/dev/null) || { echo "%{F#ff5555}${BT_POWERED_OFF_ICON}"; exit 1; }

if echo "$status_output" | grep -q "Powered: yes"; then
    # Check for connected devices
    device_info=$(bluetoothctl devices Connected 2>/dev/null | head -1)
    
    if [[ -n "$device_info" ]]; then
        # Extract device name
        device_name=$(echo "$device_info" | sed 's/.* //')
        # Truncate long device names
        if [[ ${#device_name} -gt 15 ]]; then
            device_name="${device_name:0:12}..."
        fi
        echo "%{F#2193ff}${BT_CONNECTED_ICON} $device_name"
    else
        echo "%{F#2193ff}${BT_DISCONNECTED_ICON}"
    fi
else
    echo "%{F#66ffffff}${BT_POWERED_OFF_ICON}"
fi

