# up — update the system.
# Currently dnf-only; extra package managers (flatpak, pip, …) can be chained here.
up() {
  sudo dnf update "$@"
}
