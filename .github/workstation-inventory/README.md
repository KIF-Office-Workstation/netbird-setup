# Central Workstation Hardware & Software Technical Inventory (`workstation-inventory`)

This directory serves as the **OFFICIAL SINGLE SOURCE OF TRUTH** for the KIF Office Workstation computer hardware specifications, operating system profile, software stack, remote desktop suitability, and development workload benchmarks across all repositories in the `KIF-Office-Workstation` organization.

> **MANDATORY POLICY FOR ALL AI AGENTS & DEVELOPERS:**  
> Every AI agent operating in any repository within the `KIF-Office-Workstation` organization **MUST READ THIS DIRECTORY** before:
> 1. Installing any new software package or dependency.
> 2. Proposing software applications or framework choices.
> 3. Configuring Docker containers, WSL distributions, or virtual machines.
> 4. Running local AI models or LLM inference engines.
> 5. Setting up remote desktop tools (Sunshine, Moonlight, RustDesk, Chrome Remote Desktop).
> 6. Recommending hardware upgrades (RAM, SSD, GPU, Display).
> 7. Configuring 24/7 background services.
> 8. Evaluating workload compatibility for pair programming or automation.

---

## 📁 Directory Structure & Files

- **[Master Hardware & Software Inventory Document](KIF_WORKSTATION_FULL_INVENTORY.md):** Complete 20-stage technical analysis for human review.
- **[Structured JSON Inventory Specification](KIF_WORKSTATION_FULL_INVENTORY.json):** Machine-readable JSON specification for automated tooling and AI agents.
- **[Central Migration & Audit Log](reports/20260728_204421_CENTRAL_INVENTORY_MIGRATION.md):** Timestamped migration log documenting verification evidence.

---

## 🔒 Security & Privacy Policy

- **Zero Secrets Allowed:** No passwords, tokens, API keys, cookies, private credentials, or setup keys shall ever be recorded here.
- **Sanitized Device Identifiers:** Full serial numbers, full MAC addresses, Device IDs, and recovery keys are strictly redacted (`REDACTED` or max last 4 characters for disk disambiguation).

---

## 🖥️ System Summary At-a-Glance

- **Host Machine:** Dell Inc. OptiPlex 7050 Workstation
- **OS:** Windows 10 Pro (64-bit, Build 19045)
- **CPU:** Intel Core i7-7700 CPU @ 3.60GHz (4 Cores / 8 Threads)
- **Memory (RAM):** 20 GB DDR4 @ 2400 MHz (~9.25 GB Free)
- **Storage:** 240 GB Kingston SSD (OS C:) + 1 TB Seagate HDD (Data D:)
- **Graphics Encoders:** Intel HD Graphics 630 (Quick Sync Video H.264/HEVC) + NVIDIA GeForce 210
- **NetBird Mesh Status:** Installed (v0.75.1), Active & **`Connected`** (`100.91.125.54/16`, `kif.netbird.cloud`)
