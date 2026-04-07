#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

BAG_PATH="${1:-tests/rosbag_replay/data/sample_bag}"

if [[ ! -d "$BAG_PATH" ]]; then
  echo "WARN: rosbag path not found: $BAG_PATH"
  if [[ "${REQUIRE_ROSBAG:-0}" == "1" ]]; then
    echo "ERROR: REQUIRE_ROSBAG=1 but bag is missing"
    exit 1
  fi
  exit 0
fi

if ! command -v ros2 >/dev/null 2>&1; then
  echo "ERROR: ros2 command not found"
  exit 1
fi

echo "Running rosbag info for regression input..."
ros2 bag info "$BAG_PATH"

echo "Rosbag replay regression precheck completed."
