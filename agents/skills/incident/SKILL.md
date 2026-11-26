---
name: incident
description: On-call triage. Pull open Better Stack incidents, list them numbered with a fast verdict each, then give a quick overview and a thorough read-only investigation of the ones the user picks, without subagents.
---

# Incident triage

The user is on call and wants the bird's-eye view, fast. **Read-only everywhere:** never acknowledge, resolve, escalate or comment on an incident, never post or react in Slack, never mutate anything in AWS, Datadog or the EBX API. If an action is needed, print it for the user to run.

## Step 1 — look

Better Stack `incidents` with `status: ["ongoing", "acknowledged"]`. No history, no auth checks.

Only if that returns nothing open: read `#ebx-alarms-prod` in Slack for the last 24h (one read call) and list alerts that have no recovery as candidates in Step 2's format.

## Step 2 — reply

```text
1. 🔴 <short name> · <asset/service> · <age> · <ack'd/unack'd>
2. 🟡 …
Pick? (e.g. `1 3`)
```

- 🔴 act now (impact or unacknowledged) · 🟡 watch · ⚪ noise (e.g. hotline calls, collapse them into one line).
- One line each, no commentary. Order by severity, then age. Nothing open in Better Stack or Slack: say so in one line.
- Stop and wait for the pick.

## Step 3 — quick look, then deep dive

Do everything yourself, in this session. No subagents.

1. Quick look: the 1–2 calls that tell what happened, i.e. the Datadog monitor with its alerting groups and message, or the asset's current state and alarm via the EBX prod MCP. Then print one line per incident: `<n> · <still firing|cleared> · <impact> — <what happened in plain words>`, followed by `Digging deeper.` Do not stop there.
2. Deep dive, straight after, in the same turn:
   - Prod only.
   - Go deep on the cause: start from the monitor's runbook/message, then logs, telemetry.
   - Per incident, by kind:
     - `DataDog: <service> — <monitor> on env:prod`: the Datadog monitor and its alerting groups, then the service's logs in the firing window.
     - `[ERROR|CRITICAL] … Rule: <RULE> AssetID: <id>`: the asset via the EBX prod MCP (`mcp__claude_ai_EBX_prod__*`) or the `use-api` skill, its telemetry around `Started At`, and the Asset Alarms API logs (Better Stack source `2388643`).
     - `Operations Hotline call routing`: nothing to gather.
3. Report per incident in exactly this shape, nothing more:
   `<n> · <still firing|cleared> · <impact in ≤6 words> — <likely cause or "unknown"> → <next step>` plus one evidence link, and the exact command if one is suggested.
