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

# Catppuccin Mocha Palette
DARK_BG0=0xff1e1e2e
DARK_BG1=0xff313244
DARK_BG2=0xff45475a
DARK_FG0=0xffcdd6f4
DARK_FG1=0xffbac2de
DARK_RED=0xfff38ba8
DARK_GREEN=0xffa6e3a1
DARK_YELLOW=0xfff9e2af
DARK_BLUE=0xff89b4fa
DARK_PURPLE=0xffcba6f7
DARK_AQUA=0xff94e2d5
DARK_ORANGE=0xfffab387
DARK_GREY=0xff6c7086

# Light Palette (Catppuccin Latte)
LIGHT_BG0=0xff1e1e2e
LIGHT_BG1=0xff313244
LIGHT_BG2=0xff45475a
LIGHT_FG0=0xffcdd6f4
LIGHT_FG1=0xffbac2de
LIGHT_RED=0xfff38ba8
LIGHT_GREEN=0xffa6e3a1
LIGHT_YELLOW=0xfff9e2af
LIGHT_BLUE=0xff89b4fa
LIGHT_PURPLE=0xffcba6f7
LIGHT_AQUA=0xff94e2d5
LIGHT_ORANGE=0xfffab387
LIGHT_GREY=0xff6c7086

# LIGHT_BG0=0xffeff1f5
# LIGHT_BG1=0xffe6e9ef
# LIGHT_BG2=0xffdce0e8
# LIGHT_FG0=0xff4c4f69
# LIGHT_FG1=0xff5c5f77
# LIGHT_RED=0xffd20f39
# LIGHT_GREEN=0xff40a02b
# LIGHT_YELLOW=0xffdf8e1d
# LIGHT_BLUE=0xff1e66f5
# LIGHT_PURPLE=0xff8839ef
# LIGHT_AQUA=0xff179299
# LIGHT_ORANGE=0xfffe640b
# LIGHT_GREY=0xff9ca0b0

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
export BG=$(withopacity 0xFF111212 0xf1)
export BG2=$(color $LIGHT_BG2 $DARK_BG2)

export APP_ICON_COLOR=$MAGENTA

# UI Components
export SKETCHYBAR_BG=$BG_SOLID

export SPACE_FG_COLOR_ACTIVE=$(color 0xFFE6A75A 0xFFE6A75A)
export SPACE_BG_COLOR=$(withopacity $SPACE_FG_COLOR_ACTIVE 80)
export SPACE_FG_COLOR=$WHITE
export SPACE_FG_COLOR_EMPTY=$(withopacity $WHITE 0x22)


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
