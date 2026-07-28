#!/usr/bin/env bash
# ==============================================================================
# Script: security/firewall_rules.sh
# Description: Production UFW & iptables firewall hardening for NetBird
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

echo "==> Hardening Linux Firewall (UFW) for NetBird Infrastructure..."

# 1. Standard inbound rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# 2. Allow SSH access
sudo ufw allow 22/tcp comment 'SSH Secure Access'

# 3. Allow NetBird core service ports
sudo ufw allow 51820/udp comment 'NetBird WireGuard P2P Overlay'
sudo ufw allow 3478/udp comment 'NetBird Coturn STUN/TURN UDP'
sudo ufw allow 3478/tcp comment 'NetBird Coturn TURN TCP'
sudo ufw allow 10000/tcp comment 'NetBird Signal gRPC Service'
sudo ufw allow 33073/tcp comment 'NetBird Management gRPC API'
sudo ufw allow 80/tcp comment 'HTTP ACME Web'
sudo ufw allow 443/tcp comment 'HTTPS Dashboard & gRPC Web'

# 4. Enable firewall rules
sudo ufw --force enable
sudo ufw status verbose
echo "==> Firewall hardening complete!"
