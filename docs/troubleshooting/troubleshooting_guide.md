# NetBird Comprehensive Troubleshooting Guide

This guide provides diagnostic workflows, root cause analysis, and solutions for common NetBird client and server issues.

---

## 1. Diagnostic Health Check Workflow

Execute automated diagnostics:
```bash
chmod +x ./scripts/health_check.sh
sudo ./scripts/health_check.sh
```

View detailed client peer state:
```bash
sudo netbird status --detail
```

---

## 2. Common Issues & Solutions

### Issue 1: Peer Connection Status Shows "Relayed"
- **Symptom:** `netbird status --detail` displays connection type as `Relayed`.
- **Root Cause:** Direct UDP port `51820` is blocked by a restrictive firewall or symmetric NAT.
- **Resolution:**
  1. Ensure UDP 51820 is allowed in host firewall:
     ```bash
     sudo ufw allow 51820/udp
     ```
  2. Verify STUN port `3478/udp` is accessible.
  3. Relayed connection via WebSockets/HTTPS over port `443` is functioning normally as fallback.

---

### Issue 2: `Daemon Status: NeedsLogin`
- **Symptom:** Client daemon is running but disconnected.
- **Root Cause:** Session expired or valid setup key required.
- **Resolution:**
  ```bash
  sudo netbird up --management-url https://netbird.example.com --setup-key <YOUR_SETUP_KEY>
  ```

---

### Issue 3: Container gRPC Connection Timeout Behind Traefik
- **Symptom:** gRPC requests to `/signalexchange.*` or `/management.*` return HTTP 502/504 error.
- **Root Cause:** Missing `h2c` scheme in Traefik service definition for gRPC cleartext forwarding.
- **Resolution:** Verify `traefik.http.services.netbird-grpc-svc.loadbalancer.server.scheme=h2c` label in `docker-compose.yml`.
