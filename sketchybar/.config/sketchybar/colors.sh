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

# Catppuccin Macchiato Palette
DARK_BG0=0xff24273a
DARK_BG1=0xff363a4f
DARK_BG2=0xff494d64
DARK_FG0=0xffcad3f5
DARK_FG1=0xffb8c0e0
DARK_RED=0xffed8796
DARK_GREEN=0xffa6da95
DARK_YELLOW=0xffeed49f
DARK_BLUE=0xff8aadf4
DARK_PURPLE=0xffc6a0f6
DARK_AQUA=0xff8bd5ca
DARK_ORANGE=0xfff5a97f
DARK_GREY=0xff5b6078

# Light Palette (Using same as Dark to enforce theme)
LIGHT_BG0=0xff24273a
LIGHT_BG1=0xff363a4f
LIGHT_BG2=0xff494d64
LIGHT_FG0=0xffcad3f5
LIGHT_FG1=0xffb8c0e0
LIGHT_RED=0xffed8796
LIGHT_GREEN=0xffa6da95
LIGHT_YELLOW=0xffeed49f
LIGHT_BLUE=0xff8aadf4
LIGHT_PURPLE=0xffc6a0f6
LIGHT_AQUA=0xff8bd5ca
LIGHT_ORANGE=0xfff5a97f
LIGHT_GREY=0xff5b6078

# General
export BLACK=$(color $LIGHT_BG0 $DARK_BG0)
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
export BG=$(color 0xCC24273a 0xCC24273a)
export BG2=$(color $LIGHT_BG2 $DARK_BG2)

export APP_ICON_COLOR=$MAGENTA

# UI Components
export SKETCHYBAR_BG=$BG_SOLID

export SPACE_FG_COLOR_ACTIVE=$(color $LIGHT_BLUE $DARK_BLUE)
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
