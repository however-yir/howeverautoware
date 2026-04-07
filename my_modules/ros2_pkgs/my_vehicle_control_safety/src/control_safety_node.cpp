// Change Source: Autoware 30-point implementation request | Date: 2026-04-07
#include <algorithm>
#include <chrono>

#include <geometry_msgs/msg/twist.hpp>
#include <rclcpp/rclcpp.hpp>

using namespace std::chrono_literals;

class ControlSafetyNode : public rclcpp::Node {
public:
  ControlSafetyNode() : Node("control_safety_node") {
    max_linear_x_ = declare_parameter<double>("max_linear_x", 4.0);
    max_angular_z_ = declare_parameter<double>("max_angular_z", 0.8);
    command_timeout_sec_ = declare_parameter<double>("command_timeout_sec", 0.5);
    fallback_linear_x_ = declare_parameter<double>("fallback_linear_x", 0.0);
    fallback_angular_z_ = declare_parameter<double>("fallback_angular_z", 0.0);

    pub_ = create_publisher<geometry_msgs::msg::Twist>("/control/command_safe", 10);
    sub_ = create_subscription<geometry_msgs::msg::Twist>(
      "/planning/command", 10,
      [this](const geometry_msgs::msg::Twist::SharedPtr msg) {
        last_cmd_time_ = now();
        auto safe = *msg;
        safe.linear.x = std::clamp(safe.linear.x, -max_linear_x_, max_linear_x_);
        safe.angular.z = std::clamp(safe.angular.z, -max_angular_z_, max_angular_z_);
        pub_->publish(safe);
      });

    timer_ = create_wall_timer(100ms, [this]() {
      if ((now() - last_cmd_time_).seconds() <= command_timeout_sec_) {
        return;
      }
      geometry_msgs::msg::Twist fallback;
      fallback.linear.x = fallback_linear_x_;
      fallback.angular.z = fallback_angular_z_;
      pub_->publish(fallback);
    });
  }

private:
  double max_linear_x_{};
  double max_angular_z_{};
  double command_timeout_sec_{};
  double fallback_linear_x_{};
  double fallback_angular_z_{};

  rclcpp::Time last_cmd_time_{0, 0, RCL_ROS_TIME};
  rclcpp::Publisher<geometry_msgs::msg::Twist>::SharedPtr pub_;
  rclcpp::Subscription<geometry_msgs::msg::Twist>::SharedPtr sub_;
  rclcpp::TimerBase::SharedPtr timer_;
};

int main(int argc, char ** argv) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ControlSafetyNode>());
  rclcpp::shutdown();
  return 0;
}
