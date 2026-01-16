#!/bin/bash

# Smooth brightness transition script
# Usage: smooth-brightness.sh up|down [percentage] [steps]

OPERATION=$1
TOTAL_CHANGE=${2:-10}  # Default 10% total change
STEPS=${3:-20}          # Default 20 steps for smooth transition
DELAY=${4:-0.05}        # Default 50ms delay between steps

if [[ "$OPERATION" != "up" && "$OPERATION" != "down" ]]; then
    echo "Usage: $0 up|down [percentage] [steps] [delay]"
    exit 1
fi

# Calculate step size
STEP_SIZE=$(echo "scale=2; $TOTAL_CHANGE / $STEPS" | bc)

# Perform smooth transition
for ((i=1; i<=STEPS; i++)); do
    if [[ "$OPERATION" == "up" ]]; then
        brightnessctl set +${STEP_SIZE}% 2>/dev/null
    else
        brightnessctl set ${STEP_SIZE}%- 2>/dev/null
    fi
    sleep "$DELAY"
done