#!/bin/bash

# Path to state file
STATE_FILE="/tmp/polybar_weather_state"

# Check current state
if [ -f "$STATE_FILE" ] then
    # Currently showing forecast, switch to current weather
    rm "$STATE_FILE"
    ~/.config/polybar/scripts/weather/weather.sh
else
    # Currently showing current weather, switch to forecast
    touch "$STATE_FILE"
    ~/.config/polybar/scripts/weather/weather-forecast.sh
fi
