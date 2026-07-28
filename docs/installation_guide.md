# NetBird Complete Production Installation & Setup Guide

This document provides step-by-step instructions for deploying NetBird (Self-Hosted Control Plane and NetBird Client Overlay Nodes) on Linux and Windows infrastructure.

---

## 1. Environment & Prerequisites

Before installing NetBird, ensure your environment meets the following specifications:

| Resource | Minimum Requirement | Recommended Production |
| :--- | :--- | :--- |
| **OS** | Ubuntu 20.04 LTS / 22.04 LTS / Debian 11+ | Ubuntu 22.04 LTS / Debian 12 |
| **CPU** | 1 vCPU | 2+ vCPUs |
| **RAM** | 1 GB | 2 GB - 4 GB |
| **Disk** | 10 GB SSD | 20+ GB NVMe |
| **Public Ports** | UDP 51820, UDP/TCP 3478, TCP 10000, TCP 33073, TCP 80/443 | Same |

---

## 2. Server Stack Installation (Docker Compose)

To deploy the full NetBird Self-Hosted Control Plane (Management, Signal, Coturn STUN/TURN, Dashboard UI, Traefik Reverse Proxy):

1. **Set Domain Name:**
   ```bash
   export NETBIRD_DOMAIN="netbird.yourdomain.com"
   ```

2. **Execute Deployment Automation Script:**
   ```bash
   chmod +x ./scripts/deploy_netbird_server.sh
   ./scripts/deploy_netbird_server.sh "$NETBIRD_DOMAIN"
   ```

3. **Verify Active Containers:**
   ```bash
   docker compose ps
   ```

---

## 3. Client Node Installation

NetBird Agent Client must be installed on all infrastructure nodes that will participate in the secure mesh network.

### A. Linux Node (Ubuntu / Debian / RHEL)
Run the official NetBird client installer:
```bash
curl -fsSL https://pkgs.netbird.io/install.sh | sudo sh
```
Or execute the repository script:
```bash
chmod +x ./scripts/install_netbird_client.sh
./scripts/install_netbird_client.sh "<YOUR_SETUP_KEY>"
```

### B. Windows Host Node
Download the official MSI installer or execute via PowerShell:
```powershell
winget install netbird.netbird
```
Or run the daemon in background.

---

## 4. Registering & Connecting Nodes

1. **Self-Hosted Management URL Connection:**
   ```bash
   sudo netbird up --management-url https://netbird.yourdomain.com:443 --setup-key YOUR_SETUP_KEY
   ```

2. **NetBird Cloud Connection:**
   ```bash
   sudo netbird up --setup-key YOUR_SETUP_KEY
   ```

3. **Verify Interface & Peer Status:**
   ```bash
   sudo netbird status --detail
   ```

---

## 5. Verifying WireGuard Network Interface

Once connected, NetBird automatically initializes a WireGuard kernel/userspace network interface (`wt0` or `netbird0`) and assigns an overlay IP address (`100.x.y.z`).

Check active network interfaces:
```bash
ip addr show wt0
```
Output:
```text
wt0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq_codel state UNKNOWN group default qlen 500
    inet 100.64.0.1/16 scope global wt0
```
