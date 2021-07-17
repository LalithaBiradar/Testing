#include "teplcwtestservice.h"
#include <QDebug>
#include<wiringPi.h>
#include<wiringPiI2C.h>
#include"union.h"
#include "loadcellcalls.h"
#include <QtMath>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>

#define ACCP_ON 0x80
#define ACCP_OFF 0x7f
#define UW_ON 0x01
#define UW_OFF 0xFE
#define OW_ON 0x40
#define OW_OFF 0xBF
#define BUZZER_ON 0x40
#define BUZZER_OFF 0xBF
#define CONV_ON 0x80
#define CONV_OFF 0x7f
#define FLOAT_OP8_ON 0x10
#define FLOAT_OP8_OFF 0xEF

extern IPDATA i2cipdata;

void isr_f_S1(void);
void isr_f_S2(void);
void heartbit_f();
void trigger_table_sql();
void addDynamicwt_sql(QString date_time,QString dynwt, QString status);
unsigned int bin_bcd(unsigned char, unsigned int);
unsigned int digit(unsigned int);
unsigned int bincon(unsigned int);
void get_avg_xbar(void);
unsigned char event_med_lat_ctr;
bool alarm_msg_sql_logfg;

extern void bin_dynamic_calculation();
extern loadcellcalls* isrIndicatorGpio;
extern void update_counts_sql();

constexpr int wpGPIO_IN_PIN16_SENSOR1     = 4;
constexpr int wpGPIO_IN_PIN18_SENSOR2     = 5;
constexpr int wpGPIO_OUT_PIN29            = 21;
constexpr int wpGPIO_OUT_PIN11            = 0;
constexpr int wpGPIO_OUT_PIN13            = 2;
constexpr int wpGPIO_IN_PIN12_heartbit    = 1;

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
extern struct flag_declaration config_param;

extern bool conv_onfg,debounce2fg,debounce1fg,cw_bypassfg;
extern bool nlfg,zr_calc_connectfg,ch_exitdlyfg,accept_zrfg;
extern bool md_errfg,logmd_errfg,chkmderrfg,hmi_mderrfg;
extern bool err1fg,mdwdfg,disp_err29fg,disp_err2fg,disp_err7fg;
extern bool sensor2fg,err_s2dlyfg,airprsfg,scaime_triggerfg;
extern bool reset_err1fg,reset_err2fg,reset_err7fg,s2dlyfg;
extern bool err7_auditfglogfg,sensor1fg,err2_auditfglogfg;
extern bool disp_err1fg,err2_rst_fg,reset_err29fg;

extern unsigned int debounce_count1,debounce_count2,scaime_trigger_count,debounce_dly;
extern unsigned int debounce_ctr2,debounce_ctr1,pack_debounce_dly,exit_dly,in_sped_ctr;
extern unsigned int mdwd_ctr,auto_rst_err2_ctr,md_hold_delay;
extern unsigned char err_ctr;

//------------------------------------------
extern bool rejvfg,hldfg,heart_tnmsfg,mdrejvfg;
extern bool rc_sensorfg,s2_failfg,rc_shiftfg3,mdhldfg;
extern bool zr_val_avug,sendzrcommandfg,mdregvfg,shifteventfg;
extern bool rc_shiftfg2,rc_shiftfg1,debounce3fg,calcovrfg;
extern bool err1_auditfglogfg,sendcommandfg,recvfg,setzero_screenfg;
extern bool ow_shiftfg,uw_shiftfg,dcompfg,display_error17fg;
extern bool resetstzero_screenfg,task1fg,staticnsetz_taskfg;
extern bool in_spd_fg,display_guageval,comparefg;
extern bool UWdynamic_sql_logfg,OKdynamic_sql_logfg,OWdynamic_sql_logfg;
extern bool dcomp_onfg;
extern float x_fact,positive_dcompfg;
extern bool display_error14fg,display_error15fg,display_error16fg;
extern bool display_error20fg,display_error22fg,display_error23fg;
extern bool display_error26fg,display_error27fg,display_error30fg;
extern bool display_error19fg,display_error1fg,display_error2fg;
extern bool display_error7fg;

extern bool estop_err,dynamic_cyclefg,airprs_err,dooropenchk_err;
extern bool binfullfg,dooropenchk,Qjamfg,coveropenchk,Qjam_relfg;
extern unsigned char air_prsctr,binfull_ctr,estop_ctr,rvbinfull_ctr;
extern unsigned char Qjam_ctr,Qjam_relctr;
extern unsigned int dooropendbn_ctr,coveropendbn_ctr;
extern unsigned int s2fail_ctr,s2fail_time;

extern unsigned int temp_binval;
extern unsigned int rc_shift_time1,rc_shift_ctr1;
extern unsigned int rc_shift_time2,rc_shift_ctr2;
extern unsigned int rc_shift_time3,rc_shift_ctr3;
extern unsigned int MLO_status_12;
extern unsigned int MLO_status_13,avg_buff;



extern unsigned char mdrejv_ctr,nl_ctr;
extern unsigned char shift_ms_count,shift_ms_ctr,avg_count;
extern int i2cdev,i2cdata,i2crtcdev,i2coutputdev;
extern int i2creg,i2cinputdev;
extern unsigned int in_sped_ctr,min1_dly_ctr,show_sped_ctr;

extern unsigned char shift_buff[110],shift_data_old,shift_data_new1;
extern unsigned char shift_ctr,rejv_ctr,nl_count,dcomp_ctr;
extern unsigned char cont_reg_ctr,cont_rej_count;
extern unsigned char rc_sts1,rc_sts2,rc_sts3,temp_loop;
extern unsigned char S2_DLY_TIME,md_dbn_ctr,rdi2cbyte;
extern unsigned char s2_dly_ctr,recv_counter,rc_counter,avg_stk_ctr;

extern unsigned int cpp_prd_speed,staticnsetz_taskctr;
extern unsigned int cpp_opr_delay,s1_count,z_time;
extern unsigned int cpp_hold_delay,task1ctr,start_delay;
extern unsigned int cpp_rej_cnt,cpp_md_opdly,temp_buffer;
extern unsigned int scan_hold_delay,conterr1_ctr;
extern unsigned int opr_delay,hold_delay,debounce_count3;
extern unsigned int bin_val,bin_ref,rx_counter,setzero_screenctr;
extern unsigned int zr_buff[7];
extern unsigned int mdhold_delayctr,ref,dcomp_bin;
extern unsigned int colour_sts,avg_bin,std_dev_buffer;
extern unsigned int uw_count,ow_count,accp_count;
extern unsigned int tot_count,avg_accp_bin;
extern unsigned int avg[10];

extern float max_wt,min_wt,sndval;
extern float cpp_prd_tare,val,cpp_prd_target;
extern float upper_limit,lower_limit,dev_result;

extern QString datavalstn1,dcomp_factor,dcomp_dataval1,batch_ow_cnt;
extern QString dataval1,str_avg_accp_wt,prdresult,batch_tot_cnt;
extern QString batch_accp_cnt,batch_uw_cnt,batch_avgaccp_wt;
extern QString prdwt,str_std_devresult;
extern QString var1;// = "Dynamic";

extern QString stats_param[14];
extern QString global_datetime,userid,var3;

//----------------------------------------------
extern QString alarm_msg;
extern QString config_parameter[11];

teplcwtestservice testservice;
teplcwtestservice::teplcwtestservice(QObject *parent) : QObject(parent)
{

}


