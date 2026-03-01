#!/bin/bash
# Claude Code MCP 환경 설정 스크립트
# 실행: bash setup.sh

SETUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code MCP Setup ==="
echo ""

# --- Notion ---
if [ -f "$SETUP_DIR/.notion.env" ]; then
  source "$SETUP_DIR/.notion.env"
  echo "[Notion] 토큰 로드됨"
  claude mcp add notion \
    -e OPENAPI_MCP_HEADERS="{\"Authorization\": \"Bearer $NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}" \
    -- npx -y @notionhq/notion-mcp-server
  echo "[Notion] MCP 추가 완료"
else
  echo "[Notion] .notion.env 파일 없음 - 스킵"
fi

echo ""

# --- Playwright ---
claude mcp add playwright npx @playwright/mcp@latest
echo "[Playwright] MCP 추가 완료"

# --- Vercel ---
claude mcp add vercel --transport http https://mcp.vercel.com
echo "[Vercel] MCP 추가 완료"

# --- Supabase ---
claude mcp add supabase --transport http https://mcp.supabase.com/mcp
echo "[Supabase] MCP 추가 완료"

echo ""
echo "=== 완료! claude mcp list 로 확인하세요 ==="
