cmake_minimum_required(VERSION 3.5)
project(p5_pkg)


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    rclcpp_action
    plansys2_msgs
    plansys2_executor
)

add_executable(move_action_node src/move_action_node.cpp)
ament_target_dependencies(move_action_node ${dependencies})

add_executable(load_box_action_node src/load_box_action_node.cpp)
ament_target_dependencies(load_box_action_node ${dependencies})

add_executable(leave_box_action_node src/leave_box_action_node.cpp)
ament_target_dependencies(leave_box_action_node ${dependencies})

add_executable(fill_box_action_node src/fill_box_action_node.cpp)
ament_target_dependencies(fill_box_action_node ${dependencies})

add_executable(deliver_supply_to_workstation_action_node src/deliver_supply_to_workstation_action_node.cpp)
ament_target_dependencies(deliver_supply_to_workstation_action_node ${dependencies})

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  move_action_node
  load_box_action_node
  leave_box_action_node
  fill_box_action_node
  deliver_supply_to_workstation_action_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION lib/${PROJECT_NAME}
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  find_package(ament_cmake_gtest REQUIRED)
endif()

ament_export_dependencies(${dependencies})

ament_package()