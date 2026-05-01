#!/usr/bin/env bash
set -euo pipefail

# Antidote — minimal zsh plugin manager
# Cloned to ~/.antidote and sourced from ~/.zshrc

ANTIDOTE_DIR="${HOME}/.antidote"

if [ -d "${ANTIDOTE_DIR}" ]; then
  echo "Antidote already present at ${ANTIDOTE_DIR}, pulling latest"
  git -C "${ANTIDOTE_DIR}" pull --ff-only
else
  git clone --depth=1 https://github.com/mattmc3/antidote.git "${ANTIDOTE_DIR}"
fi
