# fkill — pick one or more of YOUR processes with fzf and kill them.
# Multi-select: Tab to add, Shift+Tab to remove. Pass a signal as $1 (default: 9).
fkill() {
  local pids
  pids=$(ps -f -u "$USER" | sed 1d | fzf -m --height=40% --reverse --prompt='kill> ' --header='Tab to multi-select' | awk '{print $2}')
  [[ -n "$pids" ]] && echo "$pids" | xargs kill -"${1:-9}"
}
