

# export ZSH_CACHE_DIR="$HOME/.cache"


# setopt correct
# setopt no_complete_aliases

# Completions for Brew
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

#   autoload -Uz compinit
#   compinit
# fi


#Source ZGen Directives

if [ -f ~/.zgen-setup ]; then
  source ~/.zgen-setup
fi


# Jenv configuration
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
