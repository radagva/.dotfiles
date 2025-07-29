#!/bin/bash

# Get Bluetooth device battery percentage for Cubitt Earbuds
get_earbuds_battery() {
    # BATTERY_INFO=$(system_profiler SPBluetoothDataType 2>/dev/null | \
    #               awk '/Cubitt Earbuds/,/Minor Type:/' | \
    #               grep -E "Battery Percent:|Left:|Right:")
    #
    # if [ -n "$BATTERY_INFO" ]; then
    #     LEFT=$(echo "$BATTERY_INFO" | awk '/Left:/{print $NF}')
    #     RIGHT=$(echo "$BATTERY_INFO" | awk '/Right:/{print $NF}')
    #
    #     if [ -n "$LEFT" ] && [ -n "$RIGHT" ]; then
    #         echo "🎧 L:${LEFT%?}% R:${RIGHT%?}%"
    #     elif [ -n "$LEFT" ]; then
    #         echo "🎧 L:${LEFT%?}%"
    #     elif [ -n "$RIGHT" ]; then
    #         echo "🎧 R:${RIGHT%?}%"
    #     else
    #         echo "🎧 ?%"
    #     fi
    # else
        echo "🎧 NC"  # NC = Not Connected
    # fi
}

# Main execution
get_earbuds_battery
