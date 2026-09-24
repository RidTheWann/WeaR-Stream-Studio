# OBS CMake bootstrap module

include_guard(GLOBAL)

# Map fallback configurations for optimized build configurations
# gersemi: off
set(
  CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO
    RelWithDebInfo
    Release
    MinSizeRel
    None
    ""
)
set(
  CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL
    MinSizeRel
    Release
    RelWithDebInfo
    None
    ""
)
set(
  CMAKE_MAP_IMPORTED_CONFIG_RELEASE
    Release
    RelWithDebInfo
    MinSizeRel
    None
    ""
)
# gersemi: on

# Prohibit in-source builds
if("${CMAKE_CURRENT_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_SOURCE_DIR}")
  message(
    FATAL_ERROR
    "In-source builds of OBS are not supported. "
    "Specify a build directory via 'cmake -S <SOURCE DIRECTORY> -B <BUILD_DIRECTORY>' instead."
  )
  file(REMOVE_RECURSE "${CMAKE_CURRENT_SOURCE_DIR}/CMakeCache.txt" "${CMAKE_CURRENT_SOURCE_DIR}/CMakeFiles")
endif()

# Set default global project variables
# WeaR Stream Studio (phase 2): product metadata rebranded. Internal target/
# API names (libobs, obs-*, CMake target names) intentionally unchanged.
set(OBS_COMPANY_NAME "WeaR Studio")
set(OBS_PRODUCT_NAME "WeaR Stream Studio")
set(OBS_WEBSITE "https://github.com/RidTheWann/WeaR-Stream-Studio")
set(OBS_COMMENTS "Free and open source software for video recording and live streaming")
set(OBS_LEGAL_COPYRIGHT "(C) WeaR Studio. Based on OBS Studio by OBS Project")
set(OBS_CMAKE_VERSION 3.0.0)

# Configure default version strings
set(_obs_default_version "0" "0" "1")
set(_obs_release_candidate 0)
set(_obs_beta 0)

# Add common module directories to default search path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/common" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/finders")

include(policies NO_POLICY_SCOPE)
include(versionconfig)
include(buildnumber)
include(osconfig)

# Allow selection of common build types via UI
if(NOT CMAKE_GENERATOR MATCHES "(Xcode|Visual Studio .+)")
  if(NOT CMAKE_BUILD_TYPE)
    set(
      CMAKE_BUILD_TYPE
      "RelWithDebInfo"
      CACHE STRING
      "OBS build type [Release, RelWithDebInfo, Debug, MinSizeRel]"
      FORCE
    )
    set_property(
      CACHE CMAKE_BUILD_TYPE
      PROPERTY STRINGS Release RelWithDebInfo Debug MinSizeRel
    )
  endif()
endif()

# Enable default inclusion of targets' source and binary directory
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)
