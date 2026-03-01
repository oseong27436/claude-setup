#!/bin/bash
# MCP 서버 설정

SETUP_DIR="$1"
echo "[MCP] 설정 중..."

# --- Notion ---
if [ -f "$SETUP_DIR/.notion.env" ]; then
  source "$SETUP_DIR/.notion.env"
  claude mcp add notion \
    -e OPENAPI_MCP_HEADERS="{\"Authorization\": \"Bearer $NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}" \
    -- npx -y @notionhq/notion-mcp-server
  echo "[MCP] Notion 완료"
else
  echo "[MCP] Notion - .notion.env 없음, 스킵"
fi

# --- GitHub ---
if [ -f "$SETUP_DIR/.github.env" ]; then
  source "$SETUP_DIR/.github.env"
  claude mcp add github \
    -e GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN" \
    -- npx -y @modelcontextprotocol/server-github
  echo "[MCP] GitHub 완료"
else
  echo "[MCP] GitHub - .github.env 없음, 스킵"
fi

# --- Playwright ---
claude mcp add playwright npx @playwright/mcp@latest
echo "[MCP] Playwright 완료"

# --- Vercel ---
claude mcp add vercel --transport http https://mcp.vercel.com
echo "[MCP] Vercel 완료"

# --- Supabase ---
claude mcp add supabase --transport http https://mcp.supabase.com/mcp
echo "[MCP] Supabase 완료"
