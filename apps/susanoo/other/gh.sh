#!/usr/bin/env bash
set -euo pipefail

# Install dnf5 plugins (needed for config-manager addrepo)
sudo dnf install dnf5-plugins -y

# Add the official GitHub CLI repository
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo

# Install GitHub CLI from the gh-cli repo
sudo dnf install gh --repo gh-cli -y