void teplcwtestservice::startService()
{
   qDebug() << "teplcwtestthread service TID" << QThread::currentThreadId();
   qDebug()<<"Thread start--";
   wiringPiISR(wpGPIO_IN_PIN16_SENSOR1,INT_EDGE_FALLING,&isr_f_S1);
   wiringPiISR(wpGPIO_IN_PIN18_SENSOR2,INT_EDGE_FALLING,&isr_f_S2);
   wiringPiISR(wpGPIO_IN_PIN12_heartbit,INT_EDGE_FALLING,&heartbit_f);


   mupMedLatPollTimer = std::make_unique<QTimer>(this);
   connect(mupMedLatPollTimer.get(),SIGNAL(timeout()),this,SLOT(medLatPoll()));
   mupMedLatPollTimer->start(50);

   mupSqlLogTimer = std::make_unique<QTimer>(this);
   connect(mupSqlLogTimer.get(),SIGNAL(timeout()),this,SLOT(sqleventPoll()));
   mupSqlLogTimer->start(90);

   connect(&testservice,  SIGNAL(sqllog()),
           this,          SLOT(sqllogdata()));

}

void teplcwtestservice::medLatPoll()
{

    event_mediumlatinput_checked();
    event_softpolling_checked();


}

void teplcwtestservice::sqllogdata()
{
    if(OWdynamic_sql_logfg)
    {
        OWdynamic_sql_logfg = 0;
        update_counts_sql();
        addDynamicwt_sql(global_datetime,prdwt,"OW");
        trigger_table_sql();



    }

    if(UWdynamic_sql_logfg)
    {

        UWdynamic_sql_logfg = 0;
        update_counts_sql();
        addDynamicwt_sql(global_datetime,prdwt,"UW");
        trigger_table_sql();



    }
    if(OKdynamic_sql_logfg)
    {

        OKdynamic_sql_logfg = 0;
        update_counts_sql();
        addDynamicwt_sql(global_datetime,prdwt,"OK");
        trigger_table_sql();





    }


}


void teplcwtestservice::sqleventPoll()
{

    if(alarm_msg_sql_logfg)
    {
        alarm_msg_sql_logfg = 0;
        addAlaramdata(global_datetime,alarm_msg,userid);

    }

}

//---------------------------------------------------------------------------
void isr_f_S1(void)
{


    if(conv_onfg & (!debounce1fg) & (!digitalRead(wpGPIO_IN_PIN16_SENSOR1)) & (!cw_bypassfg))
    {
        if(nlfg & zr_calc_connectfg)
        {
            zr_calc_connectfg = 0;

        }
        zr_calc_connectfg = 0;

        nlfg = 0;
        ch_exitdlyfg = 0;
        exit_dly = 0;
        accept_zrfg = 0;
        in_sped_ctr++;


        if(md_errfg)
        {

            logmd_errfg = 1;
            mdwdfg = 0;
            mdwd_ctr = 0;
            err1fg = 1;
            chkmderrfg = 0;
             hmi_mderrfg = 1;
             disp_err29fg = 1;
        }


        if(err_ctr > 0)
        {
            err_ctr++;
            err1fg = 1;


            err2_auditfglogfg = 1;

            display_error2fg = 1;
            alarm_msg = "ERR-02 REDUCE INPUT SPEED OF THE PRODUCT";
            alarm_msg_sql_logfg = 1;

            err2_rst_fg = 1;
            disp_err2fg = 1;
            auto_rst_err2_ctr = 0;
            md_errfg = 0;

        }
        else if(!md_errfg)
        {
            err_ctr++;
            err1fg = 0;
            err2_rst_fg = 0;

            hmi_mderrfg = 0;
            logmd_errfg = 0;

            err1fg = 0;
            if(disp_err2fg)
            {
                disp_err2fg = 0;
                reset_err2fg = 1;

            }
            if(disp_err7fg)
            {
                disp_err7fg = 0;
                reset_err7fg = 1;

            }
            if(disp_err1fg)
            {
                disp_err1fg = 0;
                reset_err1fg = 1;

            }
            if(disp_err29fg)
            {
                disp_err29fg = 0;
                reset_err29fg = 1;

            }

        }
        else if(md_errfg)
        {
            md_errfg = 0;
            err_ctr++;
           // err1fg = 0;

        }
        else
        {
            err_ctr++;
            err1fg = 0;
            err2_rst_fg = 0;
            if(disp_err2fg)
            {
                disp_err2fg = 0;
                reset_err2fg = 1;

            }
            if(disp_err7fg)
            {
                disp_err7fg = 0;
                reset_err7fg = 1;

            }
            if(disp_err1fg)
            {
                disp_err1fg = 0;
                reset_err1fg = 1;

            }



        }
       // command_timectr = 0;
        debounce1fg = 1;
        debounce_count1 = pack_debounce_dly;
        debounce_ctr1 = 0;
        sensor1fg = 1;
        if(config_parameter[0] != "CW3000HSA")
        {
            scaime_trigger_count = 0;
            scaime_triggerfg = 1;
            digitalWrite(wpGPIO_OUT_PIN29, 0);
        }
        //qDebug() << "I M In SENSOR1 ISR -- step-1";

    }



}

void isr_f_S2()
{

    if(conv_onfg & (!debounce2fg) & (!digitalRead(wpGPIO_IN_PIN18_SENSOR2)) & (!cw_bypassfg))
    {
        debounce2fg = 1;
        debounce_count2 = pack_debounce_dly;
        debounce_ctr2 = 0;
        sensor2fg = 1;
        s2dlyfg = 1;
        err_s2dlyfg = 1;
        airprsfg = 1;
        //qDebug() << "I M In SENSOR2 ISR - STEP 2";

        if(err_ctr == 0)
        {

                    err1fg = 1;
                    err7_auditfglogfg = 1;
                    disp_err7fg = 1;
                    logmd_errfg = 0;
                    display_error7fg = 1;
                    alarm_msg = "ERR-07 SENSOR1 NOT SENSED OR SENSOR2 DOUBLE SENSED";
                    alarm_msg_sql_logfg = 1;





        }
        else
        {
            err_ctr--;
        }

    }


}


//-----------------------------------------------------------------------

