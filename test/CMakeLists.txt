cmake_minimum_required(VERSION 3.5)
project(drogdrogon-visitors-log_test CXX)

add_executable(${PROJECT_NAME} test_main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE Drogon::Drogon)
# add_subdirectory(drogon) # If include drogon source code locally
# target_link_libraries(${PROJECT_NAME} PRIVATE drogon)

ParseAndAddDrogonTests(${PROJECT_NAME})
