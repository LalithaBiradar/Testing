#include <fstream>
#include <iostream>
//using namespace std;

#include "loadcellcalls.h"
#include "timerthread.h"
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QDebug>
#include <QTimer>
#include<QVariant>
#include<wiringPi.h>
#include<QFile>
#include"union.h"

#include<csignal>

#include<QIcon>
#include<QFont>
#include <QtMath>
#include "widget.h"
//#include "ui_widget.h"

//#include "T4OPCServer.h"
//#include <qtrpt.h>
#include <QtSql>
#include <QtDebug>
#include <QtQml/QQmlEngine>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlProperty>

#include<wiringPiI2C.h>

#include<qserialport.h>

#include <QWidget>

#include <QQuickItem>
#include <QQmlError>
#include <QtWidgets>

//#include <ldap.h>

unsigned int avg[10];
unsigned char rdi2cbyte;

short int rtc_sec,rtc_min,rtc_hour;
int rtc_day,rtc_month,rtc_year;
IPDATA i2cipdata;
extern QSerialPort serial,serial_usb0;

quint32 buff[9];
unsigned int bin_val,bin_ref,rx_counter;
unsigned int  debounce_dly,debounce_count1,debounce_count2,pack_debounce_dly;
unsigned int start_delay,s1_count,scaime_trigger_count;
unsigned int dynamic_ring_buff;
unsigned char s2_dly_ctr,commfail_counter;

float upper_limit,lower_limit;
unsigned int debounce_ctr2,debounce_ctr1;

unsigned int opr_delay,hold_delay;

unsigned char shift_buff[110],shift_data_old,shift_data_new1;
unsigned char shift_ctr;
unsigned int in_sped_ctr,min1_dly_ctr,show_sped_ctr;
 unsigned int colour_sts;
bool static_togglefg,static_startfg,dynamic_cyclefg;
bool calibfg,wait_togglefg,disp_staticfg;
bool conv_onfg,debounce2fg,debounce1fg,poweron_stats_updatefg;
bool sensor1fg,s2dlyfg,togglefg = 1;
bool sensor2fg,calcovrfg,ackfg;
bool setzfg,sendcommandfg,sendzrcommandfg;
bool hldfg,write_textfilefg;
bool tnmsfg;
bool shifteventfg;
bool estop_err;
bool s2_failfg;
bool serial_enablefg;
bool err1fg;
bool err2_rst_fg,rc_chK_on_sensorfg;
bool touch_buzzer_onfg;
bool comparefg;
bool in_spd_fg;
bool dooropenchk,coveropenchk;
bool dooropenchk_err;
bool poweron_setzero,recvfg;
bool scaime_triggerfg,chk_calib_errfg;
bool calib_errstepfg;
bool dcompfg,dcomp_onfg,positive_dcompfg;
bool chk_comfailfg;
bool rejvfg;
bool binfullfg;
bool Qjamfg;
bool Qjam_relfg;
bool sndwt_extfg;
bool display_guageval,show_caliberrfg;
bool mdregvfg;// = 0;
bool ow_shiftfg,uw_shiftfg;
bool command_responsefg;
bool display_error17fg;
bool display_error14fg,display_error15fg,display_error16fg;
bool display_error20fg,display_error22fg,display_error23fg;
bool display_error26fg,display_error27fg,display_error30fg;
bool display_error19fg,display_error1fg,display_error2fg;
bool display_error7fg;
unsigned int command_responsectr,command_timectr;
unsigned int conterr1_ctr;
unsigned char estop_ctr;
unsigned char binfull_ctr,Qjam_ctr,Qjam_relctr,rvbinfull_ctr;
unsigned char dcomp_ctr,rejv_ctr,mdrejv_ctr;
unsigned int dcomp_bin,zr_val_avug;
unsigned char nl_count;
unsigned int zr_reftime,dly_25mmtime;
QString str_std_devresult,str_avg_accp_wt;
unsigned int setzero_screenctr;
bool setzero_screenfg,resetstzero_screenfg;
bool poweron_nwdate_syncfg;
extern bool err_s2dlyfg,unique_bchfg;
bool OWdynamic_sql_logfg,UWdynamic_sql_logfg,OKdynamic_sql_logfg;

QString dcomp_factor;
bool debounce3fg;
unsigned char touch_buzzer_ctr;
unsigned int auto_rst_err2_ctr,ERR2_RST_TIME;
unsigned int s2fail_ctr,s2fail_time,debounce_count3;
unsigned char air_prsctr;

bool airprs_err = 0;
bool airprsfg = 0;
bool calib_step1,calib_step2,calib_step3,calib_step1_1,calib_step2_2,calib_step3_3;

unsigned int dooropendbn_ctr,coveropendbn_ctr;

unsigned char avg_stk_ctr,avg_count;
unsigned int avg_bin;

unsigned int temp_buffer,std_dev_buffer,avg_buff;
extern bool alarm_msg_sql_logfg;
float dev_result;

char buf[7];
float sndval;


float temp_sd1,temp_sd2,temp_sd3,temp_sd4;

QString dcomp_dataval1;

unsigned int platform,platform_plus;

float pully_count;
 QVariantList qmlDynamic_val;

//#define OW_COUNT 50500
#define CONV_ON 0x80
#define CONV_OFF 0x7f


#define ACCP_ON 0x80
#define ACCP_OFF 0x7f
#define UW_ON 0x01
#define UW_OFF 0xFE
#define OW_ON 0x40
#define OW_OFF 0xBF

#define BUZZER_ON 0x40
#define BUZZER_OFF 0xBF

#define FLOAT_OP8_ON 0x10
#define FLOAT_OP8_OFF 0xEF




#define Touch_BUZZER_ON 0x01
#define Touch_BUZZER_OFF 0xFE

unsigned int MLO_status_12 = 0;
unsigned int MLO_status_13 = 0;
unsigned int OW_ERR;

QByteArray local_bytes[90];

extern QString prdwt;// = ui->prdwtlineEdit->text();
extern QString prdresult;// = ui->prdresultlineEdit->text();

extern QString alarm_msg;

extern QString prev_value,cur_value,event_msg,userid;
bool reset_err12fg;



extern bool nlfg,ch_exitdlyfg,accept_zrfg;
extern unsigned int exit_dly;
unsigned int z_time;
unsigned int ref;
unsigned int zr_buff[7];
unsigned char temp_loop,nl_ctr;
unsigned char err_ctr;
unsigned char cont_reg_ctr,cont_rej_count;

unsigned int rc_shift_time1,rc_shift_ctr1;
unsigned int rc_shift_time2,rc_shift_ctr2;
unsigned int rc_shift_time3,rc_shift_ctr3;
bool rc_shiftfg1,rc_shiftfg2,rc_shiftfg3;
unsigned char rc_sts1,rc_sts2,rc_sts3;
bool rc_sensorfg,calib_switcherrfg;
unsigned char rc_counter;

QString dataval = 0,datavalstn1;
float val = 0;

char scaime_measure_time[11] = {0x01,0x10,0x00,0xa1,0x00,0x01,0x02,0x01,0x11,0x7e,0xbd};
char scaime_stable_time[11] = {0x01,0x10,0x00,0xa0,0x00,0x01,0x02,0x00,0xb4,0xbe,0x87};


unsigned char recv_counter,event_200ms_ctr = 0,event_600ms_ctr;

unsigned char shift_ms_count,shift_ms_ctr;

unsigned int uw_count = 0,ow_count = 0,accp_count = 0;
unsigned int tot_count,avg_accp_bin = 0;
float max_wt,min_wt,rej_percent,avg_accp_wt;
float temp_maxwt,temp_minwt;
QString batch_rej_percnt;
QTime timezt;

int ret_val;

bool reset_err7fg,reset_err2fg;
bool reset_err29fg,disp_err29fg;

//void get_avg_xbar(void);
unsigned char loadcell_txbuff[15];


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
constexpr int wpGPIO_IN_PIN12_heartbit             = 1;

constexpr int wpGPIO_IN_PIN7             = 7;

bool mdhldfg,batch_stop;

extern int i2cdev,i2cdata,i2crtcdev,i2coutputdev;
extern int i2creg,i2cinputdev;


extern float cpp_prd_target;
extern float cpp_prd_tare;
extern unsigned int cpp_prd_length;
extern float cpp_prd_Ulimit;
extern float cpp_prd_Llimit;
extern unsigned int cpp_prd_speed;
extern unsigned int cpp_opr_delay;
extern unsigned int cpp_hold_delay;
extern unsigned int cpp_rej_cnt,cpp_md_opdly;
unsigned int md_hold_delay,mdhold_delayctr;
unsigned int CALIB_Hi,CALIB_Lo;

unsigned int scan_hold_delay;

const char productcode[] =    {"PRODUCT CODE           # "};
const char productname[] =    {"PRODUCT NAME           # "};
const char productbatchno[] = {"BATCH NUMBER           # "};
const char producttargetwt[] ={"TARGET WT              # "};
const char producttarewt[] =  {"TARE WT                # "};
const char productupperL[] =  {"UPPER LIMIT            # "};
const char productlowerL[] =  {"LOWER LIMIT            # "};
const char prodACCPCOUNT[] =  {"ACCEPT COUNTS         # "};
const char prodUNDERCOUNT[] = {"\nUNDERWEIGHT COUNTS    # "};
const char prodOWERCOUNT[] =  {"\nOVERWEIGHT COUNTS     # "};
const char prodTOTALCOUNT[] = {"\nTOTAL COUNTS         # "};
const char prodTOTALREJ[] =   {"\nTOTAL REJECTION      # "};
const char prodMAXWT[] =      {"\nACCEPT MAX WEIGHT       # "};
const char prodMINWT[] =      {"\nACCEPT MIN WEIGHT       # "};
const char prodAVGWT[] =      {"\nAVERAGE ACCEPT WEIGHT# "};

FILE *stats_fptr;
//extern QObject *updateCppVal;
//extern QVariantList wtScreenValues;

struct flag_declaration
{
    unsigned int CW_1200 : 1;
    unsigned int CW_3K : 1;
    unsigned int CW_6K : 1;
    unsigned int CW_10K : 1;
    unsigned int CW_21K : 1;
    unsigned int CW_600HSA : 1;
    unsigned int CW_3000HSA : 1;
    unsigned int CW_100HSA : 1;
    unsigned int CW_1200HSA : 1;
    unsigned int LC_TYPE : 1;
    unsigned int LC_MODEL : 1;

};
struct flag_declaration config_param;

QByteArray ddd[70] = 0;

QFile file("/home/odroid/Projects/Qt/CWMODEL_SELECTION.txt");

QFile stats_file("/home/odroid/Projects/Qt/STATS.txt");
//QFile ONOFF_file("ONOFFSTATUS.txt");
QFile ONOFF_file("/home/odroid/Projects/Qt/ONOFFSTATUS.txt");


QString ONOFF_param[4];

QString stats_param[14];

//bool rv_sensorfgchk;
//unsigned char rv_sensordbnctr;
//bool rv_sensordbnfg;



QTextStream out(&file);
extern bool disp_err2fg,disp_err7fg;


unsigned int temp_binval;

extern QString batch_accp_cnt,batch_ow_cnt,batch_uw_cnt,batch_tot_cnt,userid_audit;
QString batch_avgaccp_wt;

bool zr_calc_connectfg,heart_tnmsfg;
bool disp_err1fg,err1_auditfglogfg;
bool reset_err1fg;
bool cw_bypassfg;
extern bool duplicate_batchfg;
extern bool prodnfg;
void bin_dynamic_calculation();
QString read_str_mon;
QString read_str_date;
char Loadcells_3kCommands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//
{0x01,0x10,0x00,0x2f,0x00,0x02,0x04,0x0d,0x40,0x00,0x03,0xf2,0x8e},//0
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//1
        };
char Loadcells_6kCommands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//
{0x01,0x10,0x00,0x2f,0x00,0x02,0x04,0xa1,0x20,0x00,0x07,0xd2,0x03},//0
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//1
        };

char Loadcells_HSACommands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//
{0x02,0x43,0x31,0x30,0x30,0x03,0x71},//21
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//1
        };

char Loadcells_3kHSACommands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//
{0x02,0x43,0x32,0x30,0x30,0x30,0x03,0x42},//21
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//1
        };

char Loadcells_ZRCommands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//
{0x01,0x03,0x00,0x7e,0x00,0x02,0xa4,0x13},//21
{0x02,0x47,0x03,0x44},//1
        };