void heartbit_f()
{
    if((!digitalRead(wpGPIO_IN_PIN12_heartbit)))
    {
        heart_tnmsfg = !heart_tnmsfg;
        if(conv_onfg && ((config_param.CW_1200HSA == 1) || ((config_param.CW_600HSA == 1))  || ((config_param.CW_3000HSA==1)) || (config_param.CW_6K == 1) || (config_param.CW_1200) || (config_param.CW_3K)))
        {
            shift_ms_ctr++;
            if(shift_ms_ctr >= shift_ms_count)
            {

                shift_ms_ctr = 0;
                shifteventfg = 0;
                shift_data_new1 = 0;
                shift_data_old = shift_buff[0];
                for(shift_ctr = 0;shift_ctr < 90 + 4;shift_ctr++)			//80
                {

                    shift_buff[shift_ctr] = shift_data_new1;
                    shift_data_new1 = shift_data_old;
                    shift_data_old = shift_buff[shift_ctr + 1];
                }

                if(shift_buff[cpp_opr_delay] == 1)
                {
                    hldfg = 1;
                    shift_buff[cpp_opr_delay] = 0;
                    rejvfg = 1;
                    rejv_ctr = 0;
                    airprsfg = 0;
                    digitalWrite(wpGPIO_OUT_PIN11, 1);//TODO

                    MLO_status_12 = MLO_status_12 | UW_ON | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                    cont_reg_ctr++;


                }
                else if(shift_buff[cpp_opr_delay] == 2)
                {
                    hldfg = 1;
                    shift_buff[cpp_opr_delay] = 0;
                    airprsfg = 0;
                    MLO_status_13 = MLO_status_13 | ACCP_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

                    cont_reg_ctr = 0;


                }
                else if(shift_buff[cpp_opr_delay] == 3)
                {
                    hldfg = 1;
                    shift_buff[cpp_opr_delay] = 0;
                    rejvfg = 1;
                    rejv_ctr = 0;
                    airprsfg = 0;
                    MLO_status_13 = MLO_status_13 | OW_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                    digitalWrite(wpGPIO_OUT_PIN11, 1);//TODO
                    cont_reg_ctr++;
                }

                if(shift_buff[cpp_md_opdly] == 4)
                {
                    mdhldfg = 1;
                    shift_buff[cpp_md_opdly] = 0;
                    mdregvfg = 1;
                    mdrejv_ctr = 0;
                    airprsfg = 0;
                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    digitalWrite(wpGPIO_OUT_PIN13, 1);//TODO
                    cont_reg_ctr++;

                }

            }

        }

        //====================================================================================
        if(debounce1fg && (debounce_ctr1 >= debounce_count1))
        {
            debounce1fg = 0;

        }
        else if(debounce1fg)
        {

            debounce_ctr1++;

        }

        if(debounce2fg && (debounce_ctr2 >= debounce_count2))
        {
            debounce2fg = 0;

        }
        else if(debounce2fg)
        {

            debounce_ctr2++;
        }

        //====================================================================================

        if(sensor1fg && ((!debounce1fg) | config_param.CW_1200 | config_param.CW_3K | config_param.CW_6K))
        {
            s1_count++;
            if(s1_count >= (start_delay))
            {
                sensor1fg = 0;
                s1_count = 0;
                recv_counter = 0;
                calcovrfg = 0;
                sendcommandfg = 1;
            }

        }

        //====================================================================================



        if(s2dlyfg)
        {
            s2_dly_ctr++;

            if(s2_dly_ctr >= S2_DLY_TIME)//15
            {
                s2_dly_ctr = 0;
                s2dlyfg = 0;

                if(!recvfg & !err1fg & conv_onfg)
                {
                    err1fg = 1;

                    display_error1fg = 1;
                    alarm_msg = "ERROR-01 REDUCE THE SPEED OF CONVEYOR";
                    alarm_msg_sql_logfg = 1;

                    conterr1_ctr++;
                    if(conterr1_ctr >= 2)
                    {
                        err1_auditfglogfg = 0;
                        disp_err1fg = 0;

                    }



                }

                if(!calcovrfg & !err1fg)
                {
                    calcovrfg = 1;
                    conterr1_ctr = 0;
                    qDebug() << "I m in STEP -3";
                    bin_dynamic_calculation();

                    isrIndicatorGpio->signal2dynamic(); // temprory hide for cause of ERROR1

                    recvfg = 0;
                    if(uw_shiftfg == 1)
                    {
                        uw_shiftfg = 0;
                        shift_buff[0] = 1;

                    }
                    if(ow_shiftfg == 1)
                    {
                        ow_shiftfg = 0;
                        shift_buff[0] = 3;

                    }



                }



                if(logmd_errfg)
                {
                    shift_buff[0] = 4;
                    err_s2dlyfg = 0;
                    md_hold_delay = cpp_hold_delay + 4;
                    // qDebug() << "MD OPERATE START";

                }
                else if(err1fg)  //else if(err1fg & err_s2dlyfg)
                {
                    err_s2dlyfg = 0;
                    shift_buff[0] = 3;
                    scan_hold_delay = cpp_hold_delay + 4;
                    //  calcovrfg = 1;

                    qDebug() << "ERRRRRRRRR......................";


                }
                else
                {
                    scan_hold_delay = cpp_hold_delay;
                    md_hold_delay = cpp_hold_delay;
                }

                if(!rc_shiftfg1)
                {
                    rc_shiftfg1 = 1;
                    rc_shift_ctr1 = 0;

                }

            }


        }

        //====================================================================================

        if(conv_onfg & !debounce3fg)
        {


            if(rc_sensorfg)
            {
                rc_counter = 0;
                if(!(i2cipdata.SBIT.ipcwrejc & 0x01))
                {
                    debounce_count3 = (debounce_dly/2);
                    debounce_count3 = debounce_count3 + 10;
                    debounce3fg = 1;

                    if(rc_sensorfg & (!cw_bypassfg) & (!dcompfg))
                    {
                        rc_sensorfg = 0;
                        conv_onfg = 0;
                        display_error17fg = 1;
                        MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                        MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                        digitalWrite(wpGPIO_OUT_PIN11, 0);
                        MLO_status_12 = MLO_status_12 | BUZZER_ON;
                        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                        alarm_msg = "ERR-17 REJECTION CONFIRMATION FAILED";
                        alarm_msg_sql_logfg = 1;

                        qDebug() << "RC SENSORRR";

                    }

                }
            }

        }


        if(rc_shiftfg1)
        {
            rc_shift_ctr1++;
            if(rc_shift_ctr1 >= rc_shift_time1)
            {
                rc_shiftfg1 = 0;
                rc_sts2 = rc_sts1;
                rc_shiftfg2 = 1;
                rc_shift_ctr2 = 0;
                rc_sts1 = 0;
                qDebug() << "STATUS1";

            }

        }

        if(rc_shiftfg2)
        {
            rc_shift_ctr2++;
            if(rc_shift_ctr2 >= rc_shift_time2)
            {
                rc_shiftfg2 = 0;
                rc_sts3 = rc_sts2;
                rc_shiftfg3 = 1;
                rc_shift_ctr3 = 0;
                rc_sts2 = 0;
                qDebug() << "STATUS2";

            }

        }

        if(rc_shiftfg3)
        {
            rc_shift_ctr3++;
            if(rc_shift_ctr3 >= rc_shift_time3)
            {
                rc_shiftfg3 = 0;
                rc_shift_ctr3 = 0;
                if(rc_sts3 == 1)
                {
                    rc_sensorfg = 1;
                }
                else if(rc_sts3 == 2)
                {
                    rc_sensorfg = 0;
                    rc_sts3 = 0;
                    qDebug() << "STATUS3";

                    qDebug() << "GIIIIIIIII";
                    //  rc_sts3 = 1;

                }
                else
                {
                   // rc_sensorfg = 1;

                }

            }

        }

//=========================================

        if(heart_tnmsfg)
        {
            if(s2_failfg)
            {
                digitalWrite(wpGPIO_OUT_PIN11, 0);//TODO
                MLO_status_13 = MLO_status_13 & OW_OFF & ACCP_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
            }

            if(task1fg)
            {
                staticnsetz_taskctr++;
                if(staticnsetz_taskctr >= task1ctr)
                {
                    staticnsetz_taskctr = 0;
                    staticnsetz_taskfg = 1;

                }

            }
            //====================================================================================
            if(setzero_screenfg)
            {
                setzero_screenctr++;
                if(setzero_screenctr >= 1500 && (!conv_onfg))
                {
                    setzero_screenctr = 0;
                    setzero_screenfg = 0;
                    resetstzero_screenfg = 1;
                }
            }

            //====================================================================================

            if(conv_onfg)
            {
                //mdbit = FIO3PIN;
                //if(!((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x20))//hide on 7-1-2020
                if(((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x20))
                {
                    md_dbn_ctr = 0;

                }
                else if((!md_errfg) & ((!debounce1fg | chkmderrfg)))
                {
                    md_dbn_ctr++;
                    if(md_dbn_ctr >= 2)
                    {
                        //  hmi_mderrfg = 1;
                        md_dbn_ctr = 0;
                        md_errfg = 1;
                        mdwdfg = 1;
                        mdwd_ctr = 0;


                    }

                }
                else if(chkmderrfg & !md_errfg)
                {
                    md_dbn_ctr++;
                    if(md_dbn_ctr >= 2)
                    {
                        hmi_mderrfg = 1;
                        md_dbn_ctr = 0;
                        md_errfg = 1;
                        mdwdfg = 1;
                        mdwd_ctr = 0;


                    }

                }
                if(chkmderrfg & md_errfg)
                {

                    hmi_mderrfg = 1;
                    md_dbn_ctr = 0;
                    md_errfg = 0;
                    mdwdfg = 0;
                    mdwd_ctr = 0;
                    logmd_errfg = 1;
                    chkmderrfg = 0;
                    err1fg = 1;


                }

                if(conv_onfg & mdwdfg)
                {
                    mdwd_ctr++;
                    if(mdwd_ctr >= 150)
                    {
                        md_errfg = 0;
                        mdwdfg = 0;
                        mdwd_ctr = 0;
                    }
                }

                min1_dly_ctr++;
                if((min1_dly_ctr >= 1000) & in_spd_fg)
                {

                    x_fact = in_sped_ctr * 6;
                    x_fact = x_fact / 60;

                    if(x_fact == 0)
                    {
                        x_fact = 1;
                    }

                    in_sped_ctr = in_sped_ctr * 6;
                    show_sped_ctr = in_sped_ctr;
                    display_guageval = 1;
                    in_sped_ctr = 0;
                    min1_dly_ctr = 0;
                }

            }

            if(conv_onfg)
            {

                if(!debounce2fg & sensor2fg)
                {


                    if(digitalRead(wpGPIO_IN_PIN18_SENSOR2))
                    {
                        sensor2fg = 0;
                    }
                    if((!sensor1fg & !sensor2fg))// & (ch_err_ctr == 0))
                    {
                        if(digitalRead(wpGPIO_IN_PIN16_SENSOR1))
                        {
                            ch_exitdlyfg = 1;
                            exit_dly = 0;

                        }
                    }

                }
                if(ch_exitdlyfg)
                {
                    exit_dly++;

                    if(digitalRead(wpGPIO_IN_PIN16_SENSOR1))
                    {

                        if((exit_dly >= z_time) & (accept_zrfg & !err1fg))
                        {
                            exit_dly = 0;
                            ch_exitdlyfg = 0;
                            accept_zrfg = 0;
                            nlfg = 1;
                            zr_val_avug = 0;
                            nl_count = 0;
                            sendzrcommandfg = 1;


                        }
                    }
                }


                if(conv_onfg && rejvfg && (config_parameter[9] == "11"))
                {
                    rdi2cbyte = wiringPiI2CReadReg8(i2cinputdev,0x12);
                    i2cipdata.sInput = rdi2cbyte;

                    if(!((i2cipdata.SBIT.ipcwverif & 0x01)))
                    {
                    }
                    else
                    {
                        rejvfg = 0;
                        rejv_ctr = 0;

                    }

                }

                if(conv_onfg && mdregvfg && (config_parameter[9] == "11"))
                {
                    rdi2cbyte = wiringPiI2CReadReg8(i2cinputdev,0x12);
                    i2cipdata.sInput = rdi2cbyte;

                    if(!((i2cipdata.SBIT.ipmdverif & 0x01)))
                    {

                    }
                    else if(mdregvfg)
                    {
                        mdregvfg = 0;
                        mdrejv_ctr = 0;
                    }

                }


                if(conv_onfg & hldfg)
                {
                    hold_delay++;
                    if(hold_delay >= scan_hold_delay)//cpp_hold_delay)
                    {
                        qDebug() << cpp_hold_delay;
                        hold_delay = 0;
                        hldfg = 0;
                        MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                        wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);

                        MLO_status_12 = MLO_status_12 & UW_OFF & BUZZER_OFF;
                        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                        digitalWrite(wpGPIO_OUT_PIN11, 0);
                        //   digitalWrite(wpGPIO_OUT_PIN13, 0);

                    }

                }

                if(conv_onfg & mdhldfg)
                {
                    mdhold_delayctr++;
                    if(mdhold_delayctr >= md_hold_delay)//cpp_hold_delay)
                    {
                        qDebug() << md_hold_delay;
                        mdhold_delayctr = 0;
                        mdhldfg = 0;
                        MLO_status_12 = MLO_status_12 & BUZZER_OFF;
                        wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                        digitalWrite(wpGPIO_OUT_PIN13, 0);

                    }

                }

                //--------------------------------------------------------------------------------------


                if(debounce3fg & (debounce_count3 == 1))
                {
                    debounce3fg = 0;

                }
                else if(debounce3fg)
                {
                    debounce_count3--;
                }


                if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
                {
                    if(scaime_triggerfg)
                    {
                        scaime_trigger_count++;
                        if((scaime_trigger_count >= 3) & scaime_triggerfg)
                        {
                            scaime_trigger_count = 0;
                            scaime_triggerfg = 0;
                            digitalWrite(wpGPIO_OUT_PIN29, 1);

                        }
                    }

                }


                //====================================================================================

                //====================================================================================


                if(conv_onfg & nlfg & !err1fg & (err_ctr == 0) & zr_calc_connectfg)
                {

                    if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K)
                    {

                        ref = 0;
                        zr_calc_connectfg = 0;
                        zr_val_avug = bin_val + zr_val_avug;
                        nl_count++;
                        if(nl_count < 6)
                        {
                            sendzrcommandfg = 1;
                        }
                        else
                        {
                            bin_val = zr_val_avug / 6;

                            if(nl_ctr == 7)
                            {
                                nl_ctr = 0;

                            }
                            qDebug() << bin_val;
                            zr_buff[nl_ctr] = bin_val;
                            for(temp_loop = 0;temp_loop < 7;temp_loop++)
                            {
                                ref = ref + zr_buff[temp_loop];
                            }
                            qDebug() << ref;

                            ref = ref / 7;
                            bin_ref = ref;
                            if(config_param.CW_3K)
                            {
                                bin_val = bin_val & 0xfffe;
                                bin_ref = bin_ref & 0xfffe;
                            }
                            if(config_param.CW_6K)
                            {
                                temp_binval = bin_bcd(5,bin_ref);
                                qDebug() << temp_binval;
                                temp_binval = digit(temp_binval);
                                qDebug() << temp_binval;
                                bin_ref = bincon(temp_binval);
                                // bin_ref = bin_val;//& 0xfffe;
                            }
                            qDebug() << bin_ref;                                   
                            qDebug() << temp_binval << "FINAL ZR";
                            nlfg = 0;
                            nl_ctr++;

                        }

                    }

                    if(config_param.CW_600HSA || config_param.CW_3000HSA || config_param.CW_1200HSA)
                    {
                        ref = 0;
                        zr_calc_connectfg = 0;

                        if(nl_ctr >= 5)
                        {
                            nl_ctr = 0;

                        }
                        qDebug() << bin_val;
                        zr_buff[nl_ctr] = bin_val;
                        for(temp_loop = 0;temp_loop < 5;temp_loop++)
                        {
                            ref = ref + zr_buff[temp_loop];
                        }
                        qDebug() << ref;

                        ref = ref / 5;
                        bin_ref = ref;
                        qDebug() << bin_ref;

                        temp_binval = bin_bcd(5,bin_ref);
                        qDebug() << temp_binval;
                        temp_binval = digit(temp_binval);
                        qDebug() << temp_binval;
                        temp_binval = bincon(temp_binval);
                        qDebug() << temp_binval;

                        bin_ref = temp_binval;

                        if(config_param.CW_3000HSA)
                        {
                            bin_val = bin_val & 0xfffe;
                            bin_ref = bin_ref & 0xfffe;


                        }
                        qDebug() << "I m in ZRRRRRRR -- 5";

                        nlfg = 0;
                        nl_ctr++;

                    }

                }

            }

        }



    }


}


