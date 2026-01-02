#!/usr/bin/env bash

if [ -n "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
  if [ "$1" = "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
      sketchybar --set $NAME background.drawing=on label="$1"
  else
      sketchybar --set $NAME background.drawing=off
  fi
fi
