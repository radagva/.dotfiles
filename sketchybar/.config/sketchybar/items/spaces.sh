#!/bin/sh
sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    sid=$i
    space=(
      space="$sid"
      icon="$sid"
      icon.color=$SPACE_FG_COLOR
      label.color=$SPACE_FG_COLOR
      icon.highlight_color=$SPACE_FG_COLOR_ACTIVE
      label.highlight_color=$SPACE_FG_COLOR_ACTIVE
      label.font="sketchybar-app-font:Regular:12.0"
      icon.font="$FONT:Regular:12"
      icon.padding_left=10
      icon.padding_right=0
      display=$m
      padding_left=2
      padding_right=2
      label.padding_right=12
      label.y_offset=-1
      # background.border_width=1
      # background.border_color=$SPACE_FG_COLOR_ACTIVE
      script="$PLUGIN_DIR/spaces.sh"
    )

    sketchybar --add space space.$sid center \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked aerospace_workspace_change

    apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

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

    sketchybar --set space.$sid label="$icon_strip"
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done


space_creator=(
  # icon=􀆊
  icon.font="$FONT:Heavy:12.0"
  # padding_left=10
  # padding_right=8
  label.drawing=off
  display=active
  width=0
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change
