#!/usr/bin/env bash
# ==============================================================================
# Script: backup_netbird.sh
# Description: Automated backup script for NetBird state & configurations
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

BACKUP_DIR="/var/backups/netbird/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "==> Creating NetBird backup in $BACKUP_DIR..."

# Server state backup (if self-hosted)
if [ -d "/var/lib/netbird" ]; then
  sudo cp -r /var/lib/netbird "$BACKUP_DIR/var_lib_netbird"
fi

# Config directory backup
if [ -d "/etc/netbird" ]; then
  sudo cp -r /etc/netbird "$BACKUP_DIR/etc_netbird"
fi

# Docker Compose state backup (if present)
if [ -d "$HOME/netbird" ]; then
  sudo cp -r "$HOME/netbird" "$BACKUP_DIR/docker_netbird"
fi

# Create compressed tarball
TAR_FILE="/var/backups/netbird/netbird_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
sudo tar -czf "$TAR_FILE" -C "$BACKUP_DIR" .
sudo rm -rf "$BACKUP_DIR"

echo "==> Backup complete! Archive generated: $TAR_FILE"
