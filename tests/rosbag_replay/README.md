> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Rosbag Replay Regression

Run replay regression to validate critical pipelines against known scenario bags.

```bash
./tests/rosbag_replay/run_rosbag_regression.sh /path/to/rosbag
```

If no bag path is provided, the script checks `tests/rosbag_replay/data/sample_bag`.
