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

# Gruvbox Dark Palette
DARK_BG0=0xff282828
DARK_BG1=0xff3c3836
DARK_BG2=0xff504945
DARK_FG0=0xfffbf1c7
DARK_FG1=0xffebdbb2
DARK_RED=0xffcc241d
DARK_GREEN=0xff98971a
DARK_YELLOW=0xffd79921
DARK_BLUE=0xff458588
DARK_PURPLE=0xffb16286
DARK_AQUA=0xff689d6a
DARK_ORANGE=0xffd65d0e
DARK_GREY=0xff928374

# Gruvbox Light Palette
LIGHT_BG0=0xfffbf1c7
LIGHT_BG1=0xffebdbb2
LIGHT_BG2=0xffd5c4a1
LIGHT_FG0=0xff282828
LIGHT_FG1=0xff3c3836
LIGHT_RED=0xff9d0006
LIGHT_GREEN=0xff79740e
LIGHT_YELLOW=0xffb57614
LIGHT_BLUE=0xff076678
LIGHT_PURPLE=0xff8f3f71
LIGHT_AQUA=0xff427b58
LIGHT_ORANGE=0xffaf3a03
LIGHT_GREY=0xff7c6f64

# General
export BLACK=$(color $LIGHT_FG0 $DARK_BG0)
export WHITE=$(color $LIGHT_FG1 $DARK_FG1)
export RED=$(color $LIGHT_RED $DARK_RED)
export GREEN=$(color $LIGHT_GREEN $DARK_GREEN)
export BLUE=$(color $LIGHT_BLUE $DARK_BLUE)
export YELLOW=$(color $LIGHT_YELLOW $DARK_YELLOW)
export ORANGE=$(color $LIGHT_ORANGE $DARK_ORANGE)
export MAGENTA=$(color $LIGHT_PURPLE $DARK_PURPLE)
export GREY=$(color $LIGHT_GREY $DARK_GREY)
export TRANSPARENT=0x00000000

export BATTERY_1=$(color $LIGHT_GREEN $DARK_GREEN)
export BATTERY_2=$(color $LIGHT_YELLOW $DARK_YELLOW)
export BATTERY_3=$(color $LIGHT_ORANGE $DARK_ORANGE)
export BATTERY_4=$(color $LIGHT_RED $DARK_RED)
export BATTERY_5=$(color $LIGHT_RED $DARK_RED)

export BG_SOLID=$(color $LIGHT_BG0 $DARK_BG0)
export BG=$(color 0xCCfbf1c7 0xCC282828)
export BG2=$(color $LIGHT_BG2 $DARK_BG2)

export APP_ICON_COLOR=$MAGENTA

# UI Components
export SKETCHYBAR_BG=$BG_SOLID

export SPACE_FG_COLOR_ACTIVE=$(color $LIGHT_ORANGE $DARK_ORANGE)
export SPACE_BG_COLOR=$(withopacity $SPACE_FG_COLOR_ACTIVE 80)
export SPACE_FG_COLOR=$WHITE


# General bar colors
export BAR_COLOR=$BG
export BAR_BORDER_COLOR=$BG2
export BACKGROUND_1=$BG
export BACKGROUND_2=$BG2
export ICON_COLOR=$WHITE
export LABEL_COLOR=$WHITE
export POPUP_BACKGROUND_COLOR=$BAR_COLOR
export POPUP_BORDER_COLOR=$WHITE
export SHADOW_COLOR=$BLACK
