#!/usr/bin/env bash
set -euo pipefail

# Import the Microsoft signing key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add the official Visual Studio Code repository
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Refresh metadata and install Visual Studio Code
sudo dnf check-update || true
sudo dnf install code -y
