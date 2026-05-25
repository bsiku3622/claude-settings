---
name: discuss-done
description: Exit DISCUSS mode and return to Normal Mode. Implementation does not start automatically — wait for the user's next instruction.
---

Run this bash command immediately using the Bash tool:

```
mkdir -p .claude && echo normal > .claude/.mode
```

Now in Normal Mode. The discussion is closed, but do not begin implementation reflexively. Wait for the user's next instruction — they may want to implement now, or they may want to step away and come back. Once implementation begins, follow the Normal Mode rules in CLAUDE.md.

$ARGUMENTS
