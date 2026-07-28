# Project Manifest: NetBird Infrastructure Deployment (`netbird-setup`)

**Repository Name:** `KIF-Office-Workstation/netbird-setup`  
**Deployment Target:** `server.muhager.com` (`178.105.49.9`) & WSL Client Nodes  
**NetBird Release:** `v0.75.0` (Stable)  
**License:** BSD 3-Clause  

---

## 📋 System Component & File Inventory

### Root Files
| File Name | Purpose |
| :--- | :--- |
| **`README.md`** | Main entry point, quickstart, system architecture overview |
| **`PROJECT_MANIFEST.md`** | Complete system inventory, environment specs, and file index |
| **`INSTALL_LOG.md`** | Chronological shell execution logs and installation output |
| **`CHANGELOG.md`** | Version history and infrastructure modification log |
| **`LICENSE`** | BSD 3-Clause Open Source License |
| **`.gitignore`** | Excludes state files, SQLite DBs, private keys, certificates, `.env` |

---

### Directory Inventory

#### `docs/` - Complete Documentation Suite
- **`docs/installation_guide.md`**: Step-by-step NetBird client & server installation guide.
- **`docs/validation_tests.md`**: Health check test suite and verification matrix.

#### `docs/architecture/` - Architecture & System Specifications
- **`docs/architecture/system_architecture.md`**: Component interaction models, gRPC ports, data layer.
- **`docs/architecture/architecture_diagram.mermaid`**: Mermaid diagram source for mesh network.

#### `docs/network/` - Network Topology & Performance
- **`docs/network/network_topology.md`**: CGNAT `100.64.0.0/16` addressing, WireGuard P2P, Coturn TURN relay.
- **`docs/network/performance_notes.md`**: MTU tuning, throughput metrics, socket buffer optimization.

#### `docs/security/` - Security Hardening & Firewall Matrix
- **`docs/security/security_hardening.md`**: Cryptographic standards (ChaCha20-Poly1305), ZTNA, access rules.

#### `docs/maintenance/` - Maintenance, Backup, & Recovery
- **`docs/maintenance/backup_recovery_procedure.md`**: Automated daily backups, disaster recovery workflow.
- **`docs/maintenance/upgrade_procedure.md`**: Docker Compose and client upgrade & rollback steps.

#### `docs/troubleshooting/` - Diagnostics & Error Fixes
- **`docs/troubleshooting/troubleshooting_guide.md`**: Step-by-step troubleshooting for common error states.

#### `config/` - Sanitized Configuration Templates
- **`config/docker-compose.yml.example`**: NetBird self-hosted server docker-compose stack template.
- **`config/config.yaml.example`**: NetBird management service configuration template.
- **`config/dashboard.env.example`**: Dashboard UI environment variable template.
- **`config/netbird-client.cfg.example`**: Client default profile configuration sample.
- **`config/firewall_rules.conf`**: Firewall port matrix rules reference.

#### `scripts/` - Operational Automation Scripts
- **`scripts/deploy_netbird_server.sh`**: Automated server stack installer script.
- **`scripts/install_netbird_client.sh`**: Client installation & setup key registration script.
- **`scripts/backup_netbird.sh`**: Automated backup tarball generator.
- **`scripts/restore_netbird.sh`**: Disaster recovery restoration script.
- **`scripts/health_check.sh`**: Diagnostics and health reporter script.
- **`scripts/test_mesh_connectivity.sh`**: Peer ping and latency testing tool.

#### `security/` - Host Security Automation
- **`security/firewall_rules.sh`**: UFW firewall hardening script for Linux hosts.

#### `reports/` - Verification Reports
- **`reports/deployment_report.md`**: Handover deployment sign-off report.
- **`reports/validation_report.md`**: Health check test results matrix.

---

## 🛠️ Infrastructure & Environment Specifications

| Parameter | Server Node Specification | Client Peer Specification |
| :--- | :--- | :--- |
| **OS** | Ubuntu 22.04.5 LTS (Jammy) | Windows / WSL Ubuntu |
| **Public IP** | `178.105.49.9` | Dynamic CGNAT / Local Subnet |
| **NetBird Mesh IP** | `100.64.0.1` | `100.64.0.2` |
| **WireGuard Interface** | `wt0` (MTU 1280) | `wt0` (MTU 1280) |
| **Open Ingress Ports** | UDP 51820, UDP/TCP 3478, TCP 10000, TCP 33073, TCP 80/443 | Outbound UDP 51820, TCP 443 |
| **Auth Method** | Single-User / Setup Keys / OIDC SSO | Setup Keys / SSO |

---

## 🔒 Secret Exclusion Policy

The following sensitive files are strictly excluded via `.gitignore` and MUST NOT be committed to version control:
- `*.env`, `*.env.local`
- `*.key`, `*.pem`, `*.crt`
- `management.json`, `default.json`, `active_profile.json`, `service.json`
- `management.db`, `signal.state`, `management.state`
- `*.tar.gz`, `/var/backups/netbird/`
