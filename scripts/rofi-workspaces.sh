#!/bin/bash

# Rofi workspace switcher for bspwm
# Shows all workspaces and allows switching to selected one

get_workspaces() {
    bspc query -D --names
}

get_current_workspace() {
    bspc query -D -d focused --names
}

main() {
    local workspaces
    local current_workspace
    local selected
    
    workspaces=$(get_workspaces)
    current_workspace=$(get_current_workspace)
    
    # Use rofi to select workspace
    selected=$(echo "$workspaces" | rofi -dmenu \
        -p "Select workspace" \
        -mesg "Current: $current_workspace" \
        -theme "/usr/share/rofi/themes/gruvbox-dark.rasi")
    
    # If something was selected, switch to it
    if [ -n "$selected" ]; then
        bspc desktop -f "$selected"
    fi
}

main