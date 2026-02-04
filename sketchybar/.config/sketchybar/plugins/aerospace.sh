#!/usr/bin/env bash

# Handles the "aerospace_workspace_change" event to update space highlights and window icons.

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/helpers/icon_map.sh"

# Function to get window icons for a space
# Usage: get_icon_strip <space_id>
get_icon_strip() {
  local space_id=$1
  local apps=$(aerospace list-windows --workspace "$space_id" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  
  local icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon_strip+=$(__icon_map "$app")
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  echo "$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # 1. Highlight the new focused workspace
  # 2. Unhighlight the previous workspace
  # 3. Update window icons for both (in case windows moved with the focus change)
  
  # Note: AEROSPACE_FOCUSED_WORKSPACE and AEROSPACE_PREV_WORKSPACE are passed by the trigger
  
  # Fetch focused monitor once
  FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
  
  # Prepare arguments for a single sketchybar call
  ARGS=()

  # --- Handle Empty Workspaces on the Focused Monitor ---
  # Hide empty workspaces first. 
  # If the focused workspace is empty, it will be un-hidden by the next block.
  EMPTY_WORKSPACES=$(aerospace list-workspaces --monitor focused --empty)
  for i in $EMPTY_WORKSPACES; do
     ARGS+=(--set space.$i display=0)
  done
  
  # --- Update FOCUSED Workspace ---
  if [ -n "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
    icon_strip_focused=$(get_icon_strip "$AEROSPACE_FOCUSED_WORKSPACE")
    
    ARGS+=(--set space.$AEROSPACE_FOCUSED_WORKSPACE \
           display=$FOCUSED_MONITOR \
           icon.highlight=true \
           label.highlight=true \
           icon.color=$BLACK \
           label.color=$ORANGE \
           background.color=$(color $SPACE_BG_COLOR $SPACE_BG_COLOR) \
           label="$icon_strip_focused")
  fi

  # --- Update PREVIOUS Workspace ---
  if [ -n "$AEROSPACE_PREV_WORKSPACE" ] && [ "$AEROSPACE_PREV_WORKSPACE" != "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
    icon_strip_prev=$(get_icon_strip "$AEROSPACE_PREV_WORKSPACE")
    
    ARGS+=(--set space.$AEROSPACE_PREV_WORKSPACE \
           icon.highlight=false \
           label.highlight=false \
           icon.color=$SPACE_FG_COLOR \
           label.color=$SPACE_FG_COLOR \
           background.color=$TRANSPARENT \
           label="$icon_strip_prev")
  fi

  # Apply all changes in one go
  sketchybar "${ARGS[@]}"
fi
