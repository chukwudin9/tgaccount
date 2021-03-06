TEMPLATE = app

TARGET = tgplugin

QT += dbus declarative
CONFIG += meegotouch link_pkgconfig

PKGCONFIG += accounts-qt AccountSetup

DBUS_INTERFACES += Authorization.xml

CONFIG += mobility
MOBILITY += systeminfo messaging

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp qmlapplicationviewer.cpp
HEADERS += qmlapplicationviewer.h

QMAKE_CXXFLAGS += -std=c++2a
QMAKE_LFLAGS += -Os -rdynamic

contains(MEEGO_EDITION, harmattan) {
    QMAKE_CC = /opt/strawberry-gcc-10.2/bin/arm-none-linux-gnueabi-gcc
    QMAKE_CXX = /opt/strawberry-gcc-10.2/bin/arm-none-linux-gnueabi-g++
    QMAKE_LINK = /opt/strawberry-gcc-10.2/bin/arm-none-linux-gnueabi-g++
    QMAKE_LFLAGS += -static-libstdc++
}

# Silence the compiler warning for now
QMAKE_CXXFLAGS += -Wno-register -Wno-literal-suffix \
                  -Wno-deprecated-copy -Wno-unused-local-typedefs

target.path = /usr/lib/AccountSetup/bin
INSTALLS += target

invoker.files = invoker/tgplugin
invoker.path = /usr/lib/AccountSetup
INSTALLS += invoker

provider.files = tg.provider
provider.path = /usr/share/accounts/providers
service.files = tg.service
service.path = /usr/share/accounts/services
INSTALLS += provider service

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

DISTFILES += \
    qml/CodeView.qml \
    qml/EditExistingView.qml \
    qml/MainPage.qml \
    qml/PasswordView.qml \
    qml/RegistrationView.qml \
    qml/Title.qml \
    qml/main.qml

RESOURCES += \
    resource.qrc

DEFINES += HARMATTAN_BOOSTER
LIBS += -lX11
