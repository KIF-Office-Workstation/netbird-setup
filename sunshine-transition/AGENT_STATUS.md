# Sunshine Host Agent Status

> Communication dashboard for Sunshine Host installation and Moonlight streaming readiness.

## Current state

- **Overall status:** `COMPLETE_WITH_INPUT_ISSUE`
- **Last updated:** 2026-07-29 08:44 +03:00
- **Agent:** ChatGPT reviewing agent
- **Installed Version:** `v2026.516.143833`
- **Windows Service State:** `Running` (`SunshineService`)
- **Service Startup Type:** `Automatic`
- **Web UI Account:** **Configured & Secured** (`https://localhost:47990`)
- **Primary Encoder:** **Intel Quick Sync Video (`h264_qsv`)**
- **Target Resolution / FPS:** `1920x1080` @ 60 FPS
- **Desktop Application:** Active
- **Moonlight Client Installed:** `Yes` (client device)
- **Moonlight Pairing:** `Completed`
- **Remote Streaming:** `Launched successfully`
- **Video Output:** `Working`
- **Keyboard Input:** `OPEN ISSUE` — on-screen keyboard does not appear or typing cannot be completed inside the Moonlight session
- **NetBird IP:** `100.91.125.54`
- **Latest control commit:** Will be updated by GitHub commit history

## Requests / blockers

- **Blockers:** None for video streaming or host availability.
- **Open issue:** Keyboard input from the Moonlight client is not yet verified as working.
- **Risky actions:** None authorized or required.

## User input required

Test the following without installing additional software:

1. Inside the active Moonlight session, tap once with three fingers to request the on-screen keyboard.
2. Open Windows Notepad and test typing there first.
3. In Sunshine Web UI, confirm keyboard input is enabled under the input configuration.
4. Do not mark the input issue resolved until actual text entry is verified.

## Deferred optional components

Do not install these unless the matching problem appears and the user approves:

- Virtual Display Driver — black screen, headless use, or resolution problems.
- ViGEmBus — virtual gamepad support.
- HidHide — duplicate controller input.
- Wake-on-LAN tooling — remote power-on requirement.
- Virtual Audio Driver — audio routing or missing-audio issue.
- HWiNFO or similar monitoring — thermal, stutter, or performance diagnosis.
- Playnite — optional gaming launcher only.

## Latest evidence / reports

- `sunshine-transition/reports/20260729_084400_MOONLIGHT_CLIENT_AND_INPUT_STATUS.md`
- `sunshine-transition/reports/20260728_224119_SUNSHINE_INSTALLATION_REPORT.md`
- `https://github.com/KIF-Office-Workstation/.github.git` (Sunshine inventory and organization notes)
