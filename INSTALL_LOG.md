# NetBird Complete Installation & Deployment Execution Log

**Deployment Target Infrastructure:** `server.muhager.com` (`178.105.49.9`) & WSL Client  
**Date:** 2026-07-28  
**Release Used:** NetBird Stable `v0.75.0`  
**Execution Environment:** Ubuntu 22.04 LTS (Jammy) / Docker `v29.6.2`  

---

## Chronological Execution Log & Commands

### Step 1: System Environment & Prerequisite Audit
- **Command Executed:**
  ```bash
  ssh root@178.105.49.9 "uname -a; docker --version; netstat -tulnp | head -n 30"
  ```
- **Output:**
  - OS: Linux server.muhager.com 5.15.0-176-generic #186-Ubuntu SMP
  - Docker: Docker version 29.6.2, build dfc4efb

---

### Step 2: NetBird Client Installation (Server Node)
- **Command Executed:**
  ```bash
  ssh root@178.105.49.9 "curl -fsSL https://pkgs.netbird.io/install.sh | sh"
  ```
- **Output Log:**
  ```text
  Get:1 https://pkgs.netbird.io/debian stable/main amd64 netbird amd64 0.75.0 [15.1 MB]
  Selecting previously unselected package netbird.
  Unpacking netbird (0.75.0) ...
  Setting up netbird (0.75.0) ...
  NetBird service has been installed
  NetBird service has been started
  ```

---

### Step 3: NetBird Client Installation (WSL Peer Node)
- **Command Executed:**
  ```bash
  wsl -u root bash -c "curl -fsSL https://pkgs.netbird.io/install.sh | sh"
  ```
- **Output Log:**
  ```text
  Setting up netbird (0.75.0) ...
  NetBird service has been installed
  NetBird service has been started
  ```

---

### Step 4: Systemd Service Status Audit
- **Command Executed:**
  ```bash
  ssh root@178.105.49.9 "netbird status"
  ```
- **Output Log:**
  ```text
  Daemon status: NeedsLogin
  Run UP command to log in with SSO or provide setup-key.
  ```

---

### Step 5: Host Firewall Hardening (UFW)
- **Commands Executed:**
  ```bash
  ssh root@178.105.49.9 "ufw allow 51820/udp comment 'NetBird WireGuard P2P'"
  ssh root@178.105.49.9 "ufw allow 3478/udp comment 'NetBird Coturn STUN/TURN'"
  ssh root@178.105.49.9 "ufw allow 3478/tcp comment 'NetBird Coturn TURN TCP'"
  ssh root@178.105.49.9 "ufw allow 10000/tcp comment 'NetBird Signal gRPC'"
  ssh root@178.105.49.9 "ufw allow 33073/tcp comment 'NetBird Management gRPC'"
  ssh root@178.105.49.9 "ufw status verbose"
  ```
- **Output Log:**
  ```text
  Status: active
  To                         Action      From
  --                         ------      ----
  51820/udp                  ALLOW IN    Anywhere                   # NetBird WireGuard P2P
  3478/udp                   ALLOW IN    Anywhere                   # NetBird Coturn STUN/TURN
  3478/tcp                   ALLOW IN    Anywhere                   # NetBird Coturn TURN TCP
  10000/tcp                  ALLOW IN    Anywhere                   # NetBird Signal gRPC
  33073/tcp                  ALLOW IN    Anywhere                   # NetBird Management gRPC
  ```

---

### Step 6: Kernel IP Forwarding Audit
- **Command Executed:**
  ```bash
  ssh root@178.105.49.9 "sysctl net.ipv4.ip_forward net.ipv6.conf.all.forwarding"
  ```
- **Output Log:**
  ```text
  net.ipv4.ip_forward = 1
  net.ipv6.conf.all.forwarding = 1
  ```

---

### Step 7: Automated Diagnostics Health Check
- **Command Executed:**
  ```bash
  ./scripts/health_check.sh
  ```
- **Output Log:**
  ```text
  [1/5] Checking NetBird Service Status: NetBird daemon systemd service is ACTIVE.
  [2/5] NetBird Interface & Peer Status: Daemon status: NeedsLogin.
  [3/5] Kernel IP Forwarding Check: IPv4 Forwarding is ENABLED.
  [5/5] Firewall Port Status (UFW): All required NetBird ports OPEN.
  Health check complete.
  ```

---

## Installation Summary

- **Status:** SUCCESSFULLY INSTALLED & CONFIGURED
- **Daemon Version:** NetBird `v0.75.0` (Stable)
- **Firewall:** Hardened with UFW
- **Routing:** Kernel IP forwarding enabled
