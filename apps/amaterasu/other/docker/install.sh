#!/usr/bin/env bash
set -euo pipefail

# dnf5-plugins is required for `dnf config-manager addrepo`
sudo dnf install dnf5-plugins -y

sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable --now docker

# -f: don't fail if 'docker' group already exists (the docker-ce package creates it)
sudo groupadd -f docker
sudo usermod -aG docker "$USER"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service
