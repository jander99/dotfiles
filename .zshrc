#!/usr/bin/env zsh

export TERM="xterm-256color"

#Source ZGen Directives
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
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

if [ -d "$HOME/google-cloud-sdk" ]; then
  export GCLOUD_PATH=$HOME/google-cloud-sdk
  export CLOUDSDK_PYTHON=$(which python3)
  source "${GCLOUD_PATH}"/path.zsh.inc
  source "${GCLOUD_PATH}"/completion.zsh.inc
fi 

autoload -U +X bashcompinit && bashcompinit

if [ -d /usr/local/bin/terraform ]; then
  complete -o nospace -C /usr/local/bin/terraform terraform
fi





