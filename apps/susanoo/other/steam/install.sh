#!/usr/bin/env bash
set -euo pipefail

# Enable RPM Fusion (free and nonfree) repositories
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  -y

# Enable Cisco OpenH264 codec repository
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# Install Steam
sudo dnf install steam -y
