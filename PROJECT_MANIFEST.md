# Project Manifest: NetBird Infrastructure Deployment (`netbird-setup`)

**Repository Name:** `KIF-Office-Workstation/netbird-setup`  
**GitHub URL:** `https://github.com/KIF-Office-Workstation/netbird-setup.git`  
**NetBird Release Alignment:** `netbirdio/netbird-server:latest` / `netbirdio/dashboard:latest` / NetBird Client `v0.75.0`  
**Architecture:** Modern Combined Container (`netbird-server` + Traefik v3)  
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

### Directory Inventory (`docs/` Tree)

- **`docs/installation_guide.md`**: Modern server & client deployment guide.
- **`docs/validation_tests.md`**: Health check test suite and verification matrix.
- **`docs/architecture/system_architecture.md`**: Combined container specification & interaction flow.
- **`docs/architecture/architecture_diagram.mermaid`**: Mermaid diagram source.
- **`docs/network/network_topology.md`**: CGNAT `100.64.0.0/16` addressing, WireGuard P2P, & Relay fallback.
- **`docs/network/performance_notes.md`**: MTU tuning, throughput metrics, socket buffer optimization.
- **`docs/security/security_hardening.md`**: Cryptographic standards (ChaCha20-Poly1305), ZTNA, access rules.
- **`docs/security/firewall_rules.sh`**: Host UFW firewall hardening script (Least Privilege).
- **`docs/maintenance/backup_recovery_procedure.md`**: Automated daily backups & disaster recovery workflow.
- **`docs/maintenance/upgrade_procedure.md`**: Docker Compose container & client upgrade & rollback steps.
- **`docs/troubleshooting/troubleshooting_guide.md`**: Diagnostics manual for common error states.

### Operational Directories
- **`config/`**: Sanitized templates (`docker-compose.yml.example`, `config.yaml.example`, `dashboard.env.example`, `netbird-client.cfg.example`, `firewall_rules.conf`).
- **`scripts/`**: Operational bash scripts (`deploy_netbird_server.sh`, `install_netbird_client.sh`, `backup_netbird.sh`, `restore_netbird.sh`, `health_check.sh`, `test_mesh_connectivity.sh`).
- **`reports/`**: Audit reports ([deployment_report.md](reports/deployment_report.md), [validation_report.md](reports/validation_report.md)).
- **`images/`**: Topology SVG diagram (`topology_diagram.svg`).

---

## 🛠️ Least Privilege Firewall Port Matrix

| Port | Protocol | Scope | Required Purpose |
| :--- | :--- | :--- | :--- |
| **`80`** | TCP | Public Ingress | HTTP ACME Let's Encrypt challenge & HTTPS redirect |
| **`443`** | TCP | Public Ingress | Unified HTTPS (Dashboard, gRPC Management/Signal, Relay WebSockets) |
| **`3478`** | UDP | Public Ingress | NetBird STUN Service for NAT IP/port discovery |
| **`51820`** | UDP | Public Ingress | WireGuard Direct Peer-to-Peer Encrypted Overlay |
| `10000` | TCP | Docker Bridge | Internal Container Signal gRPC (Proxied over 443) |
| `33073` | TCP | Docker Bridge | Internal Container Management gRPC (Proxied over 443) |

---

## 🔒 Secret & Infrastructure Privacy Assessment

- All passwords, tokens, API keys, setup keys, and private keys have been sanitized.
- Server IPs and domain names are replaced with generic placeholders (`netbird.example.com`).
- `.gitignore` blocks all sensitive data types (`*.pem`, `*.key`, `*.db`, `*.env`, `acme.json`).
