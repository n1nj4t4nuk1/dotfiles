#!/usr/bin/env bash
set -euo pipefail

# MesloLGS Nerd Font — recommended by powerlevel10k, works great with starship
# Installed at user level under ~/.local/share/fonts (no sudo required)

FONT_DIR="${HOME}/.local/share/fonts"
BASE_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"

mkdir -p "${FONT_DIR}"

declare -a VARIANTS=(
  "MesloLGS NF Regular.ttf"
  "MesloLGS NF Bold.ttf"
  "MesloLGS NF Italic.ttf"
  "MesloLGS NF Bold Italic.ttf"
)

for variant in "${VARIANTS[@]}"; do
  encoded="${variant// /%20}"
  curl -fLo "${FONT_DIR}/${variant}" "${BASE_URL}/${encoded}"
done

fc-cache -f
echo "MesloLGS NF installed. Configure your terminal to use it."
