# Agent Notes & Organizational Escalation Log

## NOTE-20260728-002 — NetBird Setup Scope Correction: Windows 10 Client Installation

- **Status:** `RESOLVED` / `IN_PROGRESS`
- **Priority:** HIGH
- **Created by:** Antigravity AI
- **Created at:** 2026-07-28 16:16 +03:00
- **Target Component:** Office Workstation (Windows 10 Pro x64) / NetBird Windows Client
- **Scope Correction Summary:** The previous assumption regarding a Hetzner Linux server deployment was **INCORRECT**. The true goal of repository `netbird-setup` is installing, configuring, and maintaining the **NetBird Windows Client** on the 24/7 Office Workstation.
- **Current State:** NetBird Client is currently **NOT INSTALLED** on the Windows host.
- **Action Plan:** 
  1. Prepare official NetBird Windows Client installer (`.exe`/`.msi`).
  2. Verify Windows Service registration (`NetBird` service set to Automatic startup).
  3. Authenticate device via Setup Key or interactive user login.
  4. Verify `Connected` status and 24/7 background persistence.
- **Evidence Path:** `reports/20260728_161613_SCOPE_CORRECTION_AND_OUT_OF_SCOPE_AUDIT.md`
