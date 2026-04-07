#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/sync_upstreams.sh"
"$ROOT_DIR/scripts/run_full_regression.sh"
