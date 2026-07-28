# Office Workstation Module Manifest: NetBird (`netbird-setup`)

**Parent Program:** `Office Workstation`  
**Module:** `NetBird Zero-Trust Network Infrastructure`  
**Repository Name:** `KIF-Office-Workstation/netbird-setup`  
**GitHub URL:** `https://github.com/KIF-Office-Workstation/netbird-setup.git`  
**Governance:** [`GOVERNANCE.md`](GOVERNANCE.md)  
**NetBird Release Alignment:** `v0.75.1` (Official Release API Verified)  
**Independently Verified Pinned Container Images:**  
- `netbirdio/netbird-server:0.75.1` (AGPLv3)
- `netbirdio/dashboard:v2.90.7` (Independent Release Tag)
- `traefik:v3.6`

**Architecture:** Official Combined Container (`netbird-server` + Traefik v3)  
**Licensing:** BSD 3-Clause (Client & Tooling) / AGPLv3 (Server Components)

## Permanent Scope Statement

This manifest covers only the NetBird module within the broader **Office Workstation** program.

NetBird is not the identity or complete scope of Office Workstation. It is one documented component among current and future workstation tools, services, security controls, development environments, automation systems, and supporting infrastructure.

The permanent parent identity and change restrictions are defined in `GOVERNANCE.md` and must be preserved by every future contributor and agent.

---

## 📋 System Component & File Inventory

### Root Files
| File Name | Purpose |
| :--- | :--- |
| **`README.md`** | Office Workstation identity, NetBird module overview, quickstart, and index |
| **`GOVERNANCE.md`** | Permanent project charter, source-of-truth policy, and agent restrictions |
| **`PROJECT_MANIFEST.md`** | NetBird module inventory, environment specifications, and component index |
| **`INSTALL_LOG.md`** | Chronological shell execution logs and verification history |
| **`CHANGELOG.md`** | Version history and infrastructure modification log |
| **`LICENSE`** | BSD 3-Clause & AGPLv3 dual license specification |
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
