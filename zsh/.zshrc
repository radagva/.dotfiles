autoload -Uz compinit && compinit
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# autoload -Uz compinit
#
# for dump in ~/.zcompdump(N.mh+24); do
#     compinit
# done

# compinit -C

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/radagv/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $ZSH/oh-my-zsh.sh
source $HOME/.private

# User configuration
export EDITOR=nvim

# alias scripts
alias generate-secret="openssl rand -base64 32"
alias getip="ipconfig getifaddr en0"
alias nvim-plugin='nvim -c "set rtp+=./"'
alias love="/Applications/love.app/Contents/MacOS/love"
alias simulator="/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator"
alias air='$(go env GOPATH)/bin/air'
alias puv="uv run python"

# custom functions
function check-port() {
  lsof -i tcp:"$1"
}

function kill-port() {
  kill -9 $(lsof -t -i tcp:"$1")
}

function upload () {
  curl bashupload.com -T $1;
}

function measure() {
  local sort_order="-n"
  local targets=()

  # Parse arguments
  for arg in "$@"; do
    if [[ "$arg" == "--desc" ]]; then
      sort_order="-nr"
    else
      targets+=("$arg")
    fi
  done

  # Default to current directory if no targets specified
  if [ ${#targets[@]} -eq 0 ]; then
    targets=(".")
  fi

  # Run measurement
  du -sk "${targets[@]}" 2>/dev/null | sort $sort_order | awk '{
    size = $1
    $1 = ""
    sub(/^[ \t]+/, "", $0) # Clean up leading space

    if (size >= 1048576) {
      formatted = sprintf("%.1fG", size / 1048576)
    } else if (size >= 1024) {
      formatted = sprintf("%.1fM", size / 1024)
    } else {
      formatted = sprintf("%dK", size)
    }

    printf "%-8s %s\n", formatted, $0
  }'
}

alias dcurl='f() {curl $1 | pbcopy};f'
# alias check-port='f() { lsof -i tcp:$1 };f'

# to quickly upload files to a temporary cloud disk
# alias upload='f() { curl bashupload.com -T $1 };f'


# Android CLI
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$PATH":"$HOME/.pub-cache/bin"

# pnpm
export PNPM_HOME="/Users/radagv/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# bun completions
[ -s "/Users/radagv/.bun/_bun" ] && source "/Users/radagv/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(uv generate-shell-completion zsh)"

# opencode
export PATH=/Users/radagv/.opencode/bin:$PATH

# flutter
export PATH="/Users/radagv/Downloads/flutter/bin:$PATH"