void bin_dynamic_calculation()
{


   // if(conv_onfg & !nlfg)                       //Commented for solving Count miss match by LS on 090721
    if((conv_onfg & !nlfg) & !err1fg)
    {
        calcovrfg = 0;

        if(bin_val < bin_ref)
        {
            bin_val = 0;

        }
        else
        {
            bin_val = bin_val - bin_ref;
            if((bin_val > cpp_prd_tare) & conv_onfg)
            {
                qDebug() << bin_val;

                bin_val = bin_val - cpp_prd_tare;
                qDebug() << bin_val;

            }
            else if(conv_onfg)
            {
                bin_val = 0;

            }
            if(config_param.CW_3K)
            {
                bin_val = bin_val & 0xfffe;


            }


        }

        qDebug() << val;
        qDebug() << bin_val;

        if(conv_onfg & dcompfg)
        {
            dcomp_bin = dcomp_bin + bin_val;
            dcomp_ctr++;
            if(dcomp_ctr >= 20)
            {
               // dcomp_ctr = 0;

                dcomp_bin = dcomp_bin / 20;

                if(config_param.CW_3K || config_param.CW_3000HSA)
                {
                    dcomp_bin = dcomp_bin & 0xfffe;

                }

                if(config_param.CW_6K)
                {



                    dcomp_bin = bin_bcd(5,dcomp_bin);
                    // qDebug() << temp_binval1;
                    dcomp_bin = digit(dcomp_bin);
                    qDebug() << dcomp_bin;
                    dcomp_bin = bincon(dcomp_bin);



                }



                if(cpp_prd_target >= dcomp_bin)
                {
                    dcomp_bin = cpp_prd_target - dcomp_bin;
                    positive_dcompfg = 1;
                    qDebug() << "POSITIVE";
                    dcomp_dataval1 = "0";


                }
                else
                {
                    dcomp_bin = dcomp_bin - cpp_prd_target;
                    positive_dcompfg = 0;
                    qDebug() << "NEG";
                    dcomp_dataval1 = "0";


                }

                qDebug() << "DCOMP BIN" << dcomp_bin;



                if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_6K || config_param.CW_1200HSA || config_param.CW_3000HSA)
                {
                    val = (float)dcomp_bin / 10;
                    dcomp_factor.clear();
                    dcomp_factor =  QString::number(val,'f',1);
                    qDebug() << dcomp_factor << " 1";

                }
                if(config_param.CW_600HSA)
                {

                    temp_binval = bin_bcd(5,dcomp_bin);
                    qDebug() << temp_binval;
                    temp_binval = digit(temp_binval);
                    qDebug() << temp_binval;
                    temp_binval = bincon(temp_binval);
                    qDebug() << temp_binval;

                    dcomp_bin = temp_binval;

                    qDebug() << "DCOMP BIN" << dcomp_bin;

                    val = (float)dcomp_bin / 100;
                    dcomp_factor.clear();
                    dcomp_factor =  QString::number(val,'f',2);
                    qDebug() << dcomp_factor << " 2";

                }
                if(positive_dcompfg)
                {


                    qDebug() << dcomp_factor << " 3";
                    dcomp_factor = "(+)" + dcomp_factor;
                    qDebug() << dcomp_factor;
                    dcomp_dataval1 = QString::number(dcomp_bin);
                    dcomp_dataval1 = "1" + dcomp_dataval1;


                }
                else
                {
                    dcomp_factor = "(-)" + dcomp_factor;
                    qDebug() << dcomp_factor;
                    dcomp_dataval1 = QString::number(dcomp_bin);
                    dcomp_dataval1 = "0" + dcomp_dataval1;


                }

            }

        }
        else if(dcomp_onfg & conv_onfg)
        {
            if(positive_dcompfg)
            {
                bin_val = bin_val + dcomp_bin;
                qDebug() << "POSITIVE D";

            }
            else
            {
                if(bin_val >= dcomp_bin)
                {
                    bin_val = bin_val - dcomp_bin;
                    qDebug() << "NEG D" << dcomp_bin;

                }
                else
                {
                    bin_val = 0;
                }
            }


        }

        if((config_param.CW_1200 || config_param.CW_3K) || config_param.CW_3000HSA || config_param.CW_6K || config_param.CW_1200HSA)
        {
            val = (float)bin_val / 10;
            //  WtRecord.stuff.weight = val;
            sndval = val;

        }
        if(config_param.CW_600HSA)
        {
            val = (float)bin_val / 100;
            sndval = val;
            //   WtRecord.stuff.weight = val;

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

            prdwt = datavalstn1;

            if(bin_val > upper_limit)
            {

                qDebug() << "UPPER LIMIT";
                ow_shiftfg = 1;
                // shift_buff[0] = 3;
                ow_count++;
                accept_zrfg = 0;
                //  WtRecord.stuff.owcount = ow_count;

                rc_sts1 = 1;

                prdresult = "OW";

                batch_ow_cnt =  QString::number(ow_count);
                stats_param[3] = batch_ow_cnt;


                //   dynamicwt_sts(3);
                colour_sts = 3;

                OWdynamic_sql_logfg = 1;







            }
            else if(bin_val < lower_limit)
            {
                qDebug() << "LOWER LIMIT";
                //shift_buff[0] = 1;
                uw_shiftfg = 1;
                uw_count++;
                rc_sts1 = 1;
                accept_zrfg = 0;
                //  WtRecord.stuff.uwcount = uw_count;

                prdresult = "UW";

                batch_uw_cnt =  QString::number(uw_count);
                stats_param[1] = batch_uw_cnt;


                colour_sts = 1;
                UWdynamic_sql_logfg = 1;


            }
            else
            {

                qDebug() << "ACCP LIMIT";
                shift_buff[0] = 2;
                accept_zrfg = 1;
                rc_sts1 = 2;

                accp_count++;
                //  WtRecord.stuff.account = accp_count;

                avg_accp_bin = avg_accp_bin + bin_val;
                avg_buff = avg_accp_bin / accp_count;
                qDebug() << avg_buff << "STDDDDD avg_buff";

                stats_param[6] = QString::number(avg_accp_bin);//avg_accp_bin;
                stats_param[12] = QString::number(avg_buff);//avg_buff;

                get_avg_xbar();


                if(!comparefg)
                {
                    comparefg = 1;
                    max_wt = bin_val;
                    min_wt = bin_val;
                    stats_param[0] = "1";
                }
                else
                {
                    if(max_wt < bin_val)
                    {
                        max_wt = bin_val;
                    }
                    if(min_wt > bin_val)
                    {
                        min_wt = bin_val;
                    }

                }

                if(avg_buff >= bin_val)
                {
                    temp_buffer = avg_buff - bin_val;
                }
                else
                {
                    temp_buffer = bin_val - avg_buff;

                }

                temp_buffer = temp_buffer * temp_buffer;
                qDebug() << temp_buffer << "STDDDDD temp_buffer";

                std_dev_buffer = temp_buffer + std_dev_buffer;
                qDebug() << std_dev_buffer << "STDDDDD std_dev_buffer";
                stats_param[11] = QString::number(std_dev_buffer);



                dev_result = (float)std_dev_buffer / accp_count;
                qDebug() << dev_result << "STDDDDD DEVIATION";


                dev_result = qSqrt(dev_result);
                qDebug() << dev_result << "STDDDDD DEVIATION";

                dev_result = dev_result / 100;
                qDebug() << dev_result << "STDDDDD DEVIATION";


                str_std_devresult =  QString::number(dev_result,'f',3);
                stats_param[5] = str_std_devresult;

                if(config_param.CW_1200 || config_param.CW_3K || config_param.CW_3000HSA || config_param.CW_6K || config_param.CW_1200HSA)
                {

                    val = (float)avg_buff / 10;
                    dataval1 =  QString::number(val,'f',1);
                    batch_avgaccp_wt = dataval1;

                    qDebug() << batch_avgaccp_wt << "AVG CCP WT";



                    val = (float)min_wt / 10;
                    dataval1 =  QString::number(val,'f',1);
                    stats_param[7] = dataval1;

                    val = (float)max_wt / 10;
                    dataval1 =  QString::number(val,'f',1);
                    stats_param[8] = dataval1;


                    val = (float)avg_bin / 10;
                    str_avg_accp_wt =  QString::number(val,'f',1);

                }
                if(config_param.CW_600HSA)
                {

                    val = (float)avg_buff / 100;
                    dataval1 =  QString::number(val,'f',2);
                    batch_avgaccp_wt = dataval1;


                    val = (float)min_wt / 100;
                    dataval1 =  QString::number(val,'f',2);
                    stats_param[7] = dataval1;

                    val = (float)max_wt / 100;
                    dataval1 =  QString::number(val,'f',2);
                    stats_param[8] = dataval1;


                    val = (float)avg_bin / 100;
                    str_avg_accp_wt =  QString::number(val,'f',2);

                }

                stats_param[9] = QString::number(min_wt);//min_wt;
                stats_param[10] = QString::number(max_wt);//max_wt;

                prdresult = "OK";


                batch_accp_cnt =  QString::number(accp_count);
                stats_param[2] = batch_accp_cnt;


                colour_sts = 2;

                OKdynamic_sql_logfg = 1; //need to include






            }

            batch_tot_cnt =  QString::number((accp_count+uw_count+ow_count));
            stats_param[4] = batch_tot_cnt;
            //testservice.sqllog();    //commented to solve count miss match by LS 9/07/21
             testservice.sqllogdata();
          //  write_textfilefg = 1;


            //  WtRecord.stuff.totcount = (accp_count+uw_count+ow_count);
            // T4OPC_WriteTagArray("WeightRecord", WtRecord.record, 1);

//            if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
//            {
//                qDebug() << "Failed to create";
//            }
//            QTextStream in(&stats_file);
//            in << stats_param[0] << "\n";
//            in << stats_param[1] << "\n";
//            in << stats_param[2] << "\n";
//            in << stats_param[3] << "\n";
//            in << stats_param[4] << "\n";
//            in << stats_param[5] << "\n";
//            in << stats_param[6] << "\n";
//            in << stats_param[7] << "\n";
//            in << stats_param[8] << "\n";
//            in << stats_param[9] << "\n";
//            in << stats_param[10] << "\n";
//            in << stats_param[11] << "\n";
//            in << stats_param[12] << "\n";

//            stats_file.close();




        }

    }


}

