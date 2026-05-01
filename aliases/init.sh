# Make sudo expand aliases (trailing space tells the shell to keep alias-checking the next word)
alias sudo="sudo "

# Source each alias file independently (add a new line per file)
# $ALIASES_DIR is exported by envvar.sh
source "$ALIASES_DIR/git.sh"
source "$ALIASES_DIR/dir.sh"