//{0x02,0x51,0x2e,0x38,0x34,0x38,0x2c,0x31,0x30,0x03,0x65},//42
//{0x02,0x52,0x30,0x31,0x31,0x36,0x03,0x57},//43
//{0x02,0x51,0x2e,0x38,0x34,0x38,0x2c,0x31,0x30,0x03,0x65},//44
char Loadcells_Commands[][13] = //{weighcell_static_filterLOW};
{
{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},//ECFS static
{0x02,0x51,0x2e,0x39,0x31,0x30,0x2c,0x31,0x30,0x03,0x69},//0
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//1
{0x02,0x4e,0x03,0x4d},//2
{0x02,0x53,0x03,0x50},//3
{0x02,0x51,0x2e,0x35,0x38,0x36,0x2c,0x36,0x03,0x5d},//4
{0x02,0x43,0x35,0x30,0x30,0x03,0x75},//5
{0x02,0x4f,0x03,0x4c},//6
{0x02,0x54,0x03,0x57},//7
{0x06},//8




{0x01,0x10,0x00,0x6c,0x00,0x01,0x02,0x00,0x00,0xaf,0x3c},//9--1 scaime static
{0x01,0x10,0x00,0x01,0x00,0x01,0x02,0x00,0x07,0xe6,0x43},//10--2
{0x01,0x10,0x00,0x28,0x00,0x01,0x02,0x01,0x00,0xa1,0xe8},//11--3
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//12--4
{0x01,0x06,0x00,0x90,0x00,0xd1,0x49,0xbb},//13--5
{0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7b},//14--6
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//15--7
{0x01,0x03,0x00,0x7e,0x00,0x02,0xa4,0x13},//16--8



{0x02,0x4f,0x03,0x4c},//17 ECFS calib
{0x02,0x51,0x2e,0x39,0x31,0x30,0x2c,0x31,0x30,0x03,0x69},//0
{0x02,0x52,0x31,0x30,0x30,0x30,0x03,0x50},//19
{0x02,0x54,0x03,0x57},//20
{0x02,0x43,0x35,0x30,0x30,0x03,0x75},//21
{0x02,0x53,0x03,0x50},//22



{0x01,0x10,0x00,0x01,0x00,0x01,0x02,0x00,0x07,0xe6,0x43},//23 scaime calib
{0x01,0x10,0x00,0x28,0x00,0x01,0x02,0x01,0x00,0xa1,0xe8},//24
{0x01,0x10,0x00,0x6c,0x00,0x01,0x02,0x00,0x00,0xaf,0x3c},//25
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//26
{0x01,0x06,0x00,0x90,0x00,0xd1,0x49,0xbb},//27
{0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7b},//28
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//29
{0x01,0x10,0x00,0x2f,0x00,0x02,0x04,0x86,0xa0,0x00,0x01,0x59,0x5d},//30
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//31
{0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xd8,0xbb,0x5a},//32
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//33

{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//34 scaime calib
{0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xec,0xba,0x8d},//35
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//36
{0x01,0x03,0x00,0x1a,0x00,0x02,0xe5,0xcc},//37
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//38
{0x01,0x10,0x00,0x90,0x00,0x01,0x02,0x00,0xde,0x3b,0x58},//39
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xe7},//40
{0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7b},//41


{0x02,0x51,0x2e,0x38,0x34,0x38,0x2c,0x31,0x30,0x03,0x65},//42
{0x02,0x52,0x30,0x31,0x31,0x36,0x03,0x57},//43
{0x02,0x51,0x2e,0x38,0x34,0x38,0x2c,0x31,0x30,0x03,0x65},//44

{0x02,0x47,0x03,0x44},//45

{0x01,0x03,0x00,0x9c,0x00,0x02,0x04,0x25},//scaime dynamic--46
{0x01,0x10,0x00,0x01,0x00,0x01,0x02,0x00,0x01,0x66,0x41},//dynamic adc  47
{0x01,0x10,0x00,0x28,0x00,0x01,0x02,0x00,0x00,0xA0,0x78},//static filter off  48
{0x01,0x10,0x00,0xa0,0x00,0x01,0x02,0x00,0xb4,0xBE,0x87},//stable T 49
{0x01,0x10,0x00,0xa1,0x00,0x01,0x02,0x00,0xa0,0xBF,0x59},//Measure T 50

{0x01,0x10,0x00,0x6c,0x00,0x01,0x02,0x01,0x03,0xEE,0xAD},//dynamic ON 51
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xE7},//clear 52

{0x01,0x06,0x00,0x90,0x00,0xd1,0x49,0xBB},//eep save 53
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xE7},//clear 54

{0x01,0x06,0x00,0x90,0x00,0xd0,0x88,0x7B},//reset 55
{0x01,0x06,0x00,0x90,0x00,0x00,0x89,0xE7},//clear 56



        };

bool hmi_mderrfg;
unsigned char md_dbn_ctr;
bool md_errfg;
bool mdwdfg;
unsigned int mdwd_ctr;
bool logmd_errfg;
bool chkmderrfg;



unsigned char loadsteps=0,loadstepss = 11;
unsigned char dynamic_loadsteps=0;

int ccc = 0;
QString ccc2,ccc1;

extern bool err2_auditfglogfg;
extern bool err7_auditfglogfg;

extern QString dataval1;

extern void* userData;

QString global_datetime,global_stpdatetime,update_datetime;


float x_fact,y_fact;
bool negfg,CW1200fg;
unsigned int last_ppm;

bool staticnsetz_taskfg,task1fg;
unsigned int staticnsetz_taskctr,task1ctr,rtc_read_timer;

extern unsigned int Max_len,MAX_SPEED,MIN_SPEED;

//unsigned int bin_bcd(unsigned char, unsigned int);
//unsigned int digit(unsigned int);

unsigned char start_dly;
//unsigned int bincon(unsigned int);

unsigned char S2_DLY_TIME;

//void heartbit_f();
QString config_parameter[11];

extern QString var1;// = "Dynamic";
extern QString var2;// = "AUDIT";
extern QString var3;// = "AlARAM";

extern QString cpp_prd_batchno;
extern bool batch_endfg;

extern loadcellcalls* isrIndicatorGpio;

union {
    int record[6];
    struct {
        int uwcount;
        int account;
        int owcount;
        int totcount;
        double weight;
    } stuff;
} WtRecord;

double w;
extern QThread thread_timer;

loadcellcalls::loadcellcalls(QObject *parent):QObject(parent)
{

    Fivemstimer = new QTimer(this);
    Fivemstimer->setTimerType(Qt::PreciseTimer);
    Fivemstimer->connect(Fivemstimer,SIGNAL(timeout()),this,SLOT(FivemsLoop()));
    Fivemstimer->start(5);

    RTC_read_timer = new QTimer(this);
    RTC_read_timer->connect(RTC_read_timer,SIGNAL(timeout()),this,SLOT(OnesecLoop()));
    RTC_read_timer->start(1000);

    if(!file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }

    while(!file.atEnd())
    {
        //QByteArray line = file.readLine();
        QTextStream line(&file);


        line >> config_parameter[0];
        line >> config_parameter[1];
        line >> config_parameter[2];
        line >> config_parameter[3];
        line >> config_parameter[4];
        line >> config_parameter[5];
        line >> config_parameter[6];
        line >> config_parameter[7];
        line >> config_parameter[8];
        line >> config_parameter[9];
        line >> config_parameter[10];

        qDebug() << "model- " << config_parameter[0];
        qDebug() << "platform data - " << config_parameter[1];
        qDebug() << "start delay in ms - " << config_parameter[2];
        qDebug() << "MAX LENGTH - " << config_parameter[3];

        platform = config_parameter[1].toInt();

        serial_usb0.setBaudRate(QSerialPort::Baud9600);
        serial_usb0.setDataBits(QSerialPort::Data8);
        serial_usb0.setParity(QSerialPort::NoParity);
        serial_usb0.setStopBits(QSerialPort::OneStop);
        serial_usb0.setFlowControl(QSerialPort::NoFlowControl);

        if(config_parameter[0] == "CW1200")
        {
            qDebug() << "GOT the MODEL";
            config_param.CW_1200 = 1;

            CW1200fg = 1;
            OW_ERR = 11000;
            zr_reftime = 350;
            S2_DLY_TIME = 19;//10;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;

            qDebug() << MAX_SPEED << "MAX SPEED";
            qDebug() << MIN_SPEED << "MIN SPEED";

            platform_plus = platform + 25;
            if(config_parameter[1] == "550")
            {
                pully_count = 0.039;

            }
            else
            {
                pully_count = 0.037;

            }

            start_dly = config_parameter[2].toInt();
            qDebug() << "CONFIG START DElAY" << start_dly;

        }
        if(config_parameter[0] == "CW1200_COMBI")
        {
            qDebug() << "GOT the COMBI MODEL";
            config_param.CW_1200 = 1;

            CW1200fg = 1;
            OW_ERR = 11000;

            S2_DLY_TIME = 19;//10;

            Max_len = config_parameter[3].toInt();

            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;

            platform_plus = platform + 25;
            pully_count = 0.050;

            start_dly = config_parameter[2].toInt();
            zr_reftime = 350;

            if(cpp_opr_delay <= 20)
            {
                shift_ms_count = 1;
            }
            else if(cpp_opr_delay <= 45)//50
            {
                shift_ms_count = 2;
                qDebug() << shift_ms_count;

            }
            else if(cpp_opr_delay <= 85)
            {
                shift_ms_count = 3;
                qDebug() << shift_ms_count;

            }
            else if(cpp_opr_delay <= 99)
            {
                shift_ms_count = 4;
                qDebug() << shift_ms_count;

            }


        }
        if(config_parameter[0] == "CW1200_COMBI1")
        {
            qDebug() << "GOT the COMBI MODEL";
            config_param.CW_1200 = 1;

            CW1200fg = 1;
            OW_ERR = 11000;

            S2_DLY_TIME = 19;//10;
            //                 Max_len = 190;//290
            Max_len = config_parameter[3].toInt();

            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            //platform = 250;//350;
            platform_plus = platform + 25;
            pully_count = 0.0315;//0.050;
            //                 start_dly = 90;
            start_dly = config_parameter[2].toInt();
            zr_reftime = 350;

            if(cpp_opr_delay <= 20)
            {
                shift_ms_count = 1;
            }
            else if(cpp_opr_delay <= 45)//50
            {
                shift_ms_count = 2;
                qDebug() << shift_ms_count;

            }
            else if(cpp_opr_delay <= 85)
            {
                shift_ms_count = 3;
                qDebug() << shift_ms_count;

            }
            else if(cpp_opr_delay <= 99)
            {
                shift_ms_count = 4;
                qDebug() << shift_ms_count;

            }


        }


        if(config_parameter[0] == "CW3000")
        {
            qDebug() << "GOT the COMBI MODEL CW3K";
            config_param.CW_3K = 1;

            CW1200fg = 1;
            OW_ERR = 21000;
            S2_DLY_TIME = 19;//10;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            platform_plus = platform + 25;
            pully_count = 0.050;
            start_dly = config_parameter[2].toInt();

            CALIB_Hi = 8374498;
            CALIB_Lo = 8323739;

            zr_reftime = 350;

            shift_ms_count = 1;

            if(config_parameter[1] == "440")
            {
                CALIB_Hi = 16760880;
                CALIB_Lo = 16712000;
                zr_reftime = 550;
                dly_25mmtime = 25;

                S2_DLY_TIME = 20;//11;

                pully_count = 0.063;//0.064
                //                     qDebug() << "GOT the COMBI MODEL CW3K 440";
            }

            Loadcells_Commands[30][7] = 0x0d;
            Loadcells_Commands[30][8] = 0x40;
            Loadcells_Commands[30][9] = 0x00;
            Loadcells_Commands[30][10] = 0x03;
            Loadcells_Commands[30][11] = 0xf2;
            Loadcells_Commands[30][12] = 0x8e;

        }
        if(config_parameter[0] == "CW3000_1")
        {
            qDebug() << "GOT the COMBI MODEL CW3K";
            config_param.CW_3K = 1;

            CW1200fg = 1;
            OW_ERR = 21000;
            S2_DLY_TIME = 19;//10;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            platform_plus = platform + 25;
            pully_count = 0.037;
            start_dly = config_parameter[2].toInt();

            CALIB_Hi = 8374498;
            CALIB_Lo = 8323739;
            zr_reftime = 350;


        }

        if(config_parameter[0] == "CW3000_COMBI")
        {
            qDebug() << "GOT the COMBI MODEL";
            config_param.CW_3K = 1;

            CW1200fg = 1;
            OW_ERR = 21000;

            S2_DLY_TIME = 19;//10;
            CALIB_Hi = 16760880;
            CALIB_Lo = 16712000;

            if(config_parameter[1] == "500")
            {
                CALIB_Hi = 16760880;
                CALIB_Lo = 16652058;
            }


            //                 Max_len = 190;//290
            Max_len = config_parameter[3].toInt();

            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;

            platform_plus = platform + 25;
            pully_count = 0.050;
            //                 start_dly = 90;
            start_dly = config_parameter[2].toInt();
            zr_reftime = 350;

        }


        if(config_parameter[0] == "CW6000")
        {
            qDebug() << "GOT the COMBI MODEL CW6K";
            config_param.CW_6K = 1;

            CW1200fg = 1;
            OW_ERR = 51000;
            S2_DLY_TIME = 19;//10;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            platform_plus = platform + 25;
            pully_count = 0.0385;
            start_dly = config_parameter[2].toInt();

            CALIB_Hi = 16756211;//8374498;
            CALIB_Lo = 16722797;//8323739;

            zr_reftime = 400;

            shift_ms_count = 1;

            Loadcells_Commands[30][7] = 0x0d;
            Loadcells_Commands[30][8] = 0x40;
            Loadcells_Commands[30][9] = 0x00;
            Loadcells_Commands[30][10] = 0x03;
            Loadcells_Commands[30][11] = 0xf2;
            Loadcells_Commands[30][12] = 0x8e;

        }


        if(config_parameter[0] == "CW3000HSA")
        {
            qDebug() << "GOT the COMBI MODEL CW3KHSA";
            //config_param.CW_3K = 1;
            config_param.CW_3000HSA = 1;

            CW1200fg = 1;
            OW_ERR = 21000;
            S2_DLY_TIME = 26;//13;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            platform_plus = platform + 10;//25;
            pully_count = 0.0394;//0.0325;
            start_delay = config_parameter[2].toInt();
            start_delay = start_delay / 5;

            if(platform == 200)
            {
                pully_count = 0.0394;

            }

        }
        if(config_parameter[0] == "CW1200HSA")
        {
            qDebug() << "GOT the COMBI MODEL CW3KHSA";
            //config_param.CW_3K = 1;
            config_param.CW_1200HSA = 1;

            CW1200fg = 1;
            OW_ERR = 11000;
            S2_DLY_TIME = 26;//13;
            Max_len = config_parameter[3].toInt();
            MAX_SPEED = config_parameter[4].toInt();//250;
            MIN_SPEED = config_parameter[5].toInt();//250;
            platform_plus = platform + 10;//25;
            pully_count = 0.0394;//0.0325;
            start_delay = config_parameter[2].toInt();
            start_delay = start_delay / 5;


        }


        if(config_parameter[0] == "CW600HSA")
        {
            qDebug() << "GOT the MODEL---CW600HSA";
            config_param.CW_600HSA = 1;

            S2_DLY_TIME = 15;
            OW_ERR = 50500;
            //                   Max_len = 150;
            Max_len = config_parameter[3].toInt();

            MAX_SPEED = config_parameter[4].toInt();//400;
            MIN_SPEED = config_parameter[5].toInt();//250;

            shift_ms_count = 1;
            pully_count = 0.0394;
            //platform = 200;
            //platform = config_parameter[1].toInt();
            qDebug() << "GOT PLATFORM" << platform;
            platform_plus = platform + 10;
            //                   start_delay = 10;
            start_delay = config_parameter[2].toInt();
            start_delay = start_delay / 5;


        }


        if(config_parameter[0] == "CW100HSA")
        {
            qDebug() << "GOT the MODEL---CW100HSA";
            config_param.CW_600HSA = 1;
            config_param.CW_100HSA = 1;

            S2_DLY_TIME = 15;
            OW_ERR = 10500;
            //                   Max_len = 150;
            Max_len = config_parameter[3].toInt();

            MAX_SPEED = config_parameter[4].toInt();//400;
            MIN_SPEED = config_parameter[5].toInt();//250;

            shift_ms_count = 1;
            pully_count = 0.0394;
            //platform = 200;
            //platform = config_parameter[1].toInt();
            qDebug() << "GOT PLATFORM" << platform;
            platform_plus = platform + 10;
            //                   start_delay = 10;
            start_delay = config_parameter[2].toInt();
            start_delay = start_delay / 5;


        }



    }
    qDebug() << "GOT PLATFORM" << platform << "plus " << platform_plus;
    qDebug() << "start delay" << start_delay;
    qDebug() << "MAX LENGTH" << Max_len;

    file.close();

    //----------------------------TEST CODE-----------------------



    if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }
    QTextStream in1(&ONOFF_file);

    in1 >> ONOFF_param[0];
    in1 >> ONOFF_param[1];
    in1 >> ONOFF_param[2];
    in1 >> ONOFF_param[3];

    qDebug() << "LOG OUT TIME" << ONOFF_param[2];

    if(ONOFF_param[0] == "1")
    {
        cw_bypassfg = 1;
    }
    if(ONOFF_param[1] == "1")
    {
        // duplicate_batchfg = 1;
        prodnfg = 1;
    }
    if(ONOFF_param[3] == "1")
    {
        batch_endfg = 1;
    }
    if(ONOFF_param[3] == "2")
    {
        unique_bchfg = 1;
    }



    ONOFF_file.close();

