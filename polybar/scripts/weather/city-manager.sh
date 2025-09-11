#!/bin/bash

# Configuration
CONFIG_FILE="$HOME/.config/polybar/scripts/weather/cities.conf"
CURRENT_CITY_FILE="$HOME/.config/polybar/scripts/weather/current_city"

# Function to show usage
show_usage() {
    echo "City Manager for Polybar Weather"
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  list                    List all available cities"
    echo "  set CITY_NAME           Set current city by name"
    echo "  set-id CITY_ID          Set current city by ID"
    echo "  current                 Show current city setting"
    echo "  add NAME ID DISPLAY     Add a new city to config"
    echo "  remove CITY_NAME        Remove city from config"
    echo "  search TERM             Search for cities containing term"
    echo "  test CITY_NAME          Test weather fetch for a city"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 set \"Cape Town\""
    echo "  $0 set-id 3369157"
    echo "  $0 current"
    echo "  $0 add STELLENBOSCH 3361934 \"Stellenbosch\""
    echo "  $0 remove \"Cape Town\""
    echo "  $0 search cape"
    echo "  $0 test \"Cape Town\""
}

# Function to create config file if it doesn't exist
create_config_if_missing() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Creating config file at: $CONFIG_FILE"
        mkdir -p "$(dirname "$CONFIG_FILE")"
        cat > "$CONFIG_FILE" << 'EOF'
# Weather Cities Configuration
# Format: CITY_NAME:CITY_ID:DISPLAY_NAME
# You can find city IDs at: http://bulk.openweathermap.org/sample/city.list.json.gz

# South African Cities
MOSSEL_BAY:973709:Mossel Bay
CAPE_TOWN:3369157:Cape Town
JOHANNESBURG:993800:Johannesburg
DURBAN:1007311:Durban
PRETORIA:964137:Pretoria
PORT_ELIZABETH:964712:Port Elizabeth
BLOEMFONTEIN:1018683:Bloemfontein
PIETERMARITZBURG:962367:Pietermaritzburg

# International Cities (examples)
LONDON:2643743:London
NEW_YORK:5128581:New York
PARIS:2988507:Paris
TOKYO:1850147:Tokyo
SYDNEY:2147714:Sydney
EOF
    fi
}

