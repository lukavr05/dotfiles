#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

API_KEY="8a9e98d41de585beb8405200c2b50dee"
CITY="973709" 
UNITS="metric"

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?id=$CITY&appid=$API_KEY&units=$UNITS")

if [ ! -z "$weather" ]; then
    temp=$(echo "$weather" | jq '.main.temp' | cut -d "." -f 1)
    desc=$(echo "$weather" | jq -r '.weather[0].main')
    
    case $desc in
        "Clear") icon="" ;;
        "Clouds") icon="" ;;
        "Rain") icon="" ;;
        "Drizzle") icon="" ;;
        "Thunderstorm") icon="" ;;
        "Snow") icon="" ;;
        "Mist"|"Fog") icon="" ;;
        "Haze") icon="" ;;
        "Smoke") icon="" ;;
        "Dust"|"Sand") icon="" ;;
        "Squall") icon="" ;;
        "Tornado") icon="" ;;
        *) icon="" ;;
    esac
    
    echo "Mossel Bay %{T2}$icon%{T-} $temp°C"
else
    echo "Weather Unavailable"
fi
