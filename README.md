# dotfiles

Personal configuration and software inventory tracked per host.

## Layout

```
init.sh                # entry point: sourced from .zshrc, sources everything else
envvar.sh              # exported env vars (DOTFILES_DIR, EDITOR, …)

aliases/
  init.sh              # sources each <topic>.sh below
  <topic>.sh           # alias bundles (git.sh, dir.sh, …)

functions/
  init.sh              # sources each <name>.sh below
  <name>.sh            # shell functions that change shell state (fcd, fkill, …)

dots/
  <tool>/              # config files for a given tool, symlinked into $HOME
                       # or $XDG_CONFIG_HOME (zsh, starship, …)

apps/
  <host>/
    dnf.json           # packages installed via dnf
    flatpak.json       # flatpak apps
    pip.json           # python packages
    gext.json          # GNOME shell extensions
    other.json         # custom installs and setup steps (see below)
    other/
      <id>/
        install.sh     # entry-point for "packages" entries
        setup.sh       # entry-point for "setup" entries

sysinfo/
  <host>.json          # host metadata (OS, hostname, hardware)
```

Each host gets its own folder under `apps/` and its own metadata file under `sysinfo/`. Currently tracked: `susanoo` (Fedora 44 Workstation).

## How it loads

`.zshrc` sources `~/.dotfiles/init.sh`. The chain from there:

```
.zshrc
  └─ init.sh
       ├─ envvar.sh                  → exports DOTFILES_DIR, ALIASES_DIR, FUNCTIONS_DIR, EDITOR, …
       ├─ aliases/init.sh
       │    ├─ aliases/git.sh        → git aliases (gs, gc, gd, …)
       │    └─ aliases/dir.sh        → dir aliases (la, .., …)
       └─ functions/init.sh
            ├─ functions/fcd.sh      → fzf cd picker
            └─ functions/fkill.sh    → fzf process killer
```

Env vars load first so aliases and functions can reference `$ALIASES_DIR`, `$FUNCTIONS_DIR`, etc.

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

`other.json` uses `scripts` instead of `install-text`. The value is the **folder name** under `other/`. The script filename inside that folder depends on which top-level array the entry lives in:

| Section in `other.json` | Script filename | Purpose |
|---|---|---|
| `packages` | `install.sh` | Installs a piece of software |
| `setup` | `setup.sh` | Configures the system (no software install per se) |

Example `packages` entry:

```json
{
  "name": "Visual Studio Code",
  "id": "code",
  "scripts": "vscode",
  "description": "Microsoft's cross-platform source code editor"
}
```
→ script at `apps/<host>/other/vscode/install.sh`.

Example `setup` entry:

```json
{
  "name": "Flatpak",
  "id": "flatpak",
  "scripts": "flatpak",
  "description": "Adds the flathub remote system-wide"
}
```
→ script at `apps/<host>/other/flatpak/setup.sh`.

Future helper scripts (update, uninstall, etc.) can live alongside the entry-point in the same folder.
