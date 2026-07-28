# Office Workstation Governance Charter

## Status

This document defines the permanent identity, scope, and operating rules of the **Office Workstation** program.

These rules are binding for all future work performed by humans, AI agents, automation tools, or deployment systems.

## Permanent Identity

The project identity is **Office Workstation**.

This identity must not be renamed, narrowed, replaced, or redefined around any individual technology, service, vendor, agent, server, or network tool.

NetBird, Docker, WSL, HestiaCP, Git, development tools, security utilities, monitoring systems, backup systems, AI agents, scripts, and future components are modules within the Office Workstation ecosystem.

No module is allowed to become the identity of the overall project.

## Purpose

The Office Workstation program exists to provide an authoritative operational record of the office workstation and its supporting infrastructure.

It must document what is installed, why it exists, how it is configured, how it is validated, how it is maintained, and how it can be safely upgraded, rolled back, or removed.

## Source of Truth

The repository and its related Office Workstation repositories are the official source of truth for the workstation environment.

A component present on the workstation but absent from the documentation is considered undocumented infrastructure and must be documented before it is treated as an approved part of the environment.

## Mandatory Documentation Standard

Every component must document:

1. purpose and business or operational reason
2. installation date and responsible executor
3. supported operating systems and prerequisites
4. dependencies and integrations
5. exact installation and configuration procedure
6. non-secret configuration references
7. security and permissions model
8. ports, services, storage paths, and network exposure
9. validation and health-check procedure
10. backup and recovery requirements
11. upgrade procedure
12. rollback procedure
13. safe removal procedure
14. known limitations and risks
15. change history and supporting reports

Secrets, private keys, access tokens, passwords, personal data, and production credentials must never be committed.

## Change Policy

All material changes must be traceable through Git history.

Changes must preserve existing technical documentation unless removal is explicitly approved and justified.

Each change must include a clear commit message and update the relevant manifest, installation log, change log, runbook, or report when applicable.

No agent may silently rewrite the project structure, remove historical records, or change the project identity.

## Agent Rules

Before changing this repository, every agent must:

1. read `README.md`
2. read `GOVERNANCE.md`
3. identify the component being changed
4. preserve the Office Workstation parent identity
5. make the smallest safe change required
6. document the result and any validation performed

Agents are explicitly prohibited from:

- redefining the repository as a single-product project
- presenting NetBird or any other module as the full Office Workstation project
- deleting documentation to simplify the repository
- inventing validation results
- committing secrets
- making unrelated changes without approval

## Module Model

Each installed technology is treated as an independent module under Office Workstation.

A module may have its own repository, folder, scripts, reports, configuration templates, and runbooks, but it must always state that it belongs to the Office Workstation program.

The module name may change or the module may be replaced without changing the Office Workstation identity.

## Architecture Principle

The workstation is the primary operational and development environment.

GitHub provides versioned documentation and synchronization.

External servers and cloud services are deployment or support targets, not replacements for the Office Workstation source of truth unless explicitly documented and approved.

## Non-Negotiable Rule

**No future task, commit, agent, migration, or technology may change the permanent identity of this project from Office Workstation into a repository centered on one individual component.**

Any proposed change that conflicts with this rule must be rejected and reported before execution.
