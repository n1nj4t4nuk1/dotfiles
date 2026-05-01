# PATH: prepend user bins (deduped via typeset -U)
typeset -U path
path=(~/.local/bin ~/bin $path)

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# Antidote — load plugins listed in .zsh_plugins.txt
source ~/.antidote/antidote.zsh
antidote load ~/.dotfiles/dots/zsh/.zsh_plugins.txt

# Starship prompt
eval "$(starship init zsh)"

# Dotfiles entry point (aliases, functions, env, etc.)
source ~/.dotfiles/init.sh
