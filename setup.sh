#!/bin/bash
# Claude Code MCP 환경 설정 스크립트
# 실행: bash setup.sh

SETUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code MCP Setup ==="
echo ""

# --- Git 글로벌 설정 ---
git config --global user.email "oseong27436@gmail.com"
git config --global user.name "oseong27436"
echo "[Git] 글로벌 user 설정 완료"
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

# --- SuperClaude ---
if command -v pipx &> /dev/null; then
  pipx install superclaude 2>/dev/null || pipx upgrade superclaude
  PYTHONIOENCODING=utf-8 PYTHONUTF8=1 superclaude install
  echo "[SuperClaude] 설치 완료"
else
  echo "[SuperClaude] pipx 없음 - pip으로 시도"
  pip install superclaude && PYTHONIOENCODING=utf-8 PYTHONUTF8=1 superclaude install
  echo "[SuperClaude] 설치 완료"
fi

echo ""
echo "=== 완료! claude mcp list 로 확인하세요 ==="
echo "=== Claude Code 재시작 후 /sc 명령어 사용 가능 ==="
