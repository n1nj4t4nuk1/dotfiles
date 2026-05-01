# Dotfiles entry point — sourced from .zshrc
# Resolve our own directory (zsh: ${0:A:h})
DOTFILES_DIR="${0:A:h}"

# Env vars (must be first so aliases/functions can reference them)
source "$DOTFILES_DIR/envvar.sh"

# Aliases
source "$DOTFILES_DIR/aliases/init.sh"

# Commands (shell functions)
source "$DOTFILES_DIR/commands/init.sh"
