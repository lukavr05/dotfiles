#!/bin/bash

# Icons
BT_CONNECTED_ICON=""
BT_DISCONNECTED_ICON=""
BT_POWERED_OFF_ICON=""

# Get bluetooth status
get_bluetooth_status() {
    local status_output
    status_output=$(bluetoothctl show 2>/dev/null) || {
        echo "%{F#ff5555}${BT_POWERED_OFF_ICON}"
        return 1
    }
    
    if echo "$status_output" | grep -q "Powered: yes"; then
        # Check for connected devices
        local device_info
        device_info=$(bluetoothctl devices Connected 2>/dev/null | head -1)
        
        if [[ -n "$device_info" ]]; then
            # Extract device name efficiently
            local device_name="${device_info##* }"
            
            # Truncate long device names
            if [[ ${#device_name} -gt 15 ]]; then
                device_name="${device_name:0:12}..."
            fi
            
            echo "%{F#2193ff}${BT_CONNECTED_ICON} $device_name"
        else
            echo "%{F#2193ff}${BT_DISCONNECTED_ICON} N/A"
        fi
    else
        echo "%{F#66ffffff}${BT_POWERED_OFF_ICON} OFF"
    fi
}

# Main logic
get_bluetooth_status