//    if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
//    {
//        qDebug() << "Failed to create";
//    }
//    QTextStream in(&stats_file);

//    in >> stats_param[0];
//    in >> stats_param[1];
//    in >> stats_param[2];
//    in >> stats_param[3];
//    in >> stats_param[4];
//    in >> stats_param[5];
//    in >> stats_param[6];
//    in >> stats_param[7];
//    in >> stats_param[8];
//    in >> stats_param[9];
//    in >> stats_param[10];
//    in >> stats_param[11];
//    in >> stats_param[12];

//    stats_file.close();
//    qDebug() << stats_param[0]; //fg
//    qDebug() << stats_param[1]; //UW
//    qDebug() << stats_param[2]; //OK
//    qDebug() << stats_param[3]; //OW
//    qDebug() << stats_param[4]; //TOT
//    qDebug() << stats_param[5]; //std dev
//    qDebug() << stats_param[6]; //avg ok
//    qDebug() << stats_param[7]; // min wt
//    qDebug() << stats_param[8]; // max wt
//    qDebug() << stats_param[9]; //
//    qDebug() << stats_param[10]; //
//    qDebug() << stats_param[11]; //
//    qDebug() << stats_param[12];// AVg accp wt<< "END"; // max wt


//    if(stats_param[0] == "1")
//    {
//        comparefg = 1;
//        min_wt = stats_param[9].toFloat();
//        max_wt = stats_param[10].toFloat();
//        avg_accp_bin = stats_param[6].toInt();
//    }

//    uw_count = stats_param[1].toInt();
//    accp_count = stats_param[2].toInt();
//    ow_count = stats_param[3].toInt();
//    batch_tot_cnt = stats_param[4];
//    batch_accp_cnt = stats_param[2];
//    batch_ow_cnt = stats_param[3];
//    batch_uw_cnt = stats_param[1];

//    std_dev_buffer = stats_param[11].toInt();
//    avg_buff = stats_param[12].toInt();

//    qDebug() << uw_count;
//    qDebug() << accp_count;
//    qDebug() << ow_count;
//    qDebug() << std_dev_buffer;
//    qDebug() << avg_buff;


//    if(config_param.CW_600HSA)
//    {
//        val = (float)avg_buff / 100;
//        dataval1 =  QString::number(val,'f',2);

//    }
//    else
//    {
//        val = (float)avg_buff / 10;
//        dataval1 =  QString::number(val,'f',1);

//    }

//    batch_avgaccp_wt = dataval1;
//    qDebug() << batch_avgaccp_wt << "AVG ACCP WT";

    rej_percent = (uw_count + ow_count);
    rej_percent = rej_percent / (uw_count + ow_count + accp_count);
    rej_percent = rej_percent * 100;
    batch_rej_percnt =  QString::number(rej_percent);





    poweron_nwdate_syncfg = 1;

}