# Function to list all cities
list_cities() {
    create_config_if_missing
    echo "Available cities:"
    echo "=================="
    local count=0
    while IFS=: read -r city_key city_id display_name; do
        # Skip comments and empty lines
        [[ $city_key =~ ^#.*$ ]] && continue
        [[ -z "$city_key" ]] && continue
        printf "%-3d. %-20s (ID: %s)\n" $((++count)) "$display_name" "$city_id"
    done < "$CONFIG_FILE"
}

# Function to search cities
search_cities() {
    local search_term="$1"
    create_config_if_missing
    echo "Cities matching '$search_term':"
    echo "==============================="
    local found=false
    while IFS=: read -r city_key city_id display_name; do
        # Skip comments and empty lines
        [[ $city_key =~ ^#.*$ ]] && continue
        [[ -z "$city_key" ]] && continue
        
        # Case-insensitive search in display name
        if [[ "${display_name,,}" == *"${search_term,,}"* ]]; then
            printf "%-20s (ID: %s)\n" "$display_name" "$city_id"
            found=true
        fi
    done < "$CONFIG_FILE"
    
    if [[ "$found" == "false" ]]; then
        echo "No cities found matching '$search_term'"
    fi
}

# Function to get city info
get_city_info() {
    local search_term="$1"
    local search_type="$2"  # "name" or "id"
    
    while IFS=: read -r city_key city_id display_name; do
        # Skip comments and empty lines
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

# Function to set current city
set_current_city() {
    local city_name="$1"
    create_config_if_missing
    
    city_info=$(get_city_info "$city_name" "name")
    if [[ $? -eq 0 ]]; then
        city_id=$(echo "$city_info" | cut -d: -f1)
        display_name=$(echo "$city_info" | cut -d: -f2)
        
        # Create current city file
        mkdir -p "$(dirname "$CURRENT_CITY_FILE")"
        echo "$city_id:$display_name" > "$CURRENT_CITY_FILE"
        
        echo "Current city set to: $display_name (ID: $city_id)"
        
        # Update smart-weather.sh to use current city
        update_smart_weather_script
    else
        echo "Error: City '$city_name' not found in config file."
        echo "Use '$0 list' to see available cities or '$0 add' to add a new city."
        exit 1
    fi
}

# Function to set current city by ID
set_current_city_by_id() {
    local city_id="$1"
    create_config_if_missing
    
    city_info=$(get_city_info "$city_id" "id")
    if [[ $? -eq 0 ]]; then
        display_name=$(echo "$city_info" | cut -d: -f2)
        
        # Create current city file
        mkdir -p "$(dirname "$CURRENT_CITY_FILE")"
        echo "$city_id:$display_name" > "$CURRENT_CITY_FILE"
        
        echo "Current city set to: $display_name (ID: $city_id)"
        
        # Update smart-weather.sh to use current city
        update_smart_weather_script
    else
        echo "Error: City with ID '$city_id' not found in config file."
        exit 1
    fi
}

# Function to show current city
show_current_city() {
    if [[ -f "$CURRENT_CITY_FILE" ]]; then
        city_info=$(cat "$CURRENT_CITY_FILE")
        city_id=$(echo "$city_info" | cut -d: -f1)
        display_name=$(echo "$city_info" | cut -d: -f2)
        echo "Current city: $display_name (ID: $city_id)"
    else
        echo "No current city set. Using default: Mossel Bay"
    fi
}

# Function to add new city
add_city() {
    local city_key="$1"
    local city_id="$2"
    local display_name="$3"
    
    if [[ -z "$city_key" ]] || [[ -z "$city_id" ]] || [[ -z "$display_name" ]]; then
        echo "Error: All parameters required for add command"
        echo "Usage: $0 add CITY_KEY CITY_ID \"Display Name\""
        exit 1
    fi
    
    create_config_if_missing
    
    # Check if city already exists
    if get_city_info "$display_name" "name" > /dev/null; then
        echo "Error: City '$display_name' already exists in config"
        exit 1
    fi
    
    # Add to config file
    echo "$city_key:$city_id:$display_name" >> "$CONFIG_FILE"
    echo "Added city: $display_name (ID: $city_id)"
}

# Function to remove city
remove_city() {
    local city_name="$1"
    create_config_if_missing
    
    if ! get_city_info "$city_name" "name" > /dev/null; then
        echo "Error: City '$city_name' not found in config"
        exit 1
    fi
    
    # Create temporary file without the city to remove
    temp_file=$(mktemp)
    while IFS=: read -r city_key city_id display_name; do
        if [[ "${display_name,,}" != "${city_name,,}" ]]; then
            echo "$city_key:$city_id:$display_name" >> "$temp_file"
        fi
    done < "$CONFIG_FILE"
    
    mv "$temp_file" "$CONFIG_FILE"
    echo "Removed city: $city_name"
}

# Function to test weather fetch
test_city() {
    local city_name="$1"
    create_config_if_missing
    
    city_info=$(get_city_info "$city_name" "name")
    if [[ $? -eq 0 ]]; then
        city_id=$(echo "$city_info" | cut -d: -f1)
        display_name=$(echo "$city_info" | cut -d: -f2)
        
        echo "Testing weather fetch for: $display_name (ID: $city_id)"
        
        # Get script directory
        script_dir="$(dirname "$CONFIG_FILE")"
        
        # Test current weather
        echo "Current weather:"
        "$script_dir/weather.sh" --id "$city_id"
        echo ""
        
        # Test forecast
        echo "Weather forecast:"
        "$script_dir/weather-forecast.sh" --id "$city_id"
    else
        echo "Error: City '$city_name' not found in config file."
        exit 1
    fi
}

# Function to update smart-weather.sh script to use current city
update_smart_weather_script() {
    local smart_weather_script="$(dirname "$CONFIG_FILE")/smart-weather.sh"
    
    if [[ -f "$CURRENT_CITY_FILE" ]] && [[ -f "$smart_weather_script" ]]; then
        city_info=$(cat "$CURRENT_CITY_FILE")
        city_id=$(echo "$city_info" | cut -d: -f1)
        
        # Create updated smart-weather script
        cat > "$smart_weather_script" << EOF
#!/bin/bash

# Path to state file
STATE_FILE="/tmp/polybar_weather_state"

# Get current city setting
CURRENT_CITY_FILE="$CURRENT_CITY_FILE"
if [[ -f "\$CURRENT_CITY_FILE" ]]; then
    city_info=\$(cat "\$CURRENT_CITY_FILE")
    city_id=\$(echo "\$city_info" | cut -d: -f1)
    CITY_ARGS="--id \$city_id"
else
    CITY_ARGS=""
fi

# Check which script to run based on state
if [ -f "\$STATE_FILE" ]; then
    # Show forecast
    ~/.config/polybar/scripts/weather/weather-forecast.sh \$CITY_ARGS
else
    # Show current weather (default)
    ~/.config/polybar/scripts/weather/weather.sh \$CITY_ARGS
fi
EOF
        
        chmod +x "$smart_weather_script"
    fi
}

# Main script logic
case "$1" in
    list)
        list_cities
        ;;
    set)
        if [[ -z "$2" ]]; then
            echo "Error: City name required"
            echo "Usage: $0 set \"City Name\""
            exit 1
        fi
        set_current_city "$2"
        ;;
    set-id)
        if [[ -z "$2" ]]; then
            echo "Error: City ID required"
            echo "Usage: $0 set-id CITY_ID"
            exit 1
        fi
        set_current_city_by_id "$2"
        ;;
    current)
        show_current_city
        ;;
    add)
        add_city "$2" "$3" "$4"
        ;;
    remove)
        if [[ -z "$2" ]]; then
            echo "Error: City name required"
            echo "Usage: $0 remove \"City Name\""
            exit 1
        fi
        remove_city "$2"
        ;;
    search)
        if [[ -z "$2" ]]; then
            echo "Error: Search term required"
            echo "Usage: $0 search TERM"
            exit 1
        fi
        search_cities "$2"
        ;;
    test)
        if [[ -z "$2" ]]; then
            echo "Error: City name required"
            echo "Usage: $0 test \"City Name\""
            exit 1
        fi
        test_city "$2"
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
