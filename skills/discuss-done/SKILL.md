---
name: discuss-done
description: Exit DISCUSS mode and return to Normal Mode. Implementation does not start automatically — wait for the user's next instruction.
---

Bash 도구를 사용해 즉시 다음 명령을 실행합니다:

```
mkdir -p .claude && echo normal > .claude/.mode
```

이제 Normal Mode입니다. 사용자의 다음 지시를 기다리고 논의가 끝났다고 바로 구현에 들어가지 않습니다. 맥락에 따라 지금 구현을 시작할 수도 있고, 잠시 멈추고 다시 discuss 모드에 진입할 수도 있습니다. 구현이 시작되면 CLAUDE.md의 「작업 시 지켜야 하는 것 → 구현 규칙」을 따르세요.

$ARGUMENTS
