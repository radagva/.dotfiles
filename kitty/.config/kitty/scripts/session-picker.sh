#!/usr/bin/env bash

# Include your Apple Silicon Homebrew path for fzf
PATH="$PATH:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$HOME/.fzf/bin:$HOME/.local/bin"
SESSIONS_DIR="$HOME/.config/kitty/sessions"

if [ ! -d "$SESSIONS_DIR" ]; then
    echo "Error: Directory $SESSIONS_DIR does not exist."
    read -p "Press enter to exit..."
    exit 1
fi

if ! command -v fzf &> /dev/null; then
    echo "Error: 'fzf' command not found in PATH."
    read -p "Press enter to exit..."
    exit 1
fi

# Parse session files and send them to fzf
selected=$(for file in "$SESSIONS_DIR"/*.kitty-session; do
    [ -e "$file" ] || continue
    session_name=$(basename "$file" .kitty-session)

    # Extract tab names defined by 'new_tab' in the session file
    tabs=$(awk '/^new_tab/ {sub(/^new_tab[ \t]*/, ""); print ($0 ? $0 : "Tab")}' "$file" | paste -sd, - | sed 's/,/, /g')

    # If a session file doesn't explicitly define tabs, fall back to [Default]
    if [ -z "$tabs" ]; then
        echo "$session_name - [Default]"
    else
        echo "$session_name - [$tabs]"
    fi
done | fzf --prompt="⚡ Select Kitty Session: " --height=100% --reverse)

if [ -n "$selected" ]; then
    # Safely strip the tab list to extract just the raw session file name
    session_to_load=$(echo "$selected" | awk -F ' - ' '{print $1}')

    # Tell Kitty to load the selected session directly onto the parent window
    kitty @ action --match state:overlay_parent goto_session "$SESSIONS_DIR/$session_to_load.kitty-session"
fi
