source ~/.bashrc
. "$HOME/.cargo/env"
export PATH="/Users/radagv/Downloads/flutter/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/radagv/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/radagv/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/radagv/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/radagv/Downloads/google-cloud-sdk/completion.bash.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/radagv/.sdkman"
[[ -s "/Users/radagv/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/radagv/.sdkman/bin/sdkman-init.sh"
