#!/usr/bin/env bash
# ==============================================================================
# Script: deploy_netbird_server.sh
# Description: Automated deployment script for NetBird Self-Hosted Server Stack
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

DOMAIN="${1:-}"

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <your-netbird-domain.com>"
  exit 1
fi

echo "==> Preparing NetBird server deployment for domain: ${DOMAIN}"

# 1. Install prerequisites
sudo apt-get update -qq
sudo apt-get install -y -qq curl jq docker.io docker-compose-v2 ufw

# 2. Enable kernel IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.d/99-netbird.conf
echo "net.ipv6.conf.all.forwarding = 1" | sudo tee -a /etc/sysctl.d/99-netbird.conf

# 3. Configure UFW firewall
echo "==> Configuring UFW rules..."
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 80/tcp comment 'HTTP ACME'
sudo ufw allow 443/tcp comment 'HTTPS NetBird'
sudo ufw allow 51820/udp comment 'NetBird WireGuard'
sudo ufw allow 3478/udp comment 'NetBird Coturn STUN/TURN'
sudo ufw allow 3478/tcp comment 'NetBird Coturn TURN TCP'
sudo ufw allow 10000/tcp comment 'NetBird Signal'
sudo ufw allow 33073/tcp comment 'NetBird Management'
sudo ufw --force enable

# 4. Download NetBird Quickstart installer
export NETBIRD_DOMAIN="$DOMAIN"
echo "==> Running official NetBird self-hosted installer..."
curl -fsSL https://github.netbird.io/getting-started.sh | bash

echo "==> NetBird Self-Hosted Server deployed successfully!"
echo "Check container status using: docker compose ps"
