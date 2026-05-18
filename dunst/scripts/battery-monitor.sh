#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT0"

[[ ! -d "$BATTERY_PATH" ]] && exit 0

NOTIFIED_LOW=false
NOTIFIED_CRITICAL=false
NOTIFIED_CHARGED=false
NOTIFIED_CHARGING=false

get_time_estimate() {
    local mode="$1"    # "charging" or "discharging"

    local energy_now energy_full power_now
    energy_now=$(< "$BATTERY_PATH/energy_now")
    energy_full=$(< "$BATTERY_PATH/energy_full")
    power_now=$(< "$BATTERY_PATH/power_now")

    # Guard against zero power_now — happens briefly right after plug/unplug
    # while the hardware hasn't settled on a stable charge rate yet
    if [[ -z "$power_now" || "$power_now" -eq 0 ]]; then
        echo "Calculating..."
        return
    fi

    local remaining
    if [[ "$mode" == "charging" ]]; then
        remaining=$(( energy_full - energy_now ))
    else
        remaining=$energy_now
    fi

    # Both values are µWh and µW, so dividing gives hours
    # Multiply by 3600 first to get seconds, avoids losing precision in integer division
    local total_seconds=$(( (remaining * 3600) / power_now ))
    local hrs=$(( total_seconds / 3600 ))
    local min=$(( (total_seconds % 3600) / 60 ))

    if [[ $hrs -gt 0 ]]; then
        echo "${hrs}hr ${min}min"
    else
        echo "${min}min"
    fi
}

PREV_STATUS=""

while true; do
    CAPACITY=$(< "$BATTERY_PATH/capacity")
    STATUS=$(< "$BATTERY_PATH/status")

    case "$STATUS" in
        Charging)
            # Fire once per plug-in event
            if [[ "$NOTIFIED_CHARGING" == false ]]; then
                TIME=$(get_time_estimate "charging")
                notify-send -a "battery-monitor" -u low \
                    "Battery Charging" \
                    "󰂄 ${CAPACITY}% · ${TIME} until full"
                NOTIFIED_CHARGING=true
            fi

            # Reset discharge notifications for next unplug
            NOTIFIED_LOW=false
            NOTIFIED_CRITICAL=false
            NOTIFIED_CHARGED=false
            ;;

        Full)
            if [[ "$NOTIFIED_CHARGED" == false ]]; then
                notify-send -a "battery-monitor" -u low \
                    "Battery Full" "󰁹 Fully charged"
                NOTIFIED_CHARGED=true
                NOTIFIED_CHARGING=false
            fi
            ;;

        Discharging|"Not charging")
            # Reset charging flag so next plug-in fires again
            NOTIFIED_CHARGING=false

            if [[ "$CAPACITY" -le 10 && "$NOTIFIED_CRITICAL" == false ]]; then
                notify-send -a "battery-monitor" -u critical \
                    "Battery Critical" "󰂃 ${CAPACITY}% — plug in now"
                NOTIFIED_CRITICAL=true
                NOTIFIED_LOW=true
            elif [[ "$CAPACITY" -le 20 && "$NOTIFIED_LOW" == false ]]; then
                TIME=$(get_time_estimate "discharging")
                notify-send -a "battery-monitor" -u normal \
                    "Battery Low" "󰁻 ${CAPACITY}% · ${TIME} remaining"
                NOTIFIED_LOW=true
            fi
            ;;
    esac

    PREV_STATUS="$STATUS"
    sleep 10    # shorter interval so plug/unplug is detected promptly
done
