#-------------------------------------------------
#
# Project created by QtCreator 2015-01-31T22:40:55
#
#-------------------------------------------------

QT += core network gui qml opengl quick svg xml testlib androidextras

DEFINES += QTVIDEOSINK_NAME=qt5videosink

TARGET = QtGStreamerHUD
TEMPLATE = app

pluginModule = QtGStreamer

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    CONFIG(debug, debug|release) {
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi-v7a/Debug/libgstreamer_android.so
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi-v7a/Debug/libQtGStreamerQuick2.so
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-debug-1.4.5/include/gstreamer-1.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-debug-1.4.5/include/glib-2.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-debug-1.4.5/lib/glib-2.0/include

        unix:!macx: LIBS += -L$$PWD/../../libs/armeabi-v7a/Debug/  -lQt5GStreamerQuick-1.0 -lQt5GStreamerUi-1.0 -lQt5GStreamerUtils-1.0 -lQt5GStreamer-1.0 -lQt5GLib-2.0
        unix:!macx: LIBS += -L$$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/ -lgstreamer_android -lgstpbutils-1.0 -lorc-0.4 -lffi -lgmodule-2.0 -lglib-2.0 -lintl -liconv

        DEPENDPATH += $$PWD/../../libs/armeabi-v7a/Debug

        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Debug/libQt5GStreamerQuick-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Debug/libQt5GLib-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Debug/libQt5GStreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Debug/libQt5GStreamerUi-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Debug/libQt5GStreamerUtils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgobject-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgmodule-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgthread-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgstreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgstpbutils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgstaudio-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgstvideo-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libgstbase-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libffi.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/liborc-0.4.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libintl.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libiconv.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-debug-1.4.5/lib/libglib-2.0.a
    }

    CONFIG(release, debug|release) {
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi-v7a/Release/libgstreamer_android.so
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi-v7a/Release/libQtGStreamerQuick2.so
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-release-1.4.5/include/gstreamer-1.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-release-1.4.5/include/glib-2.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-armv7-release-1.4.5/lib/glib-2.0/include

        unix:!macx: LIBS += -L$$PWD/../../libs/armeabi-v7a/Release/  -lQt5GStreamerQuick-1.0 -lQt5GStreamerUi-1.0 -lQt5GStreamerUtils-1.0 -lQt5GStreamer-1.0 -lQt5GLib-2.0
        unix:!macx: LIBS += -L$$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/ -lgstreamer_android -lgstpbutils-1.0 -lorc-0.4 -lffi -lgmodule-2.0 -lglib-2.0 -lintl -liconv

        DEPENDPATH += $$PWD/../../libs/armeabi-v7a/Release

        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Release/libQt5GStreamerQuick-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Release/libQt5GLib-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Release/libQt5GStreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Release/libQt5GStreamerUi-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi-v7a/Release/libQt5GStreamerUtils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgobject-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgmodule-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgthread-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgstreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgstpbutils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgstaudio-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgstvideo-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libgstbase-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libffi.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/liborc-0.4.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libintl.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libiconv.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-armv7-release-1.4.5/lib/libglib-2.0.a
    }
}

