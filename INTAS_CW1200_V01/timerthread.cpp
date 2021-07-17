#include "timerthread.h"
#include "dbmanagers.h"
#include <QDebug>


#include "loadcellcalls.h"
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include<wiringPi.h>
#include<wiringPiI2C.h>
#include <QTimer>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>

//-----------------------------------------------------------------------
#define CONV_ON 0x80
#define CONV_OFF 0x7f

extern char Loadcells_3kHSACommands[][13];
extern char Loadcells_3kCommands[][13];
extern char Loadcells_6kCommands[][13];
extern char Loadcells_HSACommands[][13];
extern QFile stats_file;
extern QString var1;// = "Dynamic";
extern float master_binval[3];
extern QString stats_param[14];
//--------------------Flags------------------------------
extern bool chk_comfailfg,calibfg,ackfg,serial_enablefg,recvfg,nlfg,barcodeseven_lengthfg,write_textfilefg;
extern bool conv_onfg,calib_errstepfg,task1fg,dynamic_xfer_endfg,slavemcfg,dbpoweronfg;
extern bool chk_calib_errfg,static_togglefg,static_startfg,search_barcodefg,poweroncountsfg;
extern bool disp_staticfg,setzfg,accelfg,poweron_removemsg,dynamic_calcfg,ow_shiftfg,uw_shiftfg;
extern bool poweron_setzero,deaccelfg,en_rcwpulsefg,alarm_msg,mastermcfg,show_caliberrfg;
extern bool Qbreakfg,airprsfg,setzero_screenfg,sensor1fg,calcovrfg,sendcommandfg;
extern bool dooropenchk,dynamic_cyclefg,staticnsetz_taskfg,s2dlyfg,prodnfg,zr_calc_connectfg;
extern bool calib_step1,calib_step2,calib_step3,calib_step1_1,calib_step2_2,calib_step3_3;
bool toggle5msecfg;
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
extern void counts_fromsql();
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
extern void addDynamicwt_sql(QString,QString,QString);
//extern void update_counts_sql();
extern float x_fact,y_fact;
extern char buf[7];
extern float sndval;
extern void trigger_table_sql();
//------------------------------------------------
extern unsigned char shift_buff[110];
char ij_printer_buffer[30];
QString printer_buffer;
QString ij_datavalue;
bool send_ackfg;



timerthread::timerthread(QObject *parent) : QObject(parent)
{

   // serial.open(QSerialPort::ReadWrite);

}



void timerthread::DoSetup(QThread &thread_timer){
    qDebug()<<"Thread start";
    connect(&thread_timer,SIGNAL(started()),this,SLOT(init_timerthread()));

}

void timerthread::init_timerthread()
{

   // serial.connect(&serial,SIGNAL(readyRead()),this,SLOT(static_loop()),Qt::UniqueConnection);
    serial_usb0.open(QSerialPort::ReadWrite);
    // uart2_serial.connect(&uart2_serial,SIGNAL(readyRead()),this,SLOT(static_loop1()),Qt::UniqueConnection);

    sql_logtimer = new QTimer(this);
    sql_logtimer->connect(sql_logtimer,SIGNAL(timeout()),this,SLOT(RTC50_read_timer()));
    sql_logtimer->start(15);

//    serial_Fivemstimer = new QTimer(0);
//    serial_Fivemstimer->setInterval(7);
//    serial_Fivemstimer->setTimerType(Qt::PreciseTimer);
//    serial_Fivemstimer->connect(serial_Fivemstimer,SIGNAL(timeout()),this,SLOT(serial_FivemsLoop()));
//     serial_Fivemstimer->start(7);
#if 0
    ij_printer_buffer[0] = 'J';
    ij_printer_buffer[1] = 'D';
    ij_printer_buffer[2] = 'I';

    ij_printer_buffer[3] = '|';
    ij_printer_buffer[4] = '1';
    ij_printer_buffer[5] = '|';

    ij_printer_buffer[6] = 'W';
    ij_printer_buffer[7] = 'E';
    ij_printer_buffer[8] = 'I';
    ij_printer_buffer[9] = 'G';
    ij_printer_buffer[10] = 'H';
    ij_printer_buffer[11] = 'T';
    ij_printer_buffer[12] = '=';

    ij_printer_buffer[19] = '|';
    ij_printer_buffer[20] = '\x0d';
    sndval = 123.45;
    sprintf(buf,"%.2f",sndval);

    ij_printer_buffer[13] = buf[0];
    ij_printer_buffer[14] = buf[1];
    ij_printer_buffer[15] = buf[2];
    ij_printer_buffer[16] = buf[3];
    ij_printer_buffer[17] = buf[4];
    ij_printer_buffer[18] = buf[5];

    qDebug() << ij_printer_buffer << "IJ";

    sndval = 12.87;
    sprintf(buf,"%.2f",sndval);

    ij_printer_buffer[13] = buf[0];
    ij_printer_buffer[14] = buf[1];
    ij_printer_buffer[15] = buf[2];
    ij_printer_buffer[16] = buf[3];
    ij_printer_buffer[17] = buf[4];
    ij_printer_buffer[18] = buf[5];

    qDebug() << ij_printer_buffer << "IJ";
#endif
    printer_buffer = "JDI|1|WEIGHT=";





}


