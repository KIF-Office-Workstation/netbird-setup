#!/usr/bin/env bash
# ==============================================================================
# Script: health_check.sh
# Description: Automated diagnostic and health monitor for NetBird deployment
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

echo "======================================================================"
echo "                   NETBIRD SYSTEM HEALTH CHECK REPORT                 "
echo "======================================================================"
echo "Date: $(date -u)"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "======================================================================"

# 1. Check NetBird CLI & Daemon Service
echo -e "\n[1/5] Checking NetBird Service Status:"
if systemctl is-active --quiet netbird; then
  echo "âœ” NetBird daemon systemd service is ACTIVE."
else
  echo "âœ– WARNING: NetBird daemon systemd service is NOT running."
fi

# 2. Check NetBird Connection Detail
echo -e "\n[2/5] NetBird Interface & Peer Status:"
sudo netbird status --detail || echo "NetBird client is disconnected."

# 3. Check Kernel IP Forwarding
echo -e "\n[3/5] Kernel IP Forwarding Check:"
IP_FWD=$(sysctl -n net.ipv4.ip_forward)
if [ "$IP_FWD" -eq 1 ]; then
  echo "âœ” IPv4 Forwarding is ENABLED."
else
  echo "âœ– WARNING: IPv4 Forwarding is DISABLED."
fi

# 4. Check Docker Containers (if self-hosted)
echo -e "\n[4/5] Self-Hosted Container Health (if present):"
if command -v docker >/dev/null 2>&1; then
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "netbird|coturn|traefik" || echo "No self-hosted server containers active on this node."
fi

# 5. Firewall Open Ports Verification
echo -e "\n[5/5] Firewall Port Status (UFW):"
sudo ufw status verbose | grep -E "51820|3478|10000|33073|80|443" || echo "No explicit UFW NetBird rules found."

echo "======================================================================"
echo "Health check complete."
