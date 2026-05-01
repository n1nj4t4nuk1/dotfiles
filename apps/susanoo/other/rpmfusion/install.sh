#!/usr/bin/env bash
set -euo pipefail

# Enable RPM Fusion free and nonfree repositories.
# Required by: steam, akmod-nvidia, xorg-x11-drv-nvidia-cuda, plus many media codecs.
# Idempotent: re-installing the release RPMs is a no-op.
sudo dnf install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
  -y
