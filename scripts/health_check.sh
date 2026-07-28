#!/usr/bin/env bash
# ==============================================================================
# Script: health_check.sh
# Description: Health check reporter for NetBird combined server & client
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

# 1. Check NetBird Daemon Service Status
echo -e "\n[1/5] Checking NetBird Service Status:"
if systemctl is-active --quiet netbird; then
  echo "✔ NetBird daemon systemd service is ACTIVE."
else
  echo "✖ WARNING: NetBird daemon systemd service is NOT running."
fi

# 2. Check NetBird Client Interface & Status
echo -e "\n[2/5] NetBird Client Detail:"
sudo netbird status --detail || echo "NetBird client is disconnected."

# 3. Check Kernel IP Forwarding
echo -e "\n[3/5] Kernel IP Forwarding Check:"
IP_FWD=$(sysctl -n net.ipv4.ip_forward)
if [ "$IP_FWD" -eq 1 ]; then
  echo "✔ IPv4 Forwarding is ENABLED."
else
  echo "✖ WARNING: IPv4 Forwarding is DISABLED."
fi

# 4. Check Docker Containers (NetBird Combined Server Stack)
echo -e "\n[4/5] Self-Hosted Container Health (if present):"
if command -v docker >/dev/null 2>&1; then
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "netbird|traefik" || echo "No self-hosted server containers active on this node."
fi

# 5. Firewall Open Ports Verification (Least Privilege)
echo -e "\n[5/5] Firewall Port Status (UFW):"
sudo ufw status verbose | grep -E "80/tcp|443/tcp|3478/udp|51820/udp" || echo "No explicit NetBird UFW rules found."

echo "======================================================================"
echo "Health check complete."
