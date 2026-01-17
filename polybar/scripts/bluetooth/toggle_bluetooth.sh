#!/bin/bash

status_output=$(bluetoothctl show 2>/dev/null) || exit 1

if echo "$status_output" | grep -q "Powered: yes"; then
    bluetoothctl power off >/dev/null 2>&1
else
    bluetoothctl power on >/dev/null 2>&1
fi
