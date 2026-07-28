# NetBird Modern Self-Hosted Server & Client Installation Guide

This document provides complete instructions for installing and deploying the modern combined NetBird server stack (`netbirdio/netbird-server`) and NetBird client nodes.

---

## 1. Prerequisites & System Specifications

| Component | Minimum Specification | Recommended Production |
| :--- | :--- | :--- |
| **Operating System** | Ubuntu 22.04 LTS / Debian 12 | Ubuntu 22.04 LTS / Debian 12 |
| **CPU / RAM** | 1 vCPU / 1 GB RAM | 2 vCPUs / 2 - 4 GB RAM |
| **Disk Space** | 10 GB SSD | 20+ GB NVMe |
| **Public Ports (Least Privilege)** | TCP 80, TCP 443, UDP 3478, UDP 51820 | Same |
| **Domain Requirement** | Fully Qualified Domain Name (e.g. `netbird.example.com`) | Same |

---

## 2. Server Deployment (Combined Container Architecture)

The modern NetBird deployment combines Management, Signal, STUN, and Relay services into a single container image (`netbirdio/netbird-server`). Reverse proxying and TLS certificate management are handled by Traefik.

### Automated Safe Deployment
```bash
chmod +x ./scripts/deploy_netbird_server.sh
./scripts/deploy_netbird_server.sh "netbird.example.com"
```

### Dry-Run / Inspection Mode
To inspect the installer script before execution:
```bash
./scripts/deploy_netbird_server.sh --inspect
```

---

## 3. Client Agent Installation

### A. Linux Node (Debian / Ubuntu)
```bash
curl -fsSL https://pkgs.netbird.io/install.sh | sudo sh
```
Or execute the automated client script:
```bash
chmod +x ./scripts/install_netbird_client.sh
./scripts/install_netbird_client.sh "<YOUR_SETUP_KEY>" "https://netbird.example.com"
```

### B. Windows Host Node
```powershell
winget install netbird.netbird
```

---

## 4. Registering Nodes & Verifying Status

Connect the node to your self-hosted management server:
```bash
sudo netbird up --management-url https://netbird.example.com:443 --setup-key <YOUR_SETUP_KEY>
```

Verify status detail:
```bash
sudo netbird status --detail
```

Expected Output:
```text
Peers detail:
 netbird-peer-01:
  NetBird IP: 100.64.0.2
  Public key: ...
  Status: Connected
  Connection type: Direct (or Relayed via WebSockets/QUIC fallback)
```
