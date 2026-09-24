cmake_minimum_required(VERSION 3.28...3.30)

if(NOT TARGET libobs)
  message(FATAL_ERROR "OBS Core modules require 'libobs' target.")
endif()

option(ENABLE_CORE_MODULES "Enable building OBS Core Modules" ON)
set_property(GLOBAL PROPERTY ENABLE_PLUGINS ${ENABLE_CORE_MODULES})

if(NOT ENABLE_CORE_MODULES)
  set_property(GLOBAL APPEND PROPERTY OBS_FEATURES_DISABLED "Core Modules")
  return()
endif()

set_property(GLOBAL APPEND PROPERTY OBS_FEATURES_ENABLED "Core Modules")

macro(check_obs_browser)
  # Windows-only fork (phase 2): non-Windows disable-target branch removed.
  if(OS_WINDOWS AND CMAKE_VS_PLATFORM_NAME MATCHES "(ARM64|x64)")
    if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/obs-browser/CMakeLists.txt")
      message(FATAL_ERROR "Required submodule 'obs-browser' not available.")
    else()
      add_core_module(obs-browser)
    endif()
  endif()
endmacro()

macro(check_obs_websocket)
  if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/obs-websocket/CMakeLists.txt")
    message(FATAL_ERROR "Required submodule 'obs-websocket' not available.")
  else()
    add_core_module(obs-websocket)
  endif()
endmacro()

# Add plugins in alphabetical order to retain order in IDE projects
# WeaR Stream Studio (phase 1): Windows-only. Non-Windows plugins removed,
# PLATFORMS reduced to WINDOWS where applicable.
add_core_module(
    aja
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(aja-output-ui PLATFORMS WINDOWS WITH_MESSAGE)
add_core_module(coreaudio-encoder PLATFORMS WINDOWS)
add_core_module(
    decklink
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(
    decklink-captions
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(
    decklink-output-ui
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(
    frontend-tools
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(image-source)
add_core_module(nv-filters PLATFORMS WINDOWS)

check_obs_browser()

add_core_module(obs-ffmpeg)
add_core_module(obs-filters)
add_core_module(obs-libfdk)
add_core_module(obs-nvenc PLATFORMS WINDOWS)
add_core_module(obs-outputs)
add_core_module(
    obs-qsv11
    PLATFORMS WINDOWS
    ARCHITECTURES x64 x86_64
)
add_core_module(obs-text PLATFORMS WINDOWS)
add_core_module(obs-transitions)
add_core_module(
    obs-vst
    PLATFORMS WINDOWS
    WITH_MESSAGE
)
add_core_module(obs-webrtc)

check_obs_websocket()

add_core_module(obs-x264)
add_core_module(rtmp-services)
add_core_module(text-freetype2)
add_core_module(vlc-video WITH_MESSAGE)
add_core_module(win-capture PLATFORMS WINDOWS)
add_core_module(win-dshow PLATFORMS WINDOWS)
add_core_module(win-wasapi PLATFORMS WINDOWS)

set_obs_core_modules()
