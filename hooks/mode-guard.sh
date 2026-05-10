#!/bin/bash
MODE=$(cat ".claude/.mode" 2>/dev/null || echo "normal")
if [ "$MODE" = "discuss" ]; then
    echo "Cannot edit files in Discuss Mode — use /discuss-done to exit." >&2
    exit 2
fi
exit 0
