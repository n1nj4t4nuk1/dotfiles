# Environment variables exported for the rest of the shell session.
# Sourced from init.sh BEFORE aliases (so aliases/functions can reference these).

# Directory layout
export DOTFILES_DIR="${0:A:h}"
export ALIASES_DIR="$DOTFILES_DIR/aliases"
export COMMANDS_DIR="$DOTFILES_DIR/commands"
export DOTS_DIR="$DOTFILES_DIR/dots"

# Editors / pager
export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"
