#!/usr/bin/env bash
# ==============================================================================
# Script: docs/security/firewall_rules.sh
# Description: Production UFW firewall hardening (Least Privilege Model)
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

echo "==> Hardening Host Firewall (UFW) for NetBird Deployment..."

# 1. Reset default policies (Deny incoming, Allow outgoing, Deny routed)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# 2. Allow SSH access
sudo ufw allow 22/tcp comment 'SSH Access'

# 3. Allow minimum required NetBird public ports
sudo ufw allow 80/tcp comment 'HTTP ACME Challenge'
sudo ufw allow 443/tcp comment 'HTTPS NetBird (Dashboard, gRPC, API, Relay)'
sudo ufw allow 3478/udp comment 'NetBird STUN/TURN Service'
sudo ufw allow 51820/udp comment 'NetBird WireGuard P2P Overlay'

# 4. Remove legacy/internal direct ports if previously enabled
sudo ufw delete allow 10000/tcp 2>/dev/null || true
sudo ufw delete allow 33073/tcp 2>/dev/null || true

# 5. Enable firewall
sudo ufw --force enable
sudo ufw status verbose
echo "==> UFW Firewall hardening complete!"
