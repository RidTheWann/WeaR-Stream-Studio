cmake_minimum_required(VERSION 3.28...3.30)

add_library(libobs-opengl SHARED)
add_library(OBS::libobs-opengl ALIAS libobs-opengl)

if(NOT TARGET OBS::glad)
  add_subdirectory("${CMAKE_SOURCE_DIR}/deps/glad" "${CMAKE_BINARY_DIR}/deps/glad")
endif()

target_sources(
  libobs-opengl
  PRIVATE
    $<$<PLATFORM_ID:Windows>:gl-windows.c>
    gl-helpers.c
    gl-helpers.h
    gl-indexbuffer.c
    gl-shader.c
    gl-shaderparser.c
    gl-shaderparser.h
    gl-stagesurf.c
    gl-subsystem.c
    gl-subsystem.h
    gl-texture2d.c
    gl-texture3d.c
    gl-texturecube.c
    gl-vertexbuffer.c
    gl-zstencil.c
)

target_compile_options(libobs-opengl PRIVATE $<$<COMPILE_LANG_AND_ID:C,Clang>:-Wno-strict-prototypes>)

target_link_libraries(
  libobs-opengl
  PRIVATE
    OBS::libobs
    OBS::glad
)

if(OS_WINDOWS)
  configure_file(cmake/windows/obs-module.rc.in libobs-opengl.rc)
  target_sources(libobs-opengl PRIVATE libobs-opengl.rc)
endif()

target_enable_feature(libobs "OpenGL renderer")

set_target_properties_obs(
  libobs-opengl
  PROPERTIES FOLDER core
             VERSION 0
             PREFIX ""
             SOVERSION "${OBS_VERSION_MAJOR}"
)
