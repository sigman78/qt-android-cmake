@set JAVA_HOME=D:\android\jdk18x32
@set ANDROID_HOME=D:\android
@set ANDROID_SDK=D:\android
@set ANDROID_NDK=D:\android\ndk10e
@set ANDROID_NDK_TOOLCHAIN_ROOT=D:\android\ndk10e\toolchains

@set QT5_HOST=D:\android\qt5\5.11.1\msvc2017_64
@set QT5_ANDROID=D:\android\qt5\5.11.1\android_armv7 

@set PATH="%ANDROID_SDK%\\tools";"%ANDROID_SDK%\\ant\\bin";%PATH%

mkdir build
cd build
cmake .. -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE=../android/toolchain/android.toolchain.cmake -DCMAKE_MAKE_PROGRAM="%ANDROID_NDK%/prebuilt/windows-x86_64/bin/make.exe" -Wno-dev 

cd ..
cmake --build build