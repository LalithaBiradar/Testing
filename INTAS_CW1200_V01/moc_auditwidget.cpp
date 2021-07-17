/****************************************************************************
** Meta object code from reading C++ file 'auditwidget.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "auditwidget.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'auditwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_auditwidget_t {
    QByteArrayData data[7];
    char stringdata0[104];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_auditwidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_auditwidget_t qt_meta_stringdata_auditwidget = {
    {
QT_MOC_LITERAL(0, 0, 11), // "auditwidget"
QT_MOC_LITERAL(1, 12, 19), // "on_addAudit_clicked"
QT_MOC_LITERAL(2, 32, 0), // ""
QT_MOC_LITERAL(3, 33, 23), // "on_toPrintAudit_clicked"
QT_MOC_LITERAL(4, 57, 16), // "sQL_Audit_Report"
QT_MOC_LITERAL(5, 74, 15), // "gen_auditreport"
QT_MOC_LITERAL(6, 90, 13) // "open_auditpdf"

    },
    "auditwidget\0on_addAudit_clicked\0\0"
    "on_toPrintAudit_clicked\0sQL_Audit_Report\0"
    "gen_auditreport\0open_auditpdf"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_auditwidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   39,    2, 0x0a /* Public */,
       3,    0,   40,    2, 0x0a /* Public */,
       4,    3,   41,    2, 0x0a /* Public */,
       5,    0,   48,    2, 0x0a /* Public */,
       6,    3,   49,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    2,    2,    2,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    2,    2,    2,

       0        // eod
};

void auditwidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auditwidget *_t = static_cast<auditwidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->on_addAudit_clicked(); break;
        case 1: _t->on_toPrintAudit_clicked(); break;
        case 2: _t->sQL_Audit_Report((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 3: _t->gen_auditreport(); break;
        case 4: _t->open_auditpdf((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        default: ;
        }
    }
}

const QMetaObject auditwidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_auditwidget.data,
      qt_meta_data_auditwidget,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *auditwidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *auditwidget::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_auditwidget.stringdata0))
        return static_cast<void*>(const_cast< auditwidget*>(this));
    return QWidget::qt_metacast(_clname);
}

int auditwidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
