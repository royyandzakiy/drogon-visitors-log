# cmake/config_drogon.cmake
# =============================================================================
# Drogon Configuration
# =============================================================================

# This requires VCPKG_ROOT_PATH and VCPKG_TARGET_TRIPLET to be defined
# Include config_vcpkg.cmake first or ensure these variables are set

if(NOT DEFINED VCPKG_ROOT_PATH)
    message(FATAL_ERROR "\n╔════════════════════════════════════════════════════════════════════════════╗\n"
                        "║  VCPKG_ROOT_PATH must be defined before including config_drogon.cmake      ║\n"
                        "║  Please include config_vcpkg.cmake first.                                  ║\n"
                        "╚════════════════════════════════════════════════════════════════════════════╝\n")
endif()

if(NOT DEFINED VCPKG_TARGET_TRIPLET)
    message(FATAL_ERROR "\n╔════════════════════════════════════════════════════════════════════════════╗\n"
                        "║  VCPKG_TARGET_TRIPLET must be defined before including config_drogon.cmake  ║\n"
                        "║  Please include config_vcpkg.cmake first.                                  ║\n"
                        "╚════════════════════════════════════════════════════════════════════════════╝\n")
endif()

# Status indicators (if not already defined)
if(NOT DEFINED STATUS_OK)
    set(STATUS_OK "✓")
    set(STATUS_FAIL "✗")
    set(STATUS_WARN "⚠")
    set(STATUS_INFO "ℹ")
endif()

message(STATUS "")
message(STATUS "╔════════════════════════════════════════════════════════════════════════════╗")
message(STATUS "║                           DROGON CONFIGURATION                             ║")
message(STATUS "╚════════════════════════════════════════════════════════════════════════════╝")
message(STATUS "")


# =============================================================================
# Drogon Configuration (Manifest-Aware)
# =============================================================================

if(NOT DEFINED VCPKG_TARGET_TRIPLET)
    message(FATAL_ERROR "VCPKG_TARGET_TRIPLET must be defined. Check your CMake Preset.")
endif()

# Define the local manifest installation path
set(_LOCAL_VCPKG_DIR "${CMAKE_BINARY_DIR}/vcpkg_installed/${VCPKG_TARGET_TRIPLET}")
set(_GLOBAL_VCPKG_DIR "${VCPKG_ROOT_PATH}/installed/${VCPKG_TARGET_TRIPLET}")

# Status indicators
if(NOT DEFINED STATUS_OK)
    set(STATUS_OK "✓")
    set(STATUS_FAIL "✗")
endif()

# -----------------------------------------------------------------------------
# Check 1: Find DROGON_CTL_COMMAND
# -----------------------------------------------------------------------------
message(STATUS "┌─ DROGON_CTL_COMMAND Search")

# We use find_program to look in both Local (Manifest) and Global (Classic) paths
find_program(DROGON_CTL_COMMAND
    NAMES drogon_ctl
    PATHS 
        "${_LOCAL_VCPKG_DIR}/tools/drogon"
        "${_GLOBAL_VCPKG_DIR}/tools/drogon"
    DOC "Path to drogon_ctl executable"
)

if(DROGON_CTL_COMMAND)
    message(STATUS "│   ${STATUS_OK} Found: ${DROGON_CTL_COMMAND}")
    math(EXPR DROGON_CHECKS_PASSED "1")
else()
    message(STATUS "│   ${STATUS_FAIL} Not found in local or global vcpkg paths.")
    message(STATUS "│   Tip: Ensure 'ctl' is in vcpkg.json features and run CMake again.")
    message(FATAL_ERROR "DROGON_CTL_COMMAND not found!")
endif()

# # Set DROGON_CTL_COMMAND if not already defined
# if(NOT DEFINED DROGON_CTL_COMMAND)
# 	if(WIN32)
# 		set(DROGON_CTL_COMMAND "${VCPKG_ROOT_PATH}/installed/${VCPKG_TARGET_TRIPLET}/tools/drogon/drogon_ctl.exe" CACHE FILEPATH "drogon_ctl executable")
# 	else()
# 		set(DROGON_CTL_COMMAND "${VCPKG_ROOT_PATH}/installed/${VCPKG_TARGET_TRIPLET}/tools/drogon/drogon_ctl" CACHE FILEPATH "drogon_ctl executable")
# 	endif()
# endif()

# # Initialize counters
# set(DROGON_CHECKS_PASSED 0)
# set(DROGON_CHECKS_TOTAL 2)

# # -----------------------------------------------------------------------------
# # Check 1: DROGON_CTL_COMMAND
# # -----------------------------------------------------------------------------
# message(STATUS "┌─ [1/${DROGON_CHECKS_TOTAL}] DROGON_CTL_COMMAND")
# if(DEFINED DROGON_CTL_COMMAND)
#     if(EXISTS "${DROGON_CTL_COMMAND}")
#         message(STATUS "│   ${STATUS_OK} ${DROGON_CTL_COMMAND}")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 1")
        
