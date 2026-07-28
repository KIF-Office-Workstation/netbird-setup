# Changelog - NetBird Infrastructure Deployment (`netbird-setup`)

All notable changes to the NetBird deployment infrastructure, security configurations, scripts, and documentation will be recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2026-07-28

### Changed
- **Modern Architecture Migration:** Replaced legacy multi-container setup (`v0.28.0` management, signal, coturn) with the official combined `netbirdio/netbird-server` container architecture.
- **Firewall Least Privilege:** Refactored UFW firewall rules to expose only ports `80/tcp`, `443/tcp`, `3478/udp`, and `51820/udp`. Closed direct public exposure of internal gRPC ports `10000` and `33073`.
- **Safe Server Deployment Script:** Updated `scripts/deploy_netbird_server.sh` to eliminate unvalidated `curl | bash` execution, added installer inspection mode (`--inspect`), download validation, pre-modification state backup, and safe rollback error handling.
- **Unified Server Configuration:** Replaced `config/config.yaml.example` with the official unified `netbird-server` schema including embedded STUN, Relay, Dex IdP, and SQLite/PostgreSQL datastore options.
- **Documentation Normalization:** Replaced all absolute `file:///` URLs with GitHub relative markdown links across all documentation.
- **Gitignore Hardening:** Extended `.gitignore` to cover `.env.*`, `acme.json`, `setup.env`, `docker-compose.override.yml`, certificates, and SQLite databases.
- **Repository Remote URL Alignment:** Updated all documentation and configuration links to point to `https://github.com/KIF-Office-Workstation/netbird-setup.git`.

## [1.0.0] - 2026-07-28
- Initial release of NetBird setup repository.
