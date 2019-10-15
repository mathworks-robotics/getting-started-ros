cmake_minimum_required(VERSION 2.8.3)
project(custom_robot_msgs)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  message_generation
)

add_message_files(
  FILES 
  circle_detection.msg
)

generate_messages(
  DEPENDENCIES 
  std_msgs
)