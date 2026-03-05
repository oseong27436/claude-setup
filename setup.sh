#!/bin/bash
# Claude Code 환경 설정 - 진입점
# 실행: bash setup.sh

SETUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "================================"
echo "  Claude Code Setup"
echo "================================"
echo ""

# --- 글로벌 CLAUDE.md 설치 ---
mkdir -p "$HOME/.claude"
cp "$SETUP_DIR/global-claude.md" "$HOME/.claude/CLAUDE.md"
echo "[CLAUDE.md] 글로벌 설정 완료"

# --- 커스텀 커맨드 설치 ---
if [ -d "$SETUP_DIR/commands" ]; then
  cp -r "$SETUP_DIR/commands/"* "$HOME/.claude/commands/"
  echo "[Commands] 커스텀 커맨드 설치 완료"
fi
echo ""

# --- Git 글로벌 설정 ---
git config --global user.email "oseong27436@gmail.com"
git config --global user.name "oseong27436"
echo "[Git] 완료"
echo ""

bash "$SETUP_DIR/scripts/mcp.sh" "$SETUP_DIR"
echo ""

bash "$SETUP_DIR/scripts/superclaude.sh"
echo ""

echo "================================"
echo "  완료!"
echo "  - claude mcp list 로 MCP 확인"
echo "  - Claude Code 재시작 후 /sc 사용 가능"
echo "================================"
