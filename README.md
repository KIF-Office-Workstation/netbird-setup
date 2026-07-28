# NetBird Production Infrastructure Deployment (`netbird-setup`)

[![NetBird Version](https://img.shields.io/badge/NetBird-v0.75.1-blue.svg)](https://github.com/netbirdio/netbird/releases/tag/v0.75.1)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-green.svg)](LICENSE)
[![Repository](https://img.shields.io/badge/GitHub-KIF--Office--Workstation%2Fnetbird--setup-black.svg)](https://github.com/KIF-Office-Workstation/netbird-setup.git)

This repository (`netbird-setup`) is the **permanent source of truth** for deploying, configuring, maintaining, and recovering the NetBird Zero-Trust Mesh Network infrastructure aligned with official NetBird release `v0.75.1`.

---

## 📁 Repository Structure

```text
KIF-Office-Workstation/netbird-setup/
├── README.md                          # Main repository overview & quickstart
├── PROJECT_MANIFEST.md                # System manifest & component inventory
├── INSTALL_LOG.md                     # Deployment execution log
├── CHANGELOG.md                       # Release notes & version history
├── LICENSE                            # BSD 3-Clause License
├── .gitignore                         # Secret, state, & database exclusion rules
├── docs/                              # Technical Documentation Suite
│   ├── installation_guide.md          # Server & Client setup guide
│   ├── validation_tests.md            # Test suite & verification matrix
│   ├── architecture/
│   │   ├── system_architecture.md     # Combined container architecture specs
│   │   └── architecture_diagram.mermaid # Mermaid architecture source
│   ├── network/
│   │   ├── network_topology.md        # Mesh overlay, WireGuard, & CGNAT topology
│   │   └── performance_notes.md       # Benchmarks & MTU optimization
│   ├── security/
│   │   ├── security_hardening.md      # Zero-Trust & cryptographic standards
│   │   └── firewall_rules.sh          # UFW least-privilege firewall script
│   ├── maintenance/
│   │   ├── backup_recovery_procedure.md # Backup, restore, & disaster recovery
│   │   └── upgrade_procedure.md       # Container & client upgrade procedure
│   └── troubleshooting/
│       └── troubleshooting_guide.md   # Troubleshooting & diagnostic workflows
├── config/                            # Sanitized Configuration Templates
│   ├── docker-compose.yml.example     # Combined netbird-server docker-compose (v0.75.1)
│   ├── config.yaml.example            # Unified server config schema (v0.75.1)
│   ├── dashboard.env.example          # Dashboard UI environment settings
│   ├── netbird-client.cfg.example     # Client profile configuration sample
│   └── firewall_rules.conf            # Production port matrix (Least Privilege: 80, 443, 3478)
├── scripts/                           # Operational Automation Scripts
│   ├── deploy_netbird_server.sh       # Safe server deployment script with inspection mode
│   ├── install_netbird_client.sh       # Client installation script
│   ├── backup_netbird.sh              # Automated backup generator
│   ├── restore_netbird.sh             # Disaster recovery restoration script
│   ├── health_check.sh                # System health diagnostic reporter
│   └── test_mesh_connectivity.sh      # Mesh latency & ping validator
├── reports/                           # Audit & Handover Reports
│   ├── deployment_report.md           # Executive deployment report
│   └── validation_report.md           # Verification test execution report
└── images/                            # Architectural Visual Assets
    └── topology_diagram.svg           # High-resolution network topology SVG
```

---

## 🚀 Quickstart: Reproducing Deployment

### 1. Clone the Repository
```bash
git clone https://github.com/KIF-Office-Workstation/netbird-setup.git
cd netbird-setup
```

### 2. Apply Host Firewall Hardening (Least Privilege: 80/tcp, 443/tcp, 3478/udp)
```bash
chmod +x ./docs/security/firewall_rules.sh
sudo ./docs/security/firewall_rules.sh
```

### 3. Deploy NetBird Client Agent
```bash
chmod +x ./scripts/install_netbird_client.sh
sudo ./scripts/install_netbird_client.sh "<YOUR_SETUP_KEY>" "https://netbird.example.com"
```

### 4. Deploy NetBird Server Stack (Official Combined Architecture v0.75.1)
```bash
chmod +x ./scripts/deploy_netbird_server.sh
sudo ./scripts/deploy_netbird_server.sh "netbird.example.com"
```
*To inspect the installer before running:*
```bash
./scripts/deploy_netbird_server.sh --inspect
```

### 5. Validate Health & Mesh Connectivity
```bash
chmod +x ./scripts/health_check.sh ./scripts/test_mesh_connectivity.sh
sudo ./scripts/health_check.sh
```

---

## 🔒 Security & Public Repository Recommendation

> [!IMPORTANT]
> **No secrets, tokens, or private credentials are stored in this repository.**
> All files under `config/` contain sanitized placeholders (`YOUR_SECRET_HERE`, `YOUR_SETUP_KEY`).
> The repository `.gitignore` strictly blocks state files (`*.json`, `*.state`, `*.db`), `.env` files, and certificates.

---

## 🛠️ Key Operations Summary

| Action | Command / Script |
| :--- | :--- |
| **System Health Check** | `./scripts/health_check.sh` |
| **Test Mesh Connectivity** | `./scripts/test_mesh_connectivity.sh 100.64.0.x` |
| **Create System Backup** | `sudo ./scripts/backup_netbird.sh` |
| **Restore System State** | `sudo ./scripts/restore_netbird.sh /path/to/backup.tar.gz` |
| **Check Daemon Detail** | `sudo netbird status --detail` |

---

## 📚 Relative Documentation Index

- [Installation & Setup Guide](docs/installation_guide.md)
- [Network Topology & Mesh Architecture](docs/network/network_topology.md)
- [System Architecture Specification](docs/architecture/system_architecture.md)
- [Security Hardening & ZTNA](docs/security/security_hardening.md)
- [Troubleshooting & Diagnostics](docs/troubleshooting/troubleshooting_guide.md)
- [Backup & Disaster Recovery](docs/maintenance/backup_recovery_procedure.md)
- [Upgrade & Maintenance Procedure](docs/maintenance/upgrade_procedure.md)
- [Validation Test Suite](docs/validation_tests.md)
- [Deployment Sign-off Report](reports/deployment_report.md)
- [Verification Audit Report](reports/validation_report.md)
