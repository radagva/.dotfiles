export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nvim
export VISUAL=$EDITOR


export PATH="$PATH:/opt/homebrew/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"


# alias scripts
alias generate-secret="openssl rand -base64 32"

# alias functions
# to check port usage
alias check-port='f() { lsof -i tcp:$1 };f'

# to quickly upload files to a temporary cloud disk
alias upload='f() { curl bashupload.com -T $1 };f'

# for live reload GO projects
alias air='$(go env GOPATH)/bin/air'

# shortcut running python with uv venv
alias puv="uv run python"

alias dcurl='f() {curl $1 | pbcopy};f'
alias getip="ipconfig getifaddr en0"
alias nvim-plugin='nvim -c "set rtp+=./"'
alias simulator="/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator"
alias python="python3"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# Android CLI
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# fnm
export PATH="/Users/radagv/Library/Application Support/fnm:$PATH"
eval "`fnm env`"

export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

. "$HOME/.local/bin/env"

eval "$(starship init bash)"
eval "$(zoxide init bash)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(uv generate-shell-completion bash)"

# opencode
export PATH=/Users/radagv/.opencode/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/radagv/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/radagv/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/radagv/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/radagv/Downloads/google-cloud-sdk/completion.bash.inc'; fi
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/radagv/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end


# Sourced Kitty Session Picker with fzf
ksess() {
    # Update this path to where you store your session files
    local session_dir="$HOME/.config/kitty/sessions"
    local selected

    # Find files ending in .session or .kitty-session and pass them to fzf
    selected=$(find "$session_dir" -type f \( -name "*.session" -o -name "*.kitty-session" \) -printf "%P\n" | fzf --prompt="⚡ Kitty Session: " --height=40% --reverse)

    # If a selection was made, inject it directly into the current window
    if [ -n "$selected" ]; then
        kitten @ action "goto_session $session_dir/$selected"
    fi
}
