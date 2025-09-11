#!/bin/bash

# Path to state file
STATE_FILE="/tmp/polybar_weather_state"

# Get current city setting
CURRENT_CITY_FILE="/home/luka/.config/polybar/scripts/weather/current_city"
if [[ -f "$CURRENT_CITY_FILE" ]]; then
    city_info=$(cat "$CURRENT_CITY_FILE")
    city_id=$(echo "$city_info" | cut -d: -f1)
    CITY_ARGS="--id $city_id"
else
    CITY_ARGS=""
fi

# Check which script to run based on state
if [ -f "$STATE_FILE" ]; then
    # Show forecast
    ~/.config/polybar/scripts/weather/weather-forecast.sh $CITY_ARGS
else
    # Show current weather (default)
    ~/.config/polybar/scripts/weather/weather.sh $CITY_ARGS
fi
