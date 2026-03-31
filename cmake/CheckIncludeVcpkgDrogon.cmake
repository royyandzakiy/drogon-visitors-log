# ##############################################################################
# VCPKG Path Validation
# ##############################################################################

# Check if DROGON_CTL_COMMAND is set and exists
if(DEFINED DROGON_CTL_COMMAND)
    if(NOT EXISTS "${DROGON_CTL_COMMAND}")
        message(WARNING "DROGON_CTL_COMMAND is set to: ${DROGON_CTL_COMMAND}")
        message(WARNING "But this path does NOT exist!")
        message(WARNING "Please check your vcpkg installation and triplets.")
        message(WARNING "Expected location: ${DROGON_CTL_COMMAND}")
        message(WARNING "")
        message(WARNING "To fix:")
        message(WARNING "  1. Install drogon with correct triplet:")
        message(WARNING "     ./vcpkg install drogon --triplet x64-linux")
        message(WARNING "  2. Or set DROGON_CTL_COMMAND explicitly in your preset")
        message(FATAL_ERROR "DROGON_CTL_COMMAND not found!")
    else()
        message(STATUS "Found DROGON_CTL_COMMAND: ${DROGON_CTL_COMMAND}")
    endif()
else()
    message(WARNING "DROGON_CTL_COMMAND is NOT set!")
    message(WARNING "This will cause drogon_create_views to fail.")
    message(WARNING "Please add to your CMake preset:")
    message(WARNING "  \"DROGON_CTL_COMMAND\": \"\${env:VCPKG_ROOT_ENV}/installed/x64-linux/tools/drogon/drogon_ctl\"")
    message(FATAL_ERROR "DROGON_CTL_COMMAND is required!")
endif()

# Check if CMAKE_TOOLCHAIN_FILE is set and exists
if(DEFINED CMAKE_TOOLCHAIN_FILE)
    if(NOT EXISTS "${CMAKE_TOOLCHAIN_FILE}")
        message(WARNING "CMAKE_TOOLCHAIN_FILE is set to: ${CMAKE_TOOLCHAIN_FILE}")
        message(WARNING "But this path does NOT exist!")
        message(WARNING "Please check your vcpkg installation path.")
        message(FATAL_ERROR "CMAKE_TOOLCHAIN_FILE not found!")
    else()
        message(STATUS "Using vcpkg toolchain: ${CMAKE_TOOLCHAIN_FILE}")
    endif()
else()
    message(WARNING "CMAKE_TOOLCHAIN_FILE is NOT set!")
    message(WARNING "vcpkg integration may not work correctly.")
    message(WARNING "Please add to your CMake preset:")
    message(WARNING "  \"CMAKE_TOOLCHAIN_FILE\": \"\${env:VCPKG_ROOT_ENV}/scripts/buildsystems/vcpkg.cmake\"")
endif()

# Check vcpkg triplet setting
if(DEFINED VCPKG_TARGET_TRIPLET)
    message(STATUS "vcpkg triplet: ${VCPKG_TARGET_TRIPLET}")
else()
    message(STATUS "VCPKG_TARGET_TRIPLET not set, using default")
endif()

# Check for vcpkg installed packages
if(DEFINED VCPKG_ROOT_ENV)
    set(VCPKG_INSTALLED_DIR "${VCPKG_ROOT_ENV}/installed")
    if(EXISTS "${VCPKG_INSTALLED_DIR}")
        message(STATUS "vcpkg installed packages directory: ${VCPKG_INSTALLED_DIR}")
        
        # Check if the triplet directory exists
        if(DEFINED VCPKG_TARGET_TRIPLET)
            set(TRIPLET_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")
            if(EXISTS "${TRIPLET_DIR}")
                message(STATUS "Found triplet directory: ${TRIPLET_DIR}")
            else()
                message(WARNING "Triplet directory not found: ${TRIPLET_DIR}")
                message(WARNING "You may need to install packages for this triplet:")
                message(WARNING "  ./vcpkg install drogon fmt jsoncpp --triplet ${VCPKG_TARGET_TRIPLET}")
            endif()
        endif()
    endif()
endif()

message(STATUS "")