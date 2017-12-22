TEMPLATE = app

QT += location

SOURCES += main.cpp \
    parsejson.cpp \
    record.cpp \
    recordsmodel.cpp

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/location/minimal_map
INSTALLS += target

HEADERS += \
    parsejson.h \
    recordsmodel.h \
    record.h

DISTFILES +=
