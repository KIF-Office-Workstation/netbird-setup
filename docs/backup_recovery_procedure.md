# NetBird Backup, Recovery & Disaster Recovery Procedure

This guide details automated backup schedules, disaster recovery plans, state file management, and step-by-step restoration procedures for NetBird.

---

## 1. Important Data Paths

| Component | Path | Description |
| :--- | :--- | :--- |
| **Management SQLite DB** | `/var/lib/netbird/management.db` | Contains peers, setup keys, network routes, ACL rules |
| **Management PKI Certs** | `/var/lib/netbird/management.crt` / `.key` | Private key & certificate authority for gRPC SSL |
| **Signal State** | `/var/lib/netbird/signal.state` | Signal service runtime data |
| **Client Configuration** | `/var/lib/netbird/default.json` | Local WireGuard private key & server profile |

---

## 2. Automated Backup Strategy

Run the backup script via root crontab on a daily schedule:

```cron
# NetBird Daily Automated Backup at 03:00 UTC
0 3 * * * /bin/bash /path/to/netbird-setup/scripts/backup_netbird.sh >> /var/log/netbird_backup.log 2>&1
```

---

## 3. Manual Backup Procedure

```bash
chmod +x ./scripts/backup_netbird.sh
sudo ./scripts/backup_netbird.sh
```

Archive output location: `/var/backups/netbird/netbird_backup_YYYYMMDD_HHMMSS.tar.gz`.

---

## 4. Disaster Recovery & Machine Replacement

To reproduce the deployment on a fresh server instance:

1. **Provision Fresh Machine:**
   Install Ubuntu 22.04 LTS, Docker, and Git.

2. **Clone Source of Truth Repository:**
   ```bash
   git clone https://github.com/your-org/netbird-setup.git
   cd netbird-setup
   ```

3. **Restore Backup Archive:**
   ```bash
   sudo ./scripts/restore_netbird.sh /path/to/netbird_backup_archive.tar.gz
   ```

4. **Verify Restored Service:**
   ```bash
   sudo ./scripts/health_check.sh
   ```
