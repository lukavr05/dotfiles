#!/usr/bin/env bash
# Run as a background loop from bspwmrc

INTERFACE="${1:-wlp0s20f3}"   # your interface from polybar config
PREV_STATE=""

while true; do
    if ip link show "$INTERFACE" | grep -q "state UP"; then
        SSID=$(iw dev "$INTERFACE" link 2>/dev/null | \
               awk '/SSID/{print $2}')
        STATE="connected:${SSID}"

        if [[ "$PREV_STATE" != "$STATE" && -n "$SSID" ]]; then
            notify-send -a "network" -t 4000 -u low \
                "Network" "󰤨 Connected to ${SSID}"
            PREV_STATE="$STATE"
        fi
    else
        STATE="disconnected"
        if [[ "$PREV_STATE" != "$STATE" && "$PREV_STATE" != "" ]]; then
            notify-send -a "network" -t 4000 -u normal \
                "Network" "󰤭 Disconnected"
            PREV_STATE="$STATE"
        fi
    fi

    sleep 2
done
