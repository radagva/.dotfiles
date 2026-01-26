#!/bin/bash

# Log that the event fired
echo "$(date): System appearance change detected. Reloading..." >> /tmp/sketchybar_appearance.log

# Check what the system reports as the current style
MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
echo "$(date): Current mode reported by defaults: '$MODE'" >> /tmp/sketchybar_appearance.log

# Reload sketchybar config
sketchybar --reload