void timerthread::serial_FivemsLoop()
{

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

    if(sendzrcommandfg)
    {
        sendzrcommandfg = 0;
        xfer_zrdynamiccommand();

    }

    if(send_ackfg)
    {
        send_ackfg = 0;
        serial.write(weighcell_ACK,1);

    }

}

void timerthread::RTC50_read_timer()
{

    if(sndwt_extfg)
    {
        sndwt_extfg = 0;



        ij_datavalue =  QString::number(sndval,'f',2);
        printer_buffer.append(ij_datavalue);
        printer_buffer.append("|");
        printer_buffer.append('\x0d');
      //  qDebug() << printer_buffer.toUtf8() << "IJ";

        serial_usb0.write(printer_buffer.toUtf8());

        //         sndwt_extfg = 0;
        //         sprintf(buf,"%.2f",sndval);

        //         ij_printer_buffer[13] = buf[0];
        //         ij_printer_buffer[14] = buf[1];
        //         ij_printer_buffer[15] = buf[2];
        //         ij_printer_buffer[16] = buf[3];
        //         ij_printer_buffer[17] = buf[4];
        //         ij_printer_buffer[18] = buf[5];



        //         const char *data = ij_printer_buffer;
        //        serial_usb0.write(data,20);

    }


    if(write_textfilefg)
    {
        write_textfilefg = 0;
        stats_file.close();

        if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
        {
            qDebug() << "Failed to create";
        }
        QTextStream in(&stats_file);
        in << stats_param[0] << "\n";
        in << stats_param[1] << "\n";
        in << stats_param[2] << "\n";
        in << stats_param[3] << "\n";
        in << stats_param[4] << "\n";
        in << stats_param[5] << "\n";
        in << stats_param[6] << "\n";
        in << stats_param[7] << "\n";
        in << stats_param[8] << "\n";
        in << stats_param[9] << "\n";
        in << stats_param[10] << "\n";
        in << stats_param[11] << "\n";
        in << stats_param[12] << "\n";

        stats_file.close();



    }

    if(poweroncountsfg)
    {
        poweroncountsfg = 0;
        counts_fromsql();

    }


}


