#!/usr/bin/env bash

# Switcher for tabs that do not belong to any kitty session
# (they are hidden when tab_bar_filter session:~ is active)
# Enter: focus tab, ctrl-x: close tab (multi-select with tab)

# Include your Apple Silicon Homebrew path for fzf
PATH="$PATH:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$HOME/.fzf/bin:$HOME/.local/bin"

if ! command -v fzf &> /dev/null; then
    echo "Error: 'fzf' command not found in PATH."
    read -p "Press enter to exit..."
    exit 1
fi

# List tabs created outside of any session (session name empty)
list_tabs() {
    kitty @ ls --match-tab 'session:^$' | python3 -c "
import json, sys
for os_win in json.load(sys.stdin):
    for tab in os_win.get('tabs', []):
        title = tab.get('title', 'Tab')
        n = len(tab.get('windows', []))
        print(f\"{tab['id']}\t{title} ({n} window{'s' if n != 1 else ''})\")
"
}

selected=$(list_tabs | fzf --prompt="⚡ Free Tabs: " \
    --height=100% --reverse \
    --delimiter='\t' --with-nth 2 \
    --multi \
    --header="enter: switch | ctrl-x: close | tab: mark" \
    --bind="ctrl-x:execute-silent(kitty @ close-tab --match 'id:{1}')+reload(list_tabs)")

if [ -n "$selected" ]; then
    tab_id=$(echo "$selected" | head -1 | cut -f1)
    kitty @ focus-tab --match "id:$tab_id"
fi
