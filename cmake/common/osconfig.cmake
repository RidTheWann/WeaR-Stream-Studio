# OBS CMake operating system bootstrap module
# WeaR Stream Studio: Windows-only fork. Non-Windows branches removed (phase 1).

include_guard(GLOBAL)

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
  set(CMAKE_C_EXTENSIONS FALSE)
  set(CMAKE_CXX_EXTENSIONS FALSE)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/windows")
  set(OS_WINDOWS TRUE)
else()
  message(FATAL_ERROR "WeaR Stream Studio supports Windows hosts only.")
endif()
