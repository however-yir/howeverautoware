> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Calibration Versioning

Store sensor calibration bundles in `configs/calibration/versions/<version-id>/`.

Recommended structure:

- `intrinsics/`
- `extrinsics/`
- `metadata.yaml` (sensor serials, map, date)

Do not overwrite old calibration bundles; append a new version folder.