void loadcellcalls::OnesecLoop()
{

    QString alaram_dttm,str_hr,str_min,str_sec;
    QString str_date,str_mon;


    //    QVariant tmp_data;
    //        unsigned int sys_hour,sys_min,sys_sec,sys_yr;
    //        QByteArray temp_arr[4];
    //         bool ok;

#if 0
    char buf1[9];
    if(sndwt_extfg)
    {

        buf1[0] = '$';
        buf1[1] = '0';
        buf1[8] = '*';

        sndwt_extfg = 0;
        // aff = dataval.toUtf8().data();
        sprintf(buf,"%.1f",sndval);


        if(sndval <= 9.9)
        {
            buf[3] = 0x20;
            buf[4] = 0x20;
            buf[5] = 0x20;

        }
        else if(sndval <= 99.9)
        {
            buf[4] = 0x20;
            buf[5] = 0x20;

        }
        else if(sndval <= 999.9)
        {
            buf[5] = 0x20;

        }

        buf1[2] = buf[0];
        buf1[3] = buf[1];
        buf1[4] = buf[2];
        buf1[5] = buf[3];
        buf1[6] = buf[4];
        buf1[7] = buf[5];



        //  const char *data = buf1;//dynamicwt_snd[0][9];
        //  serial_usb0.write(data,9);

    }
#endif

    {
        //______Code to SYNC WITH SERVER RTC__________________________________________________________-


        //         tmp_data = timezt.currentTime().hour();
        //         temp_arr[0] = tmp_data.toByteArray();
        //         sys_hour = temp_arr[0].toInt(&ok,16);
        //         qDebug() << "CURRENT TIME" << sys_hour;

        //         tmp_data = timezt.currentTime().minute();
        //         temp_arr[0] = tmp_data.toByteArray();
        //         sys_min = temp_arr[0].toInt(&ok,16);
        //         qDebug() << "CURRENT TIME" << sys_min;

        //         tmp_data = timezt.currentTime().second();
        //         temp_arr[0] = tmp_data.toByteArray();
        //         sys_sec = temp_arr[0].toInt(&ok,16);
        //         qDebug() << "CURRENT TIME" << sys_sec;

        //         tmp_data = QDate::currentDate().year();
        //         temp_arr[0] = tmp_data.toByteArray();
        //         sys_yr = temp_arr[0].toInt(&ok,16);
        //         qDebug() << "CURRENT TIME" << sys_yr << rtc_year;



        //         rtc_hour = sys_hour;
        //         rtc_hour = rtc_hour & 0x7f;
        //         str_hr = dataval.setNum(rtc_hour,16);
        //         rtc_min = sys_min;
        //         rtc_min = rtc_min & 0x7f;
        //         str_min = dataval.setNum(rtc_min,16);
        //         rtc_sec = sys_sec;
        //         rtc_sec = rtc_sec & 0x7f;
        //         str_sec = dataval.setNum(rtc_sec,16);

        //      qDebug() << "CURRENT TIME" << sys_min << rtc_min;

        //________________________________________________________________-

        rtc_sec = wiringPiI2CReadReg8(i2crtcdev,0x02); //SEC
        rtc_sec = rtc_sec & 0x7f;
        str_sec = dataval.setNum(rtc_sec,16);
        rtc_min = wiringPiI2CReadReg8(i2crtcdev,0x03); //min
        rtc_min = rtc_min & 0x7f;
        str_min = dataval.setNum(rtc_min,16);
        rtc_hour = wiringPiI2CReadReg8(i2crtcdev,0x04); //hour
        rtc_hour = rtc_hour & 0x3f;
        str_hr = dataval.setNum(rtc_hour,16);
        if(rtc_hour <= 9)
        {
            str_hr = "0" + str_hr;
        }
        if(rtc_min <= 9)
        {
            str_min = "0" + str_min;
        }
        if(rtc_sec <= 9)
        {
            str_sec = "0" + str_sec;

        }

        emit RTC_TIME_string(str_hr,str_min,str_sec);

        rtc_day = wiringPiI2CReadReg8(i2crtcdev,0x05); //min
        rtc_day = rtc_day & 0x3f;
        str_date = dataval.setNum(rtc_day,16);
        rtc_month = wiringPiI2CReadReg8(i2crtcdev,0x07); //hour
        rtc_month = rtc_month & 0x1f;
        str_mon = dataval.setNum(rtc_month,16);
        rtc_year = wiringPiI2CReadReg8(i2crtcdev,0x08); //hour

        if(rtc_day <= 9)
        {
            str_date = "0" + str_date;
        }
        if(rtc_month <= 9)
        {
            str_mon = "0" + str_mon;
        }


        if((str_mon != read_str_mon) || (str_date != read_str_date))
        {
            read_str_mon = str_mon;
            read_str_date = str_date;
            emit RTC_string(str_mon,str_date,dataval.setNum(rtc_year,16));
            qDebug() << "One time date update";
        }


    }



    update_datetime = str_date; //dataval1.setNum(rtc_day,16);
    update_datetime = update_datetime.append("/");

    update_datetime = update_datetime.append(str_mon);//global_datetime.append(dataval1.setNum(rtc_month,16));
    update_datetime = update_datetime.append("/");

    update_datetime = update_datetime.append(dataval1.setNum(rtc_year,16));
    update_datetime = update_datetime.append("  ");
    global_datetime = update_datetime;


    alaram_dttm = str_hr;//dataval1.setNum(rtc_hour,16);//
    alaram_dttm = alaram_dttm.append(":");

    alaram_dttm = alaram_dttm.append(str_min);//alaram_dttm.append(dataval1.setNum(rtc_min,16));
    alaram_dttm = alaram_dttm.append(":");

    alaram_dttm = alaram_dttm.append(str_sec);//alaram_dttm.append(dataval1.setNum(rtc_sec,16));


    global_datetime = global_datetime.append(alaram_dttm);


    if(poweron_nwdate_syncfg)
    {
        QString nwdattime;
        QString yyyy = "20";
        QString system_cmd;
        system_cmd.clear();
        nwdattime.clear();
        nwdattime.append("'" +yyyy+ dataval.setNum(rtc_year,16) + "-" + str_mon + "-" + str_date + " " + str_hr + ":" + str_min + ":" + str_sec +"'");
        qDebug() << nwdattime;
        system("sudo timedatectl set-ntp no");
        system_cmd.append("sudo timedatectl set-time ");
        system_cmd.append(nwdattime);
        system(system_cmd.toUtf8());
        poweron_nwdate_syncfg = 0;

    }


    if(batch_stop)
    {
        batch_stop = 0;

        global_stpdatetime = str_date;//
        global_stpdatetime = global_stpdatetime.append("/");

        global_stpdatetime = global_stpdatetime.append(str_mon);//
        global_stpdatetime = global_stpdatetime.append("/");

        global_stpdatetime = global_stpdatetime.append(dataval1.setNum(rtc_year,16));
        global_stpdatetime = global_stpdatetime.append("  ");


        alaram_dttm = str_hr;//
        alaram_dttm = alaram_dttm.append(":");

        alaram_dttm = alaram_dttm.append(str_min);//
        alaram_dttm = alaram_dttm.append(":");

        alaram_dttm = alaram_dttm.append(str_sec);//


        global_stpdatetime = global_stpdatetime.append(alaram_dttm);

    }





    if(digitalRead(wpGPIO_IN_PIN18_SENSOR2))
    {
        handlediagnos_sts(20);
    }
    else
    {
        handlediagnos_sts(2);

    }
    if(digitalRead(wpGPIO_IN_PIN16_SENSOR1))
    {
        handlediagnos_sts(10);

    }
    else
    {
        handlediagnos_sts(1);

    }
    if(!((wiringPiI2CReadReg8(i2cinputdev,0x12)) & 0x80))
    {
        handlediagnos_sts(30);

    }
    else
    {
        handlediagnos_sts(3);

    }

    if(!((wiringPiI2CReadReg8(i2cinputdev,0x12)) & 0x04))
    {
        handlediagnos_sts(40);

    }
    else
    {
        handlediagnos_sts(4);

    }

    if(!((wiringPiI2CReadReg8(i2cinputdev,0x12)) & 0x08))
    {
        handlediagnos_sts(5);

    }
    else
    {
        handlediagnos_sts(50);

    }

    if(!((wiringPiI2CReadReg8(i2cinputdev,0x12)) & 0x20))
    {
        handlediagnos_sts(60);

    }
    else
    {
        handlediagnos_sts(6);

    }


    if(batch_endfg)
    {
        var1 = "/0";
        var1 = "DynamicSETTINGBATCH2";
        var2 = "/0";
        var2 = "AUDITSETTINGBATCH2";
        var3 = "/0";
        var3 = "ALARAMSETTINGBATCH2";
    }
    else
    {
        var1 = "/0";
        var1 = "Dynamic" + cpp_prd_batchno;
        var2 = "/0";
        var2 = "AUDIT" + cpp_prd_batchno;
        var3 = "/0";
        var3 = "ALARAM" + cpp_prd_batchno;

    }

    if(resetstzero_screenfg)
    {
        resetstzero_screenfg = 0;
        handleSetzero_sts(3);

    }

    if(poweron_stats_updatefg)
    {
        poweron_stats_updatefg = 0;
        power_onslot();

    }

}


void loadcellcalls::FivemsLoop()
{



    tnmsfg = !tnmsfg;

    if(chk_comfailfg && tnmsfg)
    {
        commfail_counter++;
        if(commfail_counter >= 140)
        {
            chk_comfailfg = 0;
            commfail_counter = 0;
            handleerror_sts(5);
            alarm_msg = "ERROR-05 COMMUNICATION FAILED WITH WEIGHING UNIT";
            alarm_msg_sql_logfg = 1;

        }

    }

    if(!digitalRead(wpGPIO_IN_PIN7))
    {
        qDebug() << " SHUTDOWN"; //temp hidden

        wiringPiI2CWriteReg16(i2cdev,0,0);
        wiringPiI2CWriteReg8(i2coutputdev,0x12,0);
        wiringPiI2CWriteReg8(i2coutputdev,0x13,0);

        digitalWrite(wpGPIO_OUT_PIN11, 0);
        //       // qDebug() << "destructor called";
        //        quick_exit(EXIT_SUCCESS);
        //       // system("shutdown -h now");

    }



    if(calib_step1_1)
    {



            setzfg = 0;
            static_togglefg = 0;
            static_startfg = 0;


            calib_step1_1 = 0;
            handleCalib_sts(2);

            calibfg = 1;
            qDebug() << "CALIBRATION START---1st stage-";
            loadsteps = 17;

            task1fg = 1;
            task1ctr = 150;

            if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
            {
                loadsteps = 23;

                task1fg = 1;
                task1ctr = 200;


            }

    }

    if(calib_step2)
    {

            calib_step2 = 0;
            calib_step2_2 = 1;

            if(config_param.CW_1200 || config_param.CW_1200HSA)
            {
                handleCalib_sts(6);

            }
            else if(config_param.CW_100HSA)
            {
                handleCalib_sts(10);

            }
            else if(config_param.CW_600HSA)
            {
                handleCalib_sts(3);

            }
            else if(config_param.CW_3K)
            {
                handleCalib_sts(8);

            }
            else if(config_param.CW_3000HSA)
            {
                handleCalib_sts(8);

            }
            else if(config_param.CW_6K)
            {
                handleCalib_sts(9);

            }

            qDebug() << "CALIBRATION START---2nd stage-";
    }

    if(show_caliberrfg)
    {
        show_caliberrfg = 0;
        handleCalib_sts(7);

    }

    if(calib_step3)
    {


            calib_step3 = 0;
            calib_step3_3 = 1;
            handleCalib_sts(5);
            // emit end_calib_process("Hello");
            // emit setzerostart();

    }




    if(display_guageval)
    {
        display_guageval = 0;
        emit handleIPGuage_val(show_sped_ctr);
    }

    if(tnmsfg & conv_onfg)
    {

        if(err2_rst_fg)
        {
            auto_rst_err2_ctr++;
            if(auto_rst_err2_ctr >= ERR2_RST_TIME)
            {
                err2_rst_fg = 0;
                auto_rst_err2_ctr = 0;
                err_ctr = 0;

            }

        }

    }

    if(tnmsfg)
    {

        if(display_error1fg)
        {
            display_error1fg = 0;
            handleerror_sts(1);
        }
        if(display_error2fg)
        {
            display_error2fg = 0;
            handleerror_sts(2);
        }
        if(conv_onfg & display_error7fg)
        {
            display_error7fg = 0;
            handleerror_sts(7);
        }
        if(display_error14fg)
        {
            display_error14fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(14);


        }
        if(display_error15fg)
        {
            display_error15fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(15);


        }
        if(display_error17fg)
        {
            display_error17fg = 0;
            conv_onfg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(17);
        }
        if(display_error16fg)
        {
            display_error16fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(16);


        }
        if(display_error19fg)
        {
            display_error19fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(19);

        }
        if(display_error20fg)
        {
            display_error20fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(20);


        }
        if(display_error22fg)
        {
            display_error22fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(22);


        }
        if(display_error23fg)
        {
            display_error23fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(23);


        }
        if(display_error26fg)
        {
            display_error26fg = 0;
            handleerror_sts(26);


        }
        if(display_error27fg)
        {
            display_error27fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(27);

        }
        if(display_error30fg)
        {
            display_error30fg = 0;
            handleConv_sts(conv_onfg);
            handleerror_sts(30);

        }
        if(reset_err7fg & conv_onfg)
        {
            reset_err7fg = 0;
            alarm_msg = "ERR-07 AUTO / MANUAL RESET";
            alarm_msg_sql_logfg = 1;
            handleerror_sts(70);


        }

        if(reset_err2fg & conv_onfg)
        {
            reset_err2fg = 0;
            alarm_msg = "ERR-02 AUTO / MANUAL RESET";
            alarm_msg_sql_logfg = 1;
            handleerror_sts(21);


        }

        if(reset_err29fg & conv_onfg)
        {
            reset_err29fg = 0;
            alarm_msg = "ERR-29 AUTO / MANUAL RESET";
            alarm_msg_sql_logfg = 1;
            handleerror_sts(290);


        }
        if(conv_onfg & hmi_mderrfg)
        {
            hmi_mderrfg = 0;
            alarm_msg = "ERROR-29 METAL DETECTION";
            alarm_msg_sql_logfg = 1;
            handleerror_sts(29);



        }
        if(reset_err1fg & conv_onfg)
        {
            reset_err1fg = 0;
            alarm_msg = "ERR-01 AUTO / MANUAL RESET";
            alarm_msg_sql_logfg = 1;
            handleerror_sts(10);



        }

    }

    if(calcovrfg)
    {

        if(!conv_onfg)
        {
            calcovrfg = 0;

        }
        if(err1fg)
        {
            //shift_buff[0] = 3;

        }
        else
        {
            if(setzfg)
            {
                bin_ref = bin_val;
                qDebug() << bin_ref;
                bin_val = 0;
                qDebug() << "Completed";
                qDebug() << setzfg;
                setzfg = 0;

                sndval = 0.0;
                //  sndwt_extfg = 1;

                if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
                {
                    for(temp_loop = 0;temp_loop < 7;temp_loop++)
                    {
                        zr_buff[temp_loop] = bin_ref;
                    }

                }
                else
                {
                    for(temp_loop = 0;temp_loop < 5;temp_loop++)
                    {
                        zr_buff[temp_loop] = bin_ref;
                    }

                }


            }
            else if(!conv_onfg)
            {
                if(bin_val < bin_ref)
                {
                    bin_val = 0;

                }
                else
                {
                    bin_val = bin_val - bin_ref;

                }

                disp_staticfg = 1;

            }
            if(config_param.CW_600HSA)
            {

                if(!conv_onfg)
                {
                    val = (float)bin_val / 100;
                    qDebug() << val;
                    qDebug() << bin_val;
                    if(bin_val > OW_ERR)
                    {
                        val = 0;
                        bin_val = 0;


                        handleerror_sts(12);
                        reset_err12fg = 1;

                        alarm_msg = "ERR-12 OW ERROR";
                        alarm_msg_sql_logfg = 1;


                    }
                    else if(reset_err12fg)
                    {
                        reset_err12fg = 0;
                        handleerror_sts(120);

                        alarm_msg = "ERR-12 OW ERROR -- AUTO / MANUAL RESET";
                        alarm_msg_sql_logfg = 1;

                    }
                    datavalstn1 =  QString::number(val,'f',2);
                    emit wt_string(datavalstn1);

                }

            }
            else if((config_param.CW_1200HSA || config_param.CW_1200 || config_param.CW_3K || config_param.CW_3000HSA || config_param.CW_6K) & !conv_onfg)
            {


                val = (float)bin_val / 10;
                qDebug() << val;
                qDebug() << bin_val;


                if(bin_val > OW_ERR)
                {

                    bin_val = 0;
                    val = 0;
                    handleerror_sts(12);
                    reset_err12fg = 1;
                    alarm_msg = "ERR-12 OW ERROR";
                    alarm_msg_sql_logfg = 1;
                }
                else if(reset_err12fg)
                {
                    reset_err12fg = 0;
                    handleerror_sts(120);

                    alarm_msg = "ERR-12 OW ERROR -- AUTO / MANUAL RESET";
                    alarm_msg_sql_logfg = 1;

                }
                datavalstn1 =  QString::number(val,'f',1);
                emit wt_string(datavalstn1);

            }


        }


    }

}


