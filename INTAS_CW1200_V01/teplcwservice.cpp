#include <QDebug>

#include "teplcwservice.h"
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include "loadcellcalls.h"
#include<wiringPi.h>
#include<wiringPiI2C.h>
#define CONV_ON 0x80
#define CONV_OFF 0x7f
//============================
extern char Loadcells_3kHSACommands[][13];
extern char Loadcells_3kCommands[][13];
extern char Loadcells_6kCommands[][13];
extern char Loadcells_HSACommands[][13];

extern QString var1;// = "Dynamic";
extern float master_binval[3];
//--------------------Flags------------------------------
extern bool chk_comfailfg,calibfg,ackfg,serial_enablefg,recvfg,nlfg,barcodeseven_lengthfg;
extern bool conv_onfg,calib_errstepfg,task1fg,dynamic_xfer_endfg,slavemcfg,dbpoweronfg;
extern bool chk_calib_errfg,static_togglefg,static_startfg,search_barcodefg;
extern bool disp_staticfg,setzfg,accelfg,poweron_removemsg,dynamic_calcfg,ow_shiftfg,uw_shiftfg;
extern bool poweron_setzero,deaccelfg,en_rcwpulsefg,alarm_msg,mastermcfg,show_caliberrfg;
extern bool Qbreakfg,airprsfg,setzero_screenfg,sensor1fg,calcovrfg,sendcommandfg;
extern bool dooropenchk,dynamic_cyclefg,staticnsetz_taskfg,s2dlyfg,prodnfg,zr_calc_connectfg;
extern bool calib_step1,calib_step2,calib_step3,calib_step1_1,calib_step2_2,calib_step3_3;
extern bool toggle5msecfg;
extern bool OWdynamic_sql_logfg,UWdynamic_sql_logfg,OKdynamic_sql_logfg,readbarcodefg;
extern bool binfullfg,Qjamfg,coveropenchk,sendcommandfg,sendzrcommandfg,sndwt_extfg;
//------------------variables-------------------------
extern unsigned int bin_ref,bin_val;
extern unsigned char rx_counter,recv_counter;
extern unsigned char accel_ctr,accel_count;
extern unsigned int task1ctr;
extern QByteArray ddd[70];
extern unsigned char binfull_ctr,Qbreak_ctr;
extern unsigned int MLO_status_12;
extern unsigned int MLO_status_13;
extern unsigned int OW_ERR;
extern unsigned char commfail_counter,rvbinfull_ctr;
extern unsigned char err_ctr;
extern int i2cdev,i2cdata,i2crtcdev,i2coutputdev;
extern int i2creg,i2cinputdev;
extern QString prev_value,cur_value,event_msg,userid;
extern unsigned char rcheart_counter;
extern QString global_datetime,global_stpdatetime;
extern unsigned int setzero_screenctr,s1_count;
extern unsigned char loadsteps;
extern unsigned char dynamic_loadsteps;
extern QByteArray getdata;
extern char Loadcells_Commands[][13];
extern QString config_parameter[14];
extern QByteArray br_array[20];
extern QByteArray br1_array[20];
extern unsigned char br_counter;
extern QString bardata,shift_bardata[4];
constexpr int wpGPIO_OUT_PIN11            = 0;
extern QSerialPort serial,uart2_serial,serial_usb0;
extern unsigned char shift_barsts[4];
extern QString cpp_prd_batchno;

extern QString global_datetime,global_stpdatetime;
extern QString prdwt;// = ui->prdwtlineEdit->text();
extern QString prdresult;// = ui->prdresultlineEdit->text();
extern bool conv_onfg;
extern unsigned int log_binval;
extern unsigned int CALIB_Hi,CALIB_Lo;
extern quint32 buff[9];
extern unsigned int bin_bcd(unsigned char, unsigned int);
extern unsigned int digit(unsigned int);
extern unsigned int bincon(unsigned int);
extern bool command_responsefg;
extern unsigned int command_responsectr,command_timectr;
//-----------------------------------------------------------------------
extern bool OWdynamic_sql_logfg,UWdynamic_sql_logfg,OKdynamic_sql_logfg;
extern QString global_datetime,global_stpdatetime;
extern QString prdwt;
extern QString prdresult;
extern bool conv_onfg,in_spd_fg;
extern unsigned int in_sped_ctr,min1_dly_ctr;

