# Changelog - NetBird Infrastructure Deployment (`netbird-setup`)

All notable changes to the NetBird deployment infrastructure, security configurations, scripts, and documentation will be recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-07-28

### Added
- **Repository Structure:** Initialized git repository `netbird-setup` as the single source of truth for NetBird deployment.
- **NetBird Client Installation:** Installed stable NetBird agent `v0.75.0` across Linux server (`178.105.49.9`) and WSL Ubuntu environment.
- **Firewall Hardening:** Added UFW firewall rules opening ports `51820/udp` (WireGuard), `3478/udp/tcp` (Coturn STUN/TURN), `10000/tcp` (Signal gRPC), and `33073/tcp` (Management gRPC).
- **Kernel Networking:** Configured `net.ipv4.ip_forward=1` and `net.ipv6.conf.all.forwarding=1` for subnet routing and gateway capabilities.
- **Self-Hosted Server Stack Configurations:** Created sanitized templates for Docker Compose (`docker-compose.yml.example`), Management config (`config.yaml.example`), and Dashboard env (`dashboard.env.example`).
- **Automation Scripts:**
  - `scripts/deploy_netbird_server.sh`: Automated NetBird self-hosted server deployment script.
  - `scripts/install_netbird_client.sh`: Client installation & setup key registration script.
  - `scripts/backup_netbird.sh`: Automated state and database tarball backup generator.
  - `scripts/restore_netbird.sh`: Disaster recovery restoration script.
  - `scripts/health_check.sh`: System diagnostic and health check report script.
  - `scripts/test_mesh_connectivity.sh`: Peer connectivity, ping, and throughput test script.
- **Documentation Suite:** Added detailed production guides in `/docs`, `/architecture`, `/security`, `/troubleshooting`, and `/reports`.
- **Architecture Visuals:** Embedded visual SVG network topology diagram (`images/topology_diagram.svg`) and Mermaid diagrams.
