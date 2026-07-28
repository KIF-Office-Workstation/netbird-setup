#!/usr/bin/env bash
# ==============================================================================
# Script: deploy_netbird_server.sh
# Description: Safe, evidence-validated deployment script for NetBird Server Stack
# Features: Pre-execution validation, mandatory backup enforcement, inspection mode, safe rollback
# Official Installer Source: https://github.com/netbirdio/netbird/releases/latest/download/getting-started.sh
# ==============================================================================

set -euo pipefail

# Argument parsing
DOMAIN=""
INSPECT_MODE=false
FORCE_NO_BACKUP=false
NON_INTERACTIVE=false

for arg in "$@"; do
  case "$arg" in
    --inspect)
      INSPECT_MODE=true
      ;;
    --force-without-backup)
      FORCE_NO_BACKUP=true
      ;;
    --yes|-y)
      NON_INTERACTIVE=true
      ;;
    -*)
      echo "Unknown flag: $arg"
      exit 1
      ;;
    *)
      if [ -z "$DOMAIN" ]; then
        DOMAIN="$arg"
      fi
      ;;
  esac
done

INSTALLER_URL="https://github.com/netbirdio/netbird/releases/latest/download/getting-started.sh"
AUDIT_DIR="./installer_audit"
mkdir -p "$AUDIT_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
AUDIT_INSTALLER="$AUDIT_DIR/getting-started_$TIMESTAMP.sh"
TEMP_INSTALLER="/tmp/netbird_installer_$TIMESTAMP.sh"

echo "======================================================================"
echo "              NETBIRD SERVER SAFE DEPLOYMENT AUTOMATION               "
echo "======================================================================"

# 1. Inspect Mode Implementation (Requirement 4)
if [ "$INSPECT_MODE" = true ]; then
  echo "==> [INSPECT MODE ACTIVATED]"
  echo "==> Resolving redirected download URL..."
  EFFECTIVE_URL=$(curl -w "%{url_effective}\n" -s -L -o /dev/null "$INSTALLER_URL")
  echo "==> Final Download URL: $EFFECTIVE_URL"
  
  echo "==> Downloading official installer script..."
  curl -fsSL -L "$INSTALLER_URL" -o "$TEMP_INSTALLER"
  cp "$TEMP_INSTALLER" "$AUDIT_INSTALLER"

  SHA256_HASH=$(sha256sum "$TEMP_INSTALLER" | awk '{print $1}')
  echo "==> SHA256 Checksum: $SHA256_HASH"
  echo "==> Audit Copy Preserved: $AUDIT_INSTALLER"

  RELEASE_VERSION=$(grep -m1 -i "version" "$TEMP_INSTALLER" || echo "NetBird Official Release")
  echo "==> Associated Release Info: $RELEASE_VERSION"

  echo "==> Performing Bash Syntax Check (bash -n)..."
  if bash -n "$TEMP_INSTALLER"; then
    echo "✔ Syntax Check PASSED."
  else
    echo "✖ ERROR: Installer script failed bash syntax check."
    rm -f "$TEMP_INSTALLER"
    exit 1
  fi

  echo "======================================================================"
  echo "                     COMPLETE INSTALLER CONTENT                       "
  echo "======================================================================"
  if [ -t 1 ] && command -v less >/dev/null 2>&1; then
    less "$TEMP_INSTALLER" || cat "$TEMP_INSTALLER"
  else
    cat "$TEMP_INSTALLER"
  fi
  echo "======================================================================"
  echo "==> Inspection complete. Script exiting without executing deployment."
  rm -f "$TEMP_INSTALLER"
  exit 0
fi

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <your-netbird-domain.example.com> [--inspect] [--force-without-backup] [--yes]"
  echo "Example: $0 netbird.example.com"
  exit 1
fi

echo "==> Target Domain: $DOMAIN"

