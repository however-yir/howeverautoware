> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Architecture (Layered)

## Layering Strategy

1. Dependency layer (`.repos`):
- `autoware.repos` tracks upstream baseline
- `my_vehicle.repos` tracks forked integration baseline for reproducibility

2. Upstream adaptation layer:
- `autoware` as meta repository
- Core customization aligned with `autoware_universe/core`

3. Vehicle customization layer:
- `my_modules/ros2_pkgs/my_vehicle_perception_bridge`
- `my_modules/ros2_pkgs/my_vehicle_planning_strategies`
- `my_modules/ros2_pkgs/my_vehicle_control_safety`

4. Configuration layer:
- Vehicle-specific params: `configs/vehicles/{suv,mpv,robotaxi}`
- Localization regionalized params: `configs/localization/regions`
- Calibration versioning: `configs/calibration/versions`

## Decoupling Contracts

- Perception to planning integration is topic-based, no direct package-level coupling.
- Planning supports strategy plugins via pluginlib extension point.
- Control adds saturation and timeout fallback to enforce safety boundaries.

## Interface Compatibility Rule

- Message/interface changes must trigger `scripts/check_message_breaking_changes.sh`.
- Any intentional break requires explicit impact note under `docs/interface_changes/`.
