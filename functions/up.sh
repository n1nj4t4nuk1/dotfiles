# up — update the system (dnf + flatpak).
# With args (e.g. `up some-pkg`), only dnf is targeted; flatpak only runs in the
# no-args full-update case to avoid trying to apply a dnf package name to flatpak.
up() {
  sudo dnf update "$@"
  if [[ $# -eq 0 ]]; then
    flatpak update
  fi
}
