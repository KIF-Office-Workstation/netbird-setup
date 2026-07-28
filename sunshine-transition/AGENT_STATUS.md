# Sunshine Host Agent Status

> Communication dashboard for Sunshine Host installation and Moonlight streaming readiness.

## Current state

- **Overall status:** `COMPLETE_PENDING_CLIENT_TEST`
- **Last updated:** 2026-07-28 23:23 +03:00
- **Agent:** Antigravity AI
- **Installed Version:** `v2026.516.143833`
- **Windows Service State:** `Running` (`SunshineService`)
- **Service Startup Type:** `Automatic`
- **Web UI Account:** **Configured & Secured** (`https://localhost:47990`)
- **Primary Encoder:** **Intel Quick Sync Video (`h264_qsv`)**
- **Target Resolution / FPS:** `1920x1080` @ 60 FPS
- **Desktop Application:** Active
- **Moonlight Client Pairing:** `READY_FOR_PAIRING` (Awaiting client device pairing code)
- **NetBird IP:** `100.91.125.54`
- **Latest control commit:** Will be updated after git push

## Requests / blockers

- **Blockers:** None. Sunshine Host is installed, Windows service is running, Intel QSV encoder is active, admin account is created, and Web UI is secured.

## User input required

None currently. When ready to connect from Moonlight (on laptop/phone/tablet), enter IP `100.91.125.54` in Moonlight and pair via PIN code in Sunshine Web UI (`https://localhost:47990` -> PIN tab).

## Latest evidence / reports

- `sunshine-transition/reports/20260728_224119_SUNSHINE_INSTALLATION_REPORT.md`
- `https://github.com/KIF-Office-Workstation/.github.git` (Commit `9cf397d`)
