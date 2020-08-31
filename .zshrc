#!/usr/bin/env zsh

export TERM="xterm-256color"

#Source ZGen Directives
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi

# Completions and sbin path for Brew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit

  export PATH="/usr/local/sbin:$PATH"
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
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"


# enable passphrase prompt for gpg
export GPG_TTY=$(tty)
