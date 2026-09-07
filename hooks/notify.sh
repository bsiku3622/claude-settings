#!/bin/bash
# Keep notification text static; never interpolate conversation contents.
case "$1" in
    permission)
        /usr/bin/osascript -e 'display notification "확인이 필요합니다" with title "Codex" sound name "Ping"' >/dev/null 2>&1
        ;;
    stop)
        /usr/bin/osascript -e 'display notification "작업이 완료되었습니다" with title "Codex" sound name "Glass"' >/dev/null 2>&1
        ;;
esac
# Stop hooks require JSON, and notification failures must not restart a turn.
printf '{}\n'
exit 0
