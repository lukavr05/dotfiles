#!/bin/bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/polybar"
CACHE_FILE="$CACHE_DIR/updates"
CACHE_EXPIRY=300

mkdir -p "$CACHE_DIR"

check_cache() {
    [[ -f "$CACHE_FILE" ]] || return 1
    local cache_time current_time cache_age
    cache_time=$(stat -c %Y "$CACHE_FILE" 2>/dev/null) || return 1
    current_time=$(date +%s)
    cache_age=$(( current_time - cache_time ))
    [[ $cache_age -lt $CACHE_EXPIRY ]] || return 1
    cat "$CACHE_FILE"
}

get_updates() {
    if command -v apt-get &>/dev/null; then
        if command -v /usr/lib/update-notifier/apt-check &>/dev/null; then
            /usr/lib/update-notifier/apt-check 2>&1 | cut -d';' -f1
        else
            apt list --upgradable 2>/dev/null | grep -vc "^Listing"
        fi
    elif command -v checkupdates &>/dev/null; then
        checkupdates 2>/dev/null | wc -l
    elif command -v dnf &>/dev/null; then
        dnf check-update --quiet 2>/dev/null | grep -cE '^[a-zA-Z]'
    elif command -v pacman &>/dev/null; then
        pacman -Qu 2>/dev/null | wc -l
    else
        echo "?"
    fi
}

if check_cache; then
    exit 0
fi

count=$(get_updates)
echo "$count" > "$CACHE_FILE"
echo "$count"
