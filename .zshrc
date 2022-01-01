#!/usr/bin/env zsh

export TERM="xterm-256color"

#Source ZGen Directives
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi

# On Syno yadm is installed in $HOME/yadm/bin/yadm
if [ -f $HOME/yadm/bin/yadm ]; then
  export PATH="$HOME/yadm/bin:$PATH"
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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform





