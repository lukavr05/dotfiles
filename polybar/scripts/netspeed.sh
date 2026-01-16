#!/bin/bash

# Get network interface (you can change this if needed)
INTERFACE="wlp0s20f3"

# Get network stats
RX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Read previous values from temp file
TEMP_FILE="/tmp/netspeed_stats"
if [ -f "$TEMP_FILE" ]; then
    PREV_RX=$(cat "$TEMP_FILE" | head -n1)
    PREV_TX=$(cat "$TEMP_FILE" | tail -n1)
else
    PREV_RX=$RX_BYTES
    PREV_TX=$TX_BYTES
fi

# Calculate differences (bytes per second)
RX_DIFF=$((RX_BYTES - PREV_RX))
TX_DIFF=$((TX_BYTES - PREV_TX))

# Convert to human readable format
human_readable() {
    local bytes=$1
    if [ $bytes -lt 1024 ]; then
        echo "${bytes}B"
    elif [ $bytes -lt 1048576 ]; then
        echo "$((bytes / 1024))K"
    elif [ $bytes -lt 1073741824 ]; then
        echo "$((bytes / 1048576))M"
    else
        echo "$((bytes / 1073741824))G"
    fi
}

DOWN_SPEED=$(human_readable $RX_DIFF)
UP_SPEED=$(human_readable $TX_DIFF)

# Output with orange arrows (using ANSI color code for orange)
echo -e "\e[38;5;208m↑\e[0m $UP_SPEED \e[38;5;208m↓\e[0m $DOWN_SPEED"

# Save current stats for next iteration
echo "$RX_BYTES" > "$TEMP_FILE"
echo "$TX_BYTES" >> "$TEMP_FILE"