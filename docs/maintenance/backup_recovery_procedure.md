# NetBird Maintenance, Backup & Recovery Procedure

This guide details automated state backups, disaster recovery, database restoration, and server replacement procedures.

---

## 1. Data Inventory & State Locations

| Data Component | Location | Description |
| :--- | :--- | :--- |
| **NetBird Datastore** | `/var/lib/netbird/management.db` | Embedded SQLite DB containing peers, keys, & ACL rules |
| **Dex IdP Datastore** | `/var/lib/netbird/dex.db` | OIDC user sessions and authentication data |
| **Server Configuration** | `./config.yaml` | Server configuration settings |
| **TLS Certificates** | `./letsencrypt/acme.json` | ACME TLS certificates issued by Traefik |

---

## 2. Automated Backup Execution

Generate a timestamped backup archive using:
```bash
chmod +x ./scripts/backup_netbird.sh
sudo ./scripts/backup_netbird.sh
```
Tarball destination: `/var/backups/netbird/netbird_backup_YYYYMMDD_HHMMSS.tar.gz`.

---

## 3. Disaster Recovery & Restoration

To restore NetBird from a backup archive:

```bash
chmod +x ./scripts/restore_netbird.sh
sudo ./scripts/restore_netbird.sh /var/backups/netbird/netbird_backup_YYYYMMDD_HHMMSS.tar.gz
```

Verify service status after restoration:
```bash
chmod +x ./scripts/health_check.sh
sudo ./scripts/health_check.sh
```
