> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# My Vehicle Autoware Platform

This repository is an Autoware-centered vehicle platform starter built around `.repos` reproducibility.

## Vehicle Family Goals

- Multi-model support: `SUV` / `MPV` / `Robotaxi`
- Preserve upstream compatibility while enabling custom extensions
- Keep primary integration at `autoware_universe/core` and custom modules in `my_modules/ros2_pkgs`

## Main Principles

1. `autoware` is treated as the meta repository.
2. Core customization focuses on `autoware_universe/core`-aligned modules.
3. Upstream compatibility is protected through topic contracts and interface checks.
4. Team onboarding is standardized via `.repos` files and containerized toolchain.

## Repository Layout

```text
.
├── autoware.repos
├── my_vehicle.repos
├── my_modules/ros2_pkgs/
├── configs/
├── tests/
├── scripts/
├── docker/
└── docs/
```

## Quick Start

1. Fork and sync required upstream repos:

```bash
./bootstrap_vehicle_stack.sh --owner however-yir
```

2. Import workspace dependencies:

```bash
mkdir -p src
vcs import src < my_vehicle.repos
```

3. Build and test:

```bash
source /opt/ros/humble/setup.bash
colcon build --symlink-install
source install/setup.bash
colcon test
colcon test-result --verbose
```

4. Run full regression (after upstream merges):

```bash
./scripts/post_upstream_merge.sh
```

## Compliance

- Apache-2.0 compliance guidance is maintained in [docs/COMPLIANCE_CHECKLIST.md](docs/COMPLIANCE_CHECKLIST.md)
- Third-party source/license mapping is maintained in [docs/THIRD_PARTY_NOTICES.md](docs/THIRD_PARTY_NOTICES.md)

## Branching and LTS

- Development branch: `codex/autoware-30point-foundation`
- LTS tag format: `lts-autoware-YYYYMMDD`
