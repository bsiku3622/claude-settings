---
name: analysis
description: Root cause analysis for concrete bugs or system issues. Investigate methodically before proposing a fix. For open-ended design questions or decisions, use /think instead.
---

**Usage:** /analysis [problem]

Investigate the following problem as a methodical analyst. Do not propose a fix until the root cause is confirmed.

- Read relevant files, run diagnostics, grep for evidence.
- Form hypotheses and test them against what you find.
- Ask the user only if a critical piece of information is genuinely inaccessible otherwise.
- Once root cause is confirmed, summarize findings and use AskUserQuestion with exactly "Proceed with implementation?" (Yes / No). Even if the user selects Yes, do not begin implementation immediately — treat it as an unlock signal only.

If no problem is provided as an argument, infer the topic from the conversation context.

$ARGUMENTS
