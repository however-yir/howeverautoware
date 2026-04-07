#!/usr/bin/env bash
# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
set -euo pipefail

OUT_DIR="${1:-reports/monitoring}"
mkdir -p "$OUT_DIR"
OUT_FILE="$OUT_DIR/topic_latency_loss_$(date +%Y%m%d_%H%M%S).md"

cat > "$OUT_FILE" <<REPORT
# Topic Monitoring Report

Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

## Metrics Scope

- Topic latency (p50/p95/p99)
- Topic drop ratio
- QoS mismatch observations

## Collection Commands


a) Throughput and frequency:
- ros2 topic hz /perception/object_recognition/objects
- ros2 topic hz /planning/trajectory
- ros2 topic hz /control/command/control_cmd

b) Loss and latency (recommended):
- Use topic statistics and monitoring node counters.
- Export counters to Prometheus or equivalent TSDB.

## Result Placeholder

| Topic | p95 Latency (ms) | Drop Ratio (%) | Note |
|---|---:|---:|---|
| /perception/object_recognition/objects | TBD | TBD | |
| /planning/trajectory | TBD | TBD | |
| /control/command/control_cmd | TBD | TBD | |
REPORT

echo "Generated monitoring report template: $OUT_FILE"
