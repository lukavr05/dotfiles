#!/bin/bash

# Cache file to store update count
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/polybar"
CACHE_FILE="$CACHE_DIR/updates"
CACHE_EXPIRY=300  # 5 minutes in seconds

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Check if cache is valid
check_cache() {
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_time=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE" 2>/dev/null)
        local current_time=$(date +%s)
        local cache_age=$((current_time - cache_time))
        
        if [[ $cache_age -lt $CACHE_EXPIRY ]]; then
            cat "$CACHE_FILE"
            return 0
        fi
    fi
    return 2
}

# Update cache
update_cache() {
    local count="$1"
    echo "$count" > "$CACHE_FILE"
}

# Detect package manager and get update count
get_updates() {
    local count=0
    
    # Try nala (Debian/Ubuntu)
    if command -v nala &>/dev/null; then
        nala fetch --auto 2>/dev/null || true
        count=$(nala list --upgradable 2>/dev/null | grep -cE '^\S' || echo "0")

    # Try apt (Debian/Ubuntu)
    elif command -v apt-get &>/dev/null; then
        apt-get update -qq &>/dev/null || true
        local updates=$(apt-get upgrade -s 2>/dev/null | grep -oP '^\d+ upgraded' | cut -d" " -f1)
        count="${updates:-0}"
    
    # Try pacman (Arch Linux)
    elif command -v checkupdates &>/dev/null; then
        count=$(checkupdates 2>/dev/null | wc -l)
    
    # Try dnf (Fedora)
    elif command -v dnf &>/dev/null; then
        count=$(dnf check-update --quiet 2>/dev/null | grep -v "^$" | grep -v "Last metadata" | wc -l)
    
    # Try zypper (openSUSE)
    elif command -v zypper &>/dev/null; then
        count=$(zypper list-updates 2>/dev/null | tail -n +4 | wc -l)
    
    # Try pacman (Arch) with pacman -Qu
    elif command -v pacman &>/dev/null; then
        count=$(pacman -Qu 2>/dev/null | wc -l)
    
    else
        echo "Unknown package manager"
        return 1
    fi
    
    # Ensure count is a valid number
    count=$(echo "$count" | grep -oE '^[0-9]+$' || echo "0")
    echo "$count"
}

# Main logic - if cache is valid, check_cache already outputs the value; otherwise fetch new updates
if check_cache; then
    exit 0
fi

count=$(get_updates)
update_cache "$count"
echo "$count"