void timerthread::static_loop()
{
    bool ok;

    QByteArray bytee;

    //   qDebug() << "IN SERIAL";

    if(config_parameter[0] == "CW1200" || config_parameter[0] == "CW3000" || config_parameter[0] == "CW6000"
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
    {

        // qDebug() << "IN SERIAL";

        chk_comfailfg = 0;


        if(static_startfg)
        {



            if (serial.bytesAvailable() < 9)
            {


            }
            else
            {




                bytes1 = serial.readAll();
                bytee = bytes1.toHex();
                qDebug() << bytee;//.toHex();

                if(chk_calib_errfg)
                {

                    static_startfg = 0;
                    bin_val = 0;
                    // bin_val = bytes1[5];
                    //  bin_val = bin_val << 8;
                    bin_val = bytes1[6] + bin_val;
                    bin_val = bin_val << 8;
                    bin_val = bytes1[3] + bin_val;
                    bin_val = bin_val << 8;
                    bin_val = bytes1[4] + bin_val;
                    qDebug() << "Dynamic receive>>>>>" << bin_val;

                    if(((bin_val <= 0x7fd567) & (bin_val >= 0x7ed18d)) && (config_parameter[0] == "CW1200"))
                    {
                        chk_calib_errfg = 0;

                        loadsteps = 38;
                        task1fg = 1;
                        task1ctr = 400;

                        qDebug() << "NO CALIB ERR";


                    }
                    //else if(((bin_val <= 0x7fc8e2) & (bin_val >= 0x7f029b)) && config_param.CW_3K)
                    else if(((bin_val <= CALIB_Hi) & (bin_val >= CALIB_Lo)) && (config_parameter[0] == "CW3000"))
                    {
                        chk_calib_errfg = 0;

                        loadsteps = 38;
                        task1fg = 1;
                        task1ctr = 400;

                        qDebug() << "NO CALIB ERR...3k";


                    }
                    else if(((bin_val <= CALIB_Hi) & (bin_val >= CALIB_Lo)) && (config_parameter[0] == "CW6000"))
                    {
                        chk_calib_errfg = 0;

                        loadsteps = 38;
                        task1fg = 1;
                        task1ctr = 400;

                        qDebug() << "NO CALIB ERR...6k";


                    }
                    else
                    {

                        //handleCalib_sts(7);
                        show_caliberrfg = 1;
                        calib_errstepfg = 1;
                        chk_calib_errfg = 0;


                    }


                }

                if(static_startfg)
                {
                    static_startfg = 0;
                    set_raw_bytes(ddd,bytes1);
                }

                //      serial.flush();change2
                //      serial.clear();

            }









        }
        else
        {
            rx_counter = 0;

            bytes1 = serial.readAll();
            bytes1 = bytes1.toHex();
            buff[rx_counter] = bytes1.toInt(&ok,16);
            if(buff[0] == 1)
            {


                switch(buff[1]) {
                case 0x03:
                    if(buff[4] == 3)
                    {

                        loadsteps--;


                    }

                    break;
                case 0x06:

                    break;
                case 0x10:

                    break;
                case 0x86:

                    loadsteps--;

                    break;
                case 0x90:

                    loadsteps--;

                    break;
                default:
                    break;
                }



            }
            rx_counter++;
            qDebug() << bytes1;//.toHex();

            serial.flush();

        }




    }

    if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA"))
    {

        chk_comfailfg = 0;

        if(calibfg & (!conv_onfg))
        {

            rx_counter++;
            ddd[rx_counter] = serial.read(1);
            qDebug() << ddd[rx_counter] << "ddd" << rx_counter;
            if((rx_counter == 1) | (ddd[rx_counter] == "\x06"))
            {
                rx_counter = 1;


            }
            else
            {

                if(ddd[rx_counter] == "\x03")
                {
                    ackfg = 1;

                    if(ackfg)
                    {
                        ackfg = 0;
                        qDebug() << "ACKKKKKKKK";
                        serial.write(weighcell_ACK,1);


                    }
                    serial_enablefg = 0;
                    rx_counter = 0;
                    qDebug() << "AGAINNNN";


                    if(chk_calib_errfg)
                    {
                        if((ddd[3] == "E") & (ddd[5] == "5"))
                        {

                            //handleCalib_sts(7);
                            show_caliberrfg = 1;
                            calib_errstepfg = 1;
                            chk_calib_errfg = 0;
                            qDebug() << "CALIB ERROR";
                            calibfg = 0;

                        }
                    }



                }


            }





        }
        else
        {

            if(serial.bytesAvailable() < 14)
            {

            }
            else
            {
                bytes1 = serial.readAll();
                qDebug() << "SERIAL READDDD";
                if(static_startfg)
                {
                    static_startfg = 0;
                    set_raw_bytes(ddd,bytes1);
                }

                if(chk_calib_errfg)
                {

                    QString fdfd;
                    fdfd = tr(bytes1);
                    qDebug() << "CALIB ERROR" << chk_calib_errfg;

                    if((fdfd[3] == "E") & (fdfd[5] == "5"))
                    {

                        //handleCalib_sts(7);
                        show_caliberrfg = 1;
                        calib_errstepfg = 1;
                        chk_calib_errfg = 0;
                        qDebug() << "CALIB ERROR";

                    }
                }
                qDebug() << "ACKKKKKKKK";
                send_ackfg = 1;
               // serial.write(weighcell_ACK,1);

            }

        }



    }



}

void timerthread::set_raw_bytes(QByteArray bytes[],QByteArray bytes1)
{

    //bool ok;
    unsigned int temp_binval1;

    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000")|| (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
    {



        bin_val = 0;
        bin_val = bytes1[5];
        bin_val = bin_val << 8;
        bin_val = bytes1[6] + bin_val;
        bin_val = bin_val << 8;
        bin_val = bytes1[3] + bin_val;
        bin_val = bin_val << 8;
        bin_val = bytes1[4] + bin_val;
        qDebug() << "Dynamic receive>>>>>" << bin_val;

        bin_val = (bin_val + 2500) / 10;
        qDebug() << "Dynamic receive>>>>>" << bin_val;
        if(config_parameter[0] == "CW3000")
        {
            bin_val = bin_val & 0xfffe;
            qDebug() << "Dynamic receive..........." << bin_val;

        }

        if(config_parameter[0] == "CW6000")
        {



            temp_binval1 = bin_bcd(5,bin_val);
            qDebug() << temp_binval1;
            temp_binval1 = digit(temp_binval1);
            qDebug() << temp_binval1;
            bin_val = bincon(temp_binval1);

            qDebug() << "Dynamic receive..........." << bin_val;

        }


        recvfg = 1;



    }
    else if(config_parameter[0] == "CW600HSA")
    {
        //        bin_val = 0;



        ////567.910

        //        bin_val = bytes[5].toInt(&ok,16) * 10000;//45689
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[6].toInt(&ok,16) * 1000;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[7].toInt(&ok,16) * 100;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[9].toInt(&ok,16) * 10;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[10].toInt(&ok,16);
        //        qDebug() << bin_val;

        //        if((bytes[6] == "-") | (bytes[5] == "-"))
        //        {

        //            qDebug() << "NEGATIVE";
        //            bin_val = 3000 - bin_val;

        //        }
        //        else
        //        {
        //            bin_val = bin_val + 3000;
        //            qDebug() << "POSITIVE";
        //            qDebug() << bin_val;
        //        }

        //        recvfg = 1;


        //---------------------------------------------------------------

        bin_val = 0;

        QString fdfd;

        fdfd = tr(bytes1);

        bin_val = fdfd.split("")[5].toInt() * 10000;//45689
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[6].toInt() * 1000;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[7].toInt() * 100;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[9].toInt() * 10;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[10].toInt();
        qDebug() << bin_val<<fdfd[6];

        if((fdfd[5] == 0x2d) || (fdfd[6] == "-"))
        {

            qDebug() << "NEGATIVE";
            bin_val = 3000 - bin_val;

        }
        else
        {
            bin_val = bin_val + 3000;
            qDebug() << "POSITIVE";
            qDebug() << bin_val;
        }

        recvfg = 1;




    }
    else if(config_parameter[0] == "CW3000HSA")
    {
        //        bin_val = 0;

        ////567.910

        //        bin_val = bytes[5].toInt(&ok,16) * 10000;//45689
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[6].toInt(&ok,16) * 1000;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[7].toInt(&ok,16) * 100;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[8].toInt(&ok,16) * 10;
        //        qDebug() << bin_val;

        //        bin_val = bin_val + bytes[10].toInt(&ok,16);
        //        qDebug() << bin_val;

        //        if((bytes[6] == "-") | (bytes[5] == "-"))
        //        {

        //            qDebug() << "NEGATIVE";
        //            bin_val = 3000 - bin_val;

        //        }
        //        else
        //        {
        //            bin_val = bin_val + 3000;
        //            qDebug() << "POSITIVE";
        //            qDebug() << bin_val;
        //        }

        //       // if(config_param.CW_3K)
        //        {
        //            bin_val = bin_val & 0xfffe;
        //            qDebug() << "Dynamic receive..........." << bin_val;

        //        }

        //        recvfg = 1;


        //---------------------------------------------------------------

        bin_val = 0;
        command_responsefg = 0;
        qDebug() << "command_responsectr" << command_responsectr;

        QString fdfd;

        fdfd = tr(bytes1);

        bin_val = fdfd.split("")[5].toInt() * 10000;//45689
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[6].toInt() * 1000;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[7].toInt() * 100;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[8].toInt() * 10;
        qDebug() << bin_val;

        bin_val = bin_val + fdfd.split("")[10].toInt();
        qDebug() << bin_val<<fdfd[6];

        if((fdfd[5] == 0x2d) || (fdfd[6] == "-"))
        {

            qDebug() << "NEGATIVE";
            bin_val = 3000 - bin_val;

        }
        else
        {
            bin_val = bin_val + 3000;
            qDebug() << "POSITIVE";
            qDebug() << bin_val;
        }

        bin_val = bin_val & 0xfffe;
        qDebug() << "Dynamic receive..........." << bin_val;

        recvfg = 1;



    }

    if(setzfg || static_togglefg)
    {
        calcovrfg = 1;

    }

    if((nlfg & conv_onfg) & (err_ctr == 0) & !sensor1fg)
    {
        zr_calc_connectfg = 1;

        qDebug() << "ZR CALC";

    }


}


void timerthread::static_tranfer()
{

    const char *data = &Loadcells_Commands[loadsteps][13];

    if(static_togglefg | setzfg)
    {
        serial.clear();
        serial_enablefg = 1;
        rx_counter = 0;
        qDebug() << data;
        if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA"))
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
                //                if(loadsteps==0)
                //                {
                //                    serial.write(weighcell_static_filterLOW,11);
                //                }
                //                if(loadsteps==1)
                //                {
                //                    serial.write(weighcell_RINGBUFF,8);
                //                }
                //                if(loadsteps==2)
                //                {
                //                    serial.write(weighcell_LOADRD,4);
                //                }

                loadsteps++;// = weighcell_RINGBUFF + step_counter;
            }

        }
        else if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
                || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
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

        serial.write(data,13);

    }
    else if(calibfg)
    {
        serial_enablefg = 1;

        rx_counter = 0;
        qDebug() << data;
        if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA"))
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


                //  mytimer->stop();
                task1fg = 0;
                task1ctr = 0;


                rx_counter = 0;
                qDebug() << "STEP 20.....";
                //msgBox[8]->setVisible(false);
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
                const char *data = &Loadcells_3kHSACommands[0][13];
                qDebug() << "CALIBRATION COMMAND 3000HSA";
              //  serial.write(data,13);
                serial.write(weighcell_CALB2000,8);
                loadsteps++;
            }
            if((config_parameter[0] == "CW100HSA") && loadsteps == 21)
            {
                const char *data = &Loadcells_HSACommands[0][13];
                qDebug() << "CALIBRATION COMMAND HSA";
                serial.write(data,13);
                loadsteps++;
            }
            else
            {
                loadsteps++;
//                if((config_parameter[0] == "CW3000HSA") && loadsteps == 21)
//                {
//                    const char *data = &Loadcells_3kHSACommands[0][13];
//                    qDebug() << "CALIBRATION COMMAND 3000HSA";
//                  //  serial.write(data,13);
//                    serial.write(weighcell_CALB2000,8);
//                    loadsteps++;
//                }
                serial.write(data,13);
            }
            //else
            {
                //     loadsteps++;// = weighcell_RINGBUFF + step_counter;
            }

            //  serial.write(data,13);

        }
        if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000")|| (config_parameter[0] == "CW6000")
                || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
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


            if((config_parameter[0] == "CW3000") && loadsteps == 30)
            {
                const char *data = &Loadcells_3kCommands[0][13];
                qDebug() << "CALIBRATION COMMAND";
                serial.write(data,13);
                loadsteps++;
            }
            if((config_parameter[0] == "CW6000") && loadsteps == 30)
            {
                const char *data = &Loadcells_6kCommands[0][13];
                qDebug() << "CALIBRATION COMMAND";
                serial.write(data,13);
                loadsteps++;
            }
            else
            {
                loadsteps++;
                serial.write(data,13);
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
        serial.write(data,11);


    }
}

void timerthread::xfer_dynamiccommand()
{
  serial.open(QSerialPort::ReadWrite);

    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
    {



        s1_count = 0;



        rx_counter = 0;
        dynamic_cyclefg = 1;
        s1_count = 0;

        static_startfg = 1;
        recv_counter = 0;
        qDebug() << scaime_result_wt;
        serial.clear();
        // serial.write(data,13);
        serial.write(scaime_result_wt,8);
        qDebug() << "Scaime Dynamic command";

    }
    else if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA")){

        s1_count = 0;
        rx_counter = 0;
        dynamic_cyclefg = 1;
        static_startfg = 1;
        recv_counter = 0;
        rx_counter = 0;
        qDebug() << weighcell_LOADRD;
        serial.clear();
        serial.write(weighcell_LOADRD,4);

       // serial_Fivemstimer->start(7);

    }



}

void timerthread::xfer_zrdynamiccommand()
{


    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000") || (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1")
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
            serial.clear();
            serial.write(sacime_zrtw,8);
            qDebug() << "Scaime Dynamic command";

        }

    }
    else if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA")){


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

            serial.clear();

            serial.write(weighcell_ZRLOADRD,4);

        }

    }



}



