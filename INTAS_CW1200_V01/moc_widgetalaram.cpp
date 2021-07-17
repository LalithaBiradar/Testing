/****************************************************************************
** Meta object code from reading C++ file 'widgetalaram.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "widgetalaram.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'widgetalaram.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_widgetalaram_t {
    QByteArrayData data[6];
    char stringdata0[85];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_widgetalaram_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_widgetalaram_t qt_meta_stringdata_widgetalaram = {
    {
QT_MOC_LITERAL(0, 0, 12), // "widgetalaram"
QT_MOC_LITERAL(1, 13, 20), // "on_addAlaram_clicked"
QT_MOC_LITERAL(2, 34, 0), // ""
QT_MOC_LITERAL(3, 35, 17), // "sQL_Alaram_Report"
QT_MOC_LITERAL(4, 53, 16), // "gen_alaramreport"
QT_MOC_LITERAL(5, 70, 14) // "open_alarampdf"

    },
    "widgetalaram\0on_addAlaram_clicked\0\0"
    "sQL_Alaram_Report\0gen_alaramreport\0"
    "open_alarampdf"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_widgetalaram[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x0a /* Public */,
       3,    3,   35,    2, 0x0a /* Public */,
       4,    0,   42,    2, 0x0a /* Public */,
       5,    3,   43,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    2,    2,    2,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    2,    2,    2,

       0        // eod
};

void widgetalaram::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        widgetalaram *_t = static_cast<widgetalaram *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->on_addAlaram_clicked(); break;
        case 1: _t->sQL_Alaram_Report((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 2: _t->gen_alaramreport(); break;
        case 3: _t->open_alarampdf((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        default: ;
        }
    }
}

const QMetaObject widgetalaram::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_widgetalaram.data,
      qt_meta_data_widgetalaram,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *widgetalaram::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *widgetalaram::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_widgetalaram.stringdata0))
        return static_cast<void*>(const_cast< widgetalaram*>(this));
    return QWidget::qt_metacast(_clname);
}

int widgetalaram::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
