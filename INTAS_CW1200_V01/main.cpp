#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QQuickView>
#include <QQuickItem>
#include <QtWidgets/QFileDialog>
#include <QQmlContext>
#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include <QtQml/QQmlEngine>
#include <QPrinter>
#include <QPainter>
#include <QTableView>
#include <QStandardItem>
#include<QFont>
#include "widget.h"
#include <QApplication>
//#include <ldap.h>
//#include <lber.h>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include<QVariant>
#include <wiringPi.h>
#include <wiringPiI2C.h>
#include "widget.h"
#include "widgetalaram.h"
#include "auditwidget.h"
#include <QtSql>
#include <QtDebug>
#include "savetextfield.h"
#include "printform.h"
#include "loadcellcalls.h"
#include "dbmanagers.h"
#include "d.h"
#include "timerthread.h"
#include "teplcwapp.h"
#define Switch24_ON 0x02


extern bool static_togglefg,sensor1fg;
extern bool conv_onfg,debounce2fg,debounce1fg;
extern unsigned int debounce_count1,debounce_count2,scaime_trigger_count,debounce_dly;
extern bool sensor2fg,s2dlyfg;
extern bool scaime_triggerfg;
extern bool reset_err7fg,reset_err2fg;
extern bool err2_rst_fg;
extern unsigned int auto_rst_err2_ctr,ERR2_RST_TIME,pack_debounce_dly;
bool err_s2dlyfg;
extern QString config_parameter[11];
void poweron_clear(void);
extern QString global_datetime,global_stpdatetime;
QString dsds;
extern unsigned char shift_buff[110];
extern bool command_responsefg;
extern unsigned int command_responsectr,command_timectr;
QSerialPort serial,serial_usb0;
void initGPIO(void);
extern bool disp_err1fg,reset_err1fg;
extern bool err1fg;
extern int rtc_day,rtc_month,rtc_year;
extern short int rtc_sec,rtc_min,rtc_hour;
extern unsigned int in_sped_ctr;
extern bool poweron_setzero;
extern bool hmi_mderrfg;
extern unsigned char md_dbn_ctr;
extern bool md_errfg;
extern bool mdwdfg;
extern unsigned int mdwd_ctr;
extern bool logmd_errfg;
extern bool chkmderrfg;
extern unsigned int uw_count,ow_count,accp_count;
extern unsigned int MLO_status_12;
extern unsigned int MLO_status_13;
extern bool calcovrfg;
constexpr int wpGPIO_OUT_PIN11            = 0;
constexpr int wpGPIO_OUT_PIN13            = 2;
constexpr int wpGPIO_OUT_PIN15            = 3;
constexpr int wpGPIO_OUT_PIN19            = 12;
constexpr int wpGPIO_OUT_PIN21            = 13;
constexpr int wpGPIO_OUT_PIN29            = 21;
constexpr int wpGPIO_OUT_PIN33            = 23;
constexpr int wpGPIO_IN_PIN16_SENSOR1     = 4;
constexpr int wpGPIO_IN_PIN18_SENSOR2     = 5;
constexpr int wpGPIO_IN_PIN22             = 6;
constexpr int wpGPIO_IN_PIN24             = 10;
constexpr int wpGPIO_IN_PIN31             = 22;
constexpr int wpGPIO_IN_PIN35             = 24;
constexpr int wpGPIO_IN_PIN36             = 27;
//constexpr int wpGPIO_IN_PIN12             = 1;
constexpr int wpGPIO_IN_PIN12_heartbit    = 1;
constexpr int wpGPIO_IN_PIN7             = 7;
bool poweroncountsfg;


int i2cdev,i2cdata,i2crtcdev,i2coutputdev;
int i2creg,i2cinputdev;
extern unsigned char err_ctr;
extern bool reset_err29fg,disp_err29fg,airprsfg;
bool nlfg,ch_exitdlyfg,accept_zrfg;
extern bool zr_calc_connectfg;
unsigned int exit_dly;
unsigned int temp_ctr;
float calc_speed;
extern QString alarm_msg;
bool err2_auditfglogfg;
bool err7_auditfglogfg;
extern unsigned int cpp_prd_speed;
extern QFont font;
unsigned int heart_bitctr;
extern unsigned int debounce_ctr2,debounce_ctr1;
extern float x_fact,y_fact;
extern bool negfg,cw_bypassfg;
extern unsigned int last_ppm;

void (*ptr)();
void* userData;

loadcellcalls* isrIndicatorGpio;
//extern void heartbit_f();
bool disp_err2fg,disp_err7fg;
QThread thread_timer;

#define UW_ON 0x01
#define UW_OFF 0xFE
#define ACCP_ON 0x80
#define ACCP_OFF 0x7f
#define BUZZER_ON 0x40
#define BUZZER_OFF 0xBF
#define CONV_ON 0x80
#define CONV_OFF 0x7f
#define OW_ON 0x40
#define OW_OFF 0xBF

