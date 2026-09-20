---
name: review-notes
description: Take a human code review one point at a time — understand and note each point, hold all changes until the reviewer says they are done, then apply the whole list and report per point.
---

# Review notes

The user reviews code (usually code you just wrote) and dictates findings one by one. Your job is
to understand each point precisely, keep a numbered list, and change nothing until they say the
review is complete. Then apply everything in one pass.

## Phase 1 — intake (one message per point)

For every point:

1. Read the code the point refers to before answering. Never acknowledge from memory.
2. Reply in at most a few lines: the point's number, what you understood, and the concrete change
   it implies (file and symbol). If the fix is obvious, say what you will do; do not list options.
3. Ask a question only when two readings lead to materially different changes. One question,
   then stop. Otherwise state your assumption and move on.
4. If the point conflicts with a repo rule (CLAUDE.md, an ADR, a synth test) or with an earlier
   point, say so now in one sentence. Do not relitigate it later.
5. End with a short prompt for the next point ("Point N+1?"). Nothing else.

Keep the running list in a scratch file (`review-notes.md` in the scratchpad directory) so it
survives context compaction. One line per point: number, file:symbol, the change, open question
if any.

Do not:
- edit, run formatters, or run tests during intake
- batch or reorder the user's points, or merge two into one
- pad acknowledgements with praise or restate the diff

## Phase 2 — apply (when the user says they are done)

1. Print the consolidated numbered list once, one line per point, with any still-open questions
   at the top. If questions remain, stop and wait; otherwise proceed without asking.
2. Apply all points. Work in file order, not point order, so each file is touched once.
   A point that turns out to be wrong or already handled gets skipped with a one-line reason,
   never silently.
3. Run the project's tests and lint for the touched packages. Fix failures you caused.
4. Run `/simplify` on the resulting diff if the changes are more than a handful of lines.
5. Report as a numbered list mirroring the intake numbers: done / skipped (why) / needs you
   (why). Include failing test output verbatim if anything still fails.

Never commit. Comments stay one line. Do not widen scope beyond the points given; if you notice
an unrelated problem, add it as a single line under "Not in the review" at the end.
