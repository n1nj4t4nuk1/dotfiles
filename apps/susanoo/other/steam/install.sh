#!/usr/bin/env bash
set -euo pipefail

# RPM Fusion (nonfree) is required — steam lives there
bash "$(dirname "$0")/../rpmfusion/install.sh"

# Enable Cisco OpenH264 codec repository (used for some video content in games/clients)
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# Install Steam
sudo dnf install steam -y
