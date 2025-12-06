#!/bin/bash

count=$(apt-get -s upgrade | grep -P '^\d+ upgraded' | cut -d" " -f1)

echo "$count"
