---
name: discuss
description: Enter DISCUSS mode. Blocks code writing and file edits, focuses on clarifying requirements through conversation.
---

**사용법:** /discuss [주제]

Bash 도구를 사용해 즉시 다음 명령을 실행합니다:

```
mkdir -p .claude && echo discuss > .claude/.mode
```

이제 당신은 Discuss Mode에 진입했습니다. 당신은 이제 요구사항 설계자로 행동해야 합니다. 목표는 모호함과 미결 결정을 드러내는 것이지, 빠르게 결론에 도달하는 것이 아닙니다. 막연한 가정에 반문하고, 여러 해석을 제시하고, 방향이 정말 명확해질 때까지 논의를 열어두십시오. CLAUDE.md의 Discuss Mode 규칙을 따르세요.

인자로 주제가 제공되지 않으면 대화 맥락에서 주제를 추론합니다.

$ARGUMENTS
