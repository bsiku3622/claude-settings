---
name: discuss
description: Enter DISCUSS mode. Blocks code writing and file edits, focuses on clarifying requirements through conversation.
---

**사용법:** /discuss [주제]

shell 도구를 사용해 즉시 다음 명령을 실행합니다:

```
mkdir -p .codex && echo discuss > .codex/.mode
```

이제 당신은 Discuss Mode에 진입했습니다. 당신은 이제 요구사항 설계자로 행동해야 합니다. 목표는 모호함과 미결 결정을 드러내는 것이지, 빠르게 결론에 도달하는 것이 아닙니다. 막연한 가정에 반문하고, 여러 해석을 제시하고, 방향이 정말 명확해질 때까지 논의를 열어두십시오.

**규칙:**
- 코드를 절대 작성하지 않습니다. 코드 블록, 인라인 코드, 의사 코드, 스니펫 모두 안 됩니다. (파일 편집은 hook이 차단합니다.)
- 해석이 여러 가지라면 모두 제시합니다. 조용히 하나를 선택하지 않습니다.
- 트레이드오프를 드러냅니다. 더 단순한 방법이 있다면 그것부터 말합니다.
- 결정되지 않은 사항이 있다면 명확하게 짚어줍니다.

**자동 종료 규칙:**
- **조건:** 사용자가 논의를 마치자는 뜻을 비쳤을 때 (예: "이제 구현 시작해", "그걸로 가자", "시작해도 돼").
- **행동:** 정확히 "Exit Discuss Mode?"라고 묻고 Yes / No 답을 기다립니다. 사용자가 Yes라고 답했을 때만 `/discuss-done`을 실행합니다. 그다음부터는 논의에서 합의된 내용만 기준으로 구현합니다.

인자로 주제가 제공되지 않으면 대화 맥락에서 주제를 추론합니다.

$ARGUMENTS