unsigned int bin_bcd(unsigned char ch_counter, unsigned int ctr3)
{

    unsigned char value2[10],value1,i,j;
    unsigned int bcd1,bcd2;
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
    return bcd2;

}

unsigned int digit(unsigned int t_bcd)
{
    unsigned char ch_acc,ch_b;

    ch_b = 0;
    ch_acc = t_bcd;
    ch_acc = ch_acc & 0x0f;
    if(ch_acc >= 0x05)
    {
        ch_b = 0x05;
    }
    ch_acc = t_bcd;
    t_bcd = t_bcd >> 8;
    t_bcd = t_bcd << 8;
    ch_acc = ch_acc & 0x0f0;
    ch_acc = ch_acc | ch_b;
    t_bcd = ch_acc + t_bcd;

    return t_bcd;

}

unsigned int bincon(unsigned int temp_bcd_buf)
{

    unsigned char ch_temp_val;
    unsigned char ch_val[5];
    unsigned int temp_bin_val;



    ch_temp_val = temp_bcd_buf & 0x0f;
    ch_val[4] = ch_temp_val;
    temp_bcd_buf = temp_bcd_buf >> 4;

    ch_temp_val = temp_bcd_buf & 0x0f;
    ch_val[3] = ch_temp_val;
    temp_bcd_buf = temp_bcd_buf >> 4;

    ch_temp_val = temp_bcd_buf & 0x0f;
    ch_val[2] = ch_temp_val;
    temp_bcd_buf = temp_bcd_buf >> 4;

    ch_temp_val = temp_bcd_buf & 0x0f;
    ch_val[1] = ch_temp_val;
    temp_bcd_buf = temp_bcd_buf >> 4;

    ch_temp_val = temp_bcd_buf & 0x0f;
    ch_val[0] = ch_temp_val;

    temp_bin_val = 0;
    ch_temp_val = ch_val[0];
    temp_bcd_buf = ch_temp_val * 10000;
    temp_bin_val = temp_bin_val + temp_bcd_buf;

    ch_temp_val = ch_val[1];
    temp_bcd_buf = ch_temp_val * 1000;
    temp_bin_val = temp_bin_val + temp_bcd_buf;

    ch_temp_val = ch_val[2];
    temp_bcd_buf = ch_temp_val * 100;
    temp_bin_val = temp_bin_val + temp_bcd_buf;

    ch_temp_val = ch_val[3];
    temp_bcd_buf = ch_temp_val * 10;
    temp_bin_val = temp_bin_val + temp_bcd_buf;


    temp_bin_val = temp_bin_val + ch_val[4];

    return(temp_bin_val);



}

