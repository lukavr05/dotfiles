#!/bin/sh

if ! bluetoothctl show | grep -q "Powered: yes"; then
  # Bluetooth is off
  echo "%{F#66ffffff}"
else
  # Check if any device is connected
  device=$(bluetoothctl info | grep "Name" | awk -F 'Name: ' '{print $2}')

  if [ -z "$device" ]; then
    # Bluetooth on but no device connected
    echo "%{F#2193ff}"
  else
    # Device connected: show name + icon
    echo "%{F#2193ff} $device"
  fi
fi

