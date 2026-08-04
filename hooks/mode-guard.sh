#!/bin/bash
# DISCUSS 모드에서 파일 편집을 차단한다.
#
# 상태는 ~/.claude/modes/<세션 ID> 파일의 "존재 여부"로 판정한다.
# 파일이 있으면 discuss, 없으면 normal — 내용은 보지 않는다.
# discuss-done 이 파일을 지우므로 대부분의 세션은 잔여물을 남기지 않는다.
#
# 세션 ID 를 얻지 못하면 통과시킨다(fail-open). discuss 모드는 실수를 막는
# 안전장치이지 보안 경계가 아니므로, 판정 불가일 때 정상 작업을 막는 쪽이 더 나쁘다.

SID="${CLAUDE_CODE_SESSION_ID:-}"

# 환경변수가 없으면 hook 이 stdin 으로 받는 JSON 에서 뽑는다.
if [ -z "$SID" ]; then
    SID=$(cat | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
fi

[ -z "$SID" ] && exit 0
[ -f "$HOME/.claude/modes/$SID" ] || exit 0

echo "Cannot edit files in Discuss Mode — use /discuss-done to exit." >&2
exit 2
