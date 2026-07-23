#!/usr/bin/env bash

# Launches a device selected from the device_utils dropdown.
#
# Usage:
#   device_utils.sh ios <UDID>
#   device_utils.sh android <AVD-name>

case "$1" in
  ios)
    udid="$2"
    # Boot the simulator (ignore "already booted") and bring the app forward.
    xcrun simctl boot "$udid" 2>/dev/null
    open -a Simulator
    ;;

  android)
    shift
    avd="$*"
    EMULATOR="$HOME/Library/Android/sdk/emulator/emulator"
    [ -x "$EMULATOR" ] || EMULATOR="$(command -v emulator)"
    # Launch detached so the emulator keeps running after this script exits.
    nohup "$EMULATOR" -avd "$avd" >/dev/null 2>&1 &
    ;;

  *)
    echo "usage: device_utils.sh ios <UDID> | android <AVD>" >&2
    exit 1
    ;;
esac
