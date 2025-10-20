#!/bin/sh

earphones=(
	icon.font="$FONT:Regular:16.0"
	icon.padding_right=4
	label.align=right
	update_freq=60
	script="$PLUGIN_DIR/earphones_battery.sh"
)

sketchybar --add item earphones_battery right \
           --set earphones_battery ${earphones[@]} \
           --add event bt_battery_update \
           --subscribe earphones_battery mouse.clicked bt_battery_update
