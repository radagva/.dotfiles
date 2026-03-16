#!/bin/bash

# Get Wi-Fi info from system_profiler (airport utility is deprecated)
# This might be slow (~1-2s), but it's the most reliable built-in way on newer macOS without sudo
wifi_info=$(system_profiler SPAirPortDataType 2>/dev/null)

# Extract Signal Strength (RSSI)
# Output format example: "              Signal / Noise: -58 dBm / -93 dBm"
signal=$(echo "$wifi_info" | grep "Signal / Noise:" | head -1 | awk '{print $4}')

# Colors from ~/.config/tmux-config/colors.conf
thm_green="#8a9a7b"
thm_yellow="#c4b28a"
thm_red="#c4746e"
thm_grey="#727169"

# Check if we got a signal value
if [[ -z "$signal" ]]; then
    # Check if Wi-Fi is on but disconnected
    if echo "$wifi_info" | grep -q "Status: Connected"; then
        # Connected but no signal info found (unlikely but possible)
        echo "#[fg=$thm_red]󰤮 ?"
    else
        # Disconnected or Off
        echo "#[fg=$thm_grey]󰤮 Off"
    fi
    exit 0
fi

# Convert signal to integer (remove decimals if any)
signal=${signal%.*}

# Determine color and icon based on signal strength (RSSI)
# Ranges:
# > -50: Excellent
# -50 to -60: Good
# -60 to -70: Fair
# < -70: Weak

if (( signal >= -50 )); then
    color="$thm_green" # Excellent
    icon="󰤨"
elif (( signal >= -60 )); then
    color="$thm_green" # Good
    icon="󰤥"
elif (( signal >= -70 )); then
    color="$thm_yellow" # Fair
    icon="󰤢"
else
    color="$thm_red" # Weak
    icon="󰤟"
fi

printf "#[fg=%s]%s %s dBm" "$color" "$icon" "$signal"
