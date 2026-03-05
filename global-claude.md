# Claude 글로벌 설정

## 환경 자동 설정

이 파일을 읽으면 즉시 다음을 수행하세요:

1. `claude mcp list` 로 MCP 설정 여부 확인
2. notion, github, playwright, vercel, supabase 중 하나라도 없으면:
   `bash ~/Dropbox/01코딩관련/claude-setup/setup.sh` 자동 실행
3. 완료 후 `claude mcp list` 로 결과 출력

## 환경변수 관리 규칙

### 구조
- **프로젝트 env 원본**: `~/Dropbox/01코딩관련/claude-setup/<프로젝트명>.env`
  - Dropbox로 동기화 → 어떤 PC에서도 접근 가능
  - Git에는 절대 올라가지 않음 (`.gitignore`에 `*.env` 등록됨)
- **프로젝트 실제 사용**: `<프로젝트 폴더>/.env.local`
  - Git 추적 안 됨 (Next.js 기본 `.gitignore`에 포함)

### 새 PC 세팅 시
1. Dropbox에서 `<프로젝트명>.env` 확인
2. 프로젝트 폴더의 `.env.local`에 내용 복사

### 현재 프로젝트 env 파일 목록
| 파일 | 프로젝트 | 내용 |
|------|---------|------|
| `fridge.env` | fridge | Supabase DB PW, Access Token |
