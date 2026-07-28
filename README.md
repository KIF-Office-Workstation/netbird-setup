# Office Workstation — NetBird Module (`netbird-setup`)

[![NetBird Version](https://img.shields.io/badge/NetBird-v0.75.1-blue.svg)](https://github.com/netbirdio/netbird/releases/tag/v0.75.1)
[![Dashboard Version](https://img.shields.io/badge/Dashboard-v2.90.7-blue.svg)](https://hub.docker.com/r/netbirdio/dashboard/tags)
[![License](https://img.shields.io/badge/License-BSD--3--Clause%20%2F%20AGPLv3-green.svg)](LICENSE)
[![Repository](https://img.shields.io/badge/GitHub-KIF--Office--Workstation%2Fnetbird--setup-black.svg)](https://github.com/KIF-Office-Workstation/netbird-setup.git)

## Permanent Project Identity

This repository belongs to the **Office Workstation** program.

The Office Workstation program is the permanent operational source of truth for the office computer, its development environment, supporting infrastructure, installed tools, security controls, automation, maintenance procedures, and change history.

**NetBird is one module of the Office Workstation ecosystem. It is not the identity or full scope of the project.**

The repository must never be redefined around NetBird, Docker, WSL, HestiaCP, an AI agent, or any other individual technology. Every technology is treated as a replaceable, documented component under the permanent Office Workstation identity.

See [GOVERNANCE.md](GOVERNANCE.md) for the binding project charter and change rules.

## Repository Purpose

Within the Office Workstation program, this repository currently documents the NetBird Zero-Trust networking module, including its configuration, deployment, validation, maintenance, recovery, and operational history aligned with NetBird release `v0.75.1`.

All future workstation components must follow the same documentation standard:

- installation reason and scope
- prerequisites and dependencies
- exact installation and configuration steps
- security considerations
- validation and health checks
- upgrade and rollback procedures
- removal procedure
- operational reports and change history

---

## ⚖️ Licensing Model

- **Client & Deployment Tooling:** BSD 3-Clause License.
- **Server Stack (`netbird-server` combined management, signal, relay):** GNU Affero General Public License v3.0 (AGPLv3).
- **Self-Hosted Use:** 100% free and open-source for self-hosted operational deployments under the respective licenses. See [LICENSE](LICENSE) for details.

---

## 📁 Repository Structure

```text
KIF-Office-Workstation/netbird-setup/
├── README.md                          # Office Workstation identity + NetBird module overview
├── GOVERNANCE.md                      # Permanent project charter and non-negotiable rules
├── PROJECT_MANIFEST.md                # Module manifest & component inventory
├── INSTALL_LOG.md                     # Deployment execution log
├── CHANGELOG.md                       # Release notes & version history
├── LICENSE                            # Dual License Specification (BSD 3-Clause / AGPLv3)
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
│   ├── docker-compose.yml.example     # Combined netbird-server docker-compose (v0.75.1 / v2.90.7)
│   ├── config.yaml.example            # Unified server config schema (v0.75.1)
│   ├── dashboard.env.example          # Dashboard UI environment settings
│   ├── netbird-client.cfg.example     # Client profile configuration sample
│   └── firewall_rules.conf            # Production port matrix (Least Privilege: 80, 443, 3478)
├── scripts/                           # Operational Automation Scripts
│   ├── deploy_netbird_server.sh       # Safe server deployment script with inspection mode
│   ├── install_netbird_client.sh      # Client installation script
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

## 🚀 Quickstart: Reproducing the NetBird Module

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

### 3. Inspect & Run Server Stack Deployment
```bash
chmod +x ./scripts/deploy_netbird_server.sh
./scripts/deploy_netbird_server.sh --inspect
sudo ./scripts/deploy_netbird_server.sh "netbird.example.com"
```

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

- [Project Governance & Permanent Charter](GOVERNANCE.md)
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
