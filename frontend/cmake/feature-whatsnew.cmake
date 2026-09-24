include_guard(DIRECTORY)

option(ENABLE_WHATSNEW "Enable WhatsNew dialog" ON)

if(ENABLE_WHATSNEW AND TARGET OBS::browser-panels)
  # WeaR Stream Studio (phase 1): Windows-only. macOS/Linux whatsnew variants
  # removed; Windows variant is provided by cmake/os-windows.cmake.
  target_enable_feature(obs-studio "What's New panel" WHATSNEW_ENABLED)
endif()