extern float x_fact,y_fact;
extern char buf[7];
extern float sndval;
//------------------------------------------------
extern unsigned char shift_buff[110];
extern char ij_printer_buffer[30];
extern QString printer_buffer;
extern QString ij_datavalue;
extern bool send_ackfg;

//=============================

constexpr int TEPLCWService::BUFSIZE;

/* Must do nothing in the ctor.
 * See note in TEPLCWUARTService.cpp
 */
TEPLCWService::TEPLCWService(QObject *parent) : QObject(parent)
{

}

void TEPLCWService::startService()
{
    // Create the buffer used to receive data
    m_pRecvBuffer = std::make_unique<char[]>(BUFSIZE);

    // Timer for stats calculation
    m_pDbgTimer = std::make_unique<QTimer>(this);
    m_pDbgTimer->start(5);

 qDebug("TEPLCWService  running as threadId %p", QThread::currentThreadId());

    connect(m_pDbgTimer.get(), SIGNAL(timeout()),
            this,           SLOT(teplfivems()));

    qDebug("Base CW startService");
}

void TEPLCWService::resumeService()
{
    // Reset fifos here

    m_dbgSigmaNumRd = 0;       // Reset running total
    //m_pDbgTimer->start(250);   // Start timer for 250 ms

    m_pauseFlag = false;
    qDebug("Base CW Service: Resuming writing into FIFOs");
}

void TEPLCWService::pauseService()
{
    qDebug("Base CW Service: Pausing writing into FIFOs in processRawData()");
    m_pauseFlag = true;
    //m_pDbgTimer->stop();
}

void TEPLCWService::stopService()
{
    // Quit service thread here
    qDebug("Stopping base CW Service");
    //m_pDbgTimer->stop();
    emit finished();
}

void TEPLCWService::dbgCalcStats()
{
    int Bps = static_cast<int>(m_dbgSigmaNumRd/0.250);
    QByteArray qba(m_pRecvBuffer.get(), 4);
    quint64 dd = 0x0000;
    bool ok;


   // QString byteStr(qba);
    QString byteStr(qba.toHex(' '));
    //qDebug() << "Data rate =" << Bps << "Bps. Bytes read =" << byteStr;
    m_dbgSigmaNumRd = 0;

     QByteArray byteStr1(qba.toHex(' '));

    dd = (qba[0]);
    byteStr = "12345678";

   // byteStr = byteStr >> 4;
    dd = byteStr.toLong(&ok,10);
  //  dd = dd >> 4;

  //  qDebug() << dd;

    //emit write("123");
    emit dbgUpdateBps(Bps);
    emit dbgUpdateBytesRead(byteStr);
}

TEPLCWService::~TEPLCWService() {
    qDebug("TEPLCWService abstract base class dtor");
}


void TEPLCWService::teplfivems()
{
    //sendcommandfg = 1;
   // qDebug("Starting 5ms on threadId %p", QThread::currentThreadId());
    if(sendzrcommandfg)
    {
        sendzrcommandfg = 0;
        //qDebug() << "5MS";
        //emit write("12");
        xfer_zrdynamiccommand();

    }

    if(staticnsetz_taskfg)
    {
        staticnsetz_taskfg = 0;
        static_tranfer();

    }

    if(sendcommandfg)
    {
        sendcommandfg = 0;
        xfer_dynamiccommand();

    }
    if(send_ackfg)
    {
        send_ackfg = 0;
        write(weighcell_ACK,1);

    }




}



