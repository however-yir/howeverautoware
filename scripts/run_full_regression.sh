#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

ROS_DISTRO="${ROS_DISTRO:-humble}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="${ROOT_DIR}/reports/regression/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$REPORT_DIR"

if [[ -f "/opt/ros/$ROS_DISTRO/setup.bash" ]]; then
  # shellcheck disable=SC1090
  source "/opt/ros/$ROS_DISTRO/setup.bash"
else
  echo "ERROR: /opt/ros/$ROS_DISTRO/setup.bash not found" >&2
  exit 1
fi

pushd "$ROOT_DIR" >/dev/null

colcon build --symlink-install | tee "$REPORT_DIR/colcon_build.log"
# shellcheck disable=SC1091
source install/setup.bash
colcon test --event-handlers console_direct+ | tee "$REPORT_DIR/colcon_test.log"
colcon test-result --verbose | tee "$REPORT_DIR/colcon_test_result.log"

./tests/rosbag_replay/run_rosbag_regression.sh | tee "$REPORT_DIR/rosbag_regression.log"
./scripts/check_message_breaking_changes.sh | tee "$REPORT_DIR/interface_guard.log"
./scripts/collect_topic_metrics.sh "$REPORT_DIR"
./scripts/profile_realtime.sh "$REPORT_DIR"

popd >/dev/null

echo "Full regression complete: $REPORT_DIR"
