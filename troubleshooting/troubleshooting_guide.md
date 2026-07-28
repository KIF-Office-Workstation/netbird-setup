# NetBird Comprehensive Troubleshooting & Diagnostics Guide

This document lists diagnostic workflows, common error states, root cause analyses, and verified resolutions for NetBird deployments.

---

## 1. Quick Diagnostic Checklist

When experiencing issues, execute the following commands in order:

```bash
# 1. Check local daemon service status
sudo netbird status --detail

# 2. Check local WireGuard interface
ip addr show wt0

# 3. Test ping to NetBird Management API / Signal server
curl -v https://netbird.yourdomain.com:443

# 4. View daemon logs
sudo journalctl -u netbird --no-pager -n 100
```

---

## 2. Common Issues & Solutions

### Problem 1: `Daemon status: NeedsLogin` or `Disconnected`
- **Symptom:** Peer status displays `NeedsLogin` or fails to register.
- **Root Cause:** Client service is not authenticated or setup key has expired.
- **Fix:**
  ```bash
  sudo netbird down
  sudo netbird up --setup-key <VALID_SETUP_KEY>
  ```

---

### Problem 2: Peers Connected via `Relayed` instead of `Direct`
- **Symptom:** `netbird status --detail` displays `Connection: Relayed (Coturn)`. Latency is slightly elevated.
- **Root Cause:** Symmetric NAT or host firewall blocking UDP port `51820`.
- **Fix:**
  1. Verify UDP port 51820 is allowed in host firewall:
     ```bash
     sudo ufw allow 51820/udp
     ```
  2. Verify UDP port forwarding / NAT rules on external cloud router/firewall.

---

### Problem 3: `wt0: permission denied` or `wireguard module missing`
- **Symptom:** Error creating WireGuard network interface on Linux.
- **Root Cause:** Missing kernel WireGuard module or running inside unprivileged container.
- **Fix:**
  1. Load kernel module:
     ```bash
     sudo modprobe wireguard
     ```
  2. If using Docker container client, ensure required capabilities are passed:
     ```yaml
     cap_add:
       - NET_ADMIN
       - SYS_ADMIN
       - SYS_RESOURCE
     ```

---

### Problem 4: DNS Resolution Failure inside Overlay Network
- **Symptom:** Peer IP (`100.64.0.x`) pings successfully, but domain names fail to resolve.
- **Root Cause:** Systemd-resolved DNS conflict or NetBird DNS feature disabled.
- **Fix:**
  ```bash
  sudo netbird up --enable-dns
  ```
