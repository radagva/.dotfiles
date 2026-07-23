#!/usr/bin/env bash

# Repaints the per-workspace app labels.
#
# For every workspace we list its distinct apps and render one label each:
#   - the app of the currently focused window (in the focused workspace) -> white
#   - every other app                                                    -> grey
#
# The workspace number anchor is orange when focused, grey when it has apps, and
# hidden when the workspace is empty (unless it is the focused workspace).
#
# Runs on: startup, aerospace_workspace_change, front_app_switched.

source "$CONFIG_DIR/colors.sh"

MAX_APPS=6

FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')

# Focused window -> its workspace and app name (only one app is ever "focused").
FOCUSED=$(aerospace list-windows --focused --format '%{workspace}|%{app-name}' 2>/dev/null | head -1)
FOCUSED_WS="${FOCUSED%%|*}"
FOCUSED_APP="${FOCUSED#*|}"

# All windows across all workspaces in one call: "workspace|app-name" per line.
ALL=$(aerospace list-windows --all --format '%{workspace}|%{app-name}' 2>/dev/null)

ARGS=()

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for sid in $(aerospace list-workspaces --monitor "$m"); do

    # Distinct app names in this workspace, preserving first-seen order.
    apps=$(echo "$ALL" | awk -F'|' -v ws="$sid" '$1==ws && $2!="" {print $2}' | awk '!seen[$0]++')

    if [ "$sid" = "$FOCUSED_WS" ]; then
      # Focused workspace: always visible, orange number.
      ARGS+=(--set space.$sid drawing=on display=$FOCUSED_MONITOR icon.color=$SPACE_FG_COLOR_ACTIVE)
    elif [ -n "$apps" ]; then
      # Non-empty workspace: visible, dim number.
      ARGS+=(--set space.$sid drawing=on icon.color=$GREY)
    else
      # Empty and unfocused: hide it.
      ARGS+=(--set space.$sid drawing=off)
    fi

    # Fill the app slots.
    i=1
    while IFS= read -r app; do
      [ -z "$app" ] && continue
      [ $i -gt $MAX_APPS ] && break

      if [ "$sid" = "$FOCUSED_WS" ] && [ "$app" = "$FOCUSED_APP" ]; then
        col=$WHITE
      else
        col=$GREY
      fi

      ARGS+=(--set space.$sid.app.$i drawing=on label="$app" label.color=$col)
      i=$((i + 1))
    done <<< "$apps"

    # Hide any unused slots.
    while [ $i -le $MAX_APPS ]; do
      ARGS+=(--set space.$sid.app.$i drawing=off)
      i=$((i + 1))
    done
  done
done

sketchybar "${ARGS[@]}"
