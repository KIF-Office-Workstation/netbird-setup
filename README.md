# NetBird Windows Client Setup (`netbird-setup`)

[![License](https://img.shields.io/badge/License-BSD--3--Clause-green.svg)](LICENSE)
[![Repository](https://img.shields.io/badge/GitHub-KIF--Office--Workstation%2Fnetbird--setup-black.svg)](https://github.com/KIF-Office-Workstation/netbird-setup.git)

This repository (`netbird-setup`) is the **source of truth** for installing, configuring, maintaining, and verifying the **NetBird Windows Client** on the Office Workstation (Windows 10 Pro) to ensure continuous, 24/7 zero-trust mesh connectivity.

---

## 🎯 Target System Specifications

- **Operating System:** Windows 10 Pro (x64)
- **Role:** Office Workstation (24/7 operational node)
- **Target Software:** Official NetBird Windows Client (`NetBird` Windows Service + GUI / CLI)
- **Network Scope:** WireGuard Overlay Mesh Network (`100.64.0.0/10`)

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
│   ├── installation_guide.md          # Windows Client setup & service guide
│   ├── validation_tests.md            # Test suite & verification matrix
│   ├── maintenance/
│   │   ├── backup_recovery_procedure.md # Client profile backup & restore
│   │   └── upgrade_procedure.md       # NetBird Client update procedure
│   └── troubleshooting/
│       └── troubleshooting_guide.md   # Windows service & WireGuard diagnostics
├── config/                            # Sanitized Configuration Templates
│   └── netbird-client.cfg.example     # Client profile configuration sample
├── scripts/                           # Operational Automation Scripts
│   ├── install_netbird_client.ps1     # PowerShell installer for Windows
│   ├── install_netbird_client.sh       # Shell installation script
│   ├── health_check.sh                # Client health diagnostic reporter
│   └── test_mesh_connectivity.sh      # Mesh latency & ping validator
├── reports/                           # Audit & Handover Reports
│   └── 20260728_161613_SCOPE_CORRECTION_AND_OUT_OF_SCOPE_AUDIT.md
└── archive/                           # Archived Out-of-Scope Server Templates
    └── server_templates/             # Self-hosted server deployment assets
```

---

## 🚀 Quickstart: Windows Client Installation

### 1. Verify Environment & Download Official NetBird Installer
Run PowerShell as Administrator:
```powershell
Get-Service -Name "NetBird*" -ErrorAction SilentlyContinue
```

### 2. Execute Installation
Use the official NetBird Windows installer executable/MSI from the official GitHub release:
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install_netbird_client.ps1
```

### 3. Connect to NetBird Network
To log in interactively or connect using an authorized Setup Key:
```cmd
netbird up --setup-key <YOUR_SETUP_KEY>
```

---

## 🛠️ Key Operations Summary

| Action | Command / Script |
| :--- | :--- |
| **Check Client Status** | `netbird status --detail` |
| **Check Windows Service** | `Get-Service -Name NetBird` |
| **Connect Client** | `netbird up` |
| **Disconnect Client** | `netbird down` |
| **Run Health Check** | `.\scripts\health_check.sh` |

---

## 📚 Relative Documentation Index

- [Installation & Setup Guide](docs/installation_guide.md)
- [Troubleshooting & Diagnostics](docs/troubleshooting/troubleshooting_guide.md)
- [Backup & Disaster Recovery](docs/maintenance/backup_recovery_procedure.md)
- [Upgrade & Maintenance Procedure](docs/maintenance/upgrade_procedure.md)
- [Validation Test Suite](docs/validation_tests.md)
- [Scope Correction Audit Report](reports/20260728_161613_SCOPE_CORRECTION_AND_OUT_OF_SCOPE_AUDIT.md)
