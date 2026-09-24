cmake_minimum_required(VERSION 3.28...3.30)

option(ENABLE_FREETYPE "Enable FreeType text plugin" ON)

if(NOT ENABLE_FREETYPE)
  return()
endif()

find_package(Freetype REQUIRED)

add_library(text-freetype2 MODULE)
add_library(OBS::text-freetype2 ALIAS text-freetype2)

target_sources(
  text-freetype2
  PRIVATE
    $<$<PLATFORM_ID:Windows>:find-font.c>
    $<$<PLATFORM_ID:Windows>:find-font-windows.c>
    find-font.h
    obs-convenience.c
    obs-convenience.h
    text-freetype2.c
    text-freetype2.h
    text-functionality.c
)

target_link_libraries(
  text-freetype2
  PRIVATE
    OBS::libobs
    Freetype::Freetype
)

# FreeType is hard-coded with /DEFAULTLIB:MSVCRT
target_link_options(text-freetype2 PRIVATE $<$<PLATFORM_ID:Windows>:/IGNORE:4098>)

if(OS_WINDOWS)
  configure_file(cmake/windows/obs-module.rc.in text-freetype2.rc)
  target_sources(text-freetype2 PRIVATE text-freetype2.rc)
endif()

set_target_properties_obs(text-freetype2 PROPERTIES FOLDER plugins PREFIX "")