FileIO saveTextField;
void sigexit(int sig)
{
    qDebug() << "GOT THE SIGNAL";

    wiringPiI2CWriteReg16(i2cdev,0,0);

    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

    MLO_status_12 = MLO_status_12 | BUZZER_ON;
    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

}


int main(int argc, char *argv[])
{



     qputenv("DISPLAY", ":0");
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
   // QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);2
    QApplication app(argc, argv);
    QThread::currentThread()->setPriority(QThread::HighestPriority);

     initGPIO();

     serial_usb0.setPortName("/dev/ttyS2");
     serial_usb0.open(QIODevice::ReadWrite);
     serial_usb0.setBaudRate(QSerialPort::Baud9600);
     serial_usb0.setDataBits(QSerialPort::Data8);
     serial_usb0.setParity(QSerialPort::NoParity);
     serial_usb0.setStopBits(QSerialPort::OneStop);
     serial_usb0.setFlowControl(QSerialPort::NoFlowControl);


     static_togglefg = 0;
     debounce1fg = 0;
     conv_onfg = 0;
     debounce2fg = 0;


    //! [style]
    QQuickStyle::setStyle(QStringLiteral("qrc:/qml/Style"));
    QQmlApplicationEngine engine;

    loadcellcalls handle_loadcellcalls;
   engine.rootContext()->setContextProperty("handle_loadcellcalls",&handle_loadcellcalls);


      dbmanagers db;
      Widget widget;

    engine.rootContext()->setContextProperty("savetextfield",&saveTextField);
    engine.rootContext()->setContextProperty("db",&db);
    engine.rootContext()->setContextProperty("widget",&widget);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


            Widget W;
            widgetalaram Alaram;
            auditwidget Audit;

            engine.rootContext()->setContextProperty("db",&db);
            engine.rootContext()->setContextProperty("Audit",&Audit);

            engine.rootContext()->setContextProperty("W",&W);
            engine.rootContext()->setContextProperty("Alaram",&Alaram);

//----------------------------------------------------

    //! [style]

    QObject *toplevel = engine.rootObjects().value(0);

    QQuickWindow *window = qobject_cast<QQuickWindow *>(toplevel);

    QObject::connect(&handle_loadcellcalls,SIGNAL(wt_string(QVariant)),
            window,SLOT(updateByteString(QVariant)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(wt_dynamicstring(QVariant,QVariant,QVariant,QVariant,QVariant,QVariant)),
            window,SLOT(updatedynamicString(QVariant,QVariant,QVariant,QVariant,QVariant,QVariant)));

    QObject::connect(&handle_loadcellcalls,SIGNAL(online_okcounts(QVariant,QVariant,QVariant,QVariant,QVariant)),
            window,SLOT(updateOKByteCounts(QVariant,QVariant,QVariant,QVariant,QVariant)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(dcomp_fact(QVariant)),
            window,SLOT(updateDcompFact(QVariant)));
    QObject::connect(&saveTextField,SIGNAL(online_okcounts(QVariant,QVariant,QVariant,QVariant,QVariant)),
            window,SLOT(updateOKByteCounts(QVariant,QVariant,QVariant,QVariant,QVariant)));

//    QObject::connect(&saveTextField,SIGNAL(batch_change(QString)),
//            &db,SLOT(createTable(QString)));
//    QObject::connect(&saveTextField,SIGNAL(uniquebatch_change()),
//            &db,SLOT(create_uniquebchfg()));
//    QObject::connect(&saveTextField,SIGNAL(signal_savetextfield(QString,QString,QString,QString,QString)),
//                    &db,SLOT(addAuditdata(QString,QString,QString,QString,QString)));


    QObject::connect(&handle_loadcellcalls,SIGNAL(signal_handleloadcell(QString,QString,QString,QString,QString)),
                    &db,SLOT(addAuditdata(QString,QString,QString,QString,QString)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(end_calib_process(QVariant)),
            window,SLOT(mainpage(QVariant)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(RTC_string(QVariant,QVariant,QVariant)),
            window,SLOT(updateRTCString(QVariant,QVariant,QVariant)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(RTC_TIME_string(QVariant,QVariant,QVariant)),
            window,SLOT(updateRTCTimeString(QVariant,QVariant,QVariant)));
    QObject::connect(&handle_loadcellcalls,SIGNAL(save_dcomp_fact(QString,QString)),
            &saveTextField,SLOT(storeDCOMP_FACT(QString,QString)));

    QObject::connect(&saveTextField, SIGNAL(handleSaveTextField(QVariant)),window,SLOT(handleSaveTextField(QVariant)));
    QObject::connect(&saveTextField, SIGNAL(handleSaveFileList(QVariant)),window,SLOT(handleSaveFileList(QVariant)));
    QObject::connect(&saveTextField, SIGNAL(handleUserStatusFile(QVariant)),window,SLOT(handleUserStatusFile(QVariant)));
    QObject::connect(&saveTextField, SIGNAL(handleErrorExistFile(QVariant)),window,SLOT(handleErrorExistFile(QVariant)));
    QObject::connect(&saveTextField, SIGNAL(chkFileExist(QVariant)),window,SLOT(chkFileExist(QVariant)));
    QObject::connect(&saveTextField, SIGNAL(handleSubmittFileParam(QVariant,QVariant,QVariant)),window,SLOT(handleSubmittFileParam(QVariant,QVariant,QVariant)));


    i2cdev = wiringPiI2CSetup(0x4d);


   // i2cdev = wiringPiI2CSetup(0x4c);
    qDebug() << i2cdev;

    delay(300);

    i2crtcdev = wiringPiI2CSetup(0x51);
    qDebug() << i2crtcdev;
    delay(300);

    i2coutputdev = wiringPiI2CSetup(0x21);
    qDebug() << i2coutputdev;
    delay(300);

    i2cinputdev = wiringPiI2CSetup(0x20);
    qDebug() << i2cinputdev;
    delay(300);




                i2cdata = wiringPiI2CWriteReg8(i2coutputdev,1,0);
                qDebug() << i2cdata;

                i2cdata = wiringPiI2CWriteReg8(i2coutputdev,0,0);
                qDebug() << i2cdata;

               i2cdata = wiringPiI2CWriteReg8(i2coutputdev,0x12,0x0);
             //   qDebug() << i2cdata;


                i2cdata = wiringPiI2CWriteReg8(i2coutputdev,0x13,0);
             //   qDebug() << i2cdata;


    //*******************************************************************

                i2cdata = wiringPiI2CReadReg8(i2cinputdev,0x12);
                qDebug() << i2cdata << "I2C Input";
                delay(300);

                i2cdata = wiringPiI2CReadReg8(i2cinputdev,0x13);
                qDebug() << i2cdata << "I2C Input";
                delay(300);

                MLO_status_12 = MLO_status_12 | Switch24_ON;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);



//**************************************************************

//************************************************************
                saveTextField.recall_DCOMPFACT();
                emit saveTextField.Poweron_saveParamInFile();//Poweron_saveParamInFile();
              //  emit handle_loadcellcalls.power_onslot();

                delay(100);

                timerthread handle_timerthread;
                handle_timerthread.init_timerthread();

                signal(SIGTERM,sigexit); //termination request
                signal(SIGQUIT,sigexit); //
                signal(SIGKILL,sigexit); //
                signal(SIGTRAP,sigexit); //
                signal(SIGABRT,sigexit); //abnormal termination indication
                signal(SIGILL,sigexit); // illegal instruction
                signal(SIGFPE,sigexit); // erroneous arithmatic operation


                isrIndicatorGpio = &handle_loadcellcalls;
                QObject::connect(&handle_loadcellcalls,SIGNAL(signal2dynamic()),&handle_loadcellcalls,SLOT(dynamic_calc_call()));
                QObject::connect(&handle_loadcellcalls,SIGNAL(signal2RTC()),&handle_loadcellcalls,SLOT(OnesecLoop()));

//                  wiringPiISR(wpGPIO_IN_PIN12_heartbit,INT_EDGE_FALLING,&heartbit_f);

                   poweron_setzero = 1;
                    poweroncountsfg = 1;
                 //  emit handle_loadcellcalls.power_onslot();

                TEPLCWApp CWAppObject(app, engine);


    return app.exec();
}


void initGPIO(void) {
    wiringPiSetup();
    pinMode(wpGPIO_IN_PIN16_SENSOR1,INPUT);
    pinMode(wpGPIO_IN_PIN18_SENSOR2,INPUT);
    pinMode(wpGPIO_IN_PIN12_heartbit,INPUT);

    pinMode(6,INPUT);
    pinMode(10,INPUT);
    pinMode(22,INPUT);
    pinMode(24,INPUT);
    pinMode(27,INPUT);
  //  pinMode(1,INPUT);

    pinMode(7,INPUT);


    pinMode(0,OUTPUT);
    pinMode(2,OUTPUT);
    pinMode(3,OUTPUT);
    pinMode(12,OUTPUT);
    pinMode(13,OUTPUT);
    pinMode(21,OUTPUT);
    pinMode(23,OUTPUT);

    pullUpDnControl(wpGPIO_OUT_PIN11,2);
    pullUpDnControl(wpGPIO_OUT_PIN13, 2);
    pullUpDnControl(wpGPIO_OUT_PIN29, 2);

    digitalWrite(wpGPIO_OUT_PIN11, 0);
    digitalWrite(wpGPIO_OUT_PIN13, 0);
    digitalWrite(wpGPIO_OUT_PIN15, 0);
    digitalWrite(wpGPIO_OUT_PIN19, 0);
    digitalWrite(wpGPIO_OUT_PIN21, 0);

    digitalWrite(wpGPIO_OUT_PIN29, 1);
    digitalWrite(wpGPIO_OUT_PIN33, 0);

}
