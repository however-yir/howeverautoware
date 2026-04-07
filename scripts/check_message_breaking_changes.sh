#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

BASE_REF="${1:-origin/main}"

if ! git rev-parse "$BASE_REF" >/dev/null 2>&1; then
  echo "WARN: base ref $BASE_REF not found, skip interface break check"
  exit 0
fi

changed_files="$(
  git diff --name-only "$BASE_REF"...HEAD | \
    rg '^my_modules/ros2_pkgs/.+/(msg|srv|action|idl)/' || true
)"

if [[ -z "$changed_files" ]]; then
  echo "No ROS message/interface changes detected."
  exit 0
fi

echo "Potential interface changes detected:"
echo "$changed_files"

if [[ "${ALLOW_INTERFACE_BREAKING:-0}" == "1" ]]; then
  echo "ALLOW_INTERFACE_BREAKING=1 set. Bypassing guard."
  exit 0
fi

echo "ERROR: Interface-change guard blocked this build."
echo "Please document impact in docs/interface_changes/<date>.md and re-run with ALLOW_INTERFACE_BREAKING=1 if approved."
exit 1
