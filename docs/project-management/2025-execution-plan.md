# 2025 Execution Plan

- Project: `howeverautoware`
- Track: **medium**
- Commit target: **17** (2025-01 to 2025-12)
- PR target: **3**
- Generated at: 2026-04-10 11:37:25 

## Commit Rhythm

| Month | Commit Count |
| --- | --- |
| 2025-01 | 2 |
| 2025-02 | 2 |
| 2025-03 | 1 |
| 2025-04 | 2 |
| 2025-05 | 2 |
| 2025-06 | 1 |
| 2025-07 | 1 |
| 2025-08 | 2 |
| 2025-09 | 1 |
| 2025-10 | 1 |
| 2025-11 | 1 |
| 2025-12 | 1 |

## Issue Plan (8 Issues)

| # | Issue | Labels | Milestone |
| --- | --- | --- | --- |
| 1 | [[2025 Plan] Kickoff: initialize ROS2 package boundary rules](https://github.com/however-yir/howeverautoware/issues/1) | type:feature, priority:P2, area:infra | M1 (2025-01~2025-03) |
| 2 | [[2025 Plan] Kickoff: add colcon CI and lint quality baseline](https://github.com/however-yir/howeverautoware/issues/2) | type:feature, priority:P2, area:infra | M1 (2025-01~2025-03) |
| 3 | [[2025 Plan] Core: integrate perception-planning-control data flow](https://github.com/however-yir/howeverautoware/issues/3) | type:feature, priority:P1, area:core | M2 (2025-04~2025-07) |
| 4 | [[2025 Plan] Core: implement vehicle profile parameter layering](https://github.com/however-yir/howeverautoware/issues/4) | type:feature, priority:P1, area:integration | M2 (2025-04~2025-07) |
| 5 | [[2025 Plan] Core: add deployment profiles for sim and real car](https://github.com/however-yir/howeverautoware/issues/5) | type:feature, priority:P2, area:integration | M3 (2025-08~2025-10) |
| 6 | [[2025 Plan] Fix: resolve launch dependency deadlock in bringup](https://github.com/however-yir/howeverautoware/issues/6) | type:bug, priority:P1, area:stability | M3 (2025-08~2025-10) |
| 7 | [[2025 Plan] Test: add rosbag regression and replay checks](https://github.com/however-yir/howeverautoware/issues/7) | type:test, priority:P2, area:qa | M4 (2025-11~2025-12) |
| 8 | [[2025 Plan] Docs/Deploy: finalize integration handbook and SOP](https://github.com/however-yir/howeverautoware/issues/8) | type:docs, priority:P3, area:release | M4 (2025-11~2025-12) |

## PR Rhythm

| PR | Scope | Linked Issues |
| --- | --- | --- |
| PR-1 | 初始化基线（仓库规范 + CI） | Closes #1, Closes #2 |
| PR-2 | 核心功能交付（主链路） | Closes #3, Closes #4, Closes #5 |
| PR-3 | 修复 + 测试 + 文档/部署 | Closes #6, Closes #7, Closes #8 |

## Milestone Policy

- M1: 初始化阶段（1-3月）
- M2: 核心功能阶段（4-7月）
- M3: 修复与稳定阶段（8-10月）
- M4: 测试与文档部署阶段（11-12月）
