# Claude Code 환경 설정

## 자동 설정 (이 파일을 읽으면 즉시 실행)

이 CLAUDE.md를 읽는 즉시 다음을 수행하세요:

1. `claude mcp list` 실행해서 MCP 설정 여부 확인
2. notion, github, playwright, vercel, supabase 중 하나라도 없으면:
   `bash ~/Dropbox/01코딩관련/claude-setup/setup.sh` 자동 실행
3. 완료 후 `claude mcp list` 로 결과 출력

---

## 빠른 시작 (수동)

```bash
bash ~/Dropbox/01코딩관련/claude-setup/setup.sh
```

개별 실행:
```bash
bash ~/Dropbox/01코딩관련/claude-setup/scripts/git.sh
bash ~/Dropbox/01코딩관련/claude-setup/scripts/mcp.sh ~/Dropbox/01코딩관련/claude-setup
bash ~/Dropbox/01코딩관련/claude-setup/scripts/superclaude.sh
```

---

## 구조

```
claude-setup/
├── setup.sh              # 전체 실행 진입점
├── scripts/
│   ├── git.sh            # Git 글로벌 설정
│   ├── mcp.sh            # MCP 서버 전체 설정
│   └── superclaude.sh    # SuperClaude 설치
├── .notion.env           # Notion 토큰 (Dropbox 동기화, git 제외)
└── .github.env           # GitHub PAT (Dropbox 동기화, git 제외)
```

---

## MCP 서버 목록

| 서버 | 용도 | 토큰 |
|------|------|------|
| notion | Notion 읽기/쓰기 | `.notion.env` |
| github | GitHub 레포 관리 | `.github.env` |
| playwright | 브라우저 자동화 | 없음 |
| vercel | Vercel 배포 | 없음 (OAuth) |
| supabase | Supabase DB | 없음 (OAuth) |

## Env 파일 형식

**.notion.env**
```
NOTION_TOKEN=ntn_xxxxxxxxxxxx
```

**.github.env**
```
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

---

## Notion 페이지 연결

MCP 설치 후 접근할 각 Notion 페이지에서:
1. 우상단 `...` 클릭
2. **연결 추가** 선택
3. 만들어둔 Integration 선택
