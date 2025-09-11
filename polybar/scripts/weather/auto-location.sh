#!/bin/bash

# Auto location detection script

CITY_MANAGER="$HOME/.config/polybar/scripts/weather/city-manager.sh"

# Function to detect location based on network SSID (WiFi)
detect_by_wifi() {
    local current_ssid
    current_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    
    case "$current_ssid" in
        "Home_WiFi"|"MyHomeNetwork")
            bash "$CITY_MANAGER" set "Mossel Bay"
            echo "Location set to Home: Mossel Bay"
            ;;
        "Office_WiFi"|"CompanyNetwork")
            bash "$CITY_MANAGER" set "Cape Town"
            echo "Location set to Work: Cape Town"
            ;;
        "Hotel_WiFi"|"Guest")
            bash "$CITY_MANAGER" set "Johannesburg"
            echo "Location set to Travel: Johannesburg"
            ;;
        *)
            echo "Unknown network: $current_ssid - keeping current location"
            ;;
    esac
}

# Function to detect location based on IP geolocation
detect_by_ip() {
    local city_from_ip
    city_from_ip=$(curl -s "http://ipinfo.io/city" 2>/dev/null)
    
    if [[ -n "$city_from_ip" ]]; then
        case "$city_from_ip" in
            "Mossel Bay")
                bash "$CITY_MANAGER" set "Mossel Bay"
                echo "Location detected via IP: Mossel Bay"
                ;;
            "Cape Town")
                bash "$CITY_MANAGER" set "Cape Town"
                echo "Location detected via IP: Cape Town"
                ;;
            *)
                echo "Unknown city from IP: $city_from_ip"
                # Try to find city in config
                if bash "$CITY_MANAGER" list | grep -qi "$city_from_ip"; then
                    bash "$CITY_MANAGER" set "$city_from_ip"
                    echo "Location set to: $city_from_ip"
                fi
                ;;
        esac
    else
        echo "Could not detect location via IP"
    fi
}

# Function to detect based on timezone
detect_by_timezone() {
    local timezone
    timezone=$(timedatectl show --property=Timezone --value 2>/dev/null)
    
    case "$timezone" in
        "Africa/Johannesburg")
            # Could be anywhere in SA, try other methods
            return 1
            ;;
        "Europe/London")
            bash "$CITY_MANAGER" set "London"
            echo "Location set by timezone: London"
            ;;
        "America/New_York")
            bash "$CITY_MANAGER" set "New York"
            echo "Location set by timezone: New York"
            ;;
        *)
            echo "Unknown timezone: $timezone"
            return 1
            ;;
    esac
}

# Main detection logic
echo "Detecting current location..."

# Try WiFi detection first
if detect_by_wifi; then
    exit 0
fi

# If WiFi detection fails, try IP geolocation
if detect_by_ip; then
    exit 0
fi

# If IP detection fails, try timezone
if detect_by_timezone; then
    exit 0
fi

echo "Could not auto-detect location. Current setting:"
bash "$CITY_MANAGER" current
