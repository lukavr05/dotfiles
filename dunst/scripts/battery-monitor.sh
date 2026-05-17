#!/usr/bin/env bash
# Sends dunst notifications at 20% and 10% battery.
# Run once on login (e.g. via ~/.xinitrc or a systemd user service).

NOTIFIED_20=false
NOTIFIED_10=false

while true; do
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [[ "$STATUS" == "Charging" ]]; then
        NOTIFIED_20=false
        NOTIFIED_10=false
    fi

    if [[ "$BATTERY" -le 10 && "$NOTIFIED_10" == false ]]; then
        notify-send -a "battery-monitor" -u critical \
            "Battery Critical" "⚡ ${BATTERY}%"
        NOTIFIED_10=true
    elif [[ "$BATTERY" -le 20 && "$NOTIFIED_20" == false ]]; then
        notify-send -a "battery-monitor" -u normal \
            "Battery Low - ${BATTERY}% remaining."
        NOTIFIED_20=true
    fi

    sleep 60
done
