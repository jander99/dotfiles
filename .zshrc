
#Source ZGen Directives
if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi

# Completions for Brew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Jenv configuration
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Load zshrc.d files
if [ -n "$(/bin/ls ~/.zshrc.d)" ]; then
  for f in ~/.zshrc.d/*
  do
    if [ -r "${f}" ]; then
      source "${f}"
    fi
  done
fi