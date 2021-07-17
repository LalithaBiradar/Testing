#ifndef LOADCELLCALLS_H
#define LOADCELLCALLS_H

#include<QObject>
#include<QDebug>
#include "timerthread.h"
#include <QThread>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QVariant>
#include <QTimer>
#include<QFile>
#include <iostream>
#include <csignal>
#include <QWidget>


const char scaime_gross_wt[] =          {0x01,0x03,0x00,0x7e,0x00,0x02,0xa4,0x13};
const char scaime_dynamic_filtOFF[] =   {0x01,0x10,0x00,0x6c,0x00,0x01,0x02,0x00,0x00,0xaf,0x3c};
const char scaime_static_adc[] =        {0x01,0x10,0x00,0x01,0x00,0x01,0x02,0x00,0x07,0xe6,0x43};
const char scaime_filter_ON[] =         {0x01,0x10,0x00,0x28,0x00,0x01,0x02,0x01,0x00,0xa1,0xe8};
const char scaime_clear_CMD[] =         {0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7};
const char scaime_eeprm_save[] =        {0x01,0x06,0x00,0x90,0x00,0xd1,0x49,0xbb};
const char scaime_reset_CMD[] =         {0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7b};
const char scaime_calib_wt[] =          {0x01,0x10,0x00,0x2f,0x00,0x02,0x04,0x86,0xa0,0x00,0x01,0x23,0x92};
const char scaime_calib_noload_wt[] =   {0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xd8,0xbb,0x5a};
const char scaime_scalecoeff_wt[] =     {0x01,0x03,0x00,0x1a,0x00,0x02,0xe5,0xcc};
const char scaime_calib_save_wt[] =     {0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xde,0x3b,0x58};
const char scaime_calib_load_wt[] =     {0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xec,0xba,0x8d};
const char scaime_reset[] =             {0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7b};
const char scaime_dynamic_adconverter[] = {0x01,0x10,0x00,0x01,0x00,0x01,0x02,0x00,0x01,0x66,0x41};
const char scaime_static_filterOFF[] =  {0x01,0x10,0x00,0x28,0x00,0x01,0x02,0x00,0x00,0xa0,0x78};
const char scaime_dynamic_filterON[] =  {0x01,0x10,0x00,0x6c,0x00,0x01,0x02,0x01,0x03,0xee,0xad};
const char scaime_result_wt[] = {0x01,0x03,0x00,0x9c,0x00,0x02,0x04,0x25};
const char sacime_zrtw[] = {0x01,0x03,0x00,0x7e,0x00,0x02,0xa4,0x13};

const char scaime_calib_load_wt3k[] = {0x01,0x10,0x00,0x2f,0x00,0x02,0x04,0x0d,0x40,0x00,0x03,0xf2,0x8e};

const char weighcell_static_filterLOW[]     =  {0x02,0x51,0x2e,0x39,0x31,0x30,0x2c,0x33,0x03,0x5b,0x04};
const char weighcell_dynamic_filterHIGH[]   =  {0x02,0x51,0x2e,0x35,0x38,0x36,0x2c,0x36,0x03,0x5d,0x04};
const char weighcell_CALB[]                 =  {0x02,0x43,0x35,0x30,0x30,0x30,0x03,0x75,0x04};
const char weighcell_CALB2000[]             =  {0x02,0x43,0x32,0x30,0x30,0x30,0x03,0x42};
const char weighcell_CALB1000[]             =  {0x02,0x43,0x31,0x30,0x30,0x30,0x03,0x41};

const char weighcell_RINGBUFF[]             =  {0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50,0x04};
const char weighcell_DEADLOAD[]             =  {0x02,0x4f,0x03,0x4c,0x04};
const char weighcell_FZERO[]                =  {0x02,0x54,0x03,0x57,0x04};
const char weighcell_SAVESET[]              =  {0x02,0x53,0x03,0x50,0x04};
const char weighcell_LOADRD[]               =  {0x02,0x4e,0x03,0x4d};
const char weighcell_ACK[]                  =  {0x06,0x04};
const char weighcell_ZRLOADRD[]             =  {0x02,0x47,0x03,0x44};


extern QSerialPort serial;

class loadcellcalls : public QObject
{
    Q_OBJECT
public:

    explicit loadcellcalls(QObject *parent=0);


    QByteArray bytes[50];
    QByteArray bytes1;

    ~loadcellcalls();

signals:

    void wt_string(QVariant);
    void wt_dynamicstring(QVariant,QVariant,QVariant,QVariant,QVariant,QVariant);

    void RTC_string(QVariant,QVariant,QVariant);
    void RTC_TIME_string(QVariant,QVariant,QVariant);

    void online_uwcounts(QVariant);
    void online_owcounts(QVariant);
    void online_okcounts(QVariant,QVariant,QVariant,QVariant,QVariant);
    void end_calib_process(QVariant);
    void dcomp_fact(QVariant);
    void view_batch_report();
    void view_alaram_report();
    void view_audit_report();
    void save_dcomp_fact(QString text,QString text1);
    void handleStats_list(QVariant text);
    void handleGuage_val(int cnt);
    void handleIPGuage_val(int cnt);
    void handleConv_sts(bool cnt);
    void handleerror_sts(int cnt);
    void handleCalib_sts(int cnt);
    void handleSetzero_sts(int cnt);
    void handleResln_digit(int cnt);
    void handlestzerosts(int cnt);
    void handlediagnos_sts(int cnt);

    void handlestats_data(QStringList statsdata);

    void handleChart_val(int cnt,int cnt1,int cnt2);

    void dynamicwt_sts(unsigned int cnt);
    void signal2serial();
    void signal2zrserial();
    void signal2dynamic();
    void signal2RTC();
    void signal2SQlLog();

    void handleRtcmessage(int cnt);

    void signal_alram_audit(QString,QString,QString);


    void log_batchdetails();
    void log_dynamictable();
    void log_dynamic_wt(QString,QString,QString);

     void handleDcompsts(QString cnt,QString cnt1,QString cnt2,QString cnt3);
     void handle_logouttime(QString cnt);
     void signal_handleloadcell(QString,QString,QString,QString,QString);

     void signal_command();

     void handleDynamicWt_val(QVariantList dynamicWt_val);

public slots:

     void staticstart();
     void setzerostart();
     void calibration();
     void calc_speeds();
     void stats_page();
     void read_stats_page();

     void FivemsLoop();
     void OnesecLoop();

     void gen_dcomp_fact();
     void dcomp_on_off(bool);
     void cwbypass_on_off(bool);

     void send_sts();
     void conv_onoff();
     void CRC_16(char*,int );

     void slot_view_batch_report();
     void slot_view_audit_report();
     void slot_view_alaram_report();
     void power_onslot();
     void rtc_data(QVariantList adata, qint8);
     void err_reset();

     void dynamic_calc_call();

     void output_diagnosst(unsigned int);




protected:
    void run();

private:

    QTimer* Fivemstimer;
    QTimer* RTC_read_timer;
    QTimer* sql_log_timer;

};


#endif // LOADCELLCALLS_H
