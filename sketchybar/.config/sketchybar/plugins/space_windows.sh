#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSAPCE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKESPACE=$(aerospace list-workspaces --monitor focused --empty)

update_space_label() {
	local space_id=$1
	apps=$(aerospace list-windows --workspace "$space_id" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

	icon_strip=" "
	if [ "${apps}" != "" ]; then
		while read -r app; do
			icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
		done <<<"${apps}"
	else
		icon_strip=" —"
	fi

	sketchybar --set space.$space_id label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
	# Update both previous and current workspace labels
	update_space_label "$AEROSPACE_PREV_WORKSPACE"
	update_space_label "$AEROSPACE_FOCUSED_WORKSPACE"

	# current workspace space styling (focused)
	# --animate sin 10
	sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE \
		icon.highlight=true \
		label.highlight=true \
		icon.color=$BLACK \
		label.color=$ORANGE \
    background.color=$(color 0x66111111 0x22AAAAAA) \
		background.border_color=$GREY

	# prev workspace space styling (unfocused)
	sketchybar --set space.$AEROSPACE_PREV_WORKSPACE \
		icon.highlight=false \
		label.highlight=false \
		icon.color=$WHITE \
		label.color=$WHITE \
		background.border_color=$BACKGROUND_2 \
		background.color=$TRANSPARENT

	# Handle empty workspaces
	for i in $AEROSPACE_EMPTY_WORKESPACE; do
		sketchybar --set space.$i display=0
	done

	sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
fi

# Add this to handle window movement events
if [ "$SENDER" = "window_moved" ] || [ "$SENDER" = "window_focused" ]; then
	# Update all non-empty workspaces
	for space_id in $(aerospace list-workspaces --monitor focused --empty no); do
		update_space_label "$space_id"
	done
fi
