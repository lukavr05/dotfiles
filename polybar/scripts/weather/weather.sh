#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Configuration
API_KEY="8a9e98d41de585beb8405200c2b50dee"
UNITS="metric"
CONFIG_FILE="$HOME/.config/polybar/scripts/weather/cities.conf"

# Default values
DEFAULT_CITY_NAME="Mossel Bay"
DEFAULT_CITY_ID="973709"

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --city CITY_NAME    Set city by name from config file"
    echo "  -i, --id CITY_ID        Set city by ID directly"
    echo "  -l, --list              List available cities from config"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --city \"Cape Town\""
    echo "  $0 --id 3369157"
    echo "  $0 --list"
}

# Function to list available cities
list_cities() {
    if [[ -f "$CONFIG_FILE" ]]; then
        echo "Available cities:"
        echo "=================="
        while IFS=: read -r city_key city_id display_name; do
            # Skip comments and empty lines
            [[ $city_key =~ ^#.*$ ]] && continue
            [[ -z "$city_key" ]] && continue
            printf "%-20s (ID: %s)\n" "$display_name" "$city_id"
        done < "$CONFIG_FILE"
    else
        echo "Config file not found: $CONFIG_FILE"
        exit 1
    fi
}

# Function to get city info from config
get_city_info() {
    local search_term="$1"
    local search_type="$2"  # "name" or "id"
    
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Config file not found: $CONFIG_FILE" >&2
        return 1
    fi
    
    while IFS=: read -r city_key city_id display_name; do
        # Skip comments and empty lines
        [[ $city_key =~ ^#.*$ ]] && continue
        [[ -z "$city_key" ]] && continue
        
        if [[ "$search_type" == "name" ]]; then
            # Case-insensitive comparison for display name
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

# Function to get weather icon
get_weather_icon() {
    local desc=$1
    case $desc in
        "Clear") echo "" ;;
        "Clouds") echo "" ;;
        "Rain") echo "" ;;
        "Drizzle") echo "" ;;
        "Thunderstorm") echo "" ;;
        "Snow") echo "" ;;
        "Mist"|"Fog") echo "" ;;
        "Haze") echo "" ;;
        "Smoke") echo "" ;;
        "Dust"|"Sand") echo "" ;;
        "Squall") echo "" ;;
        "Tornado") echo "" ;;
        *) echo "" ;;
    esac
}

# Parse command line arguments
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
        -l|--list)
            list_cities
            exit 0
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Determine city ID and display name
if [[ -n "$CITY_NAME" ]]; then
    # Get city info by name
    city_info=$(get_city_info "$CITY_NAME" "name")
    if [[ $? -eq 0 ]]; then
        CITY_ID=$(echo "$city_info" | cut -d: -f1)
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        echo "City '$CITY_NAME' not found in config file. Use --list to see available cities."
        exit 1
    fi
elif [[ -n "$CITY_ID" ]]; then
    # Get city info by ID
    city_info=$(get_city_info "$CITY_ID" "id")
    if [[ $? -eq 0 ]]; then
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        # If ID not in config, use it anyway but with generic display name
        DISPLAY_NAME="City (ID: $CITY_ID)"
    fi
else
    # Use defaults
    CITY_ID="$DEFAULT_CITY_ID"
    DISPLAY_NAME="$DEFAULT_CITY_NAME"
fi

# Get weather data
weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNITS")

if [ ! -z "$weather" ]; then
    temp=$(echo "$weather" | jq '.main.temp' | cut -d "." -f 1)
    desc=$(echo "$weather" | jq -r '.weather[0].main')
    icon=$(get_weather_icon "$desc")
    
    echo "$DISPLAY_NAME %{T2}$icon%{T-} $temp°C"
else
    echo "$DISPLAY_NAME - Weather Unavailable"
fi
