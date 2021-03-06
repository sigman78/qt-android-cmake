# Android build
find_program(ANDROID_LOCATION NAMES android)
find_program(ANT_LOCATION NAMES ant)

# Check if android and add binaries have been found
if (NOT ANT_LOCATION)
  message(FATAL_ERROR "Could not find ant. Please install ant and add it to the search path.")
endif()

if (NOT ANDROID_LOCATION)
  message(FATAL_ERROR "Could not find 'Android SDK and AVD Manager'. Please install the android sdk and add the <android-sdk>/tools directory to the search path.")
endif()


# Set version
set(ANDROID_VERSION_NAME ${DEMO_VERSION})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/AndroidManifest.xml.cmake ${CMAKE_CURRENT_BINARY_DIR}/AndroidManifest.xml @ONLY)


# Androiddeployqt configuration
# Find qmake version 5
find_program(QT_QMAKE_EXECUTABLE NAMES qmake)

# Create json file parsed by the androiddeployqt
set(ANDROID_SDK $ENV{ANDROID_SDK})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/configAndroid.json.cmake ${CMAKE_CURRENT_BINARY_DIR}/configAndroid.json @ONLY)

add_custom_command (
  OUTPUT createApkFromAndroidDeployQt
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/AndroidManifest.xml
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}
  COMMAND androiddeployqt --verbose --output ${CMAKE_CURRENT_BINARY_DIR}/ --input ${CMAKE_CURRENT_BINARY_DIR}/configAndroid.json
)

# Command to create debug apk from Makefile
add_custom_target (apk_debug
  COMMAND ${ANT_LOCATION} debug
  DEPENDS createApkFromAndroidDeployQt
)

# Command to create release apk from Makefile
add_custom_target (apk_release
  COMMAND ${ANT_LOCATION} release
  DEPENDS createApkFromAndroidDeployQt
)