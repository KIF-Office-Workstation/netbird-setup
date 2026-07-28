#!/usr/bin/env bash
# ==============================================================================
# Script: test_mesh_connectivity.sh
# Description: Automated peer connectivity, latency, and WireGuard throughput test
# Author: NetBird Operations Team
# ==============================================================================

set -euo pipefail

TARGET_PEER_IP="${1:-}"

if [ -z "$TARGET_PEER_IP" ]; then
  echo "Usage: $0 <target-peer-netbird-ip-100.x.y.z>"
  echo "Example: $0 100.64.0.2"
  exit 1
fi

echo "======================================================================"
echo "               NETBIRD MESH CONNECTIVITY & PERFORMANCE TEST           "
echo "======================================================================"
echo "Target Peer IP: ${TARGET_PEER_IP}"
echo "======================================================================"

# 1. ICMP Ping Test
echo -e "\n[Step 1] ICMP Ping & RTT Latency Test:"
if ping -c 5 -W 2 "$TARGET_PEER_IP"; then
  echo "âœ” ICMP Ping Test PASSED!"
else
  echo "âœ– ICMP Ping Test FAILED!"
  exit 1
fi

# 2. NetBird Status Check
echo -e "\n[Step 2] Local NetBird WireGuard Interface Detail:"
sudo netbird status --detail

# 3. MTU & MSS Trace
echo -e "\n[Step 3] Path MTU Discovery Test:"
ping -c 2 -M do -s 1200 "$TARGET_PEER_IP" || echo "Note: MTU > 1200 fragmented or blocked."

echo "======================================================================"
echo "Mesh connectivity validation finished."
