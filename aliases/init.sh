# Make sudo expand aliases (trailing space tells the shell to keep alias-checking the next word)
alias sudo="sudo "

# Resolve this file's own directory (zsh: ${0:A:h})
ALIASES_DIR="${0:A:h}"

# Source each alias file independently (add a new line per file)
source "$ALIASES_DIR/git.sh"
source "$ALIASES_DIR/dir.sh"
