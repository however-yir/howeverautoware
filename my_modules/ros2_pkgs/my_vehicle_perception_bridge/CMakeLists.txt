# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
cmake_minimum_required(VERSION 3.8)
project(my_vehicle_perception_bridge)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(sensor_msgs REQUIRED)

add_executable(perception_topic_bridge src/perception_topic_bridge_node.cpp)
ament_target_dependencies(perception_topic_bridge rclcpp sensor_msgs)

install(TARGETS perception_topic_bridge DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
