# NetBird Production Infrastructure Deployment (`netbird-setup`)

[![NetBird Version](https://img.shields.io/badge/NetBird-v0.75.0%20Stable-blue.svg)](https://netbird.io)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Deployment-Production%20Ready-brightgreen.svg)]()

This repository (`netbird-setup`) is the **permanent source of truth** for deploying, configuring, maintaining, and recovering the NetBird Zero-Trust Mesh Network infrastructure across production nodes.

---

## 📁 Repository Structure

```text
netbird-setup/
├── README.md                          # Main repository overview & quickstart
├── INSTALL_LOG.md                     # Step-by-step execution log of deployment
├── CHANGELOG.md                       # History of changes and release notes
├── docs/                              # Comprehensive documentation suite
│   ├── installation_guide.md          # Full installation manual (Server & Clients)
│   ├── network_topology.md            # Mesh overlay, WireGuard, & CGNAT topology
│   ├── upgrade_procedure.md           # Upgrade and maintenance workflows
│   ├── backup_recovery_procedure.md   # Backup, restore, and disaster recovery
│   ├── validation_tests.md            # Verification test suite & test cases
│   └── performance_notes.md           # Benchmarks, MTU tuning, & optimizations
├── config/                            # Sanitized configuration templates
│   ├── docker-compose.yml.example     # NetBird self-hosted server docker compose
│   ├── config.yaml.example            # Management service config schema
│   ├── dashboard.env.example          # Dashboard UI environment settings
│   ├── netbird-client.cfg.example     # Client profile configuration sample
│   └── firewall_rules.conf            # Production UFW/iptables port matrix
├── scripts/                           # Operational automation scripts
│   ├── deploy_netbird_server.sh       # Server stack deployment automation
│   ├── install_netbird_client.sh       # Client installation & key registration
│   ├── backup_netbird.sh              # Automated backup generator
│   ├── restore_netbird.sh             # Disaster recovery restoration script
│   ├── health_check.sh                # Diagnostics & health check reporter
│   └── test_mesh_connectivity.sh      # Mesh ping & latency validation tool
├── architecture/                      # Architecture specifications & diagrams
│   ├── system_architecture.md         # Component breakdown & interaction flow
│   └── architecture_diagram.mermaid   # Mermaid diagram source
├── security/                          # Security hardening & Zero-Trust policies
│   ├── security_hardening.md          # Cryptographic standards & ZTNA guide
│   └── firewall_rules.sh              # Host firewall hardening script
├── troubleshooting/                   # Troubleshooting & error resolution
│   └── troubleshooting_guide.md       # Diagnostic workflows & common fixes
├── images/                            # Architectural & topology visual assets
│   └── topology_diagram.svg           # High-resolution network topology SVG
└── reports/                           # Executive & validation audit reports
    ├── deployment_report.md           # Final deployment sign-off report
    └── validation_report.md           # Verification test suite execution report
```

---

## 🚀 Quickstart: Reproducing Deployment on a New Machine

To deploy NetBird on a fresh machine using this repository:

### 1. Clone the Repository
```bash
git clone https://github.com/your-org/netbird-setup.git
cd netbird-setup
```

### 2. Run Host Firewall Hardening
```bash
chmod +x ./security/firewall_rules.sh
sudo ./security/firewall_rules.sh
```

### 3. Deploy NetBird Client
```bash
chmod +x ./scripts/install_netbird_client.sh
sudo ./scripts/install_netbird_client.sh "<YOUR_SETUP_KEY>"
```

### 4. Deploy NetBird Self-Hosted Control Plane (Optional)
If self-hosting the NetBird Management, Signal, and Dashboard server stack:
```bash
chmod +x ./scripts/deploy_netbird_server.sh
sudo ./scripts/deploy_netbird_server.sh "netbird.yourdomain.com"
```

### 5. Validate Health & Connectivity
```bash
chmod +x ./scripts/health_check.sh ./scripts/test_mesh_connectivity.sh
sudo ./scripts/health_check.sh
```

---

## 🔒 Security & Secrets Hygiene

> [!IMPORTANT]
> **No secrets, tokens, or private credentials are stored in this repository.**
> All files under `/config` contain sanitized placeholders (`YOUR_SECRET_HERE`, `YOUR_SETUP_KEY`).
> The repository `.gitignore` strictly blocks state files (`*.json`, `*.state`, `*.db`) and `.env` files.

---

## 🛠️ Key Operations Summary

| Action | Command / Script |
| :--- | :--- |
| **System Diagnostics** | `./scripts/health_check.sh` |
| **Test Mesh Connectivity** | `./scripts/test_mesh_connectivity.sh 100.64.0.x` |
| **Create System Backup** | `sudo ./scripts/backup_netbird.sh` |
| **Restore System State** | `sudo ./scripts/restore_netbird.sh /path/to/backup.tar.gz` |
| **Check Daemon Detail** | `sudo netbird status --detail` |

---

## 📚 Detailed Documentation Index

- [Installation & Setup Guide](file:///docs/installation_guide.md)
- [Network Topology & Mesh Architecture](file:///docs/network_topology.md)
- [System Architecture Specification](file:///architecture/system_architecture.md)
- [Security Hardening & ZTNA](file:///security/security_hardening.md)
- [Troubleshooting & Diagnostics](file:///troubleshooting/troubleshooting_guide.md)
- [Backup & Disaster Recovery](file:///docs/backup_recovery_procedure.md)
- [Upgrade & Maintenance Procedure](file:///docs/upgrade_procedure.md)
- [Validation Test Suite](file:///docs/validation_tests.md)
- [Deployment Sign-off Report](file:///reports/deployment_report.md)
