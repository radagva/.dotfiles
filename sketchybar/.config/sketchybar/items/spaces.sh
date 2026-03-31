#!/bin/sh
sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    sid=$i
    space=(
      space="$sid"
      icon.color=$SPACE_FG_COLOR
      label.color=$SPACE_FG_COLOR
      label="⏺"
      icon.highlight_color=$SPACE_FG_COLOR_ACTIVE
      label.highlight_color=$SPACE_FG_COLOR_ACTIVE
      icon.padding_left=0
      icon.padding_right=0
      display=$m
      padding_left=2
      padding_right=2
      label.padding_right=12
      label.y_offset=-1
      script="$PLUGIN_DIR/spaces.sh"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked

    # apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    #
    # icon_strip=" "
    # if [ "${apps}" != "" ]; then
    #   while read -r app
    #   do
    #     # osascript -e "display notification \"$app\" with title "App""
    #     icon_strip+=$(__icon_map "$app")
    #   done <<< "${apps}"
    # else
    #   icon_strip=" —"
    # fi
    #
    # sketchybar --set space.$sid label="$icon_strip"
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done


space_creator=(
  icon.font="$FONT:Heavy:12.0"
  label.drawing=off
  display=active
  width=0
  script="$PLUGIN_DIR/aerospace.sh"
  icon.color=$WHITE
)

sketchybar --add item aerospace left               \
           --set aerospace "${space_creator[@]}"   \
           --subscribe aerospace aerospace_workspace_change
