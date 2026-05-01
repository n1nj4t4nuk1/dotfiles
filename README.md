# dotfiles

Personal configuration and software inventory tracked per host.

## Layout

```
apps/
  <host>/
    dnf.json        # packages installed via dnf
    flatpak.json    # flatpak apps
    pip.json        # python packages
    gext.json       # GNOME shell extensions
    other.json      # apps installed via custom shell scripts
    other/
      <id>/
        install.sh  # entry-point install script for that software
                    # (other helper scripts can live alongside it later)
dots/
  <tool>/           # config files for a given tool, symlinked into $HOME or $XDG_CONFIG_HOME
sysinfo/
  <host>.json       # host metadata (OS, version, hostname, hardware)
```

Each host gets its own folder under `apps/` and its own metadata file under `sysinfo/`. Currently tracked: `susanoo` (Fedora 44 Workstation).

`dots/` is host-agnostic: configuration files live here and are symlinked into the user's home (e.g. `~/.zshrc → ~/.dotfiles/dots/zsh/.zshrc`) or into `~/.config/` (e.g. `~/.config/starship.toml → ~/.dotfiles/dots/starship/starship.toml`).

## JSON schema

Package manifests (`dnf.json`, `flatpak.json`, `pip.json`, `gext.json`) share the same shape:

```json
{
  "packages": [
    {
      "name": "Human-readable name",
      "id": "canonical package id",
      "install-text": "what gets passed to the install command",
      "repository": "optional, e.g. flathub",
      "description": "short description",
      "post-install-commands": [
        {
          "command": "shell command to run after install",
          "description": "what the command does"
        }
      ]
    }
  ]
}
```

`post-install-commands` is optional. Use it for steps that need to run after installing the package (e.g. `chsh` to change default shell, enabling a systemd unit, etc.).

`other.json` uses `scripts` instead of `install-text`. The value is the **folder name** under `other/` containing at least an `install.sh`. Future helper scripts (update, uninstall, etc.) can live in the same folder.

```json
{
  "name": "Visual Studio Code",
  "id": "code",
  "scripts": "vscode",
  "description": "Microsoft's cross-platform source code editor"
}
```

The install script for the entry above is at `apps/<host>/other/vscode/install.sh`.
