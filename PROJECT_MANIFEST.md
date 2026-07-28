# Project Manifest: NetBird Infrastructure Deployment (`netbird-setup`)

**Repository Name:** `KIF-Office-Workstation/netbird-setup`  
**GitHub URL:** `https://github.com/KIF-Office-Workstation/netbird-setup.git`  
**NetBird Pinned Release Alignment:** `v0.75.1`  
**Pinned Container Images:** `netbirdio/netbird-server:0.75.1` | `netbirdio/dashboard:0.75.1` | `traefik:v3.6`  
**Architecture:** Official Combined Container (`netbird-server` + Traefik v3)  
**License:** BSD 3-Clause  

---

## 📋 System Component & File Inventory

### Root Files
| File Name | Purpose |
| :--- | :--- |
| **`README.md`** | Master documentation, quickstart, relative index |
| **`PROJECT_MANIFEST.md`** | System inventory, environment specs, and component index |
| **`INSTALL_LOG.md`** | Chronological shell execution logs and verification history |
| **`CHANGELOG.md`** | Version history and infrastructure modification log |
| **`LICENSE`** | BSD 3-Clause Open Source License |
| **`.gitignore`** | Strict exclusion rules for secrets, DBs, certs, and state files |

---

## 🛠️ Least Privilege Firewall Port Matrix

| Port | Protocol | Scope | Required Purpose |
| :--- | :--- | :--- | :--- |
| **`80`** | TCP | Public Ingress | HTTP ACME Let's Encrypt challenge & HTTPS redirect |
| **`443`** | TCP | Public Ingress | Unified HTTPS (Dashboard, gRPC Management/Signal, Relay WebSockets) |
| **`3478`** | UDP | Public Ingress | NetBird STUN/TURN Service for NAT IP/port discovery |
| `10000` | TCP | Docker Bridge | Internal Container Signal gRPC (Proxied over 443) |
| `33073` | TCP | Docker Bridge | Internal Container Management gRPC (Proxied over 443) |

---

## 🔒 Secret & Infrastructure Privacy Assessment

- All passwords, tokens, API keys, setup keys, and private keys have been sanitized.
- Server IPs and domain names are replaced with generic placeholders (`netbird.example.com`).
- `.gitignore` blocks all sensitive data types (`*.pem`, `*.key`, `*.db`, `*.env`, `acme.json`).
