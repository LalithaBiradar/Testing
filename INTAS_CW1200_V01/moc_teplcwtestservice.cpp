/****************************************************************************
** Meta object code from reading C++ file 'teplcwtestservice.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "teplcwtestservice.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'teplcwtestservice.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_teplcwtestservice_t {
    QByteArrayData data[13];
    char stringdata0[172];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_teplcwtestservice_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_teplcwtestservice_t qt_meta_stringdata_teplcwtestservice = {
    {
QT_MOC_LITERAL(0, 0, 17), // "teplcwtestservice"
QT_MOC_LITERAL(1, 18, 6), // "sqllog"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 12), // "startService"
QT_MOC_LITERAL(4, 39, 10), // "medLatPoll"
QT_MOC_LITERAL(5, 50, 12), // "sqleventPoll"
QT_MOC_LITERAL(6, 63, 28), // "event_mediumlatinput_checked"
QT_MOC_LITERAL(7, 92, 25), // "event_softpolling_checked"
QT_MOC_LITERAL(8, 118, 13), // "addAlaramdata"
QT_MOC_LITERAL(9, 132, 9), // "date_time"
QT_MOC_LITERAL(10, 142, 9), // "event_msg"
QT_MOC_LITERAL(11, 152, 8), // "username"
QT_MOC_LITERAL(12, 161, 10) // "sqllogdata"

    },
    "teplcwtestservice\0sqllog\0\0startService\0"
    "medLatPoll\0sqleventPoll\0"
    "event_mediumlatinput_checked\0"
    "event_softpolling_checked\0addAlaramdata\0"
    "date_time\0event_msg\0username\0sqllogdata"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_teplcwtestservice[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    0,   55,    2, 0x0a /* Public */,
       4,    0,   56,    2, 0x0a /* Public */,
       5,    0,   57,    2, 0x0a /* Public */,
       6,    0,   58,    2, 0x0a /* Public */,
       7,    0,   59,    2, 0x0a /* Public */,
       8,    3,   60,    2, 0x0a /* Public */,
      12,    0,   67,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    9,   10,   11,
    QMetaType::Void,

       0        // eod
};

void teplcwtestservice::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        teplcwtestservice *_t = static_cast<teplcwtestservice *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sqllog(); break;
        case 1: _t->startService(); break;
        case 2: _t->medLatPoll(); break;
        case 3: _t->sqleventPoll(); break;
        case 4: _t->event_mediumlatinput_checked(); break;
        case 5: _t->event_softpolling_checked(); break;
        case 6: _t->addAlaramdata((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 7: _t->sqllogdata(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (teplcwtestservice::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&teplcwtestservice::sqllog)) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject teplcwtestservice::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_teplcwtestservice.data,
      qt_meta_data_teplcwtestservice,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *teplcwtestservice::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *teplcwtestservice::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_teplcwtestservice.stringdata0))
        return static_cast<void*>(const_cast< teplcwtestservice*>(this));
    return QObject::qt_metacast(_clname);
}

int teplcwtestservice::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void teplcwtestservice::sqllog()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