void loadcellcalls::gen_dcomp_fact()
{

    if(!cw_bypassfg)
    {

        if(poweron_setzero)
        {
            //poweron_setzero = 0;
            // handleSetzero_sts(1);

            handlestzerosts(50);

        }
        else
        {
            dcompfg = 1;
            dcomp_bin = 0;
            emit dcomp_fact("    ");
            emit end_calib_process("Hello");
            emit conv_onoff();
            emit handleConv_sts(conv_onfg);
        }
    }

}

void loadcellcalls::dcomp_on_off(bool i)
{
    QString tempp;
    QString fdf,bypass_sts,tempmachine_sts;

    if(!cw_bypassfg)
    {

        dcomp_onfg = i;
        tempp = QString::number(dcomp_onfg);
        // dcomp_onfg = tempp;
        qDebug() << dcomp_onfg;
        save_dcomp_fact(tempp,dcomp_dataval1);


        if(dcomp_onfg)
        {
            fdf = "1";
            signal_handleloadcell(global_datetime,"DCOMP ON"," "," ",userid);



        }
        else
        {
            fdf = "0";
            signal_handleloadcell(global_datetime,"DCOMP OFF"," "," ",userid);

        }
        if(cw_bypassfg == 1)
        {
            bypass_sts = "2";

        }
        else
        {
            bypass_sts = "3";

        }
        //    dcomp_dataval1.remove(0,1);
        //  dcomp_bin = dcomp_dataval1.toInt();
        //  qDebug() << dcomp_bin << "dcomp bin value";

        if(CW1200fg)
        {
            val = (float)dcomp_bin / 10;
            dcomp_dataval1 =  QString::number(val,'f',1);

        }
        else
        {
            val = (float)dcomp_bin / 100;
            dcomp_dataval1 =  QString::number(val,'f',2);

        }

        if(positive_dcompfg)
        {
            dcomp_dataval1 = "(+)" + dcomp_dataval1;
        }
        else
        {
            dcomp_dataval1 = "(-)" + dcomp_dataval1;

        }

        if(prodnfg == 1)
        {
            tempmachine_sts = "4";

        }
        else
        {
            tempmachine_sts = "5";

        }



        emit handleDcompsts(fdf,dcomp_dataval1,bypass_sts,tempmachine_sts);

    }

}

void loadcellcalls::cwbypass_on_off(bool i)
{

    QString fdf,bypass_sts,tempmachine_sts;

    cw_bypassfg = i;
    if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }
    QTextStream in1(&ONOFF_file);

    if(cw_bypassfg == 1)
    {
        ONOFF_param[0] = "1";
        signal_handleloadcell(global_datetime,"CWBYPASS ON"," "," ",userid);

    }
    else
    {
        ONOFF_param[0] = "0";
        signal_handleloadcell(global_datetime,"CWBYPASS OFF"," "," ",userid);

    }

    in1 << ONOFF_param[0] << '\n';
    in1 << ONOFF_param[1] << '\n';

    ONOFF_file.close();


    if(dcomp_onfg)
    {
        fdf = "1";
    }
    else
    {
        fdf = "0";

    }
    if(cw_bypassfg == 1)
    {
        bypass_sts = "2";

    }
    else
    {
        bypass_sts = "3";

    }

    if(prodnfg == 1)
    {
        tempmachine_sts = "4";

    }
    else
    {
        tempmachine_sts = "5";

    }

    if(CW1200fg)
    {
        val = (float)dcomp_bin / 10;
        dcomp_dataval1 =  QString::number(val,'f',1);

    }
    else
    {
        val = (float)dcomp_bin / 100;
        dcomp_dataval1 =  QString::number(val,'f',2);

    }

    if(positive_dcompfg)
    {
        dcomp_dataval1 = "(+)" + dcomp_dataval1;
    }
    else
    {
        dcomp_dataval1 = "(-)" + dcomp_dataval1;

    }




    emit handleDcompsts(fdf,dcomp_dataval1,bypass_sts,tempmachine_sts);
    qDebug() << bypass_sts << "CW STS";
    qDebug() << fdf << "CW STS";
    qDebug() << dcomp_dataval1 << "CW STS";

}



