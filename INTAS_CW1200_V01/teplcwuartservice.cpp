#include <QDebug>

#include <stdexcept>

#include "teplcwuartservice.h"
#include<wiringPi.h>
#include<wiringPiI2C.h>
#include <QDebug>
#include "loadcellcalls.h"

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
QByteArray bytes1;
//=============================


/* Must do nothing in the ctor. If the QSerialPort is made into a
 * member object rather than a pointer allocated dynamically, it
 * gets constructed in the UartService ctor on the main thread.
 * When we subsequently move the service to a new thread and try to
 * access members of the QSerPort object, we get the error
 *      "QObject: Cannot create children for a parent that is in a different
 *      thread.
 *      (Parent is QSerialPort(0x4e2288), parent's thread is QThread(0x434cd0),
 *      current thread is QThread(0x7fe6b30a20)"
 */
TEPLCWUARTService::TEPLCWUARTService()
{
}

TEPLCWUARTService::~TEPLCWUARTService() {
    qDebug("TEPL CW UART Service dtor");
    m_pUart->close();
}

// For calling from C++
void TEPLCWUARTService::write(const char* out,int length)
{

    qDebug() << "Writing bytes over uart:" << out;//.toHex(' ');
    m_pUart->clear();
    m_pUart->write(out,length);
}

// This is a slot for a QML signal that has a list argument (see
// http://doc.qt.io/qt-5/qtqml-cppintegration-data.html and
// https://ruedigergad.com/2011/11/13/exchange-data-and-objects-between-c-and-qml-and-vice-versa/
// for examples of passing data from QML to C++)
// In particular, for QML signals -> C++ slots, any non-basic QML arg
// must be received as a QVariant (not even QVariantList works!)
void TEPLCWUARTService::write(QVariant qmlWdata)
{
    qDebug() << "TID" << QThread::currentThreadId()
             << "C++ write() slot rcvd QVariant";

    // Construct ByteArray from ints passed from QML
    QByteArray ba;
    for (QVariant v: qmlWdata.toList()) {
        ba.append(static_cast<char>(v.toInt()));
    }

    write(ba);
}

//void TEPLCWUARTService::write(const char* bytes,int length)
//{
//    //out = "12";
//    qDebug() << "Writing bytes over uart:" << bytes;//.toHex(' ');
//    m_pUart->clear();
//    m_pUart->write(bytes,length);
//}

// TODO: this method should NOT exist in the base Service class. Done
// only for the purposes of this UARTtest demo.
void TEPLCWUARTService::deleteLaterSetBaudRate(int br)
{
    m_pUart->setBaudRate(br);
    m_pUart->clear();
}

