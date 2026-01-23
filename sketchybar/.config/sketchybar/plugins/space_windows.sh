#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/helpers/icon_map.sh"

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSAPCE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKESPACE=$(aerospace list-workspaces --monitor focused --empty)

update_space_label() {
	local space_id=$1
	apps=$(aerospace list-windows --workspace "$space_id" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      # osascript -e "display notification \"$app\" with title "App""
      icon_strip+=$(__icon_map "$app")
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

	sketchybar --set space.$space_id label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
	# Update both previous and current workspace labels
	update_space_label "$AEROSPACE_FOCUSED_WORKSPACE"
	update_space_label "$AEROSPACE_PREV_WORKSPACE"

	# current workspace space styling (focused)
	# --animate sin 10
	sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE \
		icon.highlight=true \
		label.highlight=true \
		icon.color=$BLACK \
		label.color=$ORANGE \
    background.color=$(color $SPACE_BG_COLOR $SPACE_BG_COLOR) \

	# prev workspace space styling (unfocused)
	sketchybar --set space.$AEROSPACE_PREV_WORKSPACE \
		icon.highlight=false \
		label.highlight=false \
    icon.color=$SPACE_FG_COLOR \
    label.color=$SPACE_FG_COLOR \
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
