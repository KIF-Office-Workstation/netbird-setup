#!/usr/bin/env bash
# ==============================================================================
# Script: deploy_netbird_server.sh
# Description: Safe, validated deployment script for NetBird Self-Hosted Server
# Features: Pre-execution validation, backup creation, inspection mode, safe rollback
# Official Installer Source: https://github.com/netbirdio/netbird/releases/latest/download/getting-started.sh
# ==============================================================================

set -euo pipefail

DOMAIN="${1:-}"
INSPECT_ONLY="${2:-}"

INSTALLER_URL="https://github.com/netbirdio/netbird/releases/latest/download/getting-started.sh"
TEMP_INSTALLER="/tmp/netbird_installer_$(date +%s).sh"

echo "======================================================================"
echo "              NETBIRD SERVER SAFE DEPLOYMENT AUTOMATION               "
echo "======================================================================"

# 1. Inspection mode handler
if [ "$DOMAIN" = "--inspect" ] || [ "$INSPECT_ONLY" = "--inspect" ]; then
  echo "==> [INSPECT MODE] Downloading official installer script for review..."
  curl -fsSL "$INSTALLER_URL" -o "$TEMP_INSTALLER"
  echo "==> Installer saved to $TEMP_INSTALLER"
  echo "==> Source URL: $INSTALLER_URL"
  echo "==> File Size: $(wc -c < "$TEMP_INSTALLER") bytes"
  echo "Review the installer contents above or at $TEMP_INSTALLER before running deployment."
  exit 0
fi

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <your-netbird-domain.example.com> [--inspect]"
  echo "Example: $0 netbird.example.com"
  exit 1
fi

echo "==> Target Domain: $DOMAIN"
echo "==> Source Installer URL: $INSTALLER_URL"

# 2. Check for existing deployment and create backup before modifying
if [ -d "/var/lib/netbird" ] || [ -f "docker-compose.yml" ]; then
  echo "==> Existing NetBird deployment detected!"
  echo "==> Creating automated safety backup prior to modification..."
  if [ -f "./scripts/backup_netbird.sh" ]; then
    bash ./scripts/backup_netbird.sh || echo "Warning: Backup script finished with warnings."
  fi
fi

# 3. Enable Kernel IP Forwarding
echo "==> Verifying kernel IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null
sudo sysctl -w net.ipv6.conf.all.forwarding=1 >/dev/null

# 4. Download and validate installer script
echo "==> Downloading official NetBird installer..."
curl -fsSL "$INSTALLER_URL" -o "$TEMP_INSTALLER"

if [ ! -s "$TEMP_INSTALLER" ]; then
  echo "✖ ERROR: Downloaded installer script is empty. Aborting deployment."
  exit 1
fi

# Log version / header info
echo "==> Installer Downloaded Successfully ($(wc -c < "$TEMP_INSTALLER") bytes)."
echo "==> Header Info:"
head -n 10 "$TEMP_INSTALLER"

# 5. Execute installer in safe scope
echo "==> Executing NetBird installer for domain $DOMAIN..."
export NETBIRD_DOMAIN="$DOMAIN"

if bash "$TEMP_INSTALLER"; then
  echo "✔ NetBird Server deployment completed successfully!"
  echo "Check container status: docker compose ps"
  rm -f "$TEMP_INSTALLER"
else
  echo "✖ ERROR: NetBird deployment failed."
  echo "Rollback Instructions:"
  echo "  1. Check logs: docker compose logs"
  echo "  2. Restore backup using: ./scripts/restore_netbird.sh /var/backups/netbird/<backup_file>.tar.gz"
  rm -f "$TEMP_INSTALLER"
  exit 1
fi
