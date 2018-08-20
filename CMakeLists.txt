cmake_minimum_required(VERSION 3.0)
project(demo)

# Generate compile_commands.json for use by YCM
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Check mandatory env variables
if (NOT DEFINED ENV{Qt5_android})
  message(FATAL_ERROR "Configure the env variable Qt5_android to point to your android Qt5 installation.")
else()
  message(STATUS "Qt5 android installation dir: $ENV{Qt5_android}")
endif()

if (NOT DEFINED ENV{Qt5_host})
  message(FATAL_ERROR "Configure the env variable Qt5_host to point to your host Qt5 installation.")
else()
  message(STATUS "Qt5 host installation dir: $ENV{Qt5_host}")
endif()

# CXX global options
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Minimum Qt version
set(QT_REQUIRED_VERSION 5.9.0)

# Set application version
set(DEMO_MAJOR_VERSION 0)
set(DEMO_MINOR_VERSION 1)
set(DEMO_PATCH_VERSION 0)
set(DEMO_VERSION ${DEMO_MAJOR_VERSION}.${DEMO_MINOR_VERSION})


set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

if (ANDROID)
  set(CMAKE_PREFIX_PATH "$ENV{Qt5_android}/lib/cmake/Qt5")
  set(_dest_dir android/assets)

  # Android .so output
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/android/libs/${ARM_TARGET}/)
else()
  set(CMAKE_PREFIX_PATH "$ENV{Qt5_host}/lib/cmake/Qt5")
  if (CMAKE_HOST_APPLE)
    set(_bundle_bin Demo.app/Contents/MacOS)
    set(_dest_dir bin/${_bundle_bin})
  else()
    set(_dest_dir bin)
  endif()

  # Desktop build
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()

# Each Qt5 package finds its own dependencies
find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED Qml Quick Gui Location)

add_subdirectory(src)

