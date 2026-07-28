# Changelog - NetBird Infrastructure Deployment (`netbird-setup`)

All notable changes to the NetBird deployment infrastructure, security configurations, scripts, and documentation will be recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.3.0] - 2026-07-28

### Corrected & Verified
- **Release API Verification:** Verified official NetBird release `v0.75.1` (published `2026-07-28T09:05:32Z`) via GitHub Releases API.
- **Independent Dashboard Version Pinning:** Verified and pinned independent dashboard tag `netbirdio/dashboard:v2.90.7`, server tag `netbirdio/netbird-server:0.75.1`, and `traefik:v3.6`.
- **Installer HTTP Evidence:** Executed live HTTP request to verify installer URL, recording final redirected URL, file size (`54611` bytes), and SHA256 checksum (`0fc775486dbf516c91cdd3ca583ab5f83fe316b950d9a5558be8003d190449d8`).
- **Dual Licensing Clarification:** Documented dual licensing model in `LICENSE`, `README.md`, and `PROJECT_MANIFEST.md`: BSD 3-Clause for client/tooling and AGPLv3 for server components (`netbird-server`).
- **Strict Verification Reporting:** Updated `reports/validation_report.md` categorizing all unexecuted or environment-restricted tests as `BLOCKED BY ENVIRONMENT` and removing "Production Ready" claims.

## [1.2.0] - 2026-07-28
- Tag pinning and server schema update.

## [1.1.0] - 2026-07-28
- Architecture migration to combined server model.

## [1.0.0] - 2026-07-28
- Initial release of NetBird setup repository.
