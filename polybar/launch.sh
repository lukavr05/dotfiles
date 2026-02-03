#!/bin/bash

# Kill existing polybar instances
killall -q polybar

# Wait for processes to terminate
while pgrep -x polybar >/dev/null; do sleep 0.1; done



# Launch polybar
polybar top-bar &
