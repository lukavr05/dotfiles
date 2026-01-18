#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Configuration
API_KEY="8a9e98d41de585beb8405200c2b50dee"
UNITS="metric"
CONFIG_FILE="$HOME/.config/polybar/scripts/weather/cities.conf"
API_TIMEOUT=10
MAX_RETRIES=3

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
        "Clear") echo "" ;;
        "Clouds") echo "" ;;
        "Rain") echo "" ;;
        "Drizzle") echo "" ;;
        "Thunderstorm") echo "" ;;
        "Snow") echo "" ;;
        "Mist"|"Fog") echo "" ;;
        "Haze") echo "" ;;
        "Smoke") echo "" ;;
        "Dust"|"Sand") echo "" ;;
        "Squall") echo "" ;;
        "Tornado") echo "" ;;
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
    # Try to get current city from current_city file
    CURRENT_CITY_FILE="$HOME/.config/polybar/scripts/weather/current_city"
    if [[ -f "$CURRENT_CITY_FILE" ]]; then
        city_info=$(cat "$CURRENT_CITY_FILE")
        CITY_ID=$(echo "$city_info" | cut -d: -f1)
        DISPLAY_NAME=$(echo "$city_info" | cut -d: -f2)
    else
        # Use defaults if no current_city file exists
        CITY_ID="$DEFAULT_CITY_ID"
        DISPLAY_NAME="$DEFAULT_CITY_NAME"
    fi
fi

# Function to display extended weather report
show_extended_report() {
    local weather_data
    weather_data=$(curl -sf --max-time "$API_TIMEOUT" "http://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNITS")
    
    if [[ $? -eq 0 && -n "$weather_data" ]]; then
        local temp=$(echo "$weather_data" | jq -r '.main.temp' | cut -d "." -f 1)
        local feels_like=$(echo "$weather_data" | jq -r '.main.feels_like' | cut -d "." -f 1)
        local temp_min=$(echo "$weather_data" | jq -r '.main.temp_min' | cut -d "." -f 1)
        local temp_max=$(echo "$weather_data" | jq -r '.main.temp_max' | cut -d "." -f 1)
        local humidity=$(echo "$weather_data" | jq -r '.main.humidity')
        local pressure=$(echo "$weather_data" | jq -r '.main.pressure')
        local visibility=$(echo "$weather_data" | jq -r '.visibility // 0' | awk '{print $1/1000}')
        local wind_speed=$(echo "$weather_data" | jq -r '.wind.speed // 0')
        local wind_deg=$(echo "$weather_data" | jq -r '.wind.deg // 0')
        local desc=$(echo "$weather_data" | jq -r '.weather[0].main')
        local description=$(echo "$weather_data" | jq -r '.weather[0].description')
        local icon=$(get_weather_icon "$desc")
        
        echo "╔══════════════════════════════════════╗"
        echo "║     EXTENDED WEATHER REPORT          ║"
        echo "╚══════════════════════════════════════╝"
        echo ""
        echo "📍 Location: $DISPLAY_NAME"
        echo "🌤️  Weather: $description"
        echo "🌡️  Temperature: $temp°C (feels like $feels_like°C)"
        echo "📊 Range: $temp_min°C - $temp_max°C"
        echo "💧 Humidity: $humidity%"
        echo "🌪️  Wind: ${wind_speed}m/s from $(get_wind_direction $wind_deg)"
        echo "🔽 Pressure: $pressure hPa"
        echo "👁️  Visibility: ${visibility}km"
        echo ""
        echo "$(date '+%Y-%m-%d %H:%M:%S')"
    else
        echo "❌ Unable to fetch weather data"
        echo "Check your internet connection or try again later"
    fi
    exit 0
}

# Function to get wind direction
get_wind_direction() {
    local deg=$1
    if [[ -z "$deg" || "$deg" == "null" ]]; then
        echo "N/A"
        return
    fi
    
    # Normalize to 0-360
    deg=$((deg % 360))
    if [[ $deg -lt 0 ]]; then
        deg=$((deg + 360))
    fi
    
    if (( deg >= 337 && deg <= 360 )) || (( deg >= 0 && deg <= 22 )); then
        echo "N"
    elif (( deg >= 23 && deg <= 67 )); then
        echo "NE"
    elif (( deg >= 68 && deg <= 112 )); then
        echo "E"
    elif (( deg >= 113 && deg <= 157 )); then
        echo "SE"
    elif (( deg >= 158 && deg <= 202 )); then
        echo "S"
    elif (( deg >= 203 && deg <= 247 )); then
        echo "SW"
    elif (( deg >= 248 && deg <= 292 )); then
        echo "W"
    elif (( deg >= 293 && deg <= 336 )); then
        echo "NW"
    else
        echo "N"
    fi
}

# Check for extended report flag
if [[ "$1" == "--extended" ]]; then
    show_extended_report
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


