#!/bin/bash

# Path to state file
STATE_FILE="/tmp/polybar_weather_state"

# Check which script to run based on state
if [ -f "$STATE_FILE" ]; then
    # Show forecast
    ~/.config/polybar/scripts/weather/weather-forecast.sh
else
    # Show current weather (default)
    ~/.config/polybar/scripts/weather/weather.sh
fi
