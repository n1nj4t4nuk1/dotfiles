#!/usr/bin/env bash
set -euo pipefail

# Starship — minimal, blazing-fast cross-shell prompt
# Installed to /usr/local/bin/starship via the official installer

if command -v starship >/dev/null 2>&1; then
  echo "Starship already installed: $(starship --version)"
  exit 0
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y
