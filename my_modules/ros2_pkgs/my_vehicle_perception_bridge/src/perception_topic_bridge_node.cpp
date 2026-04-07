// Change Source: Autoware 30-point implementation request | Date: 2026-04-07
#include <rclcpp/rclcpp.hpp>
#include <sensor_msgs/msg/point_cloud2.hpp>

class PerceptionTopicBridgeNode : public rclcpp::Node {
public:
  PerceptionTopicBridgeNode() : Node("perception_topic_bridge") {
    input_topic_ = declare_parameter<std::string>("input_topic", "/sensing/lidar/points_raw");
    output_topic_ = declare_parameter<std::string>("output_topic", "/perception/input/points_raw");

    pub_ = create_publisher<sensor_msgs::msg::PointCloud2>(output_topic_, rclcpp::SensorDataQoS());
    sub_ = create_subscription<sensor_msgs::msg::PointCloud2>(
      input_topic_, rclcpp::SensorDataQoS(),
      [this](const sensor_msgs::msg::PointCloud2::SharedPtr msg) {
        pub_->publish(*msg);
      });
  }

private:
  std::string input_topic_;
  std::string output_topic_;
  rclcpp::Publisher<sensor_msgs::msg::PointCloud2>::SharedPtr pub_;
  rclcpp::Subscription<sensor_msgs::msg::PointCloud2>::SharedPtr sub_;
};

int main(int argc, char ** argv) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<PerceptionTopicBridgeNode>());
  rclcpp::shutdown();
  return 0;
}
