#!/usr/bin/env bash
set -euo pipefail

# Rust toolchain (rustc, cargo) via the official rustup installer.
# Installs to ~/.cargo and ~/.rustup (no sudo required).

if command -v rustup >/dev/null 2>&1; then
  echo "Rust already installed: $(rustup --version)"
  exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
