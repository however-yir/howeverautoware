// Change Source: Autoware 30-point implementation request | Date: 2026-04-07
#pragma once

#include <geometry_msgs/msg/pose_stamped.hpp>
#include <geometry_msgs/msg/twist_stamped.hpp>
#include <string>

namespace my_vehicle_planning_strategies {

class PlanningStrategy {
public:
  virtual ~PlanningStrategy() = default;
  virtual std::string name() const = 0;
  virtual geometry_msgs::msg::TwistStamped plan(
    const geometry_msgs::msg::PoseStamped & current_pose) = 0;
};

}  // namespace my_vehicle_planning_strategies