equals(ANDROID_TARGET_ARCH, armeabi) {
    CONFIG(debug, debug|release) {
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi/Debug/libgstreamer_android.so
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi/Debug/libQtGStreamerQuick2.so
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-debug-1.4.5/include/gstreamer-1.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-debug-1.4.5/include/glib-2.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-debug-1.4.5/lib/glib-2.0/include

        unix:!macx: LIBS += -L$$PWD/../../libs/armeabi/Debug/  -lQt5GStreamerQuick-1.0 -lQt5GStreamerUi-1.0 -lQt5GStreamerUtils-1.0 -lQt5GStreamer-1.0 -lQt5GLib-2.0
        unix:!macx: LIBS += -L$$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/ -lgstreamer_android -lgstpbutils-1.0 -lorc-0.4 -lffi -lgmodule-2.0 -lglib-2.0 -lintl -liconv

        DEPENDPATH += $$PWD/../../libs/armeabi/Debug

        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Debug/libQt5GStreamerQuick-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Debug/libQt5GLib-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Debug/libQt5GStreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Debug/libQt5GStreamerUi-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Debug/libQt5GStreamerUtils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgobject-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgmodule-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgthread-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgstreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgstpbutils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgstaudio-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgstvideo-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libgstbase-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libffi.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/liborc-0.4.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libintl.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libiconv.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-debug-1.4.5/lib/libglib-2.0.a
    }

    CONFIG(release, debug|release) {
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi/Release/libgstreamer_android.so
        ANDROID_EXTRA_LIBS += $$PWD/../../libs/armeabi/Release/libQtGStreamerQuick2.so
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-release-1.4.5/include/gstreamer-1.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-release-1.4.5/include/glib-2.0
        INCLUDEPATH += C:/Users/p_duffy/Documents/Android/gstreamer-1.0-android-arm-release-1.4.5/lib/glib-2.0/include

        unix:!macx: LIBS += -L$$PWD/../../libs/armeabi/Debug/  -lQt5GStreamerQuick-1.0 -lQt5GStreamerUi-1.0 -lQt5GStreamerUtils-1.0 -lQt5GStreamer-1.0 -lQt5GLib-2.0
        unix:!macx: LIBS += -L$$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/ -lgstreamer_android -lgstpbutils-1.0 -lorc-0.4 -lffi -lgmodule-2.0 -lglib-2.0 -lintl -liconv

        DEPENDPATH += $$PWD/../../libs/armeabi/Release

        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Release/libQt5GStreamerQuick-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Release/libQt5GLib-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Release/libQt5GStreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Release/libQt5GStreamerUi-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../libs/armeabi/Release/libQt5GStreamerUtils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgobject-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgmodule-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgthread-2.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgstreamer-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgstpbutils-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgstaudio-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgstvideo-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libgstbase-1.0.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libffi.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/liborc-0.4.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libintl.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libiconv.a
        unix:!macx: PRE_TARGETDEPS += $$PWD/../../../gstreamer-1.0-android-arm-release-1.4.5/lib/libglib-2.0.a
    }
}


INCLUDEPATH += C:/Users/p_duffy/Documents/Android/qt-gstreamer-1.2.0/src
INCLUDEPATH += C:/Users/p_duffy/Documents/Android/Boost-for-Android-master/boost_1_53_0
INCLUDEPATH += ../../elements/gstqtvideosink
INCLUDEPATH += ../../build-armv7-release/elements/gstqtvideosink
INCLUDEPATH += $$PWD/libs/mavlink/include/mavlink/v1.0/ardupilotmega
INCLUDEPATH += $$PWD/uas
INCLUDEPATH += $$PWD/comm
INCLUDEPATH += $$PWD/QsLog
INCLUDEPATH += $$PWD/ui
INCLUDEPATH += $$PWD