void TEPLCWService::static_tranfer()
{

    const char *data = &Loadcells_Commands[loadsteps][13];

    if(static_togglefg | setzfg)
    {
        //serial.clear();
        serial_enablefg = 1;
        rx_counter = 0;
        qDebug() << data;
        if((config_parameter[0] == "CW1200HSA") || (config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA"))
        {
            if((loadsteps == 2) & (disp_staticfg))
            {

                static_startfg = 1;
                if(static_togglefg)
                {
                    disp_staticfg = 1;
                    task1fg = 1;
                    task1ctr = 80;
                }
                else
                {
                    disp_staticfg = 0;
                    task1fg = 0;
                    task1ctr = 0;

                }


                rx_counter = 0;
                qDebug() << "STEP 3rr.....";


                //   handleSetzero_sts(3);





            }
            else
            {


                loadsteps++;// = weighcell_RINGBUFF + step_counter;
            }

        }
        else if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
                || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
        {

            // qDebug() << data;
            if((loadsteps == 16) & (disp_staticfg))
            {


                static_startfg = 1;
                if(static_togglefg)
                {
                    disp_staticfg = 1;
                    task1fg = 1;
                    task1ctr = 80;
                }
                else
                {
                    disp_staticfg = 0;
                    task1fg = 0;
                    task1ctr = 0;

                }


                rx_counter = 0;
                qDebug() << "STEP Scaime.....";


                //   handleSetzero_sts(3);


            }
            else
            {
                loadsteps++;// = weighcell_RINGBUFF + step_counter;
            }

        }

        //serial.write(data,13);
        write(data,13);

    }
    else if(calibfg)
    {
        serial_enablefg = 1;

        rx_counter = 0;
        qDebug() << data;
        if((config_parameter[0] == "CW1200HSA") || (config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA"))
        {
            if((loadsteps == 19))
            {



                task1fg = 1;
                task1ctr = 500;

                rx_counter = 0;
                qDebug() << "STEP 19.....";


            }
            if((loadsteps == 20))
            {



                task1fg = 0;
                task1ctr = 0;


                rx_counter = 0;
                qDebug() << "STEP 20.....";

                calib_step2 = 1;
                chk_calib_errfg = 1;




            }
            if((loadsteps == 22))
            {


                //mytimer->stop();
                task1fg = 0;
                task1ctr = 0;

                rx_counter = 0;
                qDebug() << "STEP 22.....";
                calibfg = 0;

                calib_step3 = 1;

            }

            if((config_parameter[0] == "CW3000HSA") && loadsteps == 21)
            {

                qDebug() << "CALIBRATION COMMAND 3000HSA";
                write(weighcell_CALB2000,8);
                loadsteps++;
            }
            else if((config_parameter[0] == "CW1200HSA") && loadsteps == 21)
            {

                qDebug() << "CALIBRATION COMMAND 3000HSA";
                write(weighcell_CALB1000,8);
                loadsteps++;
            }
            else if((config_parameter[0] == "CW100HSA") && loadsteps == 21)
            {
                const char *data = &Loadcells_HSACommands[0][13];
                qDebug() << "CALIBRATION COMMAND HSA";
               // serial.write(data,13);
                 write(data,13);
                loadsteps++;
            }
            else
            {
                loadsteps++;
                write(data,13);
            }

        }
        if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000")|| (config_parameter[0] == "CW6000")
                || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
        {
            if((loadsteps == 33))
            {


                task1fg = 0;
                task1ctr = 0;
                rx_counter = 0;
                qDebug() << "STEP 33.....";
                calib_step2 = 1;


            }
            if((loadsteps == 37))
            {


                task1fg = 0;
                task1ctr = 0;
                rx_counter = 0;
                qDebug() << "STEP 37.....";


                chk_calib_errfg = 1;
                static_startfg = 1;

            }

            if((loadsteps == 41))
            {


                task1fg = 0;
                task1ctr = 0;
                rx_counter = 0;
                qDebug() << "STEP 41.....";
                calibfg = 0;

                calib_step3 = 1;




            }


            if((config_parameter[0] == "CW3000" || (config_parameter[0] == "CW3000_1")) && loadsteps == 30)
            {

                qDebug() << "CALIBRATION COMMAND3K" << data;

                loadsteps++;
                write(scaime_calib_load_wt3k,13);

            }
            else if((config_parameter[0] == "CW6000") && loadsteps == 30)
            {
                const char *data = &Loadcells_6kCommands[0][13];
                qDebug() << "CALIBRATION COMMAND";
                //serial.write(data,13);
                write(data,13);
                loadsteps++;
            }
            else
            {
                loadsteps++;           
                qDebug() << data;
                write(data,13);
            }
        }



    }
    else if(dynamic_cyclefg && conv_onfg)
    {

        serial_enablefg = 1;

        if((loadsteps == 45)) // if((loadsteps == 44))
        {

            dynamic_cyclefg = 0;
            //mytimer->stop();
            task1fg = 0;
            task1ctr = 0;
            rx_counter = 0;
            qDebug() << "STEP 43.....";

            airprsfg = 1;
            dooropenchk = 1;
            coveropenchk = 1;
            conv_onfg = 1;
            binfullfg = 1;
            Qjamfg = 1;
            binfull_ctr = 0;
            rvbinfull_ctr = 0;
            wiringPiI2CWriteReg16(i2cdev,i2creg,i2cdata);
            qDebug() << i2creg << i2cdata << "dsadsadsadsadsadsreg---------------";

            MLO_status_12 = MLO_status_12 | CONV_ON;
            wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);



        }

        if((loadsteps == 45))
        {

            dynamic_cyclefg = 0;
            //                            mytimer->stop();
            task1fg = 0;
            task1ctr = 0;

            rx_counter = 0;
            qDebug() << "STEP 45.....";



        }

        if((loadsteps == 56))
        {

            dynamic_cyclefg = 0;
            //                            mytimer->stop();
            task1fg = 0;
            task1ctr = 0;

            rx_counter = 0;
            qDebug() << "STEP 56.....";

            airprsfg = 1;
            dooropenchk = 1;
            coveropenchk = 1;
            conv_onfg = 1;
            binfullfg = 1;
            Qjamfg = 1;
            binfull_ctr = 0;
            rvbinfull_ctr = 0;
            wiringPiI2CWriteReg16(i2cdev,i2creg,i2cdata);
            qDebug() << i2creg << i2cdata << "dsadsadsadsadsadsreg---------------";


            MLO_status_12 = MLO_status_12 | CONV_ON;
            wiringPiI2CWriteReg8(i2coutputdev,0x12,MLO_status_12);




        }



        if((loadsteps == 2))
        {

            dynamic_cyclefg = 0;

            task1fg = 0;
            task1ctr = 0;
            serial.clear();

            rx_counter = 0;
            qDebug() << "2.....";



        }



        rx_counter = 0;

        loadsteps++;
        qDebug() << data;
        //serial.write(data,11);
        write(data,11);


    }
}




void TEPLCWService::xfer_dynamiccommand()
{


    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
    {



        s1_count = 0;



        rx_counter = 0;
        dynamic_cyclefg = 1;
        s1_count = 0;

        static_startfg = 1;
        recv_counter = 0;
        //qDebug() << scaime_result_wt;
       // serial.clear();

       // serial.write(scaime_result_wt,8);
        emit write(scaime_result_wt,8);
        qDebug() << "Scaime Dynamic command";

    }
    else if( (config_parameter[0] == "CW1200HSA") ||(config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA")){

        s1_count = 0;
        rx_counter = 0;
        dynamic_cyclefg = 1;
        static_startfg = 1;
        recv_counter = 0;
        rx_counter = 0;
        //qDebug() << weighcell_LOADRD;
        //serial.clear();
        //serial.write(weighcell_LOADRD,4);

       emit write(weighcell_LOADRD,4);

    }



}

void TEPLCWService::xfer_zrdynamiccommand()
{


    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
    {

        if(nlfg)
        {

            qDebug() << "ZR COMMAND";
            // const char *data1 = &Loadcells_ZRCommands[0][13];

            rx_counter = 0;
            dynamic_cyclefg = 1;
            s1_count = 0;

            static_startfg = 1;
            recv_counter = 0;
            qDebug() << sacime_zrtw;
            //serial.clear();
            write(sacime_zrtw,8);
            qDebug() << "Scaime Dynamic command";

        }

    }
    else if( (config_parameter[0] == "CW1200HSA") || (config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA")){


        if(nlfg)
        {

            qDebug() << "ZR COMMAND";

            //const char *data1 = &Loadcells_ZRCommands[1][13];
            rx_counter = 0;
            dynamic_cyclefg = 1;


            static_startfg = 1;
            recv_counter = 0;

            rx_counter = 0;
            qDebug() << weighcell_ZRLOADRD;

           // serial.clear();

            write(weighcell_ZRLOADRD,4);

        }

    }



}

