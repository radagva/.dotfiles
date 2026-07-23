#!/bin/bash

# Utilities menu: a tool icon that opens a dropdown of quick actions.
# Each action copies something to the clipboard and fires a notification
# (logic lives in plugins/utilities.sh).

POPUP_OFF='sketchybar --set utilities popup.drawing=off'
POPUP_TOGGLE='sketchybar --set utilities popup.drawing=toggle'

utilities=(
  icon=$UTILITIES
  icon.font="$FONT:Regular:11.0"
  icon.color=$WHITE
  label.drawing=off
  padding_left=6
  padding_right=8
  click_script="$POPUP_TOGGLE"
  popup.horizontal=off
  popup.align=center
  popup.background.color=$POPUP_BACKGROUND_COLOR
  popup.background.border_width=0
  popup.background.corner_radius=6
  popup.background.shadow.drawing=on
  popup.blur_radius=50
  icon.y_offset=2
)

item_defaults=(
  icon.drawing=off
  label.font="$FONT:Semibold:12.0"
  label.color=$WHITE
  label.align=left
  label.padding_left=12
  label.padding_right=12
  background.padding_left=0
  background.padding_right=0
)

util_ip=(
  "${item_defaults[@]}"
  label="Copy IP address"
  click_script="$PLUGIN_DIR/utilities.sh ip; $POPUP_OFF"
)

util_hex=(
  "${item_defaults[@]}"
  label="Create random HEX hash"
  click_script="$PLUGIN_DIR/utilities.sh hex; $POPUP_OFF"
)

sketchybar --add item utilities right \
           --set utilities "${utilities[@]}" \
           \
           --add item utilities.ip popup.utilities \
           --set utilities.ip "${util_ip[@]}" \
           \
           --add item utilities.hex popup.utilities \
           --set utilities.hex "${util_hex[@]}"
