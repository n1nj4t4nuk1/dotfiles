# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles + per-host software inventory. The repo serves two roles at once:
- **Runtime**: shell code under `init.sh`, `envvar.sh`, `aliases/`, `functions/` is sourced live by zsh.
- **Inventory**: `apps/<host>/*.json` manifests describe what should be installed on each host. They are declarative records, not executed by any script in this repo (no provisioning entrypoint exists yet).

There is currently one host: `susanoo` (Fedora 44 Workstation).

## How the shell side loads

`~/.zshrc` (itself a symlink target from `dots/zsh/.zshrc`) sources `~/.dotfiles/init.sh`, which then sources, in order:

1. `envvar.sh` — must run first; exports `DOTFILES_DIR`, `ALIASES_DIR`, `FUNCTIONS_DIR`, `DOTS_DIR`, `EDITOR`, etc. Everything below references these.
2. `aliases/init.sh` — sources each `aliases/<topic>.sh` explicitly (one `source` line per file, not a glob).
3. `functions/init.sh` — same pattern for `functions/<name>.sh`.

When adding a new alias or function file, you must also add a matching `source` line to the corresponding `init.sh`. Globbing was deliberately avoided.

`DOTFILES_DIR` is resolved with zsh's `${0:A:h}` in `init.sh`, so the repo can live anywhere — don't hardcode `~/.dotfiles`.

## `dots/` — symlinked configs

`dots/<tool>/` holds tool config files that are symlinked into `$HOME` or `$XDG_CONFIG_HOME` (e.g. `~/.zshrc → dots/zsh/.zshrc`, `~/.config/starship.toml → dots/starship/starship.toml`). The symlinks themselves are not created by anything in this repo — they're set up manually per host. `dots/` is host-agnostic.

`dots/zsh/.zsh_plugins.zsh` is gitignored because antidote regenerates it from `.zsh_plugins.txt`.

## `apps/<host>/` — per-host manifests

Five JSON files share one schema (`dnf.json`, `flatpak.json`, `pip.json`, `gext.json`, `other.json`) — see README.md "JSON schema" section for the full shape. Key points:

- Standard manifests use `install-text` (the string passed to the installer).
- `other.json` is for things that don't fit a single package manager. It uses `scripts` (a folder name under `apps/<host>/other/<id>/`) instead of `install-text`, and splits entries into two top-level arrays:
  - `packages` → script must be named `install.sh` (installs software)
  - `setup` → script must be named `setup.sh` (configures the system; no install)
- Any entry (in any manifest) may include `post-install-commands` — an array of `{command, description}` objects run after install.

When adding a new `other` entry, create the folder and the correctly-named script. All install/setup scripts use `#!/usr/bin/env bash` + `set -euo pipefail`.

## Commands

This repo has no build, test, or lint pipeline. Useful commands while working in it:

```bash
# Re-source the shell config after editing aliases/functions/envvar
source ~/.dotfiles/init.sh

# Validate JSON manifests after edits
python3 -m json.tool apps/susanoo/<manifest>.json > /dev/null

# Syntax-check a shell script without running it
bash -n apps/susanoo/other/<id>/install.sh
zsh  -n functions/<name>.sh
```

`up` (defined in `functions/up.sh`) is a custom wrapper, not a system command: `up` with no args runs `sudo dnf update` then `flatpak update`; `up <pkg>...` runs only `sudo dnf update <pkg>...` (flatpak is skipped to avoid feeding it dnf package names).

## Conventions worth preserving

- Shell scripts that get *sourced* (aliases/functions/init files, `envvar.sh`) have **no shebang**. Standalone scripts (under `apps/<host>/other/*/`) use `#!/usr/bin/env bash` and `set -euo pipefail`.
- Use absolute paths in post-install commands when the binary's location matters at install time (e.g. `chsh -s /usr/bin/zsh`, not `chsh -s zsh`) — `$PATH` may not yet include it.
- The `alias sudo="sudo "` trick in `aliases/init.sh` (trailing space) is intentional: it lets `sudo <alias>` expand the following alias. Don't "fix" it.
- README.md documents the layout and JSON schema in detail; keep it in sync when changing either.
