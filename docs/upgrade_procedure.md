# NetBird Upgrade & Maintenance Procedure

This document provides step-by-step procedures for safely upgrading NetBird self-hosted control plane servers and client nodes with zero downtime and roll-back safety.

---

## 1. Upgrade Pre-flight Checklist

- [ ] Take a full system and state backup using `./scripts/backup_netbird.sh`.
- [ ] Review official NetBird Release Notes on GitHub for breaking changes.
- [ ] Ensure non-disruptive maintenance window.

---

## 2. Server Stack Upgrade (Docker Compose)

To upgrade the NetBird self-hosted server components (Management, Signal, Dashboard, Coturn):

1. **Navigate to Deployment Directory:**
   ```bash
   cd ~/netbird
   ```

2. **Run Automated Backup:**
   ```bash
   ./scripts/backup_netbird.sh
   ```

3. **Pull Latest Stable Images:**
   ```bash
   docker compose pull
   ```

4. **Restart Stack with Updated Containers:**
   ```bash
   docker compose up -d --remove-orphans
   ```

5. **Verify Stack Health:**
   ```bash
   docker compose ps
   docker compose logs --tail=50 -f management
   ```

---

## 3. Client Node Upgrade

### A. Linux Node (Debian / Ubuntu)
```bash
sudo apt-get update
sudo apt-get --only-upgrade install netbird
```

Verify service restart & connection:
```bash
sudo systemctl status netbird
sudo netbird status --detail
```

### B. Windows Node
```powershell
winget upgrade netbird.netbird
```

---

## 4. Rollback Procedure

If issues arise following an upgrade:

1. **Stop Containers / Service:**
   ```bash
   cd ~/netbird && docker compose down
   ```

2. **Restore Previous Backup State:**
   ```bash
   ./scripts/restore_netbird.sh /var/backups/netbird/netbird_backup_PREVIOUS.tar.gz
   ```

3. **Verify Restored Operation:**
   ```bash
   sudo netbird status --detail
   ```
