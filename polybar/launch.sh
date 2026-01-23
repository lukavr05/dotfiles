#!/bin/bash

# Kill existing polybar instances
killall -q polybar

# Wait for processes to terminate
while pgrep -x polybar >/dev/null; do sleep 0.1; done

# Pre-populate caches to avoid delays on startup
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/polybar"
mkdir -p "$CACHE_DIR"

# Pre-cache weather data
"$HOME/.config/polybar/scripts/weather/weather.sh" >/dev/null 2>&1 &
WEATHER_PID=$!

# Pre-cache update count
"$HOME/.config/polybar/scripts/check_updates.sh" >/dev/null 2>&1 &
UPDATES_PID=$!

# Wait for all pre-caching to complete (with timeout)
wait_timeout=5
elapsed=0
for pid in $WEATHER_PID $UPDATES_PID; do
    if ps -p $pid >/dev/null 2>&1; then
        while ps -p $pid >/dev/null 2>&1 && [ $elapsed -lt $wait_timeout ]; do
            sleep 0.5
            elapsed=$((elapsed + 1))
        done
        if ps -p $pid >/dev/null 2>&1; then
            kill $pid >/dev/null 2>&1
        fi
    fi
done

# Launch polybar
polybar &
