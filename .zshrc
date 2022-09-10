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

if [ -d "$HOME/google-cloud-sdk" ]; then
  export GCLOUD_PATH=$HOME/google-cloud-sdk
  export CLOUDSDK_PYTHON=$(which python3)
  source "${GCLOUD_PATH}"/path.zsh.inc
  source "${GCLOUD_PATH}"/completion.zsh.inc
  export USE_GKE_GCLOUD_AUTH_PLUGIN=True
fi 

autoload -U +X bashcompinit && bashcompinit

if [ -d /usr/local/bin/terraform ]; then
  complete -o nospace -C /usr/local/bin/terraform terraform
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

