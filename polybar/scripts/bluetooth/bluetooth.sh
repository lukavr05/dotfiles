#!/bin/bash

# Cache settings
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/polybar"
CACHE_FILE="$CACHE_DIR/bluetooth_state"
CACHE_EXPIRY=5  # Cache state for 5 seconds

# Icons
BT_CONNECTED_ICON=""
BT_DISCONNECTED_ICON=""
BT_POWERED_OFF_ICON=""

# Create cache directory
mkdir -p "$CACHE_DIR"

# Check if cache is valid
check_cache() {
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_time
        if stat -c %Y "$CACHE_FILE" &>/dev/null; then
            cache_time=$(stat -c %Y "$CACHE_FILE")
        elif stat -f %m "$CACHE_FILE" &>/dev/null; then
            cache_time=$(stat -f %m "$CACHE_FILE")
        else
            return 1
        fi
        
        local current_time=$(date +%s)
        local cache_age=$((current_time - cache_time))
        
        if [[ $cache_age -lt $CACHE_EXPIRY ]]; then
            cat "$CACHE_FILE"
            return 0
        fi
    fi
    return 1
}

# Update cache
update_cache() {
    echo "$1" > "$CACHE_FILE"
}

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
            echo "%{F#2193ff}${BT_DISCONNECTED_ICON}"
        fi
    else
        echo "%{F#66ffffff}${BT_POWERED_OFF_ICON}"
    fi
}

# Main logic
if ! check_cache; then
    status=$(get_bluetooth_status)
    update_cache "$status"
    echo "$status"
fi
