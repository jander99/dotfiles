#!/usr/bin/env zsh

export TERM="xterm-256color"

#Source ZGenOM Directives
if [ -f ~/.zgenom-setup ]; then
  source ~/.zgenom-setup
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# On Syno yadm is installed in $HOME/yadm/bin/yadm
# This needs to load near the top to allow other references to function
if [ -f "$HOME/yadm/bin/yadm" ]; then
  export PATH="$HOME/yadm/bin:$PATH"
fi

# Load zshrc.d files
if [ -n "$(/bin/ls ~/.zshrc.d)" ]; then
  for f in ~/.zshrc.d/*; do
    if [ -r "${f}" ]; then
      source "${f}"
    fi
  done
fi

# enable passphrase prompt for gpg
export GPG_TTY=$(tty)

# GCloud things (temporary)
if [ command -v gcloud > /dev/null 2>&1 ]; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  export USE_GKE_GCLOUD_AUTH_PLUGIN=True
  export CLOUDSDK_PYTHON=$(which python3)

fi 

autoload -U +X bashcompinit && bashcompinit

if [ command -v terraform > /dev/null 2>&1 ]; then
  complete -o nospace -C $(command -v terraform) terraform
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Really a work macbook thing, should probably make a profile. 
test -s "${HOME}/.config/certs/caadmin.netskope.com.pem" &&
  export NODE_EXTRA_CA_CERTS="${HOME}/.config/certs/caadmin.netskope.com.pem"
