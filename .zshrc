#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

#Source ZGenOM Directives
if [ -f ~/.zgenom-setup ]; then
  source ~/.zgenom-setup
fi

# Jenv configuration
if [ -f /usr/local/bin/jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# Load zshrc.d files
if [ -n "$(/bin/ls ~/.zshrc.d)" ]; then
  for f in ~/.zshrc.d/*; do
    if [ -r "${f}" ]; then
      source "${f}"
    fi
  done
fi

if [ -d "/usr/local/opt/libpq/bin" ]
then
  export PATH="/usr/local/opt/libpq/bin:$PATH"
fi

if [ -d "/usr/local/opt/openssl@1.1/bin" ]
then
  export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
fi

# Python hacks
export PATH="/usr/local/bin:$PATH"

# enable passphrase prompt for gpg
export GPG_TTY=$(tty)


# GCloud things (temporary)
export GCLOUD_PATH=$HOME/google-cloud-sdk
export CLOUDSDK_PYTHON=$(which python3)
source "${GCLOUD_PATH}"/path.zsh.inc
source "${GCLOUD_PATH}"/completion.zsh.inc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

