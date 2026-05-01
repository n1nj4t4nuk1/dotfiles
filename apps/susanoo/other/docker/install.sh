#!/usr/bin/env bash
set -euo pipefail

# Install dnf5 plugins (needed for config-manager addrepo)
sudo dnf install dnf5-plugins -y

# Add the official Docker CE repository
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker engine, CLI, containerd, plus buildx and compose plugins
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Enable and start the daemon now and on boot
sudo systemctl enable --now docker

# Allow the current user to run docker without sudo.
# Takes effect after log out / log in (or run `newgrp docker` in the current shell).
# NOTE: docker group membership is effectively root — members can mount any host
# path into a container as root, so treat it like a privileged group.
sudo usermod -aG docker "$USER"