// Perform any prologue setup before we start reading data
void TEPLCWUARTService::startService()
{
    qDebug("Starting UART service on threadId %p", QThread::currentThreadId());

    // Call up to base class
    TEPLCWService::startService();

    // Get list of serial ports on this system. Make sure ttyS1 is in the list.
    bool foundUART1 = false;
    QSerialPortInfo uart1;
    QList<QSerialPortInfo> spil = QSerialPortInfo::availablePorts();
    for (const QSerialPortInfo& spi : spil) {
        qDebug("Found UART: %s", qPrintable(spi.systemLocation()));
        if (spi.systemLocation().contains("ttyS1", Qt::CaseInsensitive)) {
            foundUART1 = true;
            uart1 = spi;    // Save a copy
            break;
        }
    }


    m_pUart = std::make_unique<QSerialPort>();

    m_pUart->setPort(uart1);
    if (!m_pUart->open(QIODevice::ReadWrite)) {
        throw std::runtime_error("UART could not be opened!");
    }


    if(config_parameter[0] == "CW1200" || config_parameter[0] == "CW3000" || config_parameter[0] == "CW6000"
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
    {
        m_pUart->setBaudRate(19200);
        m_pUart->setFlowControl(QSerialPort::NoFlowControl);
        m_pUart->setParity(QSerialPort::NoParity);
        m_pUart->setDataBits(QSerialPort::Data8);
        m_pUart->setStopBits(QSerialPort::OneStop);
        qDebug() << "19200 BR";


    }
    else
    {

        m_pUart->setBaudRate(38400);
        m_pUart->setFlowControl(QSerialPort::NoFlowControl);
        m_pUart->setParity(QSerialPort::OddParity);
        m_pUart->setDataBits(QSerialPort::Data8);
        m_pUart->setStopBits(QSerialPort::OneStop);
    }
    // The readyRead signal is emitted once, every time
    // new data is available for reading from the device.
    // http://doc.qt.io/qt-5/qiodevice.html#readyRead

    // Originally was doing this connection in resume() and
    // disconnect in pause(), but UART connection gets lost
    // if the device is open and no data is read from it for
    // a few seconds. So must keep reading at all times,
    // discarding data when pause()d.
//    connect(m_pUart.get(),  SIGNAL(readyRead()),
//            this,           SLOT(read()));
//    connect(m_pUart.get(),  SIGNAL(readyRead()),
//            this,           SLOT(read()));

    connect(m_pUart.get(),  SIGNAL(readyRead()),
            this,           SLOT(static_loop()));
    connect(m_pUart.get(),  SIGNAL(readyRead()),
            this,           SLOT(static_loop()));

   // m_pDbgTimer1 = std::make_unique<QTimer>(this);


    resumeService();
}

// Can delete this function if no UART-specific stuff needs to
// be done at resume()
void TEPLCWUARTService::resumeService()
{
    qDebug() << "Resuming UART Service";
    TEPLCWService::resumeService();
}

// Can delete this function if no UART-specific stuff needs to
// be done at pause()
void TEPLCWUARTService::pauseService()
{
    qDebug() << "Pausing UART Service";
    TEPLCWService::pauseService();
}

// Can delete this function if no UART-specific stuff needs to
// be done at stop()
void TEPLCWUARTService::stopService()
{
    qDebug("Stopping UART service");
    TEPLCWService::stopService();
}

// This is the slot that will do the UART reads.
// Read bytes from the UART; processRawData(), and put the
// output values into fifo.
void TEPLCWUARTService::read()
{
    // DELETEME: Only for the purposes of this demo. Want to have
    // at least 8 bytes read at a time for display purposes. Delete later.
  //  if (m_pUart->bytesAvailable() < 4)
  //      return;

   // qDebug() << m_pUart->readAll();

//    int numRead = m_pUart->read(m_pRecvBuffer.get(), BUFSIZE);
//   // qDebug() << numRead;
//    m_dbgSigmaNumRd += numRead;
}


void TEPLCWUARTService::static_loop()
{

  //  qDebug() << m_pUart->readAll();

    bool ok;

    QByteArray bytee;

    //   qDebug() << "IN SERIAL";

    if(config_parameter[0] == "CW1200" || config_parameter[0] == "CW3000" || config_parameter[0] == "CW6000"
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
    {



        chk_comfailfg = 0;


        if(static_startfg)
        {



            //if(serial.bytesAvailable() < 9)
            if(m_pUart->bytesAvailable() < 9)
            {


            }
            else
            {




                bytes1 = m_pUart->readAll();//serial.readAll();
                bytee = bytes1.toHex();
                qDebug() << bytee;//.toHex();

                if(chk_calib_errfg)
                {

                   // chk_calib_errfg = 0;

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
                    else if(((bin_val <= 0x7fd567) & (bin_val >= 0x7ed18d)) && (config_parameter[0] == "CW1200_COMBI"))
                    {
                        chk_calib_errfg = 0;

                        loadsteps = 38;
                        task1fg = 1;
                        task1ctr = 400;

                        qDebug() << "NO CALIB ERR";


                    }
                    //else if(((bin_val <= 0x7fc8e2) & (bin_val >= 0x7f029b)) && config_param.CW_3K)
                    else if(((bin_val <= CALIB_Hi) & (bin_val >= CALIB_Lo)) && ((config_parameter[0] == "CW3000") || (config_parameter[0] == "CW3000_1")))
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


                        show_caliberrfg = 1;
                        calib_errstepfg = 1;
                        chk_calib_errfg = 0;

                          qDebug() << bin_val << "CALIB COUNTS";


                    }


                }

                if(static_startfg)
                {
                    static_startfg = 0;
                    set_raw_bytes(ddd,bytes1);
                }



            }

        }
        else
        {
            rx_counter = 0;

           // bytes1 = serial.readAll();
            bytes1 = m_pUart->readAll();
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


            m_pUart->flush();

        }




    }

    if((config_parameter[0] == "CW600HSA") || (config_parameter[0] == "CW3000HSA") || (config_parameter[0] == "CW1200HSA"))
    {

        chk_comfailfg = 0;

        if(calibfg & (!conv_onfg))
        {

            rx_counter++;
            ddd[rx_counter] = m_pUart->read(1);//serial.read(1);
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


                        m_pUart->write(weighcell_ACK,1);


                    }
                    serial_enablefg = 0;
                    rx_counter = 0;
                    qDebug() << "AGAINNNN";


                    if(chk_calib_errfg)
                    {
                        if((ddd[5] == "E") & (ddd[9] == "5"))
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

            //if(serial.bytesAvailable() < 14)
            if(m_pUart->bytesAvailable() < 14)
            {

            }
            else
            {
                bytes1 = m_pUart->readAll();//serial.readAll();
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


void TEPLCWUARTService::set_raw_bytes(QByteArray bytes[],QByteArray bytes1)
{

    //bool ok;
    unsigned int temp_binval1;

    if((config_parameter[0] == "CW1200") || (config_parameter[0] == "CW3000")|| (config_parameter[0] == "CW6000")
            || config_parameter[0] == "CW1200_COMBI" || config_parameter[0] == "CW1200_COMBI1" || config_parameter[0] == "CW3000_COMBI" || (config_parameter[0] == "CW3000_1"))
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
        if(config_parameter[0] == "CW3000" || config_parameter[0] == "CW3000_1")
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

        //---------------------------------------------------------------

        bin_val = 0;

        QString fdfd;

       // fdfd = tr(bytes1);
        fdfd = QString(bytes1);

        if(fdfd.indexOf("E") != 1)
        {
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
        }

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
    else if(config_parameter[0] == "CW3000HSA" || (config_parameter[0] == "CW1200HSA"))
    {

        //---------------------------------------------------------------

        bin_val = 0;
        command_responsefg = 0;
        qDebug() << "command_responsectr" << command_responsectr;

        QString fdfd;

       // fdfd = tr(bytes1);
        fdfd = QString(bytes1);

        if(fdfd.indexOf("E") != 1)
        {
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
        }

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


        if(config_parameter[0] == "CW3000HSA")
        {

            bin_val = bin_val & 0xfffe;
            qDebug() << "Dynamic receive..........." << bin_val;
        }
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

