# Dotfiles entry point — sourced from .zshrc
# Resolve our own directory (zsh: ${0:A:h})
DOTFILES_DIR="${0:A:h}"

# Aliases
source "$DOTFILES_DIR/aliases/init.sh"
