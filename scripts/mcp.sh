#!/bin/bash
# MCP 서버 설정

SETUP_DIR="$1"
echo "[MCP] 설정 중..."

# --- Notion ---
if [ -f "$SETUP_DIR/.notion.env" ]; then
  source "$SETUP_DIR/.notion.env"
  claude mcp add -s user notion \
    -e OPENAPI_MCP_HEADERS="{\"Authorization\": \"Bearer $NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}" \
    -- npx -y @notionhq/notion-mcp-server
  echo "[MCP] Notion 완료"
else
  echo "[MCP] Notion - .notion.env 없음, 스킵"
fi

# --- GitHub ---
if [ -f "$SETUP_DIR/.github.env" ]; then
  source "$SETUP_DIR/.github.env"
  claude mcp add -s user github \
    -e GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN" \
    -- npx -y @modelcontextprotocol/server-github
  echo "[MCP] GitHub 완료"
else
  echo "[MCP] GitHub - .github.env 없음, 스킵"
fi

# --- Oracle OCI ---
if [ -f "$SETUP_DIR/.oci-config" ]; then
  # C:/tmp 폴더 생성 (OCI MCP 필요)
  mkdir -p /tmp

  # OCI config 복사
  mkdir -p "$HOME/.oci"
  cp "$SETUP_DIR/.oci-config" "$HOME/.oci/config"

  # uvx 설치 확인
  UVX_PATH=$(which uvx 2>/dev/null || echo "$HOME/.local/bin/uvx")
  if [ ! -f "$UVX_PATH" ]; then
    pip install uv
    UVX_PATH=$(which uvx 2>/dev/null || echo "$HOME/.local/bin/uvx")
  fi

  claude mcp add -s user oracle-oci \
    -e OCI_CONFIG_PROFILE="DEFAULT" \
    -- "$UVX_PATH" oracle.oci-api-mcp-server@latest
  echo "[MCP] Oracle OCI 완료"
else
  echo "[MCP] Oracle OCI - .oci-config 없음, 스킵"
fi

# --- Playwright ---
claude mcp add -s user playwright npx @playwright/mcp@latest
echo "[MCP] Playwright 완료"

# --- Vercel ---
claude mcp add -s user vercel --transport http https://mcp.vercel.com
echo "[MCP] Vercel 완료"

# --- Supabase ---
claude mcp add -s user supabase --transport http https://mcp.supabase.com/mcp
echo "[MCP] Supabase 완료"

# --- Google Workspace ---
if [ -f "$SETUP_DIR/.google.env" ]; then
  source "$SETUP_DIR/.google.env"

  # pip (Python311) 으로 workspace-mcp 설치
  pip install workspace-mcp 2>/dev/null

  # pip의 Scripts 폴더에서 workspace-mcp 찾기
  PIP_SCRIPTS=$(dirname "$(which pip 2>/dev/null)")
  WORKSPACE_MCP="${PIP_SCRIPTS}/workspace-mcp"
  if [ -f "${WORKSPACE_MCP}.exe" ]; then
    WORKSPACE_MCP="${WORKSPACE_MCP}.exe"
  fi

  claude mcp remove -s user google-workspace 2>/dev/null
  claude mcp add -s user google-workspace \
    -e GOOGLE_OAUTH_CLIENT_ID="$GOOGLE_CLIENT_ID" \
    -e GOOGLE_OAUTH_CLIENT_SECRET="$GOOGLE_CLIENT_SECRET" \
    -- "$WORKSPACE_MCP"
  echo "[MCP] Google Workspace 완료"
else
  echo "[MCP] Google Workspace - .google.env 없음, 스킵"
fi
