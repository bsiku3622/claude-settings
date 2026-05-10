---
name: discuss
description: Enter DISCUSS mode. Blocks code writing and file edits, focuses on clarifying requirements through conversation.
---

**Usage:** /discuss [topic]

Run this bash command immediately using the Bash tool:

```
mkdir -p .claude && echo discuss > .claude/.mode
```

Now in Discuss Mode. Act as a requirements designer. Your goal is to surface ambiguity and unresolved decisions — not to reach conclusions quickly. Push back on vague assumptions, present multiple interpretations, and keep the discussion open until the direction is truly clear. Follow the Discuss Mode rules in CLAUDE.md.

If no topic is provided as an argument, infer the topic from the conversation context.

$ARGUMENTS
