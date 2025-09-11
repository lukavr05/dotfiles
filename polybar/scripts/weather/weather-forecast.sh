#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

API_KEY="8a9e98d41de585beb8405200c2b50dee"
CITY="973709" 
UNITS="metric"

get_weather_icon() {
    local desc=$1
    case $desc in
        "Clear") echo "" ;;
        "Clouds") echo "" ;;
        "Rain") echo "" ;;
        "Drizzle") echo "" ;;
        "Thunderstorm") echo "" ;;
        "Snow") echo "" ;;
        "Mist"|"Fog") echo "" ;;
        "Haze") echo "" ;;
        "Smoke") echo "" ;;
        "Dust"|"Sand") echo "" ;;
        "Squall") echo "" ;;
        "Tornado") echo "" ;;
        *) echo "" ;;
    esac
}

# Get current weather
current_weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?id=$CITY&appid=$API_KEY&units=$UNITS")

# Get forecast data
forecast_data=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?id=$CITY&appid=$API_KEY&units=$UNITS")

if [ ! -z "$current_weather" ] && [ ! -z "$forecast_data" ]; then
    # Current weather
    current_temp=$(echo "$current_weather" | jq '.main.temp' | cut -d "." -f 1)
    current_desc=$(echo "$current_weather" | jq -r '.weather[0].main')
    current_icon=$(get_weather_icon "$current_desc")
    
    # Start building output with current weather
    output="Mossel Bay %{T2}$current_icon%{T-} ${current_temp}°C"
    
    # Get next 3 forecasts (skip first entry as it might be too close to current time)
    for i in 1 2 3; do
        forecast_time=$(echo "$forecast_data" | jq -r ".list[$i].dt_txt" | cut -d' ' -f2 | cut -d':' -f1-2)
        forecast_temp=$(echo "$forecast_data" | jq ".list[$i].main.temp" | cut -d "." -f 1)
        forecast_desc=$(echo "$forecast_data" | jq -r ".list[$i].weather[0].main")
        forecast_icon=$(get_weather_icon "$forecast_desc")
        
        output="$output | $forecast_time %{T2}$forecast_icon%{T-} ${forecast_temp}°C"
    done
    
    echo "$output"
else
    echo "Weather Forecast Unavailable"
fi
