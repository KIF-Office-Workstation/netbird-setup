# NetBird Server & Client Upgrade & Rollback Procedure

This document provides step-by-step instructions for upgrading the NetBird combined server stack and client nodes, including safety rollback steps.

---

## 1. Pre-Upgrade Safety Steps

1. Create a full backup of current state:
   ```bash
   sudo ./scripts/backup_netbird.sh
   ```
2. Inspect current container status:
   ```bash
   docker compose ps
   ```

---

## 2. Server Stack Upgrade (Docker Compose)

1. Pull latest stable container images:
   ```bash
   docker compose pull
   ```
2. Recreate containers with updated images:
   ```bash
   docker compose up -d --remove-orphans
   ```
3. Verify container health & logs:
   ```bash
   docker compose ps
   docker compose logs -f --tail=50 netbird-server
   ```

---

## 3. Rollback Procedure

If issues arise following an upgrade:

1. Stop running containers:
   ```bash
   docker compose down
   ```
2. Restore previous state backup:
   ```bash
   sudo ./scripts/restore_netbird.sh /var/backups/netbird/netbird_backup_PREVIOUS.tar.gz
   ```
3. Restart containers:
   ```bash
   docker compose up -d
   ```
