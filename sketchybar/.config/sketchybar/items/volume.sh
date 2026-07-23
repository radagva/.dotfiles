#!/bin/sh

volume_icon=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  y_offset=1
  icon=$VOLUME_100
  icon.align=left
  icon.color=$WHITE
  icon.font="$FONT:Regular:13.0"
  label.font="$FONT:SemiBold:11.0"
  label.y_offset=0
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}" \
           --subscribe volume_icon volume_change
