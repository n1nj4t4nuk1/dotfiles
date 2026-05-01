#!/usr/bin/env bash
set -euo pipefail

sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