void get_avg_xbar(void)
{

    unsigned char ch_counter;


    avg[avg_stk_ctr] = bin_val;
    if(avg_count == 9)
    {
        if(avg_stk_ctr >= 9)
        {
            avg_stk_ctr = 0;
            avg_bin = 0;
        }
        else
        {
            avg_stk_ctr++;
            avg_bin = 0;
        }

        for(ch_counter = 0 ; ch_counter < 10 ; ch_counter++)
        {
            avg_bin = avg_bin + avg[ch_counter];
        }
        avg_bin = avg_bin/10;


        qDebug() << avg_bin << "avg barr";



    }
    else
    {
        avg_stk_ctr++;
        avg_count++;
    }

}


void teplcwtestservice::event_mediumlatinput_checked()
{

        if(!s2_failfg & (!cw_bypassfg))
        {
            if((digitalRead(wpGPIO_IN_PIN18_SENSOR2)))
            {
                s2fail_ctr = 0;

            }
            else
            {

                //s2fail_ctr = 0;
                s2fail_ctr++;
                if(s2fail_ctr >= s2fail_time)
                {

                    digitalWrite(wpGPIO_OUT_PIN11, 0);
                    digitalWrite(wpGPIO_OUT_PIN13, 0);

                    conv_onfg = 0;
                   // handleConv_sts(conv_onfg);
                    s2_failfg = 1;

                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);



                  //  handleerror_sts(16);
                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                    alarm_msg = "ERROR-16 SENSOR2 FAILED";
                    alarm_msg_sql_logfg = 1;
                    display_error16fg = 1;






                }
            }

        }

        rdi2cbyte = wiringPiI2CReadReg8(i2cinputdev,0x12);
        i2cipdata.sInput = rdi2cbyte;
        if(!(i2cipdata.SBIT.ipestop & 0x01) & conv_onfg)
        {
            estop_ctr++;
            if(estop_ctr >= 3)
            {
                estop_ctr = 0;
                conv_onfg = 0;
                dynamic_cyclefg = 0;
               // handleConv_sts(conv_onfg);
                estop_err = 1;
                MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                MLO_status_12 = MLO_status_12 | BUZZER_ON;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
               // handleerror_sts(15);
                alarm_msg = "ERROR-15 ESTOP PRESSED";
                alarm_msg_sql_logfg = 1;

                display_error15fg = 1;

            }



        }
        else
        {
            estop_ctr = 0;

        }

        if(!conv_onfg & estop_err)
        {

            if(((i2cipdata.SBIT.ipestop) & 0x01))
            {
                estop_err = 0;
                estop_ctr = 0;
                dynamic_cyclefg = 0;
               // handleerror_sts(150);
                MLO_status_12 = MLO_status_12 & BUZZER_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);



            }

        }

        //if(!((wiringPiI2CReadReg8(i2cinputdev,0x12)) & 0x04) & conv_onfg & airprsfg)//04 for air prs & 02 for door open
        if(!((i2cipdata.SBIT.ipairprs) & 0x01) & conv_onfg & airprsfg)
        {
            air_prsctr++;
            if(air_prsctr >= 3)
            {

                conv_onfg = 0;
                air_prsctr = 0;
              //  handleConv_sts(conv_onfg);

                airprs_err = 1;
                airprsfg = 0;
                MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                digitalWrite(wpGPIO_OUT_PIN11, 0);
                MLO_status_12 = MLO_status_12 | BUZZER_ON;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
              //  handleerror_sts(14);
                alarm_msg = "ERROR-14 AIR PRESSURE IS NOT WITHIN RANGE";
                alarm_msg_sql_logfg = 1;

                display_error14fg = 1;


            }


        }
        else
        {
            air_prsctr = 0;

        }


        if(!conv_onfg & airprs_err)
        {

            if(((i2cipdata.SBIT.ipairprs) & 0x01))
            {
                airprs_err = 0;
                air_prsctr = 0;
             //   handleerror_sts(140);
                MLO_status_12 = MLO_status_12 & BUZZER_OFF;
                wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);

                alarm_msg = "ERR-14 AIR PRESSURE IS NOT WITHIN RANGE -- RESET AUTO / MANUAL";
                alarm_msg_sql_logfg = 1;

            }

        }


        //------------------------------------------------------------------------------------------

        if((config_parameter[10] == "11") || (config_parameter[10] == "01"))
        {

            if((i2cipdata.SBIT.ipdoor & 0x01))
            {
                dooropendbn_ctr++;
                if(conv_onfg & dooropenchk & (dooropendbn_ctr >= 3))//04 for air prs & 02 for door open
                {

                    dooropendbn_ctr = 0;

                    conv_onfg = 0;
                  //  handleConv_sts(conv_onfg);

                   // handleerror_sts(20);

                    dooropenchk_err = 1;
                    dooropenchk = 0;
                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                    digitalWrite(wpGPIO_OUT_PIN11, 0);
                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);


                    alarm_msg = "ERROR-20 CABINET DOOR OPEN";
                    alarm_msg_sql_logfg = 1;

                    display_error20fg = 1;


                }

            }
            else
            {
                dooropendbn_ctr = 0;
            }


            if(!conv_onfg & dooropenchk_err)
            {

                if(!(i2cipdata.SBIT.ipdoor & 0x01))
                {
                    dooropenchk_err = 0;
                }
                dooropendbn_ctr = 0;

            }
        }

        //----------------------------------------------------------------------------------------

        if((config_parameter[10] == "11") || (config_parameter[10] == "10"))
        {

            if((i2cipdata.SBIT.ipfrcover & 0x01))
            {
                coveropendbn_ctr++;
                if(conv_onfg & coveropenchk & (coveropendbn_ctr >= 3))//04 for air prs & 02 for door open
                {

                    coveropendbn_ctr = 0;
                    conv_onfg = 0;
                    //handleConv_sts(conv_onfg);

                 //   handleerror_sts(23);

                    //dooropenchk_err = 1;
                    coveropenchk = 0;
                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                    digitalWrite(wpGPIO_OUT_PIN11, 0);
                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);


                    alarm_msg = "ERROR-23 FRONT COVER OPEN";
                    alarm_msg_sql_logfg = 1;

                    display_error23fg = 1;


                }
                else if(conv_onfg == 0)
                {
                    coveropendbn_ctr = 0;

                }


            }
            else
            {
                coveropendbn_ctr = 0;
            }
        }

        //-----------------------------------------------------------------------------------------

        if(conv_onfg && rejvfg && (config_parameter[9] == "11"))
        {

            if(!((i2cipdata.SBIT.ipcwverif & 0x01)))
            {
                rejv_ctr++;
                if(rejv_ctr>=15 && rejvfg)//10
                {
                    conv_onfg = 0;
                 //   handleConv_sts(conv_onfg);
                    rejvfg = 0;
                    rejv_ctr = 0;

                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                    digitalWrite(wpGPIO_OUT_PIN11, 0);

                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    //handleerror_sts(30);

                    alarm_msg = "ERROR-30 REJECTION VERIFICATION FAILED";
                    alarm_msg_sql_logfg = 1;

                    display_error30fg = 1;

                }

            }
            else if(rejvfg)
            {
                rejvfg = 0;
                rejv_ctr = 0;
                qDebug() << "verfication reset1";
            }

        }


        //-----------------------------------------------------------------------------------

        if(conv_onfg && mdregvfg && (config_parameter[9] == "11"))
        {

            if(!((i2cipdata.SBIT.ipmdverif & 0x01)))
            {
                mdrejv_ctr++;
                if(mdrejv_ctr>=10 && mdregvfg)//10
                {


                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                   // digitalWrite(wpGPIO_OUT_PIN11, 0);
                    digitalWrite(wpGPIO_OUT_PIN13, 0);
                    conv_onfg = 0;
                  //  handleConv_sts(conv_onfg);
                    mdregvfg = 0;
                    mdrejv_ctr = 0;

                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    //handleerror_sts(27);

                    alarm_msg = "ERROR-27 MD REJECTION VERIFICATION FAILED";
                    alarm_msg_sql_logfg = 1;

                    display_error27fg = 1;

                }

            }
            else if(mdregvfg)
            {
                mdregvfg = 0;
                mdrejv_ctr = 0;
            }

        }


        //====================================================================================

        if(conv_onfg && binfullfg && (config_parameter[9] == "11"))
        {
            if((i2cipdata.SBIT.ipcwverif & 0x01) || ((i2cipdata.SBIT.ipmdverif & 0x01)))
            {

                rvbinfull_ctr++;
                if(rvbinfull_ctr>=80 && binfullfg)
                {
                    conv_onfg = 0;
                  //  handleConv_sts(conv_onfg);
                    binfullfg = 0;
                    rvbinfull_ctr = 0;

                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                    digitalWrite(wpGPIO_OUT_PIN11, 0);

                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    //handleerror_sts(22);

                    alarm_msg = "ERROR-22 REJECTION BINFULL ERROR";
                    alarm_msg_sql_logfg = 1;

                    display_error22fg = 1;

                }

            }
            else if(binfullfg)
            {
                rvbinfull_ctr = 0;

            }

        }


        //------------------------------------------------------------------------------------
        if(conv_onfg && binfullfg)
        {
            if(((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x40))
            {


                binfull_ctr++;
                if(binfull_ctr>=80 && binfullfg)
                {
                    conv_onfg = 0;
               //     handleConv_sts(conv_onfg);
                    binfullfg = 0;
                    binfull_ctr = 0;

                    MLO_status_12 = MLO_status_12 & CONV_OFF & UW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    MLO_status_13 = MLO_status_13 & ACCP_OFF & OW_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x13,MLO_status_13);
                    digitalWrite(wpGPIO_OUT_PIN11, 0);

                    MLO_status_12 = MLO_status_12 | BUZZER_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                    //handleerror_sts(22);

                    alarm_msg = "ERROR-22 REJECTION BINFULL ERROR";
                    alarm_msg_sql_logfg = 1;

                    display_error22fg = 1;

                }

            }
            else if(binfullfg)
            {
                binfull_ctr = 0;

            }

        }

        //------------------------------------------------------------------------------

        if(conv_onfg && Qjamfg)
        {
            if(((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x80))
            {
                Qjam_ctr++;
                if(Qjam_ctr>=30 && Qjamfg)//80
                {

                    Qjamfg = 0;
                    Qjam_ctr = 0;
                    Qjam_relfg = 1;
                    Qjam_relctr = 0;
                    MLO_status_12 = MLO_status_12 | BUZZER_ON | FLOAT_OP8_ON;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
                   // handleerror_sts(26);

                    alarm_msg = "ERROR-26 Q-JAM ERROR";
                    alarm_msg_sql_logfg = 1;

                    display_error26fg = 1;

                }

            }
            else if(Qjamfg)
            {
                Qjam_ctr = 0;

            }

        }
        else if(conv_onfg && Qjam_relfg)
        {
            if(!((wiringPiI2CReadReg8(i2cinputdev,0x13)) & 0x80))
            {

                Qjam_relctr++;
                if(Qjam_relctr>=20 && Qjam_relfg)
                {
                    Qjam_relfg = 0;
                    Qjam_relctr = 0;
                    Qjamfg = 1;
                  //  handleerror_sts(260);
                    MLO_status_12 = MLO_status_12 & BUZZER_OFF & FLOAT_OP8_OFF;
                    wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);


                }

            }

        }


        //=================================================================================

}


