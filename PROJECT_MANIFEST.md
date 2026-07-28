# Project Manifest: NetBird Windows Client Setup (`netbird-setup`)

**Repository Name:** `KIF-Office-Workstation/netbird-setup`  
**GitHub URL:** `https://github.com/KIF-Office-Workstation/netbird-setup.git`  
**Project Scope:** NetBird Windows Client Installation & 24/7 Service Configuration  
**Target Operating System:** Windows 10 Pro (Office Workstation)  
**Target Component:** Official NetBird Windows Client (`netbird.exe` & `NetBird` Service)  
**Licensing:** BSD 3-Clause (NetBird Client Agent & CLI)  

---

## 📋 System Component & File Inventory

### Core Client Files & Scripts
| File Path | Purpose |
| :--- | :--- |
| **`README.md`** | Master documentation, Windows setup quickstart |
| **`PROJECT_MANIFEST.md`** | System inventory, environment specs, component index |
| **`INSTALL_LOG.md`** | Chronological execution log and verification history |
| **`CHANGELOG.md`** | Release notes and configuration modification log |
| **`LICENSE`** | BSD 3-Clause License Specification |
| **`.gitignore`** | Strict exclusion rules for secrets, keys, and local state |
| **`scripts/install_netbird_client.ps1`** | Automated PowerShell installer for NetBird Windows Client |
| **`scripts/install_netbird_client.sh`** | Cross-platform client installation script |
| **`scripts/health_check.sh`** | Client service & interface diagnostic script |
| **`config/netbird-client.cfg.example`** | Sanitized NetBird client configuration template |

### Archived Server Templates
| File Path | Original Purpose |
| :--- | :--- |
| **`archive/server_templates/`** | Preserved self-hosted server deployment templates (out of scope) |

---

## 🔒 Secret & Privacy Assessment

- No setup keys, user login tokens, or credentials are hardcoded or committed into Git.
- All configuration files use sanitized placeholders.
- Windows event logs and service status reports strictly filter out private keys and sensitive tokens.
