> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Deployment SOP

## A. Simulation SOP

1. Import dependencies:
- `mkdir -p src && vcs import src < my_vehicle.repos`

2. Build:
- `source /opt/ros/humble/setup.bash`
- `colcon build --symlink-install`

3. Launch simulation stack:
- Use Autoware simulation launch flow from `autoware_launch`
- Overlay with vehicle config from `configs/vehicles/<model>/params.yaml`

4. Run validation:
- `./tests/rosbag_replay/run_rosbag_regression.sh`
- `./scripts/collect_topic_metrics.sh`

## B. Real Vehicle SOP

1. Confirm calibration bundle version under `configs/calibration/versions`.
2. Select target vehicle profile (`SUV` / `MPV` / `Robotaxi`).
3. Apply region localization profile from `configs/localization/regions`.
4. Start bring-up in staged sequence:
- Sensing
- Localization
- Perception
- Planning
- Control
5. Execute KPI checklist in `tests/kpi/e2e_scenario_kpi.yaml`.
6. Archive run reports under `reports/regression/<timestamp>/`.
