#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="${1:-$ROOT_DIR/src}"

declare -a PAIRS=(
  "autoware|autowarefoundation/autoware"
  "autoware_universe|autowarefoundation/autoware_universe"
  "autoware_core|autowarefoundation/autoware_core"
  "autoware_launch|autowarefoundation/autoware_launch"
)

for pair in "${PAIRS[@]}"; do
  name="${pair%%|*}"
  upstream_repo="${pair##*|}"
  path="$SRC_DIR/$name"

  if [[ ! -d "$path/.git" ]]; then
    echo "skip: $name (not found at $path)"
    continue
  fi

  if git -C "$path" remote get-url upstream >/dev/null 2>&1; then
    git -C "$path" remote set-url upstream "https://github.com/$upstream_repo.git"
  else
    git -C "$path" remote add upstream "https://github.com/$upstream_repo.git"
  fi

  git -C "$path" fetch upstream --tags
  echo "synced upstream remote: $name"
done
