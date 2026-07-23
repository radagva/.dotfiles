#!/bin/bash

# Device utils: a device icon that opens a dropdown listing the available
# iPhone simulators and Android emulators. Clicking a device launches it
# (launch logic lives in plugins/device_utils.sh).
#
# The list is built once, at bar load. Reload sketchybar after creating or
# deleting a simulator/emulator to refresh it.

POPUP_OFF='sketchybar --set device_utils popup.drawing=off'
POPUP_TOGGLE='sketchybar --set device_utils popup.drawing=toggle'

device_utils=(
  icon=$DEVICES
  icon.font="$FONT:Regular:13.0"
  icon.color=$WHITE
  label.drawing=off
  icon.y_offset=2
  padding_left=6
  padding_right=8
  click_script="$POPUP_TOGGLE"
  popup.horizontal=off
  popup.align=center
  popup.background.color=$POPUP_BACKGROUND_COLOR
  # popup.background.border_width=8
  popup.background.corner_radius=6
  # popup.background.border_color=$POPUP_BACKGROUND_COLOR
  popup.background.shadow.drawing=on
  popup.blur_radius=50
)

sketchybar --add item device_utils right \
           --set device_utils "${device_utils[@]}"

header_defaults=(
  icon.drawing=off
  label.font="$FONT:Heavy:10.0"
  label.color=$GREY
  label.align=left
  label.padding_left=12
  label.padding_right=12
)

item_defaults=(
  icon.drawing=off
  label.font="$FONT:Semibold:12.0"
  label.color=$WHITE
  label.align=left
  label.padding_left=16
  label.padding_right=16
)

# ---- iPhone simulators (deduped by model, newest runtime) ----
ios_list=$(python3 - <<'PY'
import json, re, subprocess
out = subprocess.run(["xcrun", "simctl", "list", "devices", "available", "--json"],
                     capture_output=True, text=True).stdout
try:
    data = json.loads(out)
except Exception:
    raise SystemExit
best = {}  # model name -> (version_tuple, udid)
for runtime, devs in data.get("devices", {}).items():
    m = re.search(r'iOS-(\d+)-(\d+)', runtime)
    if not m:
        continue
    ver = (int(m.group(1)), int(m.group(2)))
    for d in devs:
        if not d.get("isAvailable"):
            continue
        name = d.get("name", "")
        if "iPhone" not in name:
            continue
        cur = best.get(name)
        if cur is None or ver > cur[0]:
            best[name] = (ver, d["udid"])
for name, (ver, udid) in sorted(best.items(), key=lambda kv: (-kv[1][0][0], -kv[1][0][1], kv[0])):
    print(f"{udid}\t{name}")
PY
)

if [ -n "$ios_list" ]; then
  sketchybar --add item device_utils.ios_header popup.device_utils \
             --set device_utils.ios_header "${header_defaults[@]}" label="iPhone Simulators"
  n=0
  while IFS=$'\t' read -r udid name; do
    [ -z "$udid" ] && continue
    n=$((n + 1))
    sketchybar --add item device_utils.ios.$n popup.device_utils \
               --set device_utils.ios.$n "${item_defaults[@]}" \
                     label="$name" \
                     click_script="$PLUGIN_DIR/device_utils.sh ios $udid; $POPUP_OFF"
  done <<< "$ios_list"
fi

# ---- Android emulators (AVDs) ----
EMULATOR="$HOME/Library/Android/sdk/emulator/emulator"
[ -x "$EMULATOR" ] || EMULATOR="$(command -v emulator)"
avds=$("$EMULATOR" -list-avds 2>/dev/null)

if [ -n "$avds" ]; then
  sketchybar --add item device_utils.android_header popup.device_utils \
             --set device_utils.android_header "${header_defaults[@]}" label="Android Emulators"
  n=0
  while IFS= read -r avd; do
    [ -z "$avd" ] && continue
    n=$((n + 1))
    sketchybar --add item device_utils.android.$n popup.device_utils \
               --set device_utils.android.$n "${item_defaults[@]}" \
                     label="$avd" \
                     click_script="$PLUGIN_DIR/device_utils.sh android '$avd'; $POPUP_OFF"
  done <<< "$avds"
fi