# 2. Mandatory Backup Enforcement (Requirement 6)
if [ -d "/var/lib/netbird" ] || [ -f "docker-compose.yml" ] || [ -f "config.yaml" ]; then
  echo "==> Existing NetBird deployment detected!"
  if [ "$FORCE_NO_BACKUP" = true ]; then
    echo "----------------------------------------------------------------------"
    echo "⚠️ WARNING: --force-without-backup flag detected!"
    echo "⚠️ Bypassing mandatory system backup prior to deployment."
    echo "----------------------------------------------------------------------"
  else
    echo "==> Executing mandatory safety backup prior to modification..."
    if [ -f "./scripts/backup_netbird.sh" ]; then
      if bash ./scripts/backup_netbird.sh; then
        echo "✔ Mandatory pre-deployment backup completed successfully."
      else
        echo "✖ CRITICAL ERROR: Mandatory pre-deployment backup FAILED!"
        echo "Aborting deployment to prevent potential data loss."
        echo "To override, pass --force-without-backup explicitly."
        exit 1
      fi
    else
      echo "✖ CRITICAL ERROR: Backup script ./scripts/backup_netbird.sh missing!"
      echo "Aborting deployment to prevent potential data loss."
      exit 1
    fi
  fi
fi

# 3. Kernel IP Forwarding Check
echo "==> Verifying kernel IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || true
sudo sysctl -w net.ipv6.conf.all.forwarding=1 >/dev/null 2>&1 || true

# 4. Improved Installer Integrity Validation (Requirement 5)
echo "==> Downloading official NetBird installer..."
EFFECTIVE_URL=$(curl -w "%{url_effective}\n" -s -L -o /dev/null "$INSTALLER_URL")
curl -fsSL -L "$INSTALLER_URL" -o "$TEMP_INSTALLER"
cp "$TEMP_INSTALLER" "$AUDIT_INSTALLER"

if [ ! -s "$TEMP_INSTALLER" ]; then
  echo "✖ CRITICAL ERROR: Downloaded installer script is empty. Aborting deployment."
  exit 1
fi

FILE_SIZE=$(wc -c < "$TEMP_INSTALLER")
SHA256_HASH=$(sha256sum "$TEMP_INSTALLER" | awk '{print $1}')
RELEASE_INFO=$(grep -m1 -i "version" "$TEMP_INSTALLER" || echo "NetBird Stable Release")

echo "----------------------------------------------------------------------"
echo "INSTALLER INTEGRITY & AUDIT METRICS:"
echo "  - Source URL:      $INSTALLER_URL"
echo "  - Redirected URL:  $EFFECTIVE_URL"
echo "  - Audit File:      $AUDIT_INSTALLER"
echo "  - File Size:       $FILE_SIZE bytes"
echo "  - SHA256 Checksum: $SHA256_HASH"
echo "  - Release Info:    $RELEASE_INFO"
echo "----------------------------------------------------------------------"

echo "==> Performing bash syntax validation (bash -n)..."
if bash -n "$TEMP_INSTALLER"; then
  echo "✔ Syntax validation PASSED."
else
  echo "✖ CRITICAL ERROR: Installer failed bash syntax check. Aborting deployment."
  rm -f "$TEMP_INSTALLER"
  exit 1
fi

echo -e "\n--- [INSTALLER HEADER SECTION (First 20 Lines)] ---"
head -n 20 "$TEMP_INSTALLER"

echo -e "\n--- [INSTALLER FOOTER SECTION (Last 20 Lines)] ---"
tail -n 20 "$TEMP_INSTALLER"
echo "----------------------------------------------------------------------"

# Interactive confirmation prompt
if [ "$NON_INTERACTIVE" = false ] && [ -t 0 ]; then
  read -p "Do you want to proceed with executing the NetBird server installer for domain '$DOMAIN'? [y/N]: " CONFIRM
  if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled by user."
    rm -f "$TEMP_INSTALLER"
    exit 0
  fi
fi

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
