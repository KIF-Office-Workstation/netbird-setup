#!/usr/bin/env bash
# ==============================================================================
# Script: backup_netbird.sh
# Description: Automated backup script for NetBird state & configurations
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

BACKUP_PARENT_DIR="${BACKUP_TARGET_DIR:-/var/backups/netbird}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$BACKUP_PARENT_DIR/$TIMESTAMP"
mkdir -p "$BACKUP_DIR" 2>/dev/null || BACKUP_DIR="/tmp/netbird_backup_$TIMESTAMP" && mkdir -p "$BACKUP_DIR"

echo "==> Creating NetBird backup in $BACKUP_DIR..."

# Server state backup (if present)
if [ -d "/var/lib/netbird" ]; then
  echo "--> Backing up /var/lib/netbird..."
  cp -r /var/lib/netbird "$BACKUP_DIR/var_lib_netbird" 2>/dev/null || true
fi

# Config directory backup (if present)
if [ -d "/etc/netbird" ]; then
  echo "--> Backing up /etc/netbird..."
  cp -r /etc/netbird "$BACKUP_DIR/etc_netbird" 2>/dev/null || true
fi

# Local workspace config backup (if present)
if [ -d "./config" ]; then
  echo "--> Backing up ./config..."
  cp -r ./config "$BACKUP_DIR/workspace_config" 2>/dev/null || true
fi

# Create compressed tarball
TAR_FILE="$BACKUP_PARENT_DIR/netbird_backup_$TIMESTAMP.tar.gz"
if ! tar -czf "$TAR_FILE" -C "$BACKUP_DIR" . 2>/dev/null; then
  TAR_FILE="/tmp/netbird_backup_$TIMESTAMP.tar.gz"
  tar -czf "$TAR_FILE" -C "$BACKUP_DIR" .
fi

rm -rf "$BACKUP_DIR"

if [ -s "$TAR_FILE" ]; then
  echo "✔ Backup complete! Archive generated: $TAR_FILE ($(wc -c < "$TAR_FILE") bytes)"
  exit 0
else
  echo "✖ ERROR: Generated backup archive $TAR_FILE is empty."
  exit 1
fi
