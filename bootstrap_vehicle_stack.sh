#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

OWNER=""
OUT_FILE="my_vehicle.repos"

usage() {
  cat <<'USAGE'
Usage:
  ./bootstrap_vehicle_stack.sh [--owner <github-owner>] [--out <repos-file>]

Purpose:
  1) Ensure forks exist for Autoware meta/core repos.
  2) Regenerate my_vehicle.repos with your fork URLs.

Example:
  ./bootstrap_vehicle_stack.sh --owner however-yir
USAGE
}

need_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "ERROR: missing command: $cmd" >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner)
      OWNER="${2:-}"
      shift 2
      ;;
    --out)
      OUT_FILE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown arg: $1" >&2
      usage
      exit 1
      ;;
  esac
done

need_cmd gh

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "ERROR: gh not authenticated. Run: gh auth login" >&2
  exit 1
fi

LOGIN_USER="$(gh api user --jq .login)"
if [[ -z "$OWNER" ]]; then
  OWNER="$LOGIN_USER"
fi

declare -a UPSTREAMS=(
  "autowarefoundation/autoware"
  "autowarefoundation/autoware_universe"
  "autowarefoundation/autoware_core"
  "autowarefoundation/autoware_launch"
)

ensure_fork() {
  local upstream="$1"
  local name="${upstream##*/}"
  local fork_full="$OWNER/$name"

  if gh repo view "$fork_full" >/dev/null 2>&1; then
    echo "fork exists: $fork_full"
    return 0
  fi

  echo "forking: $upstream -> $fork_full"
  if [[ "$OWNER" == "$LOGIN_USER" ]]; then
    gh api -X POST "repos/$upstream/forks" >/dev/null
  else
    gh api -X POST "repos/$upstream/forks" -f organization="$OWNER" >/dev/null
  fi

  for _ in $(seq 1 60); do
    if gh repo view "$fork_full" >/dev/null 2>&1; then
      echo "fork ready: $fork_full"
      return 0
    fi
    sleep 2
  done

  echo "ERROR: fork not ready in time: $fork_full" >&2
  exit 1
}

for upstream in "${UPSTREAMS[@]}"; do
  ensure_fork "$upstream"
done

cat > "$OUT_FILE" <<YAML
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
repositories:
  autoware:
    type: git
    url: https://github.com/$OWNER/autoware.git
    version: main
  autoware_universe:
    type: git
    url: https://github.com/$OWNER/autoware_universe.git
    version: main
  autoware_core:
    type: git
    url: https://github.com/$OWNER/autoware_core.git
    version: main
  autoware_launch:
    type: git
    url: https://github.com/$OWNER/autoware_launch.git
    version: main
YAML

echo "updated $OUT_FILE"
echo "next: mkdir -p src && vcs import src < $OUT_FILE"
