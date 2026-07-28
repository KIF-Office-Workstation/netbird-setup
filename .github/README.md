# KIF Office Workstation Organizational Guidelines

This directory standardizes governance, agent interaction loops, central hardware/software inventories, and infrastructure policies across all repositories in the `KIF-Office-Workstation` organization.

---

## 💻 Workstation Inventory (Single Source of Truth)

The central specification for the KIF Office Workstation (`DESKTOP-R9OACQD` - Windows 10 Pro) is maintained in the [`workstation-inventory/`](workstation-inventory/README.md) directory.

> **MANDATORY FOR ALL AI AGENTS:** All AI agents operating in any repository within the `KIF-Office-Workstation` organization **MUST READ** the workstation inventory before proposing software installations, Docker/WSL setups, local AI inference models, remote desktop streaming (Sunshine/Moonlight), or hardware upgrades.

- **Central Inventory Index:** [workstation-inventory/README.md](workstation-inventory/README.md)
- **Master Technical Inventory (Markdown):** [workstation-inventory/KIF_WORKSTATION_FULL_INVENTORY.md](workstation-inventory/KIF_WORKSTATION_FULL_INVENTORY.md)
- **Structured JSON Inventory Specification:** [workstation-inventory/KIF_WORKSTATION_FULL_INVENTORY.json](workstation-inventory/KIF_WORKSTATION_FULL_INVENTORY.json)
