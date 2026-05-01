#!/usr/bin/env bash
set -euo pipefail

# Add the flathub remote system-wide so the apps in flatpak.json can be installed.
# --if-not-exists makes this a no-op when the remote already exists.
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
