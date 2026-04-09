#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${ROOT_DIR}/docker/docker-compose.dev.yml"

usage() {
  cat <<'USAGE'
Usage: ./scripts/dev_container_entry.sh <up|shell|verify|down>

Commands:
  up      Build and start dev container in background
  shell   Open interactive shell in running dev container
  verify  Run minimal verification path inside dev container
  down    Stop and remove dev container
USAGE
}

cmd="${1:-}"
if [[ -z "${cmd}" ]]; then
  usage
  exit 1
fi

case "${cmd}" in
  up)
    docker compose -f "${COMPOSE_FILE}" up -d --build
    ;;
  shell)
    docker compose -f "${COMPOSE_FILE}" exec dev bash
    ;;
  verify)
    docker compose -f "${COMPOSE_FILE}" run --rm dev bash -lc "source /opt/ros/humble/setup.bash && python3 --version && colcon --version && test -f /workspace/my_vehicle.repos && echo '[ok] container baseline verified'"
    ;;
  down)
    docker compose -f "${COMPOSE_FILE}" down
    ;;
  *)
    usage
    exit 1
    ;;
esac
