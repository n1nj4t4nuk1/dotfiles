# Environment variables exported for the rest of the shell session.
# Sourced from init.sh BEFORE aliases (so aliases/functions can reference these).
# Assumes $DOTFILES_DIR has already been exported by init.sh.

# Derived directory layout
export ALIASES_DIR="$DOTFILES_DIR/aliases"
export FUNCTIONS_DIR="$DOTFILES_DIR/functions"
export DOTS_DIR="$DOTFILES_DIR/dots"

# Editors / pager
export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"