void loadcellcalls::calibration()
{




    if(((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x04))
    {

        qDebug() << "CALIBRATION START----------------";
        calib_switcherrfg = 0;

        setzfg = 0;
        static_togglefg = 0;
        static_startfg = 0;
        task1fg = 0;
        wait_togglefg = 1;
        if(calibfg)
        {

        }
        else
        {
            handleCalib_sts(1);
            calib_step1 = 1;
            alarm_msg = "CALIBRATION ATTEMPTED ";
            emit signal_handleloadcell(global_datetime,alarm_msg," "," ",userid);
            qDebug() << "CALIBRTION AUDITED";

        }

    }
    else if(!((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x04))
    {
        handleCalib_sts(18);
        calib_switcherrfg = 1;
        alarm_msg = "ERROR-18->CALIBRATION SWITCH IS OFF";
        emit signal_handleloadcell(global_datetime,alarm_msg," "," ",userid);


    }




}

void loadcellcalls::setzerostart()
{

   // QString fdf,bypass_sts;


    if(!conv_onfg)
    {
        qDebug() << "Setzero START----------------";
        dynamicwt_sts(4);

        //   MLO_status_13 = MLO_status_13 | Touch_BUZZER_ON;
        //  wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

//        touch_buzzer_onfg = 1;
//        touch_buzzer_ctr = 0;
        calib_errstepfg = 0;


        setzfg = 1;
        task1fg = 1;
        task1ctr = 100;
        static_togglefg = 0;
        static_startfg = 0;
        calibfg = 0;
        loadsteps = 0;

        err1fg = 0;

        if(setzfg)
        {
            qDebug() << "SETZERO START";

            wait_togglefg = 1;
            disp_staticfg = 1;

            if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
            {
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 9;
                chk_comfailfg = 1;
                commfail_counter = 0;

            }
            else if(config_param.CW_600HSA){
                emit wt_string(QString::number(0,'f',2));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;

            }
            else if(config_param.CW_3000HSA)
            {
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;

            }
            else if(config_param.CW_1200HSA)
            {
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;

            }





        }
        if(poweron_setzero)
        {
            poweron_setzero = 0;
            handleSetzero_sts(1);
            setzero_screenfg = 1;
            setzero_screenctr = 0;


            send_sts();




        }
        else
        {

            handleSetzero_sts(1);
            setzero_screenfg = 1;
            setzero_screenctr = 0;

        }

    }

}

void loadcellcalls::send_sts()
{
    QString fdf,bypass_sts,tempt1,tempmachine_sts;

    if(dcomp_onfg)
    {
        fdf = "1";


    }
    else
    {
        fdf = "0";

    }
    if(cw_bypassfg == 1)
    {
        bypass_sts = "2";

    }
    else
    {
        bypass_sts = "3";

    }

    if(prodnfg == 1)
    {
        tempmachine_sts = "4";

    }
    else
    {
        tempmachine_sts = "5";

    }

    if(poweron_setzero)
    {
        tempt1 = "1";

    }

    if(CW1200fg)
    {
        val = (float)dcomp_bin / 10;
        dcomp_dataval1 =  QString::number(val,'f',1);

    }
    else
    {
        val = (float)dcomp_bin / 100;
        dcomp_dataval1 =  QString::number(val,'f',2);

    }

    if(positive_dcompfg)
    {
        dcomp_dataval1 = "(+)" + dcomp_dataval1;
    }
    else
    {
        dcomp_dataval1 = "(-)" + dcomp_dataval1;

    }


    emit handleDcompsts(fdf,dcomp_dataval1,bypass_sts,tempmachine_sts);

}


void loadcellcalls::staticstart()
{


    qDebug() << conv_onfg;


    if(!conv_onfg & !poweron_setzero)
    {

        qDebug() << "STATIC START----------------";
        dynamicwt_sts(4);
        qDebug() << static_togglefg;

        err1fg = 0;


        //  MLO_status_13 = MLO_status_13 | Touch_BUZZER_ON;
        //   wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

        touch_buzzer_onfg = 1;
        touch_buzzer_ctr = 0;


        static_togglefg = !static_togglefg;

        if(static_togglefg)
        {
            qDebug() << "STATIC START";

            static_startfg = 0;
            disp_staticfg = 1;
            task1fg = 1;
            task1ctr = 80;
            setzfg = 0;
            calibfg = 0;


            if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
            {
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 9;
                chk_comfailfg = 1;
                commfail_counter = 0;

            }
            else if(config_param.CW_600HSA){
                emit wt_string(QString::number(0,'f',2));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;
            }
            else if(config_param.CW_3000HSA){
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;
            }
            else if(config_param.CW_1200HSA){
                emit wt_string(QString::number(0,'f',1));
                loadsteps = 0;
                chk_comfailfg = 1;
                commfail_counter = 0;
            }


        }
        else
        {



            qDebug() << "STATIC STOP";

            task1fg = 0;
            task1ctr = 0;
            staticnsetz_taskfg = 0;


        }





    }
    else if(poweron_setzero)
    {
        //handleSetzero_sts(50);
        handleerror_sts(50);



    }






}



void loadcellcalls::conv_onoff()
{

    if(duplicate_batchfg)
    {
        handleerror_sts(300);

    }
    else if(!poweron_setzero)
    {

        unsigned int mtrs_min,pack_per_min;
        unsigned int pack_length,temp_ctr,temp_ctr1;
        float calc_speed;


        scan_hold_delay = cpp_hold_delay;
        md_hold_delay = cpp_hold_delay;
        task1fg = 0;
        task1ctr = 0;
        staticnsetz_taskfg = 0;
        val = 0;
        shift_ms_ctr = 0;

        s2_dly_ctr = 0;
        calcovrfg = 0;
        rejvfg = 0;
        rejv_ctr = 0;
        mdregvfg = 0;
        mdrejv_ctr = 0;
        s2dlyfg = 0;
        hold_delay = 0;
        hldfg = 0;
        err_ctr = 0;
        s2fail_ctr = 0;
        s2_failfg = 0;
        estop_ctr = 0;
        air_prsctr = 0;
        //  airprsfg = 1;  //
        //  dooropenchk = 1;
        cont_reg_ctr = 0;
        cont_rej_count = cpp_rej_cnt;

        digitalWrite(wpGPIO_OUT_PIN11, 0);
        digitalWrite(wpGPIO_OUT_PIN13, 0);
        MLO_status_12 = MLO_status_12 & UW_OFF;
        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
        MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);



        nlfg = 0;
        ch_exitdlyfg = 0;
        exit_dly = 0;
        accept_zrfg = 0;
        err1fg = 0;
        in_spd_fg = 1;
        min1_dly_ctr = 0;
        in_sped_ctr = 0;

        hmi_mderrfg = 0;
        md_errfg = 0;

        disp_err2fg = 0;
        disp_err7fg = 0;


        qDebug() << "CONV ON/OFF START----------------";


        setzfg = 0;
        static_togglefg = 0;
        static_startfg = 0;
        disp_staticfg = 0;
        nl_ctr = 0;

        emit handleGuage_val(cpp_prd_speed);

        conv_onfg = !conv_onfg;

        if(conv_onfg)
        {

            if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
            {
                qDebug() << "Dynamic Commands START";




                static_togglefg = 0;
                static_startfg = 0;
                setzfg = 0;
                dynamic_cyclefg = 1;
                loadsteps = 47;

                conv_onfg = 1;

                debounce1fg = 0;
                debounce2fg = 0;


                pack_per_min = cpp_prd_speed;//120;
                pack_length = cpp_prd_length;//70;
                //   s2fail_time = pack_length * 3;

                upper_limit = cpp_prd_target + cpp_prd_Ulimit;
                lower_limit = cpp_prd_target - cpp_prd_Llimit;



                mtrs_min = (pack_per_min * platform_plus) / 1000;
                z_time = (zr_reftime * 6) / mtrs_min;//300
                s2fail_time = (pack_length * 12) / mtrs_min;
                s2fail_time = s2fail_time * 3;

                ERR2_RST_TIME = (platform_plus * 6) / mtrs_min;


                qDebug() << mtrs_min << "mtrsmin";
                qDebug() << start_dly << "start delay";
                qDebug() << pack_length << "pack length";

//                debounce_dly = (pack_length * 6) / mtrs_min;
//                temp_ctr = (debounce_dly * 10) + start_dly;//90;
                debounce_dly = (pack_length * 12) / mtrs_min;
                  pack_debounce_dly = (pack_length * 12) / mtrs_min;//6
                temp_ctr = (debounce_dly * 5) + start_dly;//90;
                scaime_stable_time[7] = 0x00;
                Loadcells_Commands[50][7] = 0x00;

                //  temp_ctr = 190;

                if(config_param.CW_3K && platform == 440)
                {
                    S2_DLY_TIME = 20;//10;
                    dly_25mmtime = (25 * 6) / mtrs_min;
                    S2_DLY_TIME = S2_DLY_TIME + dly_25mmtime;
                    qDebug() << S2_DLY_TIME << "s2dly" << dly_25mmtime << "...25mm";
                }
                if(config_param.CW_6K && platform == 550)
                {
                    S2_DLY_TIME = 20;//10;
                    dly_25mmtime = (25 * 6) / mtrs_min;
                    S2_DLY_TIME = S2_DLY_TIME + dly_25mmtime;
                    qDebug() << S2_DLY_TIME << "s2dly" << dly_25mmtime << "...25mm";
                }

                if(config_param.CW_6K)
                {


                    if(cpp_opr_delay <= 20)
                    {
                        shift_ms_count = 1;
                    }
                    else if(cpp_opr_delay <= 50)
                    {
                        shift_ms_count = 2;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 80)
                    {
                        shift_ms_count = 3;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 99)
                    {
                        shift_ms_count = 4;
                        qDebug() << shift_ms_count;

                    }


                }
                if(config_param.CW_1200 || config_param.CW_3K)
                {


                    if(cpp_opr_delay <= 20)
                    {
                        shift_ms_count = 1;
                    }
                    else if(cpp_opr_delay <= 45)//50
                    {
                        shift_ms_count = 2;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 85)
                    {
                        shift_ms_count = 3;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 99)
                    {
                        shift_ms_count = 4;
                        qDebug() << shift_ms_count;

                    }


                }


                if(temp_ctr >= 0x700)
                {
                    scaime_stable_time[7] = 0x07;
                    Loadcells_Commands[50][7] = 0x07;

                }
                else if(temp_ctr >= 0x600)
                {
                    scaime_stable_time[7] = 0x06;
                    Loadcells_Commands[50][7] = 0x06;

                }
                else if(temp_ctr >= 0x500)
                {
                    scaime_stable_time[7] = 0x05;
                    Loadcells_Commands[50][7] = 0x05;

                }
                else if(temp_ctr >= 0x400)
                {
                    scaime_stable_time[7] = 0x04;
                    Loadcells_Commands[50][7] = 0x04;

                }
                else if(temp_ctr >= 0x300)
                {
                    scaime_stable_time[7] = 0x03;
                    Loadcells_Commands[50][7] = 0x03;

                }
                else if(temp_ctr >= 0x200)
                {
                    scaime_stable_time[7] = 0x02;
                    Loadcells_Commands[50][7] = 0x02;

                }
                else if(temp_ctr > 0xff)
                {
                    scaime_stable_time[7] = 0x01;
                    Loadcells_Commands[50][7] = 0x01;

                }
                scaime_stable_time[8] = temp_ctr;
                Loadcells_Commands[50][8] = temp_ctr;


                temp_ctr1 = ((platform - pack_length) * 60)/ mtrs_min;
                temp_ctr1 = temp_ctr1 - (start_dly + 10);//100;

                // temp_ctr1 = 266;
                qDebug() << temp_ctr1 << "55555555555555";


                scaime_measure_time[7] = 0x00;
                Loadcells_Commands[51][7] = 0;

                if(temp_ctr1 >= 0x1f4)
                {
                    scaime_measure_time[7] = 0x01;
                    Loadcells_Commands[51][7] = 0x01;

                    temp_ctr1 = 0x190;

                }
                else if(temp_ctr1 > 0xff)
                {
                    scaime_measure_time[7] = 0x01;
                    Loadcells_Commands[51][7] = 0x01;


                }
                scaime_measure_time[8] = temp_ctr1;
                Loadcells_Commands[51][8] = temp_ctr1;


                start_delay = (temp_ctr1 + temp_ctr + 20) / 5;//10;//40
                //start_delay = 80;



                qDebug() << temp_ctr << "ST";
                qDebug() << temp_ctr1 << "MT";

                qDebug() << start_delay << "DEVANAND";






                temp_ctr = pack_per_min * platform_plus;
                temp_ctr = temp_ctr / 1000;
                calc_speed = temp_ctr - 1;
                //   calc_speed = calc_speed * 0.051;       //66/1000/2=0.033
                //0.037 used for CW1200-350mm
                //0.051 -- CW1200-250
                calc_speed = calc_speed * pully_count;
                if(pack_per_min <= 99)
                {
                    calc_speed = (calc_speed * 4096) / 5;
                    i2cdata = calc_speed + 85;// / 2;

                }
                else if(pack_per_min <= 140)
                {
                    if(config_parameter[1] == "550")
                    {
                        calc_speed = (calc_speed * 4096) / 5;
                        i2cdata = calc_speed + 110;// / 2;
                    }
                    else
                    {
                        calc_speed = (calc_speed * 4096) / 5;
                        i2cdata = calc_speed + 130;// / 2;
                    }

                }
                else if(pack_per_min <= 180)
                {
                    calc_speed = (calc_speed * 4096) / 5;
                    i2cdata = calc_speed + 150;// / 2;

                }
                else if(pack_per_min <= 200)
                {
                    calc_speed = (calc_speed * 4096) / 5;
                    i2cdata = calc_speed + 190;// / 2;

                }
                else
                {
                    temp_ctr = pack_per_min * platform_plus;
                    temp_ctr = temp_ctr / 1000;
                    calc_speed = temp_ctr - 1;
                    calc_speed = calc_speed * pully_count;//0.052;
                    calc_speed = (calc_speed * 4096) / 5;
                    i2cdata = calc_speed + 195;// / 2;

                }



                i2creg = i2cdata / 255;



                CRC_16(scaime_stable_time,9);
                Loadcells_Commands[50][9] = scaime_stable_time[9];
                Loadcells_Commands[50][10] = scaime_stable_time[10];
                CRC_16(scaime_measure_time,9);
                Loadcells_Commands[51][9] = scaime_measure_time[9];
                Loadcells_Commands[51][10] = scaime_measure_time[10];

                rc_shift_time1 = (190 * 12) / mtrs_min;
                rc_shift_time2 = (70 * 12) / mtrs_min;
                rc_shift_time3 = (50 * 12) / mtrs_min;
                rc_shiftfg1 = rc_shiftfg2 = rc_shiftfg3 = 0;
                rc_shift_ctr1 = 0;
                rc_shift_ctr2 = 0;
                rc_shift_ctr3 = 0;

                if(dcompfg)
                {
                    rc_sensorfg = 0;

                }
                else
                {
                    rc_sensorfg = 1;

                }

            }
            else if(config_param.CW_600HSA || config_param.CW_3000HSA || config_param.CW_1200HSA){


                //if(config_param.CW_600HSA)
                {


                    if(cpp_opr_delay <= 30)
                    {
                        shift_ms_count = 1;
                    }
                    else if(cpp_opr_delay <= 50)
                    {
                        shift_ms_count = 2;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 80)
                    {
                        shift_ms_count = 3;
                        qDebug() << shift_ms_count;

                    }
                    else if(cpp_opr_delay <= 99)
                    {
                        shift_ms_count = 4;
                        qDebug() << shift_ms_count;

                    }


                }

                if(cpp_prd_speed >= 370)
                {
                    S2_DLY_TIME = 8;//16;//8;

                }
                else if(cpp_prd_speed >= 350)
                {
                    S2_DLY_TIME = 10;//16;//8;//9;

                }
                else
                {
                    S2_DLY_TIME = 12;//18;

                }

                calc_speeds();


                loadsteps = 42;

                dynamic_cyclefg = 1;

                conv_onfg = 1;

                debounce1fg = 0;
                debounce2fg = 0;

                pack_per_min = cpp_prd_speed;//120;

                pack_length = cpp_prd_length;//70;


                temp_ctr = pack_per_min * platform_plus;//210;
                temp_ctr = temp_ctr / 1000;
                calc_speed = temp_ctr - 1;

                if(platform == 200)
                {
                    if(config_parameter[8] == "1")
                    {
                        qDebug() << "I m in loop 1DEVANAND";
                        if(pack_per_min <= 119)
                        {
                            calc_speed = calc_speed * 0.0375;      //0.0375 reuired for INTAS //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 40;// / 2;

                        }
                        else if(pack_per_min <= 180)
                        {
                            calc_speed = calc_speed * 0.0375;       //66/1000/2=0.033 //0.0375 reuired for INTAS
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 70;// / 2;

                        }
                        else if(pack_per_min <= 240)
                        {
                            calc_speed = calc_speed * 0.0375;       //66/1000/2=0.033//0.0375 reuired for INTAS
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 100;// / 2;

                        }
                        else if(pack_per_min <= 290)
                        {
                            calc_speed = calc_speed * 0.0375;       //66/1000/2=0.033//0.0375 reuired for INTAS
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 125;// / 2;

                        }
                        else if(pack_per_min <= 350)
                        {
                            calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 100;// / 2;

                        }
                        else if(pack_per_min <= 450)
                        {
//                            calc_speed = calc_speed * 0.0390;       //66/1000/2=0.033
//                            calc_speed = (calc_speed * 4096) / 5;
//                            i2cdata = calc_speed + 100;// / 2;

                            calc_speed = calc_speed * 0.0335;//0.0390;
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 100;// / 2;

                        }


                    }
                    else
                    {

                        if(pack_per_min <= 119)
                        {
                            calc_speed = calc_speed * 0.0385;      //0.0375 reuired for INTAS //66/1000/2=0.033 & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 40;// / 2;

                        }
                        else if(pack_per_min <= 180)
                        {
                            calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033 //0.0375 reuired for INTAS & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 60;// / 2;

                        }
                        else if(pack_per_min <= 240)
                        {
                            calc_speed = calc_speed * 0.0370; //0.0385
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 120;// / 2;90 chnaged

                        }
                        else if(pack_per_min <= 290)
                        {
                            calc_speed = calc_speed * 0.0380;       //66/1000/2=0.033//0.0375 reuired for INTAS & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 125;// / 2;

                        }
                        else if(pack_per_min <= 350)
                        {
                            calc_speed = calc_speed * 0.0390;       //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 120;// / 2;

                        }
                        else if(pack_per_min <= 400)
                        {
                            calc_speed = calc_speed * 0.0395;       //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 110;// / 2;

                        }
                    }
                }
                else if(platform == 250 || platform == 350)
                {
                    if(config_param.CW_3000HSA && platform == 250)
                    {
                        calc_speed = calc_speed * pully_count;//0.0385;

                        if(pack_per_min <= 119)
                        {
                            // calc_speed = calc_speed * 0.0385;      //0.0375 reuired for INTAS //66/1000/2=0.033 & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 40;// / 2;

                        }
                        else if(pack_per_min <= 180)
                        {
                            //  calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033 //0.0375 reuired for INTAS & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 60;// / 2;

                        }
                        else if(pack_per_min <= 240)
                        {
                            //  calc_speed = calc_speed * 0.0385;
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 90;// / 2;90

                        }
                        else if(pack_per_min <= 290)
                        {
                            // calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033//0.0375 reuired for INTAS & 0.0330 for CIPLA
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 125;// / 2;

                        }
                        else if(pack_per_min <= 350)
                        {
                            // calc_speed = calc_speed * 0.0395;       //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 120;// / 2;100

                        }
                        else if(pack_per_min <= 400)
                        {
                            //   calc_speed = calc_speed * 0.0404;       //66/1000/2=0.033
                            calc_speed = (calc_speed * 4096) / 5;
                            i2cdata = calc_speed + 100;// / 2;

                        }

                    }
                    else
                    {
                        if(platform == 250)
                        {

                            if(pack_per_min <= 119)
                            {
                                calc_speed = calc_speed * 0.0385;      //0.0375 reuired for INTAS //66/1000/2=0.033 & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 40;// / 2;

                            }
                            else if(pack_per_min <= 180)
                            {
                                calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033 //0.0375 reuired for INTAS & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 60;// / 2;

                            }
                            else if(pack_per_min <= 240)
                            {
                                calc_speed = calc_speed * 0.0385;
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 90;// / 2;90

                            }
                            else if(pack_per_min <= 290)
                            {
                                calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033//0.0375 reuired for INTAS & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 125;// / 2;

                            }
                            else if(pack_per_min <= 350)
                            {
                                calc_speed = calc_speed * 0.0395;       //66/1000/2=0.033
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 120;//100;// / 2;

                            }
                            else if(pack_per_min <= 400)
                            {
                                calc_speed = calc_speed * 0.0404;       //66/1000/2=0.033
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 100;// / 2;

                            }
                        }
                        else if(platform == 350)
                        {
                            calc_speed = calc_speed * pully_count;//0.0385;
                            if(pack_per_min <= 119)
                            {
                                // calc_speed = calc_speed * 0.0385;      //0.0375 reuired for INTAS //66/1000/2=0.033 & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 40;// / 2;

                            }
                            else if(pack_per_min <= 180)
                            {
                                //  calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033 //0.0375 reuired for INTAS & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 60;// / 2;

                            }
                            else if(pack_per_min <= 240)
                            {
                                // calc_speed = calc_speed * 0.0385;
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 90;// / 2;90

                            }
                            else if(pack_per_min <= 290)
                            {
                                // calc_speed = calc_speed * 0.0385;       //66/1000/2=0.033//0.0375 reuired for INTAS & 0.0330 for CIPLA
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 100;// / 2;

                            }
                            else if(pack_per_min <= 350)
                            {
                                // calc_speed = calc_speed * 0.0395;       //66/1000/2=0.033
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 110;// / 2;

                            }
                            else if(pack_per_min <= 400)
                            {
                                // calc_speed = calc_speed * 0.0404;       //66/1000/2=0.033
                                calc_speed = (calc_speed * 4096) / 5;
                                i2cdata = calc_speed + 100;// / 2;

                            }


                        }
                    }

                }


                i2creg = i2cdata / 255;

                if(dcompfg)
                {
                    rc_sensorfg = 0;

                }
                else
                {
                    rc_sensorfg = 1;

                }

            }



            MLO_status_12 = MLO_status_12 & BUZZER_OFF;
            wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);


            touch_buzzer_onfg = 1;
            touch_buzzer_ctr = 0;

            event_msg = "CONVEYOR ON";
            prev_value = " ";
            cur_value = " ";


            delay(500);





            wiringPiI2CWriteReg16(i2cdev,i2creg,i2cdata);//need to check
            //wiringPiI2CWrite(i2cdev,i2cdata);
            // wiringPiI2CWrite(i2cdev,1220);


            qDebug() << i2creg << "reg---------------";
            qDebug() << i2cdata << "data---------------";

            serial.clear();


            task1fg = 1;
            task1ctr = 80;

        }
        else
        {
            conv_onfg = 0;
            handleConv_sts(conv_onfg);

            wiringPiI2CWriteReg16(i2cdev,0,0);

            MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
            wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
            MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
            wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);


            event_msg = "CONVEYOR OFF";
            prev_value = " ";
            cur_value = " ";


            binfullfg = 0;
            binfull_ctr = 0;
            rvbinfull_ctr = 0;
            task1fg = 0;
            task1ctr = 0;
            staticnsetz_taskfg = 0;
            commfail_counter = 0;

            qDebug() << "CONV OFF";

        }

    }
    else if(poweron_setzero)
    {
        handleerror_sts(50);
        handleConv_sts(0);
    }
}


