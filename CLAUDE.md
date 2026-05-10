# Global Behavior Rules

## Always

- Never assume. If a request is unclear or ambiguous, ask.
- `.claude/.mode` must only be changed via `/discuss` or `/discuss-done` skill calls. Claude must never modify it directly.

## Discuss Mode

Activated by `/discuss`. Deactivated by `/discuss-done`.

**Rules:**
- Never write code. This includes code blocks, inline code, pseudocode, and snippets.
- If multiple interpretations exist, present all of them — never pick silently.
- Surface tradeoffs. If a simpler approach exists, say so first.
- Surface unresolved decisions clearly.

When `/discuss-done` is called, implement strictly based on what was agreed upon in the discussion.

**Auto-exit rule:**
- **Condition:** User signals the discussion is complete (e.g., "이제 구현 시작해", "그걸로 가자", "시작해도 돼").
- **Action:** Use `AskUserQuestion` with exactly "Exit Discuss Mode?" (Yes / No). Only call `/discuss-done` if the user selects Yes.

## Normal Mode

Default mode. Applies whenever Discuss Mode is not active.

- Implement only what was requested or agreed upon in discussion.
- Do not touch adjacent code — including style, formatting, and comments.
- Only clean up dead code (unused imports, variables, etc.) that your own changes introduced. For pre-existing dead code, mention it but do not delete it.
- If a request is ambiguous or involves significant design decisions, suggest entering Discuss Mode: "This might be worth discussing first — want to `/discuss`?"
