> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Unified QoS Policy

## Policy Baseline

- Sensor high-rate topics: `SensorDataQoS`
- Control command topics: reliable + keep last
- Event/status topics: reliable + transient local where needed

## Governance Rules

1. QoS profile selection must be documented for every new topic.
2. Changes to QoS defaults must include regression impact analysis.
3. QoS mismatch should be monitored in runtime metrics and CI integration tests.

## Reference

- Default QoS values are tracked in `configs/qos/default_qos.yaml`.
