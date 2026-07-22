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

### `hooks/mode-guard.sh` — Mode Enforcement Hook

A `PreToolUse` hook that blocks `Edit` and `Write` whenever `.claude/.mode` contains `discuss`. This is what makes Discuss Mode actually unable to write code, rather than just asking Claude nicely.

### `settings.json` — Hooks and Plugins

- Wires `mode-guard.sh` into `PreToolUse` for `Edit|Write`.
- Auto-allows `Bash` while in Discuss Mode (read-only investigation is fine).
- Enables the `clangd-lsp` and `codex` plugins.
- No desktop-notification hooks: this is a headless server, so the macOS `osascript` notifications from `main` are dropped rather than replaced.

## Branches

`settings.json` and `CLAUDE.md` are platform-specific — hook commands, notifier, and the documented directory layout all differ per machine.

- `main` — macOS
- `windows` — Windows 11
- `ubuntu-server` — Ubuntu 22.04 server (headless, nginx + systemd host)

Shared content (`skills/`, `writing-style.md`, `LICENSE`) should be changed on `main` and merged forward.

## Installation

These files live in `~/.claude/` and are loaded by Claude Code automatically.

**Ubuntu server**

```bash
git clone -b ubuntu-server <this-repo> ~/.claude
chmod +x ~/.claude/hooks/*.sh
```

The `CLAUDE.md` on this branch documents a headless host laid out around `/srv`, `/etc/nginx`, `/etc/wireguard`, and systemd units rather than a personal home directory. Hooks are referenced by `~/.claude/...` so no absolute-path edits are needed.

If you already have a `~/.claude/` directory, merge selectively — at minimum copy `CLAUDE.md`, `skills/`, `hooks/`, and the `hooks` block from `settings.json`.

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
2. Before any `Edit` or `Write` tool call, `mode-guard.sh` reads the file. If the mode is `discuss`, it exits with code `2`, which Claude Code treats as a denied tool call.
3. `Bash` calls are explicitly allowed during Discuss Mode so Claude can still read, grep, and run diagnostics while you think.

This keeps Discuss Mode honest: it is enforced by the harness, not by trusting the model to remember the rule.

## License

[MIT](./LICENSE)
