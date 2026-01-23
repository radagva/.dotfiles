#!/bin/bash

# Function to get the appropriate color based on macOS appearance mode
color() {
    # Check if at least one color is provided
    if [ $# -eq 0 ]; then
        echo "Error: No colors provided" >&2
        return 1
    fi

    # Get current macOS appearance mode
    local mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

    # If dark mode is active and we have a second color, use it
    if [[ "$mode" == "Dark" ]] && [ $# -ge 2 ]; then
        echo "$2"
    else
        # Otherwise use the first color (light mode or fallback)
        echo "$1"
    fi
}

withopacity() {
    local color="$1"
    local alpha="$2"

    # Remove the 0x prefix if present
    color="${color#0x}"

    # Extract the original alpha and RGB components
    local original_alpha="${color:0:2}"
    local rgb="${color:2:6}"

    # Convert alpha to hex (ensure 2-digit hex)
    alpha=$(printf "%02X" "$alpha")

    # Return the new color with modified alpha
    echo "0x${alpha}${rgb}"
}

# General
export BLACK=0xff282828
export WHITE=0xffebdbb2
export RED=0xfffb4934
export GREEN=0xffb8bb26
export BLUE=0xff83a598
export YELLOW=0xfffabd2f
export ORANGE=0xfffe8019
export MAGENTA=0xffd3869b
export GREY=0xff928374
export TRANSPARENT=0x00000000

export BATTERY_1=0xffb8bb26
export BATTERY_2=0xfffabd2f
export BATTERY_3=0xfffe8019
export BATTERY_4=0xfffb4934
export BATTERY_5=0xffcc241d

export BG_SOLID=0xFF282828
export BG=0xCC282828
export BG2=0xFF3c3836

export APP_ICON_COLOR=$MAGENTA

# UI Components
export SKETCHYBAR_BG=0xFF282828

export SPACE_FG_COLOR_ACTIVE=0xfffe8019
export SPACE_BG_COLOR=$(withopacity $SPACE_FG_COLOR_ACTIVE 80)
export SPACE_FG_COLOR=0xFFebdbb2


# General bar colors
# export BAR_COLOR=0xFF1E1E2E
export BAR_COLOR=$(color 0xff282828 0xCC282828)
export BAR_BORDER_COLOR=$BG2
export BACKGROUND_1=$BG
export BACKGROUND_2=$BG2
export ICON_COLOR=$(color $WHITE $WHITE)
export LABEL_COLOR=$(color $WHITE $WHITE)
export POPUP_BACKGROUND_COLOR=$BAR_COLOR
export POPUP_BORDER_COLOR=$WHITE
export SHADOW_COLOR=$BLACK