HEADERS += \
    ../../elements/gstqtvideosink/gstqtglvideosink.h \
    ../../elements/gstqtvideosink/gstqtglvideosinkbase.h \
    ../../elements/gstqtvideosink/gstqtquick2videosink.h \
    ../../elements/gstqtvideosink/gstqtvideosink.h \
    ../../elements/gstqtvideosink/gstqtvideosinkbase.h \
    ../../elements/gstqtvideosink/gstqtvideosinkplugin.h \
    ../../elements/gstqtvideosink/gstqwidgetvideosink.h \
    ../../build-armv7-release/elements/gstqtvideosink/gstqtvideosinkmarshal.h \
    ../../elements/gstqtvideosink/delegates/basedelegate.h \
    ../../elements/gstqtvideosink/delegates/qtquick2videosinkdelegate.h \
    ../../elements/gstqtvideosink/delegates/qtvideosinkdelegate.h \
    ../../elements/gstqtvideosink/delegates/qwidgetvideosinkdelegate.h \
    ../../elements/gstqtvideosink/painters/abstractsurfacepainter.h \
    ../../elements/gstqtvideosink/painters/genericsurfacepainter.h \
    ../../elements/gstqtvideosink/painters/openglsurfacepainter.h \
    ../../elements/gstqtvideosink/painters/videomaterial.h \
    ../../elements/gstqtvideosink/painters/videonode.h \
    ../../elements/gstqtvideosink/utils/bufferformat.h \
    ../../elements/gstqtvideosink/utils/utils.h \
    CCurrentState.h \
    GStreamerPlayer.h \
    QCurrentState.h \
    PrimaryFlightDisplayQML.h \
    audio/AlsaAudio.h \
    comm/AbsPositionOverview.h \
    comm/LinkInterface.h \
    comm/QGCMAVLink.h \
    comm/RelPositionOverview.h \
    comm/UASObject.h \
    comm/VehicleOverview.h \
    QsLog/QsLog.h \
    QsLog/QsLogDest.h \
    QsLog/QsLogDestConsole.h \
    QsLog/QsLogDestFile.h \
    QsLog/QsLogDisableForThisFile.h \
    QsLog/QsLogLevel.h \
    uas/QGCUASParamManager.h \
    ui/RadioCalibration/RadioCalibrationData.h \
    ArduPilotMegaMAV1.h \
    configuration.h \
    GAudioOutput.h \
    globalobject.h \
    LinkManager1.h \
    MAVLinkDecoder1.h \
    MAVLinkProtocol1.h \
    MG.h \
    PxQuadMAV1.h \
    QGC.h \
    QGCGeo.h \
    SlugsMAV1.h \
    TCPLink1.h \
    UAS1.h \
    UASInterface1.h \
    UASManager1.h \
    UDPLink1.h
SOURCES += main.cpp \
    ../../elements/gstqtvideosink/gstqtglvideosink.cpp \
    ../../elements/gstqtvideosink/gstqtglvideosinkbase.cpp \
    ../../elements/gstqtvideosink/gstqtquick2videosink.cpp \
    ../../elements/gstqtvideosink/gstqtvideosink.cpp \
    ../../elements/gstqtvideosink/gstqtvideosinkbase.cpp \
    ../../elements/gstqtvideosink/gstqtvideosinkplugin.cpp \
    ../../elements/gstqtvideosink/gstqwidgetvideosink.cpp \
    ../../build-armv7-release/elements/gstqtvideosink/gstqtvideosinkmarshal.c \
    ../../elements/gstqtvideosink/delegates/basedelegate.cpp \
    ../../elements/gstqtvideosink/delegates/qtquick2videosinkdelegate.cpp \
    ../../elements/gstqtvideosink/delegates/qtvideosinkdelegate.cpp \
    ../../elements/gstqtvideosink/delegates/qwidgetvideosinkdelegate.cpp \
    ../../elements/gstqtvideosink/painters/genericsurfacepainter.cpp \
    ../../elements/gstqtvideosink/painters/openglsurfacepainter.cpp \
    ../../elements/gstqtvideosink/painters/videomaterial.cpp \
    ../../elements/gstqtvideosink/painters/videonode.cpp \
    ../../elements/gstqtvideosink/utils/bufferformat.cpp \
    ../../elements/gstqtvideosink/utils/utils.cpp \
    CCurrentState.cpp \
    GStreamerPlayer.cpp \
    PrimaryFlightDisplayQML.cpp \
    QCurrentState.cpp \
    audio/AlsaAudio.cc \
    comm/AbsPositionOverview.cc \
    comm/LinkInterface.cpp \
    comm/RelPositionOverview.cc \
    comm/UASObject.cc \
    comm/VehicleOverview.cc \
    QsLog/QsLog.cpp \
    QsLog/QsLogDest.cpp \
    QsLog/QsLogDestConsole.cpp \
    QsLog/QsLogDestFile.cpp \
    uas/QGCUASParamManager.cc \
    ui/RadioCalibration/RadioCalibrationData.cc \
    ArduPilotMegaMAV1.cc \
    GAudioOutput.cc \
    globalobject.cc \
    LinkManager1.cc \
    MAVLinkDecoder1.cc \
    MAVLinkProtocol1.cc \
    PxQuadMAV1.cc \
    QGC.cc \
    SlugsMAV1.cc \
    TCPLink1.cc \
    UAS1.cc \
    UASManager1.cc \
    UDPLink1.cc
