# NetBird Agent Control Loop

## Mission

Complete, verify, document, and stabilize the NetBird module for the Office Workstation as quickly and safely as possible, without expanding beyond this repository or making undocumented workstation-wide changes.

This repository is a module of the private `KIF-Office-Workstation` organization. Before any work, read in this exact order:

1. `KIF-Office-Workstation/.github/README.md`
2. `KIF-Office-Workstation/.github/GOVERNANCE.md`
3. `KIF-Office-Workstation/.github/AGENT_NOTES.md`
4. This repository's `README.md`
5. `PROJECT_MANIFEST.md`
6. `GOVERNANCE.md` if present
7. `AGENT_CONTROL_LOOP.md`
8. `AGENT_STATUS.md`
9. `CHATGPT_INBOX.md`

The organization-level governance is mandatory and overrides weaker repository instructions.

## Authorized operating mode

The user authorizes the assigned Antigravity agent to work autonomously on the documented NetBird task within this repository, including read-only inspection, safe repository edits, documentation, tests, verification, and fixes that are clearly within the NetBird module.

The agent is not authorized to perform unrelated cleanup or modify another repository. Destructive, security-sensitive, access-changing, network-wide, firewall, DNS, routing, credential, service-removal, or workstation-wide changes must be recorded as a request and paused unless the exact action was already explicitly authorized.

## Fast execution workflow

Perform the following continuously until the module is complete or blocked:

### Phase 1 — Establish current truth

- Read all existing documentation and recent reports.
- Inspect the actual current NetBird state using safe and preferably read-only methods.
- Identify what is installed, configured, running, broken, incomplete, outdated, duplicated, or undocumented.
- Compare the actual state with the repository documentation.
- Never assume a command succeeded because an earlier report says it did.
- Record the initial baseline and timestamp in the appropriate report/worklog.

### Phase 2 — Build a precise action queue

Classify every item as one of:

- `SAFE_NOW` — can be executed within the current authorization and repository scope.
- `VERIFY_ONLY` — inspect and document; do not change.
- `NEEDS_USER` — requires the user's decision, credential, physical action, restart approval, or high-impact authorization.
- `NEEDS_CHATGPT_REVIEW` — requires architectural review, conflict resolution, or cross-repository coordination.
- `BLOCKED` — cannot proceed because a dependency is missing.
- `DONE` — completed and verified.

Execute all `SAFE_NOW` items immediately in the most efficient dependency order. Do not stop after each minor step.

### Phase 3 — Implement and verify

For every safe action:

- Capture the previous state when available.
- Apply the smallest correct change.
- Verify using independent evidence.
- Check for regressions.
- Update repository documentation immediately.
- Record exact commands where safe, results, timestamps, and rollback notes.
- Do not claim completion without verification.

### Phase 4 — Full completion review

Before declaring completion, verify at minimum:

- NetBird client/service installation state.
- Service/process status.
- Startup behaviour.
- Connection/peer state where permitted.
- Management and signal reachability where permitted.
- DNS/routing configuration relevant to this workstation.
- Firewall implications without changing them unless authorized.
- Authentication/login state without exposing secrets.
- Version state and support status.
- Repository documentation accuracy.
- Recovery, troubleshooting, and rollback documentation.
- No secrets committed.
- No unrelated workstation changes made.

## Communication protocol

The repository is the communication bridge between Antigravity, ChatGPT, and the user.

### `AGENT_STATUS.md`

This is the single current-state dashboard. Update it after every meaningful work cycle and before stopping. It must always show:

- Current overall status.
- Last check timestamp.
- Agent identity.
- Current phase.
- Last completed action.
- Verification result.
- Next automatic action.
- Open blockers.
- User input required, if any.
- ChatGPT review required, if any.
- Latest report and commit references.

Do not append endless duplicate status sections. Maintain one clean current dashboard plus a concise chronological activity log.

### `CHATGPT_INBOX.md`

Read this file at the start of every cycle. It contains reviewed instructions or responses from ChatGPT/user. Process only items marked `APPROVED` or instructions that clearly fall within existing authorization. Mark processed entries with timestamp, result, and evidence; do not delete history.

### Questions and blockers

When any question, decision, permission, missing information, risk, outdated version, recommended upgrade, or cross-scope action is found:

1. Do not guess.
2. Complete all other independent safe work first.
3. Add a clear entry to `AGENT_STATUS.md` under `Requests / blockers`.
4. Add the organization-level summary to `KIF-Office-Workstation/.github/AGENT_NOTES.md` when it affects the workstation, another repository, approval, update, risk, or shared decision.
5. State exactly what is needed, why, available options, recommended option, risk, and what work can continue without it.
6. Stop only the blocked portion, not unrelated safe tasks.

## Hourly check loop

Use Antigravity's native scheduling/recurring-task feature, if available, to run once every hour.

Each hourly cycle must be lightweight:

1. Read `CHATGPT_INBOX.md` and the current `AGENT_STATUS.md`.
2. Check for new repository commits or approved instructions relevant to this task.
3. Continue the next documented `SAFE_NOW` action.
4. Run only the minimum verification needed for that cycle.
5. Update `AGENT_STATUS.md` only when the state changed or a heartbeat is required.
6. Commit meaningful updates with a clear message.
7. If no work or new instruction exists, record no noisy report and consume minimal resources.

Do not create an operating-system scheduled task, persistent service, startup entry, or external automation merely to achieve the hourly loop unless explicitly authorized. If Antigravity has no native scheduler, record that limitation in `AGENT_STATUS.md`, complete the current execution session, and leave a precise resume command/instruction.

## Stop conditions

The agent may stop only when one of these is true:

- The NetBird module is fully completed, tested, documented, and verified.
- A genuine blocker prevents all remaining work.
- A high-impact action needs explicit user approval.
- Required access or credentials are unavailable.
- Continuing would violate organization governance.

Before stopping, update `AGENT_STATUS.md` with the exact state and commit all safe documentation changes.

## Completion definition

Set status to `COMPLETE_PENDING_REVIEW` only after all executable work is done and verification evidence is present. Set status to `COMPLETE_VERIFIED` only after the final review finds no unresolved functional, documentation, security, or recovery gaps.
