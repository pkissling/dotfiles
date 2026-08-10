# Claude.md

## Workflow

* After completing a task that added or changed a substantial amount of code, run the `/simplify` skill to review the diff for reuse, quality, and efficiency issues before reporting the task as done. Skip this for small changes (a few lines, trivial edits) and for tasks that are not really about code (questions, research, config-only changes that don't touch source).
* Delegate to a subagent only for large tasks that are genuinely independent and parallelizable, such as a wide multi-file investigation. Do not delegate work you can finish yourself in a handful of tool calls, and do not use subagents to verify or double-check your own work. If one subagent can complete the task, use one rather than several, and keep spawn counts low.

## Output

* Keep responses focused, brief, and concise. Keep disclaimers and caveats short, and spend most of the response on the main answer. When asked to explain something, give a high-level summary unless an in-depth explanation is specifically requested.
* Before your first tool call, say in one sentence what you're about to do. While working, give a brief update only when you find something important or change direction. When you finish, lead with the outcome: your first sentence should answer "what happened" or "what did you find," with supporting detail after it for readers who want it.