void loadcellcalls::calc_speeds()
{

    unsigned int mtrs_min,pack_per_min;
    unsigned int pack_length;
    unsigned int bcd1,bcd2,ctr3;
    unsigned char value2[10],value1,i,j,ch_counter,ch_temp_val;

    pack_per_min = cpp_prd_speed;//120;
    //platform_plus = 210;
    pack_length = cpp_prd_length;//70;
    //  s2fail_time = pack_length * 3;

    upper_limit = cpp_prd_target + cpp_prd_Ulimit;
    lower_limit = cpp_prd_target - cpp_prd_Llimit;

    start_delay = config_parameter[2].toInt();
    start_delay = start_delay / 5;

    mtrs_min = (pack_per_min * platform_plus) / 1000;
    mtrs_min = mtrs_min - 1;
    qDebug() << mtrs_min << "mtrsmin";
    debounce_dly = (pack_length * 6) / mtrs_min;//6
    pack_debounce_dly = (pack_length * 12) / mtrs_min;//6

    s2fail_time = (pack_length * 12) / mtrs_min;
    s2fail_time = s2fail_time * 3;

    z_time = (420 * 6) / mtrs_min;//6

    if(platform == 250)
    {
        rc_shift_time1 = (200 * 12) / mtrs_min;//200
        rc_shift_time2 = (100 * 12) / mtrs_min;//120
        rc_shift_time3 = (60 * 12) / mtrs_min;

        if(pack_per_min >= 250)
        {
            rc_shift_time1 = (180 * 12) / mtrs_min; //360
            rc_shift_time2 = (100 * 12) / mtrs_min;
            rc_shift_time3 = (50 * 12) / mtrs_min;

        }

    }
    else
    {
        rc_shift_time1 = (150 * 12) / mtrs_min; //360
        rc_shift_time2 = (90 * 12) / mtrs_min;
        rc_shift_time3 = (50 * 12) / mtrs_min;

    }

    rc_shiftfg1 = rc_shiftfg2 = rc_shiftfg3 = 0;
    rc_shift_ctr1 = 0;
    rc_shift_ctr2 = 0;
    rc_shift_ctr3 = 0;

    ERR2_RST_TIME = (platform_plus * 6) / mtrs_min;

    dynamic_ring_buff = (platform - pack_length) * 60;//200
    dynamic_ring_buff = dynamic_ring_buff / (mtrs_min);
    dynamic_ring_buff = dynamic_ring_buff - (start_delay * 5);
    dynamic_ring_buff = dynamic_ring_buff - 10;

//    start_delay = config_parameter[2].toInt();
//    start_delay = start_delay / 10;
//    start_delay = start_delay + 1;

    if(pack_per_min <= 120)
    {
        //   dynamic_ring_buff = dynamic_ring_buff - 60;

    }


    ctr3 = dynamic_ring_buff + 20;
    if(pack_per_min >= 400)
    {
        ctr3 = 36;
    }
    else if(pack_per_min >= 300)
    {
        ctr3 = ctr3 - 10;
    }



    qDebug() << dynamic_ring_buff << "RINGGGmtrsmin";
    ch_counter = 4;
    j = 0;
    for(i=ch_counter;i>0;i-- )
    {
        value1 = ctr3 % 10;
        value2[i] = value1;
        ctr3 = ctr3 / 10;

        j++;

    }
    bcd2 = value1;
    bcd2 = bcd2 << 4;
    for(i = 2;i <= j;i++)
    {

        bcd1 = value2[i];
        bcd2 = bcd2 | bcd1;
        bcd2 = bcd2 << 4;

    }
    bcd2 = bcd2 >> 4;


    ch_temp_val = bcd2;
    ch_temp_val = ch_temp_val & 0x0f;
    ch_temp_val = ch_temp_val + 0x30;
    qDebug() <<  ch_temp_val;
    bcd1 = 0x52 ^ ch_temp_val;


    Loadcells_Commands[44][5] = ch_temp_val;
    qDebug() <<  Loadcells_Commands[44][5];
    bcd2 = bcd2 >> 4;

    ch_temp_val = bcd2;
    ch_temp_val = ch_temp_val & 0x0f;
    ch_temp_val = ch_temp_val + 0x30;
    qDebug() <<  ch_temp_val;
    bcd1 = bcd1 ^ ch_temp_val;



    Loadcells_Commands[44][4] = ch_temp_val;
    qDebug() <<  Loadcells_Commands[44][4];
    bcd2 = bcd2 >> 4;

    ch_temp_val = bcd2;
    ch_temp_val = ch_temp_val & 0x0f;
    ch_temp_val = ch_temp_val + 0x30;
    qDebug() <<  ch_temp_val;
    bcd1 = bcd1 ^ ch_temp_val;



    Loadcells_Commands[44][3] = ch_temp_val;
    qDebug() <<  Loadcells_Commands[44][3];
    bcd2 = bcd2 >> 4;


    ch_temp_val = bcd2;
    ch_temp_val = ch_temp_val & 0x0f;
    ch_temp_val = ch_temp_val + 0x30;
    qDebug() <<  ch_temp_val;
    bcd1 = bcd1 ^ ch_temp_val;
    bcd1 = bcd1 ^ 0x03;




    Loadcells_Commands[44][2] = ch_temp_val;
    qDebug() <<  Loadcells_Commands[44][2];

    Loadcells_Commands[44][7] = bcd1;
    qDebug() <<  Loadcells_Commands[44][7];
    //    qDebug() <<  bcd1;

}

void loadcellcalls::CRC_16(char* buff,int len)
{
    unsigned int crc = 0xFFFF;
    unsigned char crc_lo,crc_hi;
    QByteArray ddd;


    for(int pos = 0; pos < len; pos++)
    {
        crc ^= (unsigned char )buff[pos];
        loadcell_txbuff[pos] = (unsigned char )buff[pos];
        for(int i = 8; i != 0;i--)
        {

            if((crc & 0x0001) != 0)
            {
                crc >>= 1;
                crc ^= 0xA001;
            }
            else
            {
                crc >>= 1;
            }
        }

    }


    crc_lo = crc;// & 0x00ff;
    crc_hi = crc >> 8;

    crc_hi = crc_hi & 0x00ff;

    loadcell_txbuff[len + 0] = crc_lo;
    loadcell_txbuff[len + 1] = crc_hi;

    buff[len + 0] = crc_lo;
    buff[len + 1] = crc_hi;


    qDebug() << loadcell_txbuff[1];
    qDebug() << buff[1];

    qDebug() << (crc);
    qDebug() << (crc_hi);
    qDebug() << (crc_lo);




}
void loadcellcalls::stats_page()
{

    QString min_dataval,max_dataval,avg_accpwt_dataval;


    stats_fptr = fopen("codebind.txt","w");

    qDebug() << "STATS PAGE..........";


    tot_count = uw_count + ow_count + accp_count;


    rej_percent = (uw_count + ow_count);

    if(rej_percent != 0)
    {
        rej_percent = (float)rej_percent / tot_count;
        rej_percent = rej_percent * 100;

    }
    else
    {
        rej_percent = 0;

    }



    //max_wt = 12345;

    temp_maxwt = (float)max_wt / 100;

    max_dataval =  QString::number(temp_maxwt,'f',2);


    qDebug() << temp_maxwt;
    qDebug() << bin_val;

    //min_wt = 87965;
    temp_minwt = (float)min_wt / 100;
    min_dataval =  QString::number(temp_minwt,'f',2);


    qDebug() << min_wt;
    qDebug() << bin_val;


    //avg_accp_bin = 56787;
    avg_accp_wt = avg_accp_bin / accp_count;
    avg_accp_wt = avg_accp_wt / 100;

    avg_accpwt_dataval =  QString::number(avg_accp_wt,'f',2);



    qDebug() << avg_accp_wt;







    // fwrite(&input1,sizeof(struct person),1,fptr);

    fclose(stats_fptr);



    //    if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    //    {
    //        qDebug() << "Failed to create";
    //    }
    //     QTextStream in(&stats_file);

    //    in << prodACCPCOUNT << accp_count;
    //    in << prodUNDERCOUNT << uw_count;
    //    in << prodOWERCOUNT << ow_count;
    //    in << prodTOTALCOUNT << tot_count;
    //    in << prodTOTALREJ << rej_percent << " %";
    //    in << prodMAXWT << max_dataval << " g";
    //    in << prodMINWT << min_dataval << " g";
    //    in << prodAVGWT << avg_accpwt_dataval << " g   ";


    ////    QTextStream out(&stats_file);

    ////    out >> prodACCPCOUNT >> accp_count;

    //    stats_file.close();


}

