#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

AEROSPACE_FOCUSED_MONITOR_NO=$(aerospace list-workspaces --focused)
AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR=$(aerospace list-windows --workspace $AEROSPACE_FOCUSED_MONITOR_NO | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

if [ "$SENDER" = "front_app_switched" ]; then
  if [ -z "$INFO" ] || [ "$INFO" = "Mission Control" ]; then
    sketchybar --animate tanh 10 --set "$NAME" label="$AEROSPACE_FOCUSED_MONITOR_NO - Empty" label.padding_right=10 icon.background.image=""
  else
    sketchybar --animate tanh 10 --set "$NAME" label="$AEROSPACE_FOCUSED_MONITOR_NO - $INFO" label.padding_right=10 icon.background.image="app.$INFO" icon.background.image.scale=0.6
  fi
fi
