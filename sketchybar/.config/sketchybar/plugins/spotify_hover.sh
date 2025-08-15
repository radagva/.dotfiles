#!/bin/bash

# Configurable delay in seconds (e.g., 0.2 for 200ms)
DELAY=0.2

case "$SENDER" in
    "mouse.entered")
        # Cancel any pending hide
        kill "$(cat /tmp/spotify_popup_delay.pid 2>/dev/null)" 2>/dev/null
        # Show immediately
        sketchybar -m --set spotify.name popup.drawing=on
    ;;
    "mouse.exited")
        # Get mouse position (requires jq)
        MOUSE_POS=$(sketchybar --query spotify.name | jq -r '.popup.rectangle[]')
        POPUP_X=${MOUSE_POS%%,*}
        POPUP_Y=${MOUSE_POS#*,}
        
        # Only hide if mouse is truly outside (with delay)
        {
            sleep "$DELAY"
            CURRENT_POS=$(sketchybar --query spotify.name | jq -r '.popup.rectangle[]')
            if [[ "$CURRENT_POS" != "$MOUSE_POS" ]]; then
                sketchybar -m --set spotify.name popup.drawing=off
            fi
        } & echo $! > /tmp/spotify_popup_delay.pid
    ;;
esac
