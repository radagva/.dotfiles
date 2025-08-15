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

export BLACK=0xff181926
export WHITE=0xffcad3f5
export RED=0xffcc241d
export GREEN=0xffa6da95
export BLUE=0xff8aadf4
export YELLOW=0xfffabd2f
export ORANGE=0xffd79921
export MAGENTA=0xffc6a0f6
export GREY=0xff939ab7
export TRANSPARENT=0x00000000

export BATTERY_1=0xffa6da95
export BATTERY_2=0xffeed49f
export BATTERY_3=0xfff5a97f
export BATTERY_4=0xffee99a0
export BATTERY_5=0xffed8796

export BG_SOLID=0xFF1E1E2E
export BG=0xCC1E1E2E
export BG2=0xCC1E1E2E

export APP_ICON_COLOR=$MAGENTA


# General bar colors
# export BAR_COLOR=0xFF1E1E2E
export BAR_COLOR=$(color 0xaa574489 0xCC1E1E2E)
export BAR_BORDER_COLOR=$BG2
export BACKGROUND_1=$BG1
export BACKGROUND_2=$BG2
export ICON_COLOR=$(color $WHITE $WHITE)
export LABEL_COLOR=$(color $WHITE $WHITE)
export POPUP_BACKGROUND_COLOR=$BAR_COLOR
export POPUP_BORDER_COLOR=$WHITE
export SHADOW_COLOR=$BLACK