void teplcwtestservice::event_softpolling_checked()
{

    //------------------------------------------------------------------------
    if(conv_onfg)
    {

        if((cont_reg_ctr >= cont_rej_count) & !hldfg)
        {
            conv_onfg = 0;
            MLO_status_12 = MLO_status_12 & CONV_OFF | BUZZER_ON;
            wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);
            display_error19fg = 1;
            alarm_msg = "ERR-19 CONTINUOUS REJECTION";
            alarm_msg_sql_logfg = 1;

        }

    }
    //------------------------------------------------------------------------


}

void addDynamicwt_sql(QString date_time,QString dynwt, QString status)
{

    var1.remove(" ");

    QSqlQuery queryAdd;
    queryAdd.prepare( "INSERT INTO " + var1 + " (date_time,dyn_wt,status)VALUES('" + date_time + "', '" + dynwt + "', '" + status + "')" );


    if(queryAdd.exec())//TODO
    {

        qDebug() << "Dynamic Wt add success: " << queryAdd.lastError();

    }
    else
    {
        qDebug() << "Dynamic Wt add failed: " << queryAdd.lastError() << "VAR1 = " << var1;
    }



}

void update_counts_sql()
{

    QSqlQuery querycount;
    QString counts_table;
    counts_table = "COUNTS";
    querycount.prepare( "UPDATE " + counts_table +  " SET COMPARE = '" + stats_param[0] +  "',UW_COUNT = '" + QString::number(uw_count) +  "', OK_COUNTS = '" + QString::number(accp_count) + "', OW_COUNTS = '" + QString::number(ow_count) + "', TOT_COUNTS = '" + batch_tot_cnt + "', STD_DEV = '" + stats_param[5] + "', MIN_WT = '" + stats_param[7] + "', MAX_WT = '" + stats_param[8] + "', AVG_ACP_BIN = '" + stats_param[6] + "', MIN_WT_BIN = '" + stats_param[9] + "', MAX_WT_BIN = '" + stats_param[10] + "', STD_DEV_BUFF = '" + stats_param[11] + "', AVG_BUFF_BATCH = '" + stats_param[12] + "'" );

    if(querycount.exec())
    {

        qDebug() << "COUNTS UPDATED: ";
    }
    else
    {
        qDebug() << "COUNTS UPDATED FAILED " << querycount.lastError();
    }



}

