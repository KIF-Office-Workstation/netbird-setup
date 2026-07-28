# KIF Office Workstation Organizational Governance

## Mandatory Governance Rules
1. **Workstation Primary Source of Truth:** Local workstation code and documentation pushed to GitHub `main` branch are the sole source of truth. Production/staging servers are deployment targets only.
2. **Zero Hardcoded Secrets:** No API keys, setup keys, passwords, or private keys shall ever be committed.
3. **Empirical Evidence Reporting:** Every status claim must be backed by reproducible empirical command evidence recorded in tracked report artifacts.
4. **Non-Disruption Safety Protocol:** Never modify live production databases, firewalls, web servers, or routing without explicit user authorization.