RESOURCES += qmlplayer2.qrc

FORMS    +=

CONFIG += mobility
CONFIG += warn_off
MOBILITY = 

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/assets/qml/Storage.js \
    android/assets/qml/PrimaryFlightDisplayWithVideoQML.qml \
    android/assets/qml/qmlplayer2.qml \
    android/assets/qml/components/AltitudeIndicator.qml \
    android/assets/qml/components/Button1.qml \
    android/assets/qml/components/CompassIndicator.qml \
    android/assets/qml/components/DigitalDisplay.qml \
    android/assets/qml/components/HeartbeatDisplay.qml \
    android/assets/qml/components/InformationOverlayIndicator.qml \
    android/assets/qml/components/ModeDisplay.qml \
    android/assets/qml/components/PitchIndicator.qml \
    android/assets/qml/components/RollPitchIndicator.qml \
    android/assets/qml/components/RollPitchIndicatorWithVideo.qml \
    android/assets/qml/components/SpeedIndicator.qml \
    android/assets/qml/components/StatusDisplay.qml \
    android/assets/qml/components/StatusMessageIndicator.qml \
    android/assets/qml/components/TextButton.qml \
    android/assets/qml/resources/components/primaryFlightDisplay/pause.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/play.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/stop.svg \
    android/assets/qml/resources/components/rollPitchIndicator/background.png \
    android/assets/qml/resources/components/rollPitchIndicator/background_old.png \
    android/assets/qml/resources/components/rollPitchIndicator/needle.png \
    android/assets/qml/resources/components/rollPitchIndicator/needle_shadow.png \
    android/assets/qml/resources/components/rollPitchIndicator/overlay.png \
    android/assets/qml/resources/components/rollPitchIndicator/pitchGraticule.png \
    android/assets/qml/resources/components/rollPitchIndicator/quit.png \
    android/assets/qml/resources/components/rollPitchIndicator/artGroundSky.svg \
    android/assets/qml/resources/components/rollPitchIndicator/compass.svg \
    android/assets/qml/resources/components/rollPitchIndicator/compassIndicator.svg \
    android/assets/qml/resources/components/rollPitchIndicator/crossHair.svg \
    android/assets/qml/resources/components/rollPitchIndicator/rollGraticule.svg \
    android/assets/qml/resources/components/rollPitchIndicator/rollPointer.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/pause.png \
    android/assets/qml/resources/components/primaryFlightDisplay/play.png \
    android/assets/qml/resources/components/primaryFlightDisplay/stop.png \
    android/assets/qml/resources/components/primaryFlightDisplay/display.png \
    android/assets/qml/resources/components/primaryFlightDisplay/reset.png \
    QsLog/QsLog.pri \
    android/assets/qml/resources/components/primaryFlightDisplay/connect.png \
    android/assets/qml/resources/components/primaryFlightDisplay/disconnect.png \
    android/assets/qml/resources/components/primaryFlightDisplay/connect.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/disconnect.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/help.svg \
    android/assets/qml/resources/components/primaryFlightDisplay/help.png \
    android/assets/resources/appicon48.png \
    android/assets/resources/appicon72.png \
    android/assets/resources/appicon96.png \
    android/assets/resources/help.html \
    android/assets/qml/resources/components/rollPitchIndicator/homeheading.svg

QTPLUGIN += qsvg

SUBDIRS += \
    QsLog/log_example.pro

