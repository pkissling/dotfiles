# Claude.md

## Workflow

* After completing a task that added or changed a substantial amount of code, run the `/simplify` skill to review the diff for reuse, quality, and efficiency issues before reporting the task as done. Skip this for small changes (a few lines, trivial edits) and for tasks that are not really about code (questions, research, config-only changes that don't touch source).
* Delegate to a subagent only for large tasks that are genuinely independent and parallelizable, such as a wide multi-file investigation. Do not delegate work you can finish yourself in a handful of tool calls, and do not use subagents to verify or double-check your own work. If one subagent can complete the task, use one rather than several, and keep spawn counts low.
* Never create git commits unless explicitly instructed to. This also applies to pushing and amending commits.

## Code Style

* Comment only where a comment is absolutely necessary. The default is no comment. Do not narrate what the code does, restate an identifier, or add comments out of habit — the code is the documentation. Write one only when the reader cannot recover the reason from the code itself: a non-obvious constraint, a subtle pitfall, or a deliberate deviation from the expected approach. If a comment explains *what*, delete it; if it explains *why*, keep it short.
* **One line. Hard rule.** No multi-paragraph or multi-line block comments explaining mechanisms, measurements, alternatives considered, or the history of a change. State the non-obvious fact and stop. A second line is justified only to stop a specific future mistake (e.g. why a runtime capability probe is used instead of a version check) — never for narrative, and never as a poem or an essay.
* This applies **everywhere**: source, tests, and config files alike. Test-case preambles and config-file headers are not exempt.
* A long explanation belongs in the commit message, the PR description, or an ADR — not above the line.
* When changing code that already has a comment, first consider deleting the comment rather than amending it. A comment that has to be rewritten to stay true is usually one that should not exist. Rewrite it only if it still earns its place after the change.

## Machine-local

@~/.claude/CLAUDE.local.md
