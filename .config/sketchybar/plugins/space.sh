#!/bin/bash

update() {
	if [ "$SENDER" = "space_change" ]; then
		source "$CONFIG_DIR/colors.sh"
		COLOR=$RED
		if [ "$SELECTED" = "true" ]; then
			COLOR=$WHITE
		fi

		sketchybar --set space.$(aerospace list-workspaces --focused) icon.highlight=true \
			label.highlight=true \
			icon.color=$RED \
			label.color=$RED \
      background.color=$(color 0x66111111 0x22AAAAAA)=
	fi
}

set_space_label() {
	sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
	if [ "$BUTTON" = "right" ]; then
		echo ''
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
			aerospace workspace ${NAME#*.}
		fi
	fi
}

case "$SENDER" in
"mouse.clicked")
	mouse_clicked
	;;
*)
	update
	;;
esac
