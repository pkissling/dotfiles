# Claude.md

## Workflow

* After completing a task that added or changed a substantial amount of code, run the `/simplify` skill to review the diff for reuse, quality, and efficiency issues before reporting the task as done. Skip this for small changes (a few lines, trivial edits) and for tasks that are not really about code (questions, research, config-only changes that don't touch source).
* Delegate to a subagent only for large tasks that are genuinely independent and parallelizable, such as a wide multi-file investigation. Do not delegate work you can finish yourself in a handful of tool calls, and do not use subagents to verify or double-check your own work. If one subagent can complete the task, use one rather than several, and keep spawn counts low.
* Never create git commits unless explicitly instructed to. This also applies to pushing and amending commits.
