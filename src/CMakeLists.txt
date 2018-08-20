set(demo_SRCS main.cpp)
qt5_add_resources(demo_QRC qml.qrc)

if (ANDROID)
  add_library(Demo SHARED ${demo_SRCS} ${demo_QRC})
  qt5_use_modules(Demo Qml Quick Location)
else()
  add_executable(Demo ${demo_SRCS} ${demo_QRC})
  qt5_use_modules(Demo Qml Quick Location)
endif()

target_compile_options(Demo PRIVATE -std=c++14)

target_link_libraries(Demo Qt5::Qml Qt5::Quick Qt5::Location)

if (ANDROID)
  include(../android/AddQtAndroidApk.cmake)
  add_qt_android_apk(demo_apl Demo  BUILDTOOLS_REVISION "28.0.2" API_LEVEL 23)
endif()
