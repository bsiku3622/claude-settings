#!/bin/bash
# Hook stdin is authoritative; subagent hooks carry the parent session ID.
exec python3 -c '
import json, os, pathlib, re, sys
try:
    payload = json.load(sys.stdin)
except (ValueError, TypeError):
    payload = {}
sid = payload.get("session_id") if isinstance(payload, dict) else None
sid = sid or os.environ.get("CODEX_THREAD_ID") or os.environ.get("CODEX_SESSION_ID")
if not isinstance(sid, str) or not re.fullmatch(r"[A-Za-z0-9_-]+", sid):
    sys.exit(0)
if (pathlib.Path.home() / ".codex" / "modes" / sid).is_file():
    print("Cannot edit files in Discuss Mode — use /discuss-done to exit.", file=sys.stderr)
    sys.exit(2)
'
