# Claude Code 환경 설정

## 자동 설정 (이 파일을 읽으면 즉시 실행)

이 CLAUDE.md를 읽는 즉시 다음을 수행하세요:

1. `claude mcp list` 실행해서 MCP 설정 여부 확인
2. notion, playwright, vercel, supabase 중 하나라도 없으면:
   `bash ~/Dropbox/01코딩관련/claude-setup/setup.sh` 자동 실행
3. 완료 후 `claude mcp list` 로 결과 출력

---

## 빠른 시작 (수동)

```bash
bash ~/Dropbox/01코딩관련/claude-setup/setup.sh
```

## MCP 서버 목록

| 서버 | 용도 | 토큰 필요 |
|------|------|-----------|
| notion | Notion 읽기/쓰기 | `.notion.env` |
| playwright | 브라우저 자동화 | 없음 |
| vercel | Vercel 배포 관리 | 없음 (OAuth) |
| supabase | Supabase DB 관리 | 없음 (OAuth) |

## 토큰 파일 위치

Dropbox에서 자동 동기화됨:
```
~/Dropbox/01코딩관련/claude-setup/
├── .notion.env     # Notion Integration Token
```

## 수동 설치

### Notion
```bash
source ~/Dropbox/01코딩관련/claude-setup/.notion.env
claude mcp add notion \
  -e OPENAPI_MCP_HEADERS="{\"Authorization\": \"Bearer $NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}" \
  -- npx -y @notionhq/notion-mcp-server
```

### Playwright
```bash
claude mcp add playwright npx @playwright/mcp@latest
```

### Vercel
```bash
claude mcp add vercel --transport http https://mcp.vercel.com
```

### Supabase
```bash
claude mcp add supabase --transport http https://mcp.supabase.com/mcp
```

## Notion 페이지 연결

MCP 설치 후 접근할 각 Notion 페이지에서:
1. 우상단 `...` 클릭
2. **연결 추가** 선택
3. 만들어둔 Integration 선택
