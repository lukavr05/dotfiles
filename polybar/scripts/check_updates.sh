#!/bin/bash

# Check for available updates
count=$(apt-get -s upgrade 2>/dev/null | grep -P '^\d+ upgraded' | cut -d" " -f1)

# If count is empty or 0, show 0
if [ -z "$count" ] || [ "$count" -eq 0 ]; then
    echo "0"
else
    echo "$count"
fi
