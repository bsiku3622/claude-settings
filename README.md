# Claude Code Personal Configuration

A personal Claude Code setup that adds a **Discuss / Normal** two-mode workflow on top of the default agent. The mode is enforced by a hook so Claude cannot edit files while in Discuss Mode, and a small set of slash-command skills makes it easy to switch modes and steer reasoning.

## Components

### `CLAUDE.md` — Global Behavior Rules

Loaded into every session. Defines two operating modes:

- **Discuss Mode** — Activated by `/discuss`. Claude must not write any code (no blocks, no inline, no pseudocode), must surface all interpretations and tradeoffs, and must flag unresolved decisions.
- **Normal Mode** — Default. Claude implements only what was requested or agreed in discussion, and does not touch adjacent code.

The mode is stored in `.claude/.mode` (per project) and may only be changed through the `/discuss` and `/discuss-done` skills.

### `skills/` — Slash-Command Skills

| Skill | Purpose |
| --- | --- |
| `/discuss` | Enter Discuss Mode — blocks file edits, focuses on clarifying requirements. |
| `/discuss-done` | Exit Discuss Mode and unlock implementation. |
| `/build` | Implement based on everything decided in the conversation. |
| `/think` | Reason through a problem systematically before answering. |
| `/analysis` | Investigate a problem methodically; do not propose a fix until the root cause is confirmed. |
| `/explain` | In-depth, educator-style explanation of a concept or code. |
| `/brilliant` | Push beyond the obvious to find the most elegant solution. |
| `/challenge` | Devil's advocate — argue against the current approach to stress-test it. |
| `/brief` | Summarize the current session as a system prompt for the next chat. |

Each skill is a single `SKILL.md` file with frontmatter (`name`, `description`) and a short instruction body.

### `hooks/` — Mode Enforcement and Notifications

`mode-guard.sh` (macOS/Linux) and `mode-guard.ps1` (Windows) are `PreToolUse` hooks that block `Edit` and `Write` whenever `.claude/.mode` contains `discuss`. This is what makes Discuss Mode actually unable to write code, rather than just asking Claude nicely.

`notify.ps1` (Windows only) raises a WinRT toast on `PermissionRequest` and `Stop`. It is the counterpart of the `osascript` calls used on macOS. Notification text lives inside the script rather than in `settings.json`, because the Windows console code page mangles non-ASCII arguments passed on the command line.

### `settings.json` — Hooks, Plugins, Notifications

- Wires the mode guard into `PreToolUse` for `Edit|Write`.
- Auto-allows `Bash` while in Discuss Mode (read-only investigation is fine).
- Fires a desktop notification on `PermissionRequest` and `Stop`.
- Enables the `clangd-lsp` and `codex` plugins.

## Branches

`settings.json` and `CLAUDE.md` are platform-specific — hook commands, notifier, and the documented directory layout all differ per machine.

- `main` — macOS
- `windows` — Windows 11

Shared content (`skills/`, `writing-style.md`, `LICENSE`) should be changed on `main` and merged forward into `windows`.

## Installation

These files live in the Claude Code config directory and are loaded automatically.

**macOS / Linux**

```bash
git clone <this-repo> ~/.claude
chmod +x ~/.claude/hooks/mode-guard.sh
```

**Windows**

```powershell
git clone -b windows <this-repo> $env:USERPROFILE\.claude
```

The Windows hooks are invoked as `powershell -NoProfile -ExecutionPolicy Bypass -File ...`, so no execution-policy change is needed. Absolute paths in `settings.json` assume `C:\Users\bsiku\.claude`; adjust them if the config directory lives elsewhere.

If you already have a config directory, merge selectively — at minimum copy `CLAUDE.md`, `skills/`, `hooks/`, and the `hooks` block from `settings.json`.

## Usage

```
/discuss   should we cache the user lookups?
   ... back-and-forth, no code written ...
/discuss-done
/build
   ... Claude implements the agreed approach ...
```

Other skills (`/think`, `/analysis`, `/challenge`, etc.) work in either mode and simply steer Claude's reasoning style.

## How the Mode Guard Works

1. `.claude/.mode` holds either `discuss` or `normal` (or is absent, treated as `normal`).
2. Before any `Edit` or `Write` tool call, the mode guard reads the file. If the mode is `discuss`, it exits with code `2`, which Claude Code treats as a denied tool call. The Windows guard tolerates a BOM, CRLF line endings, and mixed case, since `.mode` may be written by either Git Bash or PowerShell.
3. `Bash` calls are explicitly allowed during Discuss Mode so Claude can still read, grep, and run diagnostics while you think.

This keeps Discuss Mode honest: it is enforced by the harness, not by trusting the model to remember the rule.

## License

[MIT](./LICENSE)
