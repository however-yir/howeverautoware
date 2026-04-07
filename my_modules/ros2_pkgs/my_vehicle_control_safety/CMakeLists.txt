# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
cmake_minimum_required(VERSION 3.8)
project(my_vehicle_control_safety)

find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(rclcpp REQUIRED)

add_executable(control_safety_node src/control_safety_node.cpp)
ament_target_dependencies(control_safety_node geometry_msgs rclcpp)

install(TARGETS control_safety_node DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
