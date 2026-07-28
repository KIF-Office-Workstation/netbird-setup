# Changelog - NetBird Infrastructure Deployment (`netbird-setup`)

All notable changes to the NetBird deployment infrastructure, security configurations, scripts, and documentation will be recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.2.0] - 2026-07-28

### Fixed & Hardened
- **Exact Tag Pinning:** Pinned container images to exact release tags: `netbirdio/netbird-server:0.75.1`, `netbirdio/dashboard:0.75.1`, and `traefik:v3.6`. Removed all `latest` tag references.
- **Unified Configuration Schema:** Replaced legacy config keys in `config/config.yaml.example` with modern `server:` root schema matching official NetBird combined server `v0.75.1`.
- **Public Firewall Port Cleanup:** Removed UDP port `51820` from public firewall rules matrix and `docker-compose.yml.example`, restricting open public ingress ports strictly to `80/tcp`, `443/tcp`, and `3478/udp`.
- **Enhanced Deploy Script Inspection Mode:** Upgraded `scripts/deploy_netbird_server.sh` `--inspect` flag to download installer, record final redirected URL, compute SHA256 checksum, perform `bash -n` syntax check, output complete script content, and exit cleanly without executing.
- **Mandatory Backup Enforcement:** Updated `scripts/deploy_netbird_server.sh` to abort deployment immediately if backup fails on existing deployment, requiring explicit `--force-without-backup` flag to override.
- **Evidence-Based Validation Reporting:** Created comprehensive verification report in `reports/validation_report.md` categorizing results into `PASSED`, `FAILED`, `NOT EXECUTED`, and `BLOCKED BY ENVIRONMENT`.

## [1.1.0] - 2026-07-28
- Architecture migration to combined server model.

## [1.0.0] - 2026-07-28
- Initial release of NetBird setup repository.
