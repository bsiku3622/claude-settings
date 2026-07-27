# Codex Personal Configuration

Personal Codex defaults for consistent behavior across machines. This branch
shares a Git history and remote with the Claude configuration while keeping
Codex-specific files and runtime state separate.

## Components

- `AGENTS.md` — global behavior, language, implementation, and Git conventions
- `writing-style.md` — long-form writing guidance by document type
- `config.toml` — model, reasoning effort, trusted projects, and MCP defaults
- `hooks.json` and `hooks/` — Discuss Mode edit guard
- `rules/` — approved command-prefix rules
- `skills/` — reusable personal workflows

The repository uses an allow-list `.gitignore`. Authentication, histories,
SQLite databases, caches, logs, shell snapshots, installed plugins, and bundled
system skills remain local and are never committed.

## Installation

```bash
git clone --branch codex https://github.com/bsiku3622/claude-settings ~/.codex
chmod +x ~/.codex/hooks/mode-guard.sh
```

Restart Codex after pulling changes so global instructions, hooks, and skills
are reloaded.

## Skills

| Skill | Purpose |
| --- | --- |
| `/brief` | Summarize the current session for a new chat |
| `/discuss` | Enter discussion-only mode and block file edits |
| `/discuss-done` | Exit discussion-only mode |
| `/explain` | Explain a topic in depth |
| `/funky-ui` | Apply the funky-ui design system |
| `/save-report` | Write and save a Markdown report |
| `/studio-baeks-ppt` | Author Studio Baeks PPT Engine decks |

## License

[MIT](./LICENSE)
