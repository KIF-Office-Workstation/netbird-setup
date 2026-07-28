#!/usr/bin/env bash
# ==============================================================================
# Script: install_netbird_client.sh
# Description: Automated installation and connection script for NetBird Agent Client
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

SETUP_KEY="${1:-}"
MGMT_URL="${2:-}"

echo "==> Installing NetBird Client..."
curl -fsSL https://pkgs.netbird.io/install.sh | sudo sh

echo "==> Verifying NetBird daemon status..."
sudo netbird status || true

if [ -n "$SETUP_KEY" ]; then
  echo "==> Registering peer with setup key..."
  if [ -n "$MGMT_URL" ]; then
    sudo netbird up --management-url "$MGMT_URL" --setup-key "$SETUP_KEY"
  else
    sudo netbird up --setup-key "$SETUP_KEY"
  fi
  echo "==> Connection established! Status:"
  sudo netbird status --detail
else
  echo "==> Installation finished. Run 'sudo netbird up' or provide a setup key to connect."
fi