void trigger_table_sql()
{
    QString trigger_table;
    trigger_table = "triggersql";
    QSqlQuery query;
//    querycount.prepare( "UPDATE " + counts_table +  " SET COMPARE = '" + stats_param[0] +  "',UW_COUNT = '" + QString::number(uw_count) +  "', OK_COUNTS = '" + QString::number(accp_count) + "', OW_COUNTS = '" + QString::number(ow_count) + "', TOT_COUNTS = '" + batch_tot_cnt + "', STD_DEV = '" + stats_param[5] + "', MIN_WT = '" + stats_param[7] + "', MAX_WT = '" + stats_param[8] + "', AVG_ACP_BIN = '" + stats_param[6] + "'" );
    query.prepare( "UPDATE " + trigger_table +  " SET trigger = '" + "1" +  "'");

    if(query.exec())
    {
        qDebug() << "Trigger UPDATED: ";
    }
    else
    {
        qDebug() << "Trigger UPDATED FAILED " << query.lastError();
    }
}

void teplcwtestservice::addAlaramdata(QString date_time, QString event_msg,QString username)
{
    var3.remove(" ");
    QSqlQuery queryAdd;
    queryAdd.prepare( "INSERT INTO " + var3 + " (date_time,event_msg,username)VALUES('" + date_time + "', '" + event_msg + "','" + username + "')" );
    if(queryAdd.exec())
    {

        qDebug() << "Alaram add success: " << queryAdd.lastError();
    }
    else
    {
        qDebug() << "Alaram Wt add failed: " << queryAdd.lastError();
    }
    trigger_table_sql();
}

