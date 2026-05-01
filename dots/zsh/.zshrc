# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# Antidote — load plugins listed in .zsh_plugins.txt
source ~/.antidote/antidote.zsh
antidote load ~/.dotfiles/dots/zsh/.zsh_plugins.txt
