---
name: save-report
description: Save a report as a Markdown file in D:\Reports.
---

**Usage:** /save-report [주제 또는 지시사항]

사용자가 요청한 주제 또는 현재 세션의 맥락을 바탕으로 보고서 형식의 Markdown 문서를 작성하고 파일로 저장합니다.

## 작성 규칙

- 한국어로 작성
- 보고서 형식 — 제목(H1), 개요, 본문 섹션(H2/H3), 결론 순서로 구성
- 사실과 의견을 구분해서 서술
- 필요 시 표, 코드 블록, 리스트 사용
- 사용자가 요청한 주제에 집중하되, 관련된 중요한 정보나 배경도 포함
- 수식은 LaTeX로 — 인라인은 `$...$`, 블록은 `$$...$$` (예: `$E=mc^2$`, `$$\int \sec x\,dx = \ln|\sec x+\tan x|+C$$`). 표·GFM과 함께 Report Viewer가 KaTeX로 렌더한다.

## 파일명 생성

1. 본문 제목을 기반으로 kebab-case slug 생성 (영문/숫자/하이픈만, 한글이면 음차 또는 영문 요약)
2. 현재 로컬 시각을 `YYYY-MM-DD_HH-MM` 포맷으로 prefix
3. 최종 파일명: `YYYY-MM-DD_HH-MM-{title-slug}.md`

예: `2026-05-23_17-04-quarterly-roadmap-review.md`

## 저장 절차

1. 보고서 본문을 작성합니다.
2. 본문 제목에서 slug를 추출합니다.
3. PowerShell 도구로 `Get-Date -Format "yyyy-MM-dd_HH-mm"` 을 실행해 현재 시각 prefix를 얻습니다.
4. `D:\Reports\{prefix}-{slug}.md` 경로에 Write 도구로 저장합니다.
5. 동일 파일명이 이미 존재하면 `-2`, `-3` 식으로 suffix를 붙입니다.
6. 저장 완료 후 절대 경로 한 줄로 결과를 알립니다.
