#!/bin/sh

sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for sid in $(aerospace list-workspaces --monitor $m); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=0x44ffffff \
        background.corner_radius=10 \
        height=20 \
        width=20 \
        label="$sid" \
        background.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"

    if [ "$sid" -eq "1" ]; then
      sketchybar --set space.$sid background.drawing=on
    fi
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done