#         # Check if executable has execute permission
#         # if(UNIX AND NOT IS_EXECUTABLE "${DROGON_CTL_COMMAND}")
#         #     message(STATUS "│   ${STATUS_WARN} File exists but is not executable")
#         #     message(STATUS "│   ${STATUS_INFO} Run: chmod +x ${DROGON_CTL_COMMAND}")
#         # endif()
#     else()
#         message(STATUS "│   ${STATUS_FAIL} ${DROGON_CTL_COMMAND} (file not found)")
#         message(STATUS "│   ${STATUS_INFO} Install drogon with:")
#         message(STATUS "│   ${STATUS_INFO}   cd ${VCPKG_ROOT_PATH}")
#         message(STATUS "│   ${STATUS_INFO}   ./vcpkg install drogon --triplet ${VCPKG_TARGET_TRIPLET}")
#         message(FATAL_ERROR "│\n╚════════════════════════════════════════════════════════════════════════════╝\n"
#                             "DROGON_CTL_COMMAND not found! Please install drogon via vcpkg.\n")
#     endif()
# else()
#     message(STATUS "│   ${STATUS_FAIL} DROGON_CTL_COMMAND is not set!")
#     message(FATAL_ERROR "│\n╚════════════════════════════════════════════════════════════════════════════╝\n"
#                         "DROGON_CTL_COMMAND must be set! Add to your CMake preset.\n")
# endif()
# message(STATUS "└─────────────────────────────────────────────────────────────────────────")

# # -----------------------------------------------------------------------------
# # Check 2: Drogon installation
# # -----------------------------------------------------------------------------
# message(STATUS "")
# message(STATUS "┌─ [2/${DROGON_CHECKS_TOTAL}] Drogon Installation")
# set(DROGON_INSTALL_DIR "${VCPKG_ROOT_PATH}/installed/${VCPKG_TARGET_TRIPLET}")

# if(EXISTS "${DROGON_INSTALL_DIR}")
#     message(STATUS "│   ${STATUS_OK} Installation directory: ${DROGON_INSTALL_DIR}")
    
#     # Check for drogon includes
#     if(EXISTS "${DROGON_INSTALL_DIR}/include/drogon")
#         message(STATUS "│   ${STATUS_OK} Headers: found")
#     else()
#         message(STATUS "│   ${STATUS_WARN} Headers: not found")
#     endif()
    
#     # Check for drogon libraries
#     if(EXISTS "${DROGON_INSTALL_DIR}/lib/libdrogon.a")
#         message(STATUS "│   ${STATUS_OK} Static library: libdrogon.a")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 1")
#     elseif(EXISTS "${DROGON_INSTALL_DIR}/lib/libdrogon.so")
#         message(STATUS "│   ${STATUS_OK} Shared library: libdrogon.so")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 1")
#     elseif(EXISTS "${DROGON_INSTALL_DIR}/lib/libdrogon.dylib")
#         message(STATUS "│   ${STATUS_OK} Shared library: libdrogon.dylib")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 1")
#     elseif(EXISTS "${DROGON_INSTALL_DIR}/lib/drogon.lib")
#         message(STATUS "│   ${STATUS_OK} Shared library: drogon.lib")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 1")
#     elseif(EXISTS "${DROGON_INSTALL_DIR}/lib")
#         message(STATUS "│   ${STATUS_WARN} Library directory exists but drogon library not found")
#         message(STATUS "│   ${STATUS_INFO} Contents: ${DROGON_INSTALL_DIR}/lib/")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 0")
#     else()
#         message(STATUS "│   ${STATUS_WARN} Library directory not found")
#         message(STATUS "│   ${STATUS_INFO} Drogon may not be installed for this triplet")
#         math(EXPR DROGON_CHECKS_PASSED "${DROGON_CHECKS_PASSED} + 0")
#     endif()
# else()
#     message(STATUS "│   ${STATUS_FAIL} Installation directory not found: ${DROGON_INSTALL_DIR}")
#     message(STATUS "│   ${STATUS_INFO} Run: cd ${VCPKG_ROOT_PATH} && ./vcpkg install drogon --triplet ${VCPKG_TARGET_TRIPLET}")
#     message(FATAL_ERROR "│\n╚════════════════════════════════════════════════════════════════════════════╝\n"
#                         "Drogon not installed! Please install via vcpkg.\n")
# endif()
# message(STATUS "└─────────────────────────────────────────────────────────────────────────")

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
message(STATUS "")
message(STATUS "╔════════════════════════════════════════════════════════════════════════════╗")
message(STATUS "║                         DROGON CONFIGURATION SUMMARY                       ║")
message(STATUS "╠════════════════════════════════════════════════════════════════════════════╣")
message(STATUS "║  ${STATUS_OK} drogon_ctl          : ${DROGON_CTL_COMMAND}")
message(STATUS "║  ${STATUS_OK} Installation dir    : ${DROGON_INSTALL_DIR}")
message(STATUS "╠════════════════════════════════════════════════════════════════════════════╣")
message(STATUS "║  Checks passed: ${DROGON_CHECKS_PASSED}/${DROGON_CHECKS_TOTAL} (${DROGON_CHECKS_TOTAL} critical)				                            ║")
if(DROGON_CHECKS_PASSED EQUAL DROGON_CHECKS_TOTAL)
    message(STATUS "║  Status: ${STATUS_OK} READY for drogon usage                                          ║")
else()
    message(STATUS "║  Status: ${STATUS_WARN} Some checks failed - may affect drogon_create_views           ║")
endif()
message(STATUS "╚════════════════════════════════════════════════════════════════════════════╝")
message(STATUS "")