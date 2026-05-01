#!/usr/bin/env bash
set -euo pipefail

# Import the Microsoft signing key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add the official Visual Studio Code repository
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Refresh metadata and install Visual Studio Code
sudo dnf check-update || true
sudo dnf install code -y