void loadcellcalls::read_stats_page()
{

    QStringList strList;

    strList<<"UNDERWEIGHT COUNT #"+stats_param[1];
    //  strList<<stats_param[1];
    strList<<"ACCEPT COUNT #"+stats_param[2];
    //  strList<<stats_param[2];
    strList<<"OVERWEIGHT COUNT#"+stats_param[3];
    //   strList<<stats_param[3];
    strList<<"TOTAL COUNT #"+stats_param[4];
    //  strList<<stats_param[4];
    strList<<"STANDARD DEVIATION #"+stats_param[5];
    //  strList<<stats_param[5];
    strList<<"MINIMUM WEIGHT #"+stats_param[7];
    //  strList<<stats_param[7];
    strList<<"MAXIMUM WEIGHT#"+stats_param[8];
    //  strList<<stats_param[8];
    strList<<"AVERAGE ACCEPT WEIGHT #"+batch_avgaccp_wt;//stats_param[12];
    //   strList<<stats_param[12];
    emit handlestats_data(strList);



}



loadcellcalls::~loadcellcalls()
{
    wiringPiI2CWriteReg16(i2cdev,0,0);
    wiringPiI2CWriteReg8(i2coutputdev,0x12,0);
    digitalWrite(wpGPIO_OUT_PIN11, 0);
    qDebug() << "destructor called";

    delay(100);


    // system("shutdown -h now");
}

//------------------------------------------------------------------------------------



void loadcellcalls::slot_view_batch_report()
{
    emit view_batch_report();

}

void loadcellcalls::slot_view_audit_report()
{
    emit view_audit_report();

}
void loadcellcalls::slot_view_alaram_report()
{
    emit view_alaram_report();

}



void loadcellcalls::power_onslot()
{


    //    uw_count = stats_param[1].toInt();
    //    accp_count = stats_param[2].toInt();
    //    ow_count = stats_param[3].toInt();
    //    batch_tot_cnt = stats_param[4];
    //    batch_accp_cnt = stats_param[2];
    //    batch_ow_cnt = stats_param[3];
    //    batch_uw_cnt = stats_param[1];

    emit online_okcounts(accp_count,stats_param[5],0,uw_count,ow_count);
    //    emit online_uwcounts(uw_count);
    //    emit online_owcounts(ow_count);


    if(CW1200fg)
    {
        datavalstn1 =  QString::number(0,'f',1);

    }
    else
    {
        datavalstn1 =  QString::number(0,'f',2);
    }
    emit wt_string(datavalstn1);

    //dataval =  QString::number(lcd,'f',2);

    //emit wt_string(dataval);

    emit handle_logouttime(ONOFF_param[2]);

}



void loadcellcalls::rtc_data(QVariantList rtc_adata,qint8)
{

    bool ok;
    QByteArray temp_arr[6];
    QString set_datetime,set_alaram_dttm;


    qDebug() << rtc_adata[0];
    qDebug() << rtc_adata[1];
    qDebug() << rtc_adata[2];
    qDebug() << rtc_adata[3];
    qDebug() << rtc_adata[4];
    qDebug() << rtc_adata[5];

    if(rtc_adata[2] >= "20")
    {

    }
    else
    {
        rtc_adata[2] = "20";
    }

    temp_arr[0] = rtc_adata[0].toByteArray();
    qDebug() << temp_arr[0] << "dsdadsadsadsa45";
    rtc_day = temp_arr[0].toInt(&ok,16);
    temp_arr[1] = rtc_adata[1].toByteArray();
    rtc_month = temp_arr[1].toInt(&ok,16);
    temp_arr[2] = rtc_adata[2].toByteArray();
    rtc_year = temp_arr[2].toInt(&ok,16);

    temp_arr[3] = rtc_adata[3].toByteArray();
    rtc_hour = temp_arr[3].toInt(&ok,16);
    temp_arr[4] = rtc_adata[4].toByteArray();
    rtc_min = temp_arr[4].toInt(&ok,16);
    temp_arr[5] = rtc_adata[5].toByteArray();
    rtc_sec = temp_arr[5].toInt(&ok,16);


    if(temp_arr[0]!="" && temp_arr[1]!="" && temp_arr[2]!="" && temp_arr[3]!="" && temp_arr[4]!="" && temp_arr[5]!="")
    {
        if(temp_arr[0] > "31" || temp_arr[1] > "12" || temp_arr[3] > "23" || temp_arr[4] > "59" || temp_arr[5] > "59")
        {
            qDebug() << "RTC NOT ALLOWED" << temp_arr[3];
            handleRtcmessage(2);

        }
        else
        {
            RTC_read_timer->stop();


            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,2,rtc_sec);
            qDebug() << i2cdata << "RTC";
            delay(500);

            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,3,rtc_min);
            qDebug() << i2cdata << "RTC";
            delay(500);

            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,4,rtc_hour);
            qDebug() << i2cdata << "RTC";
            delay(500);

            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,5,rtc_day);
            qDebug() << i2cdata << "RTC";
            delay(500);

            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,7,rtc_month);
            qDebug() << i2cdata << "RTC";
            delay(500);

            i2cdata = wiringPiI2CWriteReg8(i2crtcdev,8,rtc_year);
            qDebug() << i2cdata << "RTC";
            delay(500);

            set_datetime = temp_arr[0]; //
            set_datetime = set_datetime.append("/");
            set_datetime = set_datetime.append(temp_arr[1]);//global_datetime.append(dataval1.setNum(rtc_month,16));
            set_datetime = set_datetime.append("/");
            set_datetime = set_datetime.append(dataval1.setNum(rtc_year,16));
            set_datetime = set_datetime.append("  ");
            set_alaram_dttm = temp_arr[3];//dataval1.setNum(rtc_hour,16);//
            set_alaram_dttm = set_alaram_dttm.append(":");
            set_alaram_dttm = set_alaram_dttm.append(temp_arr[4]);//
            set_alaram_dttm = set_alaram_dttm.append(":");
            set_alaram_dttm = set_alaram_dttm.append(temp_arr[5]);//
            set_datetime = set_datetime.append(set_alaram_dttm);


            alarm_msg = "RTC CHANGED";
            signal_handleloadcell(global_datetime,alarm_msg,global_datetime,set_datetime,userid);
            poweron_nwdate_syncfg = 1;

            RTC_read_timer->start(1000);
        }

    }
    else
    {
        handleRtcmessage(1);
    }



}

void loadcellcalls::err_reset()
{

    qDebug() << "I got reset";

    if(calib_switcherrfg)
    {
        calib_switcherrfg = 0;
        handleCalib_sts(180);

    }

    if(airprs_err)
    {
        handleerror_sts(140);
    }

    emit handleerror_sts(0);

    if(calib_step1)
    {
        calib_step1_1 = 1;
        calib_step1 = 0;

    }

    if(calib_step2_2)
    {
        calib_step2_2 = 0;

        handleCalib_sts(4);

        task1fg = 1;
        task1ctr = 500;


    }
    if(calib_step3_3)
    {
        calib_step3_3 = 0;
        emit end_calib_process("Hello");
        emit setzerostart();

    }

    if(calib_errstepfg)
    {
        calib_errstepfg = 0;

        if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
        {
            loadsteps = 40;
            task1fg = 1;
            task1ctr = 400;
        }

        if(config_param.CW_600HSA || config_param.CW_100HSA || config_param.CW_3000HSA || config_param.CW_1200HSA)
        {
            calib_step3 = 1;
        }
    }
    MLO_status_12 = MLO_status_12 & BUZZER_OFF;
    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);





    if(poweron_setzero)
    {
        handleConv_sts(0);

    }


}

void loadcellcalls::dynamic_calc_call()
{

    QString temm;

    if(conv_onfg & !nlfg)
    {

        qDebug() << val;
        qDebug() << bin_val;

        if(conv_onfg & dcompfg)
        {

            if(dcomp_ctr >= 20)
            {
                dcomp_ctr = 0;
                qDebug() << dcomp_factor;
                emit dcomp_fact(dcomp_factor);
                dcompfg = 0;
                conv_onfg = 0;
                handleConv_sts(conv_onfg);

                temm = QString::number(dcomp_onfg);
                emit save_dcomp_fact(temm,dcomp_dataval1);

                MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                digitalWrite(wpGPIO_OUT_PIN11, 0);

            }
            emit wt_string(datavalstn1);

        }


        if((config_param.CW_1200 || config_param.CW_3K) || config_param.CW_3000HSA || config_param.CW_6K || config_param.CW_1200HSA)
        {
            val = (float)bin_val / 10;

        }
        if(config_param.CW_600HSA)
        {
            val = (float)bin_val / 100;

        }


        if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_3000HSA || config_param.CW_6K || config_param.CW_1200HSA)
        {
            datavalstn1 =  QString::number(val,'f',1);

        }
        if(config_param.CW_600HSA)
        {
            datavalstn1 =  QString::number(val,'f',2);

        }

        if(conv_onfg & !dcompfg)
        {



            if(bin_val > OW_ERR)
            {
                val = 0;
                datavalstn1 = "0.0";
                handleerror_sts(12);
                reset_err12fg = 1;

                alarm_msg = "ERR-12 OW ERROR";
                alarm_msg_sql_logfg = 1;

            }
            else if(reset_err12fg)
            {
                reset_err12fg = 0;
                handleerror_sts(120);

                alarm_msg = "ERR-12 OW ERROR -- AUTO / MANUAL RESET";
                alarm_msg_sql_logfg = 1;

            }

            if(colour_sts == 1)
            {
                dynamicwt_sts(1);

            }
            else if(colour_sts == 2)
            {
                dynamicwt_sts(2);


            }
            else if(colour_sts == 3)
            {
                dynamicwt_sts(3);


            }
            emit wt_dynamicstring(datavalstn1,accp_count,str_std_devresult,str_avg_accp_wt,uw_count,ow_count);
          //  emit online_okcounts(accp_count,str_std_devresult,str_avg_accp_wt,uw_count,ow_count);//TODO
//            qmlDynamic_val.clear();
//            qmlDynamic_val<<uw_count<<ow_count<<accp_count<<str_std_devresult<<str_avg_accp_wt;//<<colour_sts;
//            emit handleDynamicWt_val(qmlDynamic_val);

        }

        bin_val = 0;

    }
}

void loadcellcalls::output_diagnosst(unsigned int status)
{
    qDebug() << "I got the CALL" << status;


    if(status == 1)
    {
        MLO_status_12 = MLO_status_12 | UW_ON;
        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
        handlediagnos_sts(11);
    }
    if(status == 10)
    {
        MLO_status_12 = MLO_status_12 & UW_OFF;
        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
        handlediagnos_sts(110);
    }
    if(status == 2)
    {
        MLO_status_13 = MLO_status_13 | ACCP_ON;
        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
        handlediagnos_sts(12);

    }
    if(status == 20)
    {
        MLO_status_13 = MLO_status_13 & ACCP_OFF;
        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
        handlediagnos_sts(120);

    }
    if(status == 3)
    {
        MLO_status_13 = MLO_status_13 | OW_ON;
        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
        handlediagnos_sts(13);
    }
    if(status == 30)
    {
        MLO_status_13 = MLO_status_13 & OW_OFF;
        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
        handlediagnos_sts(130);

    }
    //    if(status == 4)
    //    {
    //        digitalWrite(wpGPIO_OUT_PIN11, 1);

    //    }
    //    if(status == 40)
    //    {
    //        digitalWrite(wpGPIO_OUT_PIN11, 0);
    //    }


}










