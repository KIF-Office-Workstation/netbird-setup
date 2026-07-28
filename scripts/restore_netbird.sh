#!/usr/bin/env bash
# ==============================================================================
# Script: restore_netbird.sh
# Description: Restore NetBird configurations and databases from a backup archive
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

TAR_FILE="${1:-}"

if [ -z "$TAR_FILE" ] || [ ! -f "$TAR_FILE" ]; then
  echo "Usage: $0 <path-to-netbird-backup-archive.tar.gz>"
  exit 1
fi

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "==> Extracting backup archive: $TAR_FILE..."
tar -xzf "$TAR_FILE" -C "$TEMP_DIR"

echo "==> Stopping NetBird service..."
sudo systemctl stop netbird || true

if [ -d "$HOME/netbird" ]; then
  cd "$HOME/netbird" && sudo docker compose down || true
fi

# Restore state and configs
if [ -d "$TEMP_DIR/var_lib_netbird" ]; then
  echo "==> Restoring /var/lib/netbird..."
  sudo mkdir -p /var/lib/netbird
  sudo cp -r "$TEMP_DIR/var_lib_netbird/." /var/lib/netbird/
fi

if [ -d "$TEMP_DIR/etc_netbird" ]; then
  echo "==> Restoring /etc/netbird..."
  sudo mkdir -p /etc/netbird
  sudo cp -r "$TEMP_DIR/etc_netbird/." /etc/netbird/
fi

echo "==> Restarting NetBird service..."
sudo systemctl start netbird

if [ -d "$HOME/netbird" ]; then
  cd "$HOME/netbird" && sudo docker compose up -d
fi

echo "==> Restoration complete! Current status:"
sudo netbird status --detail
