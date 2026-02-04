#!/bin/bash

# This script now only handles mouse clicks for spaces.
# The visual state (highlighting) is handled by plugins/aerospace.sh

set_space_label() {
	sketchybar --set $NAME icon="$@"
}

if [ "$SENDER" = "mouse.clicked" ]; then
	if [ "$BUTTON" = "right" ]; then
		# Right click - maybe add logic here later, or keep empty
		:
	else
		if [ "$MODIFIER" = "shift" ]; then
			SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
			if [ $? -eq 0 ]; then
				if [ "$SPACE_LABEL" = "" ]; then
					set_space_label "${NAME:6}"
				else
					set_space_label "${NAME:6} ($SPACE_LABEL)"
				fi
			fi
		else
			# Left click - switch to workspace
			# NAME is "space.X", so ${NAME#*.} gives "X"
			aerospace workspace ${NAME#*.}
		fi
	fi
fi
