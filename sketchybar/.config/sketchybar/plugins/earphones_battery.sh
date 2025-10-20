#!/bin/sh

get_bt_battery() {
    # Get the battery percentage
    battery=$(system_profiler SPBluetoothDataType | awk -v device="Cubitt Earbuds" '
$0 ~ device {found=1}
found && /Battery/ {gsub(/.*: /, ""); print; exit}
')

    if [ -z "$battery" ]; then
        battery="N/A"
    fi

    echo "$battery"
}

update_bt_battery() {
    battery=$(get_bt_battery)

    sketchybar --set earphones_battery \
        label="$battery" \
        icon="󱡏"
}

case "$SENDER" in
    "mouse.clicked")
        update_bt_battery
        ;;
    *)
        update_bt_battery
        ;;
esac
