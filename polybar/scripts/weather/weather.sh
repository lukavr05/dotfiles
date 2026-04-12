#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Configuration
API_KEY="${OPENWEATHER_API_KEY:-8a9e98d41de585beb8405200c2b50dee}"
UNITS="metric"
CONFIG_FILE="$HOME/.config/polybar/scripts/weather/cities.conf"
API_TIMEOUT=10

# Cache settings
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/polybar"
CACHE_FILE="$CACHE_DIR/weather"
CACHE_EXPIRY=900

# Default values
DEFAULT_CITY_NAME="Mossel Bay"
DEFAULT_CITY_ID="973709"

# Get city info from config
get_city_info() {
    local search_term="$1"
    local search_type="$2"
    
    if [[ ! -f "$CONFIG_FILE" ]]; then
        return 1
    fi
    
    while IFS=: read -r city_key city_id display_name; do
        [[ $city_key =~ ^#.*$ ]] && continue
        [[ -z "$city_key" ]] && continue
        
        if [[ "$search_type" == "name" ]]; then
            if [[ "${display_name,,}" == "${search_term,,}" ]]; then
                echo "$city_id:$display_name"
                return 0
            fi
        elif [[ "$search_type" == "id" ]]; then
            if [[ "$city_id" == "$search_term" ]]; then
                echo "$city_id:$display_name"
                return 0
            fi
        fi
    done < "$CONFIG_FILE"
    
    return 1
}

# Get weather icon
get_weather_icon() {
    local desc=$1
    case $desc in
        "Clear") echo "" ;;
        "Clouds") echo "" ;;
        "Rain") echo "" ;;
        "Drizzle") echo "" ;;
        "Thunderstorm") echo "" ;;
        "Snow") echo "" ;;
        "Mist"|"Fog"|"Haze"|"Smoke") echo "" ;;
        "Dust"|"Sand"|"Squall"|"Tornado") echo "" ;;
        *) echo "" ;;
    esac
}

# Check if cache is valid
check_cache() {
    if [[ -f "$CACHE_FILE" ]]; then
        local cache_time
        if stat -c %Y "$CACHE_FILE" &>/dev/null; then
            cache_time=$(stat -c %Y "$CACHE_FILE")
        elif stat -f %m "$CACHE_FILE" &>/dev/null; then
            cache_time=$(stat -f %m "$CACHE_FILE")
        else
            return 1
        fi
        
        local current_time=$(date +%s)
        local cache_age=$((current_time - cache_time))
        
        if [[ $cache_age -lt $CACHE_EXPIRY ]]; then
            cat "$CACHE_FILE"
            return 0
        fi
    fi
    return 1
}

# Update cache
update_cache() {
    mkdir -p "$CACHE_DIR"
    echo "$1" > "$CACHE_FILE"
}

# Determine city ID and display name
CITY_NAME=""
CITY_ID=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--city)
            CITY_NAME="$2"
            shift 2
            ;;
        -i|--id)
            CITY_ID="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [[ -n "$CITY_NAME" ]]; then
    city_info=$(get_city_info "$CITY_NAME" "name")
    if [[ $? -eq 0 ]]; then
        CITY_ID=$(echo "$city_info" | cut -d: -f1)
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        exit 1
    fi
elif [[ -n "$CITY_ID" ]]; then
    city_info=$(get_city_info "$CITY_ID" "id")
    if [[ $? -eq 0 ]]; then
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        DISPLAY_NAME="City"
    fi
else
    CURRENT_CITY_FILE="$HOME/.config/polybar/scripts/weather/current_city"
    if [[ -f "$CURRENT_CITY_FILE" ]]; then
        city_info=$(cat "$CURRENT_CITY_FILE")
        CITY_ID=$(echo "$city_info" | cut -d: -f1)
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        CITY_ID="$DEFAULT_CITY_ID"
        DISPLAY_NAME="$DEFAULT_CITY_NAME"
    fi
fi

# Main logic with caching
if ! check_cache; then
    weather=$(curl -sf --max-time "$API_TIMEOUT" "http://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNITS")
    
    if [[ -n "$weather" ]]; then
        temp=$(echo "$weather" | jq '.main.temp' | cut -d "." -f 1)
        desc=$(echo "$weather" | jq -r '.weather[0].main')
        icon=$(get_weather_icon "$desc")
        
        result="$DISPLAY_NAME %{T4}$icon%{T1} $temp°C"
        update_cache "$result"
        echo "$result"
    else
        result="$DISPLAY_NAME - N/A"
        update_cache "$result"
        echo "$result"
    fi
fi
