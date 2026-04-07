# Change Source: Autoware 30-point implementation request | Date: 2026-04-07
cmake_minimum_required(VERSION 3.8)
project(my_vehicle_planning_strategies)

find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(pluginlib REQUIRED)

add_library(default_strategy_plugin SHARED src/default_strategy_plugin.cpp)
target_include_directories(default_strategy_plugin PUBLIC include)
ament_target_dependencies(default_strategy_plugin geometry_msgs pluginlib)

pluginlib_export_plugin_description_file(my_vehicle_planning_strategies plugins.xml)

install(DIRECTORY include/ DESTINATION include)
install(TARGETS default_strategy_plugin DESTINATION lib)
install(FILES plugins.xml DESTINATION share/${PROJECT_NAME})

ament_export_include_directories(include)
ament_export_libraries(default_strategy_plugin)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
