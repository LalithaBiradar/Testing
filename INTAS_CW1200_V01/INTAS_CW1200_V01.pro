TEMPLATE = app

#QT += qml quick
#QT += serialport
QT += serialport core
QT += quick quickcontrols2 \
       core gui printsupport sql \
       sql \

 QT += widgets
 QT += sql


CONFIG += c++14 \
            lang-fi



static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin


}


SOURCES += main.cpp \
    savetextfield.cpp \
    loadcellcalls.cpp \
        widget.cpp \
    widgetalaram.cpp \
    auditwidget.cpp \
    dbmanagers.cpp \
    timerthread.cpp \
    teplcwservice.cpp \
    teplcwuartservice.cpp \
    teplcwapp.cpp \
    teplcwtestthread.cpp \
    teplcwtestservice.cpp


LIBS += -lwiringPi -lwiringPiDev -lpthread

RESOURCES += qml.qrc \


#    res.qrc \
#    temp.qrc
#    alaramreport.qrc \
#    auditreport.qrc

OTHER_FILES += \
 #   basic-b2qt.qml \
    Style/AutoScroller.qml \
    Style/HandwritingModeButton.qml \
    Style/ScrollBar.qml \
    Style/TextArea.qml \
    Style/TextBase.qml \
    Style/TextField.qml \

#disable-xcb {
#    message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
#    CONFIG += disable-desktop
#}


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.


# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



HEADERS += \
    savetextfield.h \
    loadcellcalls.h \
    widget.h \
    widgetalaram.h \
    auditwidget.h \
    dbmanagers.h \
    union.h \
    timerthread.h \
    teplcwservice.h \
    teplcwuartservice.h \
    teplcwapp.h \
    teplcwtestthread.h \
    teplcwtestservice.h



FORMS +=

#include(/home/cwtepl/Projects/Qt/intas_cw1200_10inch/QtRptProject/QtRPT/QtRPT.pri)
#include(/home/devanand/Projects/Qt/INTAS_CW1200_10INCH/QtRptProject/QtRPT/QtRPT.pri)
#include(/home/cwtepl/Projects/Qt/cw_gxseries/QtRptProject/QtRPT/QtRPT.pri)

#include($$PWD/../QtRptProject/QtRPT/QtRPT.pri)


target.path = /home/odroid/Projects/Qt
INSTALLS += TARGET


DISTFILES += \
    README.txt






