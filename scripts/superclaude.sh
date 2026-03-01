#!/bin/bash
# SuperClaude 설치

echo "[SuperClaude] 설치 중..."

if command -v pipx &> /dev/null; then
  pipx install superclaude 2>/dev/null || pipx upgrade superclaude
  PYTHONIOENCODING=utf-8 PYTHONUTF8=1 superclaude install
elif command -v pip &> /dev/null; then
  pip install superclaude
  PYTHONIOENCODING=utf-8 PYTHONUTF8=1 superclaude install
else
  echo "[SuperClaude] pip/pipx 없음 - Python 설치 필요"
  exit 1
fi

echo "[SuperClaude] 완료 (Claude Code 재시작 후 /sc 사용 가능)"
