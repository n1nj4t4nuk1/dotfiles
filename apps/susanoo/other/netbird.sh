#!/usr/bin/env bash
set -euo pipefail

# Add the official NetBird repository
sudo tee /etc/yum.repos.d/netbird.repo > /dev/null <<'EOF'
[netbird]
name=netbird
baseurl=https://pkgs.netbird.io/yum/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.netbird.io/yum/repodata/repomd.xml.key
repo_gpgcheck=1
EOF

# Install the NetBird daemon
sudo dnf install netbird -y

# Install the GUI client (and its tray icon dependencies)
sudo dnf install libappindicator-gtk3 libappindicator netbird-ui -y
