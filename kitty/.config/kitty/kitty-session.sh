#!/usr/bin/env bash

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

selected=$(for file in "$SESSIONS_DIR"/*.kitty-session; do
    [ -e "$file" ] || continue
    session_name=$(basename "$file" .kitty-session)
    tabs=$(awk '/^tab / {sub(/^tab +/, ""); print}' "$file" | paste -sd, - | sed 's/,/, /g')
    echo "$session_name - [$tabs]"
done | fzf --prompt="⚡ Select Kitty Session: " --height=100% --reverse)

if [ -n "$selected" ]; then
    session_to_load=$(echo "$selected" | awk -F ' - ' '{print $1}')
    
    # 1. Launch the new session in the background
    kitty --session "$SESSIONS_DIR/$session_to_load.kitty-session" &
    
    # 2. Give the OS a tiny split-second to hand off the process safely
    sleep 0.1
    
    # 3. Terminate the original window that spawned this overlay
    kitty @ close-window --match state:overlay_parent
fi
