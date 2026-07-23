#!/bin/sh

# Each aerospace workspace is rendered as:
#   - an "anchor" item showing the workspace number (space.$sid)
#   - a fixed pool of "app slot" items showing the app names (space.$sid.app.$i)
#
# The visual state (which slots are shown, their labels and colors, and the
# anchor color) is driven entirely by plugins/aerospace.sh, which repaints on
# workspace change and front app switch. Using a fixed pool of slots (instead of
# adding/removing items on the fly) keeps updates flicker-free.

sketchybar --add event aerospace_workspace_change

# Max number of distinct apps shown per workspace (extra apps are hidden).
MAX_APPS=6

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for sid in $(aerospace list-workspaces --monitor $m); do

    # Workspace anchor: shows the workspace number. Click to switch to it.
    sketchybar --add item space.$sid left \
               --set space.$sid \
                     display=$m \
                     drawing=off \
                     icon="$sid" \
                     icon.font="$FONT:Bold:11.0" \
                     icon.color=$SPACE_FG_COLOR_EMPTY \
                     icon.padding_left=8 \
                     icon.padding_right=4 \
                     label.drawing=off \
                     click_script="aerospace workspace $sid"

    # App slots: one hidden text item per possible app.
    i=1
    while [ $i -le $MAX_APPS ]; do
      sketchybar --add item space.$sid.app.$i left \
                 --set space.$sid.app.$i \
                       display=$m \
                       drawing=off \
                       icon.drawing=off \
                       label.font="$FONT:Semibold:11.0" \
                       label.color=$GREY \
                       label.padding_left=0 \
                       label.padding_right=5 \
                       click_script="aerospace workspace $sid"
      i=$((i + 1))
    done
  done
done

# Invisible updater item: listens for workspace changes and front app switches
# and repaints every workspace's anchor + app slots.
sketchybar --add item aerospace left \
           --set aerospace \
                 drawing=off \
                 updates=on \
                 script="$PLUGIN_DIR/aerospace.sh" \
           --subscribe aerospace aerospace_workspace_change front_app_switched

# Initial paint.
"$PLUGIN_DIR/aerospace.sh"
