# cdd — pick a directory under the current dir with fzf and cd into it.
# Hidden directories (.git, .cache, …) are skipped by default.
cdd() {
  local dir
  dir=$(find . -maxdepth 1 -mindepth 1 -type d -not -name '.*' -printf '%f\n' | fzf --height=40% --reverse --prompt='cd> ')
  [[ -n "$dir" ]] && cd "$dir"
}
