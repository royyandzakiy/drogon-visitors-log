cmake_minimum_required(VERSION 3.5..4.2)

# ##############################################################################
# PRE PROJECT CHECKS
# ##############################################################################

include(cmake/local_path.cmake)
include(cmake/config_vcpkg.cmake)
include(cmake/config_drogon.cmake)

# ##############################################################################
# DROGON SDK CHECKS
# ##############################################################################

project(drogon-visitors-log CXX)
include(CheckIncludeFileCXX)

check_include_file_cxx(any HAS_ANY)
check_include_file_cxx(string_view HAS_STRING_VIEW)
check_include_file_cxx(coroutine HAS_COROUTINE)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

aux_source_directory(controllers CTL_SRC)
aux_source_directory(filters FILTER_SRC)
aux_source_directory(plugins PLUGIN_SRC)
aux_source_directory(models MODEL_SRC)

message(STATUS "Controllers: ${CTL_SRC}")
message(STATUS "Filters: ${FILTER_SRC}")

add_executable(${PROJECT_NAME} src/main.cc 
	${CTL_SRC} # add to have controllers
	${FILTER_SRC} # add to have filters
)

# ##############################################################################

find_package(Drogon CONFIG REQUIRED)
# add_subdirectory(drogon) # If include drogon source code locally
# target_link_libraries(${PROJECT_NAME} PRIVATE drogon)

# find_package(fmt CONFIG REQUIRED) # If include fmt via vcpkg or other
include(FetchContent)
FetchContent_Declare(
  fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 12.1.0
)
FetchContent_MakeAvailable(fmt)

target_link_libraries(${PROJECT_NAME} 
	PRIVATE 
		Drogon::Drogon 
		fmt::fmt
)

# ##############################################################################

drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views
                    ${CMAKE_CURRENT_BINARY_DIR})
# use the following line to create views with namespace CHANGE_ME prefixed
# drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views
#                     ${CMAKE_CURRENT_BINARY_DIR} TRUE CHANGE_ME)

target_include_directories(${PROJECT_NAME}
                           PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
                                   ${CMAKE_CURRENT_SOURCE_DIR}/models
								   ${CMAKE_CURRENT_SOURCE_DIR}/controllers)
target_sources(${PROJECT_NAME}
               PRIVATE
               ${SRC_DIR}
               ${CTL_SRC}
               ${FILTER_SRC}
               ${PLUGIN_SRC}
               ${MODEL_SRC})

# uncomment the following line for dynamically loading views 
# set_property(TARGET ${PROJECT_NAME} PROPERTY ENABLE_EXPORTS ON)

# ##############################################################################

add_subdirectory(test)