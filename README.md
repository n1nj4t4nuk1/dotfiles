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
    other/          # the scripts referenced from other.json
systems/
  <host>.json       # host metadata (OS, version, hostname)
```

Each host gets its own folder under `apps/` and its own metadata file under `systems/`. Currently tracked: `susanoo` (Fedora 44 Workstation).

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

`other.json` uses `script` instead of `install-text`, pointing to a file inside `other/`:

```json
{
  "name": "Visual Studio Code",
  "id": "code",
  "script": "vscode/install.sh",
  "description": "Microsoft's cross-platform source code editor"
}
```
