# Central Workstation Hardware & Software Technical Inventory (`workstation-inventory`)

This directory serves as the **authoritative, read-only central reference** for the KIF Office Workstation computer hardware specifications, operating system profile, software stack, remote desktop suitability, and development workload benchmarks.

> **Mandatory Rule for AI Assistant & Developers:** Before proposing any new software installation, architectural change, AI model execution, Docker deployment, or remote streaming configuration (such as Sunshine/Moonlight), this directory **MUST** be reviewed to evaluate hardware compatibility, encoder support, thermal margins, and memory capacity.

---

## 📁 Directory Index & Artifacts

- **[Master Hardware & Software Inventory Document](KIF_WORKSTATION_FULL_INVENTORY.md):** Complete 20-stage technical analysis of CPU, GPU, RAM, Storage, Network, Security, and Workload Matrices.
- **[Structured JSON Inventory Specification](KIF_WORKSTATION_FULL_INVENTORY.json):** Machine-readable JSON specification for automated tooling and AI agents.
- **[Latest Execution Audit Report](reports/20260728_183943_WORKSTATION_HARDWARE_SOFTWARE_AUDIT.md):** Timestamped audit execution log documenting command metrics and verification evidence.

---

## 🖥️ System Summary At-a-Glance

- **Computer Model:** Dell Inc. OptiPlex 7050 (Small Form Factor / Mini Tower)
- **Host OS:** Windows 10 Pro (64-bit, Build 19045)
- **Processor:** Intel Core i7-7700 CPU @ 3.60GHz (4 Cores / 8 Threads)
- **Memory (RAM):** 20 GB DDR4 @ 2400 MHz (~9.25 GB Free)
- **Storage:** 240 GB Kingston SSD (OS Drive C:) + 1 TB Seagate HDD (Data Drive D:)
- **Graphics & Hardware Encoders:** Intel HD Graphics 630 (Quick Sync Video H.264/HEVC) + NVIDIA GeForce 210 (Legacy)
- **Remote Connectivity:** NetBird Client v0.75.1 (Active/Connected: `100.91.125.54/16`), Chrome Remote Desktop (Active)
