// Change Source: Autoware 30-point implementation request | Date: 2026-04-07
#include "my_vehicle_planning_strategies/planning_strategy.hpp"
#include <pluginlib/class_list_macros.hpp>

namespace my_vehicle_planning_strategies {

class DefaultStrategyPlugin : public PlanningStrategy {
public:
  std::string name() const override { return "default_keep_lane"; }

  geometry_msgs::msg::TwistStamped plan(
    const geometry_msgs::msg::PoseStamped & current_pose) override {
    (void)current_pose;
    geometry_msgs::msg::TwistStamped cmd;
    cmd.twist.linear.x = 0.0;
    cmd.twist.angular.z = 0.0;
    return cmd;
  }
};

}  // namespace my_vehicle_planning_strategies

PLUGINLIB_EXPORT_CLASS(
  my_vehicle_planning_strategies::DefaultStrategyPlugin,
  my_vehicle_planning_strategies::PlanningStrategy)
