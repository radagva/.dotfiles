#!/usr/bin/env bash

# Actions for the utilities dropdown. Each action copies a value to the
# clipboard and shows a system notification confirming the copy.
#
# Usage: utilities.sh <ip|hex>

notify() {
  local title="$1" message="$2"
  if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier -title "$title" -message "$message" -sound default >/dev/null 2>&1
  else
    osascript -e "display notification \"$message\" with title \"$title\""
  fi
}

case "$1" in
  ip)
    # `getip` is a shell alias for `ipconfig getifaddr en0`; aliases are not
    # available in non-interactive scripts, so call the underlying command
    # (falling back to en1 for wired connections).
    ip="$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)"
    if [ -n "$ip" ]; then
      printf '%s' "$ip" | pbcopy
      notify "IP address copied" "$ip"
    else
      notify "IP address" "Could not determine a local IP address"
    fi
    ;;

  hex)
    hash="$(openssl rand -hex 32)"
    printf '%s' "$hash" | pbcopy
    notify "Random HEX hash copied" "$hash"
    ;;

  *)
    echo "unknown action: $1" >&2
    exit 1
    ;;
esac
