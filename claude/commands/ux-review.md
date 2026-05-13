# UX Review

Review the changes in the current PR from a UI/UX perspective by launching a subagent with UI/UX expertise.

The subagent should first study existing pages and components in the codebase to understand the project's established look, feel, and patterns. Consistency with existing UI is paramount — new or changed UI must not feel out of place.

Then identify all changed files by comparing the current branch against main (`git diff main...HEAD` and `git diff` for uncommitted changes) and review for:

1. **Consistency**: Does the new/changed UI match the structure, spacing, wording style, and interaction patterns of existing pages? Compare side-by-side with similar sections.
2. **Usability**: User flow clarity, error handling, disabled states, inline validation, setting user expectations
3. **Accessibility**: Missing `autocomplete` attributes, `aria-*` attributes, nested interactive elements, keyboard navigation
4. **Text quality**: German spelling/grammar, tone consistency with existing copy, helpful descriptions
5. **Best practices**: Proper HTML semantics, no nested `<button><a>` anti-patterns, form field types

For each finding, provide:
- Priority: Critical / Important / Nice-to-have
- What to change and why (UX rationale)
- Exact text or code suggestion
- Which file(s) to modify

Present findings as a prioritized list. Do not implement changes — only report recommendations.
