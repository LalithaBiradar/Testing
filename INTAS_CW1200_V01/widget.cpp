#include "widget.h"
#include <QtSql>
#include <QtDebug>
#include <qprinter.h>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>
#include <QPainter>
#include <QDesktopServices>
extern bool gen_batchpdf,gen_auditpdf,gen_alarampdf;

bool gen_reports;
extern QString batch_hder_userid;
extern float cpp_prd_target;
extern float cpp_prd_tare;
extern unsigned int cpp_prd_length;
extern float cpp_prd_Ulimit;
extern float cpp_prd_Llimit;
extern unsigned int cpp_prd_speed;
extern unsigned int cpp_opr_delay;
extern unsigned int cpp_hold_delay;
extern unsigned int cpp_rej_cnt;
extern bool prodnfg;
extern QString  cpp_prd_code;
extern QString  cpp_prd_name;
extern QString  cpp_prd_batchno;
extern QString global_datetime,global_stpdatetime;

extern QString demo_targetwt,demo_tarewt,demo_length;
extern QString demo_uplimit,demo_lolimit,demo_speed;
extern QString demo_oprdelay,demo_holddelay,demo_rejcnt;


extern QString demo_targetwt;
extern QString dataval;
extern QString report_compname;
extern QString report_L1Addr;
extern QString report_L2Addr;
extern QString report_machid;

extern float rej_percent;
extern QString batch_rej_percnt;
extern unsigned int uw_count,accp_count,ow_count;

#include<QFile>

QString batchstdttime;

extern QString var1;
extern QString stats_param[14];
extern QString batch_avgaccp_wt;
extern QString cpp_prd_code1,cpp_prd_name1,demo_targetwt1,demo_tarewt1,demo_length1,demo_uplimit1;
extern QString demo_lolimit1,demo_speed1,demo_oprdelay1,demo_holddelay1,demo_rejcnt1,demo_mdopr1;
extern QString demo_targetwt,demo_tarewt,demo_length;
extern QString demo_uplimit,demo_lolimit,demo_speed,demo_mdopr;
extern QString demo_oprdelay,demo_holddelay,demo_rejcnt;



QString btchnme,stdate,enddate;

extern short int rtc_sec,rtc_min,rtc_hour;
extern int rtc_day,rtc_month,rtc_year;

enum{


    dttm,
    prd_wt,
    prd_result,



    };



extern QString userid;

QString targetwt,prcssrttm;
QString batch_accp_cnt,batch_ow_cnt,batch_uw_cnt,batch_tot_cnt;



 QString prdcode,prdcodelbl,prdnm,prdnmlbl,batchnum,batchnumlbl,targetwtlbl,tarewt,tarewtlbl,prdlength,prdlengthlbl,uplmt,uplmtlbl,lwlmt,lwlmtlbl,speed,speedlbl,opdly,opdlylbl,hlddly,hlddlylbl,rejcnt,rejcntlbl;
 QString manufnm,machinenm,equipid,prntdttm,prcssrtdttm,prcsstpdttm,usrid,prdwt,prdresult;
Widget::Widget(QWidget *parent) :
    QWidget(parent)
{


    const QStringList titles {"Date & Time","Product Weight","Product Result"};
    const QStringList titles1 {"prd_cod_nm","prd_name_nm","batch_name_nm","target_wt_nm","tare_wt_nm","prd_length_nm","up_lmt_nm","lw_lmt_nm","speed_nm","opr_dly_nm","hld_dly_nm","rej_cnt_nm","md_dly_nm","uw_cnt","ok_cnt","ow_cnt","tot_cnt","std_dev","min_wt","max_wt","avg_acp_wt","batch_rej_per","Date & Time","Product Weight","Product Result"};

    pdfprocess = new QProcess(this);

}

Widget::~Widget()
{
  //  delete ui;
}

void Widget::gen_batchreport()
{

    QString local_batch;
    local_batch = cpp_prd_batchno;
    local_batch.remove(" ");

    if(gen_batchpdf)
    {
    gen_batchpdf = 0;
    QSqlQuery masterbatch("SELECT * FROM BATCH_NAME1");
    masterbatch.prepare("SELECT * FROM BATCH_NAME1 WHERE batch_name_nm = (:batch_name_nm)");
    masterbatch.bindValue(":batch_name_nm",local_batch);


    if(masterbatch.exec())
    {
        if(masterbatch.next())
        {
            qDebug() << "masterbatch.lastError()"<<masterbatch.value(0);
            qDebug() << "masterbatch.lastError()"<<masterbatch.value(1);
            qDebug() << "masterbatch.lastError()"<<masterbatch.value(2);

        }

    }

    btchnme= masterbatch.value(0).toString();
   stdate = masterbatch.value(1).toString();
    enddate = masterbatch.value(2).toString();

    gen_reports = 1;
qDebug() << btchnme << ";" << stdate << ";" << enddate << "sQL_Batch_Report";
    sQL_Batch_Report(btchnme,stdate,enddate);

    }

}



void Widget::on_addPushBtn_clicked()
{


prcssrtdttm = dataval.setNum(rtc_day,16);//ui->prcsstartdtlineEdit->text();
prcssrtdttm = prcssrtdttm.append("/");

prcssrtdttm = prcssrtdttm.append(dataval.setNum(rtc_month,16));
prcssrtdttm = prcssrtdttm.append("/");

prcssrtdttm = prcssrtdttm.append(dataval.setNum(rtc_year,16));
prcssrtdttm = prcssrtdttm.append("  ");


prcssrttm = dataval.setNum(rtc_hour,16);//ui->prcsstartdtlineEdit->text();
prcssrttm = prcssrttm.append(":");

prcssrttm = prcssrttm.append(dataval.setNum(rtc_min,16));
prcssrttm = prcssrttm.append(":");

prcssrttm = prcssrttm.append(dataval.setNum(rtc_sec,16));


prcssrtdttm = prcssrtdttm.append(prcssrttm);

qDebug() << prcssrtdttm;
qDebug() << dataval.setNum(rtc_day,16);
qDebug() << dataval.setNum(rtc_month,16);
qDebug() << dataval.setNum(rtc_year,16);


    prdcode = cpp_prd_code;//ui->prdcodelineEdit->text();
    prdcodelbl = "PRODUCT CODE";//ui->prdcodelbl->text();
    prdnm = cpp_prd_name;//ui->prdnamelineEdit->text();
    prdnmlbl = "PRODUCT NAME";//ui->prdnamelbl->text();
    batchnum = cpp_prd_batchno;//ui->batchnumlineEdit->text();
    batchnumlbl = "BATCH NUMBER";//ui->batchnumlbl->text();
   targetwt = demo_targetwt;//ui->targetlineedit->text();
   tarewt = demo_tarewt;//ui->tarewtlineEdit->text();
   prdlength = demo_length;//ui->prdlengthlineEdit->text();
   uplmt = demo_uplimit;//ui->uplmtlineEdit->text();
   lwlmt = demo_lolimit;//ui->lwlmtlineEdit->text();
    speed = demo_speed;//ui->speedlineEdit->text();
    opdly = demo_oprdelay;//ui->opdlylineEdit->text();
    hlddly = demo_holddelay;//ui->hlddlylineEdit->text();
    rejcnt = demo_rejcnt;//ui->rejcntlineEdit->text();

}

//----------------------------------------------------------------------------


void Widget::addBatchdetails()
{

    QString reportbatchNum;
    reportbatchNum = cpp_prd_batchno;
    reportbatchNum.remove(" "); //spl space prb

    if(reportbatchNum.at(0) >= '0' && reportbatchNum.at(0) <= '9')
    {
        reportbatchNum = "z"+reportbatchNum;

    }
qDebug() <<"ADdD BATCH DETAILS:"<<cpp_prd_batchno;
    if(prodnfg)
    {



        rej_percent = (uw_count + ow_count);
        rej_percent = rej_percent / (uw_count + ow_count + accp_count);
        rej_percent = rej_percent * 100;
        batch_rej_percnt =  QString::number(rej_percent);
        qDebug() << batch_rej_percnt << "REJ % VALUE";

        QSqlQuery queryAdd;

            queryAdd.prepare( "UPDATE " + reportbatchNum +  " SET uw_cnt = '" + stats_param[1] +  "', ok_cnt = '" + stats_param[2] + "', ow_cnt = '" + stats_param[3] + "', tot_cnt = '" + stats_param[4] + "', std_dev = '" + stats_param[5] + "', min_wt = '" + stats_param[7] + "', max_wt = '" + stats_param[8] + "', avg_acp_wt = '" + batch_avgaccp_wt + "', batch_rej_per = '" + batch_rej_percnt + "'" );
 //       queryAdd.prepare( "UPDATE " + reportbatchNum + " (prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per)VALUES('" + cpp_prd_code1 + "', '" + cpp_prd_name1 + "', '" + cpp_prd_batchno + "', '" + demo_targetwt1 + "', '" + demo_tarewt1 + "', '" + demo_length1 + "', '" + demo_uplimit1 + "', '" + demo_lolimit1 + "', '" + demo_speed1 + "', '" + demo_oprdelay1 + "', '" + demo_holddelay1 + "', '" + demo_rejcnt1 + "', '" + demo_mdopr1 + "', '" + stats_param[1] + "', '" + stats_param[2] + "', '" + stats_param[3] + "', '" + stats_param[4] + "', '" + stats_param[5] + "', '" + stats_param[7] + "', '" + stats_param[8] + "', '" + batch_avgaccp_wt + "', '" + batch_rej_percnt + "')" );


        if(queryAdd.exec())
        {

            qDebug() << "update query in add Batch details success: ";
        }
        else
        {
            qDebug() << "update query in add Batch details failed: " << queryAdd.lastError();
        }
   }

}

void Widget::addBatchdetails_setting()
{

    QString reportbatchNum;
    reportbatchNum = "SETTINGBATCH2";
    reportbatchNum.remove(" "); //spl space prb


 //   if(prodnfg)
    {



        rej_percent = (uw_count + ow_count);
        rej_percent = rej_percent / (uw_count + ow_count + accp_count);
        rej_percent = rej_percent * 100;
        batch_rej_percnt =  QString::number(rej_percent);
        qDebug() << batch_rej_percnt << "REJ % VALUE";

        QSqlQuery queryAdd;

            queryAdd.prepare( "UPDATE " + reportbatchNum +  " SET uw_cnt = '" + stats_param[1] +  "', ok_cnt = '" + stats_param[2] + "', ow_cnt = '" + stats_param[3] + "', tot_cnt = '" + stats_param[4] + "', std_dev = '" + stats_param[5] + "', min_wt = '" + stats_param[7] + "', max_wt = '" + stats_param[8] + "', avg_acp_wt = '" + batch_avgaccp_wt + "', batch_rej_per = '" + batch_rej_percnt + "'" );
 //       queryAdd.prepare( "UPDATE " + reportbatchNum + " (prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per)VALUES('" + cpp_prd_code1 + "', '" + cpp_prd_name1 + "', '" + cpp_prd_batchno + "', '" + demo_targetwt1 + "', '" + demo_tarewt1 + "', '" + demo_length1 + "', '" + demo_uplimit1 + "', '" + demo_lolimit1 + "', '" + demo_speed1 + "', '" + demo_oprdelay1 + "', '" + demo_holddelay1 + "', '" + demo_rejcnt1 + "', '" + demo_mdopr1 + "', '" + stats_param[1] + "', '" + stats_param[2] + "', '" + stats_param[3] + "', '" + stats_param[4] + "', '" + stats_param[5] + "', '" + stats_param[7] + "', '" + stats_param[8] + "', '" + batch_avgaccp_wt + "', '" + batch_rej_percnt + "')" );


        if(queryAdd.exec())
        {

            qDebug() << "update query in add Batch details success: ";
        }
        else
        {
            qDebug() << "update query in add Batch details failed: " << queryAdd.lastError();
        }
   }

}



void Widget::sQL_Batch_Report(QString d,QString strtDtTm,QString stpDtTm)
{

        qDebug() << d << "In sql batch report";
        qDebug() << strtDtTm << " start date time In sql batch report";
         qDebug() << stpDtTm << " stop date time In sql batch report";
        unsigned int r = 0,c = 0,num_rows = 0,k = 0,pgnum = 0;

        QString temppl;
        bool charfg;

        temppl = cpp_prd_batchno;

        QSqlQuery query;
        QStringList temp_value;

        temppl.remove(" ");



        if(d == temppl && prodnfg == 1)
        {
            addBatchdetails();
        }
        else if(d == "SETTINGBATCH2")
        {
            addBatchdetails_setting();
              qDebug() << "In sql batch reportdsadsadadsad";

        }

        d.remove(" ");
       // d = "SETTING_BATCH2";//need to remove compulsory
        var1 = "/0";
        var1 = "Dynamic" + d;

        if(temppl.at(0) >= '0' && temppl.at(0) <= '9')
        {
            temppl = "z"+temppl;
            charfg = 1;

        }
        if(d.at(0) >= '0' && d.at(0) <= '9')
        {
            d = "z"+d;
            charfg = 1;
        }

    prcsstpdttm = dataval.setNum(rtc_day,16);//ui->prcsstartdtlineEdit->text();
    prcsstpdttm = prcsstpdttm.append("/");

    prcsstpdttm = prcsstpdttm.append(dataval.setNum(rtc_month,16));
    prcsstpdttm = prcsstpdttm.append("/");

    prcsstpdttm = prcsstpdttm.append(dataval.setNum(rtc_year,16));
    prcsstpdttm = prcsstpdttm.append("  ");


    prcssrttm = dataval.setNum(rtc_hour,16);//ui->prcsstartdtlineEdit->text();
    prcssrttm = prcssrttm.append(":");

    prcssrttm = prcssrttm.append(dataval.setNum(rtc_min,16));
    prcssrttm = prcssrttm.append(":");
    prcssrttm = prcssrttm.append(dataval.setNum(rtc_sec,16));
    prcsstpdttm = prcsstpdttm.append(prcssrttm);

    prntdttm = prcsstpdttm;
//batchLoading(1);

    QPrinter printer;
    bool pgendfg = 0;
    QString footerpgnum,pgnumber;
    unsigned int totalpgs = 0;
//------------------to find the number of pages-------------------------------
    query.prepare( "SELECT date_time,dyn_wt,status FROM " + var1 );
  if( !query.exec())
    qDebug() << query.lastError();
  else
  {
  for(k=0,query.first();query.isValid();query.next(),++k){

   num_rows = k +1;
  }
  }
  qDebug() << "the number of rows = "<<num_rows;
  if(num_rows >= 13){
  totalpgs = num_rows - 13;
  totalpgs = totalpgs / 32;
  qDebug() << "the number of pages = "<<totalpgs;
    if(((totalpgs * 32) != (num_rows - 12)) && (totalpgs != 0)){
        qDebug() << "add one more page ";
        totalpgs = totalpgs + 2;
        footerpgnum = QString::number(totalpgs);

     qDebug() << "modified number of pages = "<<totalpgs;
    }
    else if((totalpgs == 0) && (num_rows > 12)){// && (num_rows < 34)){
        qDebug() << "only one page present ";
        totalpgs = totalpgs + 2;
        footerpgnum = QString::number(totalpgs);
    }

  }
  else{
    totalpgs = 0;
    qDebug() << "the number of pages = "<<totalpgs;
     if((totalpgs == 0) && (num_rows < 13)){
        qDebug() << "only one page present ";
        totalpgs = totalpgs + 1;
        footerpgnum = QString::number(totalpgs);
    }
  }

//----------------------------------------------------------------------------
//       query.prepare( "SELECT prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per FROM KA91089");
               query.prepare( "SELECT prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per FROM " + d );

       if( !query.exec() )
         qDebug() << query.lastError();
       else
       {

         qDebug( "Selected!" );
         //for(r=0,query.first();query.isValid();query.next(),++r)
         {

             query.first();
             for(c = 0; c < 22; ++c){

                 temp_value<<query.value(c).toString();

             }

             qDebug() << r << "number of rows batch report header";
             qDebug() << temp_value << "temp";

         }
       }
       QString share_location;
       share_location = "/home/odroid/share_batchFiles/" + temp_value[2] + ".pdf";
       printer.setOutputFormat(QPrinter::PdfFormat);
//       printer.setOutputFileName("F:\\ nonwritable.pdf");
       printer.setOutputFileName(share_location);

       QPainter painter;
       if (! painter.begin(&printer)) { // failed to open file
           qWarning("failed to open file, is it writable?");
         //  return 1;
       }



       QPen myPen(Qt::black, 1, Qt::SolidLine);
       painter.setPen(myPen);
       painter.setFont(QFont("times",12));
       myPen.setColor(QColor("brown"));
       painter.setPen(myPen);
       painter.drawText(330, 5, "BATCH REPORT");
       myPen.setColor(QColor("black"));
       painter.setPen(myPen);
       painter.setFont(QFont("times",8));
       painter.drawRect(0, 20, 115, 75);
       painter.drawImage(QRect(2,22,113,73),QImage("/home/odroid/Projects/Qt/logo"));
       painter.drawRect(115, 20, 645, 75);
       painter.setFont(QFont("times",14));
       painter.drawText(120, 40, report_compname);
       painter.setFont(QFont("times",10));
       painter.drawText(120, 60, report_L1Addr);
       painter.drawText(120, 80, report_L2Addr);

       painter.setFont(QFont("times",8));
       painter.drawRect(0, 95, 150, 42);
       painter.drawText(5, 115, "COMPANY NAME");
       painter.drawRect(150, 95, 219, 42);
       painter.drawText(151, 115, report_compname);

       painter.drawText(371, 115, "PRINT DATE & TIME");
       painter.drawRect(369, 95, 222, 42);
       painter.drawRect(591, 95, 169, 42);
       painter.drawText(593, 115, global_datetime);//prntdttm);

       painter.drawRect(0, 137, 150, 42);
       painter.drawText(5, 157, "MACHINE ID");
       painter.drawRect(150, 137, 219, 42);
       painter.drawText(151, 157, report_machid);

       painter.drawText(371, 157, "PROCESS START DATE & TIME");
       painter.drawRect(369, 137, 222, 42);
       painter.drawRect(591, 137, 169, 42);
       painter.drawText(593, 157, strtDtTm);

       painter.fillRect(0,179,150,42,QColor("yellow"));
       painter.drawRect(0, 179, 150, 42);
   //    painter.setFont(QFont("times",8));
       myPen.setColor(QColor("blue"));
       painter.setPen(myPen);
       painter.drawText(5, 199, "BATCH NUMBER");

       myPen.setColor(QColor("black"));
       painter.setPen(myPen);
       painter.fillRect(150,179,219,42,QColor("yellow"));
       painter.drawRect(150, 179, 219, 42);
       myPen.setColor(QColor("blue"));
       painter.setPen(myPen);
       painter.drawText(151, 199, temp_value[2]);
       myPen.setColor(QColor("black"));
       painter.setPen(myPen);


       painter.drawText(371, 199, "PROCESS STOP DATE & TIME");
       painter.drawRect(369, 179, 222, 42);
       painter.drawRect(591, 179, 169, 42);
       painter.drawText(593, 199, stpDtTm);

     /*  painter.fillRect(0,221,49,30,QColor("cyan"));
       painter.drawRect(0, 221, 49, 30);
       painter.drawText(1, 241, "SR.NO.");
       painter.fillRect(49,221,150,30,QColor("cyan"));
       painter.drawRect(49, 221, 150, 30);
       painter.drawText(50, 241, "RECIPE PARAMETER NAME");
       painter.fillRect(199,221,180,30,QColor("cyan"));
       painter.drawRect(199, 221, 180, 30);
       painter.drawText(200, 241, "SET VALUE");
       painter.fillRect(379,221,48,30,QColor("cyan"));
       painter.drawRect(379, 221, 48, 30);
       painter.drawText(380, 241, "SR.NO.");
       painter.fillRect(427,221,150,30,QColor("cyan"));
       painter.drawRect(427, 221, 150, 30);
       painter.drawText(428, 241, "RECIPE PARAMETER NAME");
       painter.fillRect(577,221,183,30,QColor("cyan"));
       painter.drawRect(577, 221, 183, 30);
       painter.drawText(578, 241, "SET VALUE");


       painter.drawRect(0, 251, 49, 30);
       painter.drawText(20, 271, "1.");
       painter.drawRect(49, 251, 150, 30);
       painter.drawText(50, 271, "PRODUCT CODE");
       painter.drawRect(199, 251, 180, 30);
       painter.drawText(200, 271, temp_value[0]);
       painter.drawRect(379, 251, 48, 30);
       painter.drawText(399, 271, "7.");
       painter.drawRect(427, 251, 150, 30);
       painter.drawText(428, 271, "LOWER LIMIT");
       painter.drawRect(577, 251, 183, 30);
       painter.drawText(578, 271, temp_value[7] + " g");

       painter.drawRect(0, 281, 49, 30);
       painter.drawText(20, 301, "2.");
       painter.drawRect(49, 281, 150, 30);
       painter.drawText(50, 301, "PRODUCT NAME");
       painter.drawRect(199, 281, 180, 30);
       painter.drawText(200, 301, temp_value[1]);
       painter.drawRect(379, 281, 48, 30);
       painter.drawText(399, 301, "8.");
       painter.drawRect(427, 281, 150, 30);
       painter.drawText(428, 301, "SPEED");
       painter.drawRect(577, 281, 183, 30);
       painter.drawText(578, 301, temp_value[8] + " ppm");

       painter.drawRect(0, 311, 49, 30);
       painter.drawText(20, 331, "3.");
       painter.drawRect(49, 311, 150, 30);
       painter.drawText(50, 331, "TARGET WEIGHT");
       painter.drawRect(199, 311, 180, 30);
       painter.drawText(200, 331, temp_value[3] + " g");
       painter.drawRect(379, 311, 48, 30);
       painter.drawText(399, 331, "9.");
       painter.drawRect(427, 311, 150, 30);
       painter.drawText(428, 331, "OPERATE DLY(CW)");
       painter.drawRect(577, 311, 183, 30);
       painter.drawText(578, 331, temp_value[9]);

       painter.drawRect(0, 341, 49, 30);
       painter.drawText(20, 361, "4.");
       painter.drawRect(49, 341, 150, 30);
       painter.drawText(50, 361, "TARE WEIGHT");
       painter.drawRect(199, 341, 180, 30);
       painter.drawText(200, 361, temp_value[4] + " g");
       painter.drawRect(379, 341, 48, 30);
       painter.drawText(399, 361, "10.");
       painter.drawRect(427, 341, 150, 30);
       painter.drawText(428, 361, "HOLD DELAY");
       painter.drawRect(577, 341, 183, 30);
       painter.drawText(578, 361, temp_value[10]);

       painter.drawRect(0, 371, 49, 30);
       painter.drawText(20, 391, "5.");
       painter.drawRect(49, 371, 150, 30);
       painter.drawText(50, 391, "PRODUCT LENGTH");
       painter.drawRect(199, 371, 180, 30);
       painter.drawText(200, 391, temp_value[5] + " mm");
       painter.drawRect(379, 371, 48, 30);
       painter.drawText(399, 391, "11.");
       painter.drawRect(427, 371, 150, 30);
       painter.drawText(428, 391, "OPERATE DLY(MD)");
       painter.drawRect(577, 371, 183, 30);
       painter.drawText(578, 391, temp_value[12]); //1

       painter.drawRect(0, 401, 49, 30);
       painter.drawText(20, 421, "6.");
       painter.drawRect(49, 401, 150, 30);
       painter.drawText(50, 421, "UPPER LIMIT");
       painter.drawRect(199, 401, 180, 30);
       painter.drawText(200, 421, temp_value[6] + " g");
       painter.drawRect(379, 401, 48, 30);
       painter.drawText(399, 421, "12.");
       painter.drawRect(427, 401, 150, 30);
       painter.drawText(428, 421, "REJECT COUNT");
       painter.drawRect(577, 401, 183, 30);
       painter.drawText(578, 421, temp_value[11]);
       */
       painter.fillRect(0,221,40,30,QColor("cyan"));
       painter.drawRect(0, 221, 40, 30);
       painter.drawText(1, 241, "SR.NO.");
       painter.fillRect(40,221,150,30,QColor("cyan"));
       painter.drawRect(40, 221, 150, 30);
       painter.drawText(45, 241, "RECIPE PARAMETER NAME");
       painter.fillRect(190,221,260,30,QColor("cyan"));
       painter.drawRect(190, 221, 260, 30);
       painter.drawText(195, 241, "SET VALUE"); // Trail
       painter.fillRect(450,221,40,30,QColor("cyan"));
       painter.drawRect(450, 221, 40, 30);
       painter.drawText(452, 241, "SR.NO.");
       painter.fillRect(490,221,160,30,QColor("cyan"));
       painter.drawRect(490, 221, 160, 30);
       painter.drawText(492, 241, "RECIPE PARAMETER NAME");
       painter.fillRect(650,221,110,30,QColor("cyan"));
       painter.drawRect(650, 221, 110, 30);
       painter.drawText(655, 241, "SET VALUE");


       painter.drawRect(0, 251, 40, 30);
       painter.drawText(10, 271, "1.");
       painter.drawRect(40, 251, 150, 30);
       painter.drawText(45, 271, "PRODUCT CODE");
       painter.drawRect(190, 251, 260, 30);
       painter.drawText(193, 271, temp_value[0]);
       painter.drawRect(450, 251, 40, 30);
       painter.drawText(460, 271, "7.");
       painter.drawRect(490, 251, 160, 30);
       painter.drawText(495, 271, "LOWER LIMIT");
       painter.drawRect(650, 251, 110, 30);
       painter.drawText(655, 271, temp_value[7] + " g");

       painter.drawRect(0, 281, 40, 30);
       painter.drawText(10, 301, "2.");
       painter.drawRect(40, 281, 150, 30);
       painter.drawText(45, 301, "PRODUCT NAME");
       painter.drawRect(190, 281, 260, 30);
       painter.drawText(193, 301, temp_value[1]);
       painter.drawRect(450, 281, 40, 30);
       painter.drawText(460, 301, "8.");
       painter.drawRect(490, 281, 160, 30);
       painter.drawText(495, 301, "SPEED");
       painter.drawRect(650, 281, 110, 30);
       painter.drawText(655, 301, temp_value[8] + " ppm");

       painter.drawRect(0, 311, 40, 30);
       painter.drawText(10, 331, "3.");
       painter.drawRect(40, 311, 150, 30);
       painter.drawText(45, 331, "TARGET WEIGHT");
       painter.drawRect(190, 311, 260, 30);
       painter.drawText(195, 331, temp_value[3] + " g");
       painter.drawRect(450, 311, 40, 30);
       painter.drawText(460, 331, "9.");
       painter.drawRect(490, 311, 160, 30);
       painter.drawText(495, 331, "OPERATE DLY(CW)");
       painter.drawRect(650, 311, 110, 30);
       painter.drawText(655, 331, temp_value[9]);

       painter.drawRect(0, 341, 40, 30);
       painter.drawText(10, 361, "4.");
       painter.drawRect(40, 341, 150, 30);
       painter.drawText(45, 361, "TARE WEIGHT");
       painter.drawRect(190, 341, 260, 30);
       painter.drawText(195, 361, temp_value[4] + " g");
       painter.drawRect(450, 341, 40, 30);
       painter.drawText(460, 361, "10.");
       painter.drawRect(490, 341, 160, 30);
       painter.drawText(495, 361, "HOLD DELAY");
       painter.drawRect(650, 341, 110, 30);
       painter.drawText(655, 361, temp_value[10]);

       painter.drawRect(0, 371, 40, 30);
       painter.drawText(10, 391, "5.");
       painter.drawRect(40, 371, 150, 30);
       painter.drawText(45, 391, "PRODUCT LENGTH");
       painter.drawRect(190, 371, 260, 30);
       painter.drawText(195, 391, temp_value[5] + " mm");
       painter.drawRect(450, 371, 40, 30);
       painter.drawText(460, 391, "11.");
       painter.drawRect(490, 371, 160, 30);
       painter.drawText(495, 391, "OPERATE DLY(MD)");
       painter.drawRect(650, 371, 110, 30);
       painter.drawText(655, 391, temp_value[12]); //1

       painter.drawRect(0, 401, 40, 30);
       painter.drawText(10, 421, "6.");
       painter.drawRect(40, 401, 150, 30);
       painter.drawText(45, 421, "UPPER LIMIT");
       painter.drawRect(190, 401, 260, 30);
       painter.drawText(195, 421, temp_value[6] + " g");
       painter.drawRect(450, 401, 40, 30);
       painter.drawText(460, 421, "12.");
       painter.drawRect(490, 401, 160, 30);
       painter.drawText(495, 421, "REJECT COUNT");
       painter.drawRect(650, 401, 110, 30);
       painter.drawText(655, 421, temp_value[11]);

       painter.drawRect(0, 431, 760, 30);
       painter.drawText(330, 451, "PRODUCTION REPORT");

       painter.drawRect(0, 461, 190, 30);
       painter.drawText(50, 481, "GOOD PRODUCT COUNT");
       painter.drawRect(190, 461, 190, 30);
       painter.drawText(240, 481, "OW PRODUCT COUNT");
       painter.drawRect(380, 461, 190, 30);
       painter.drawText(430, 481, "UW PRODUCT COUNT");
       painter.drawRect(570, 461, 190, 30);
       painter.drawText(620, 481, "TOTAL PRODUCT COUNT");

       painter.drawRect(0, 491, 190, 30);
       painter.drawText(50, 511, temp_value[14]);
       painter.drawRect(190, 491, 190, 30);
       painter.drawText(240, 511, temp_value[15]);
       painter.drawRect(380, 491, 190, 30);
       painter.drawText(430, 511, temp_value[13]);
       painter.drawRect(570, 491, 190, 30);
       painter.drawText(620, 511, temp_value[16]);


       painter.drawRect(0, 521, 190, 30);
       painter.drawText(20, 541, "MAXIMUM ACCEPT WEIGHT");
       painter.drawRect(190, 521, 190, 30);
       painter.drawText(240, 541, temp_value[19] + " g");

       painter.drawRect(380, 521, 190, 30);
       painter.drawText(400, 541, "AVERAGE ACCEPT WEIGHT");
       painter.drawRect(570, 521, 190, 30);
       painter.drawText(620, 541, temp_value[20] + " g");

       painter.drawRect(0, 551, 190, 30);
       painter.drawText(20, 571, "MINIMUM ACCEPT WEIGHT");
       painter.drawRect(190, 551, 190, 30);
       painter.drawText(240, 571, temp_value[18] + " g");

//                 rej_percent = (uw_count + ow_count);
//                 rej_percent = rej_percent / (uw_count + ow_count + accp_count);
//                 rej_percent = rej_percent * 100;
//                 batch_rej_percnt =  QString::number(rej_percent);


       painter.drawRect(380, 551, 190, 30);
       painter.drawText(400, 571, "REJECTION %");
       painter.drawRect(570, 551, 190, 30);
       painter.drawText(620, 571, temp_value[21]);

       painter.drawRect(0, 581, 190, 30);
       painter.drawText(20, 601, "STANDARD DEVIATION");
       painter.drawRect(190, 581, 190, 30);
       painter.drawText(240, 601, temp_value[17]);

      painter.fillRect(0,611,760,30,QColor("yellow"));
       painter.drawRect(0, 611, 760, 30);
       myPen.setColor(QColor("blue"));
       painter.setPen(myPen);
       painter.drawText(50, 631, "BATCH NUMBER:");
       painter.drawText(400, 631, temp_value[2]);

       myPen.setColor(QColor("black"));
       painter.setPen(myPen);
       painter.fillRect(0,641,760,30,QColor("cyan"));
       painter.drawRect(0, 641, 760, 30);
       painter.drawText(330, 661, "PRODUCTION DETAIL REPORT");


       painter.fillRect(0,671,190,30,QColor("cyan"));
       painter.drawRect(0, 671, 190, 30);
       painter.drawText(50, 691, "SR.NO.");


       painter.fillRect(190,671,190,30,QColor("cyan"));
       painter.drawRect(190, 671, 190, 30);
       painter.drawText(240, 691, "DATE & TIME");
       painter.fillRect(380,671,190,30,QColor("cyan"));
       painter.drawRect(380, 671, 190, 30);
       painter.drawText(430, 691, "PRODUCT WEIGHT");
       painter.fillRect(570,671,190,30,QColor("cyan"));
       painter.drawRect(570, 671, 190, 30);
       painter.drawText(620, 691, "PRODUCT RESULT");



       QStringList dynamiclist;
       QString dynWt;

//       query.prepare( "SELECT date_time,dyn_wt,status FROM DynamicKA91089");
       query.prepare( "SELECT date_time,dyn_wt,status FROM " + var1 );
       if( !query.exec())
         qDebug() << query.lastError();
       else
       {
         qDebug( "Selected!" );

         int x_pos = 0,rx_pos,ry_pos,rxtext_pos=0;
         int y_pos = 701;            //611;
       //  int width = 253;
         int width = 190;
          int height = 30;
          int i=0;

          int x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
          int y_pos1 = 90;
        //   int width1 = 253;
           int width1 = 190;
          int  height1 = 30;
          int j = 0;
          int pgcnt = 0;
          QString srno;

   //       for(r=0,query.first();query.isValid();query.next(),++r){
              for(k=0,query.first();query.isValid();query.next(),++k){
              dynamiclist.clear();
               srno = QString::number(k + 1);
               qDebug() << "number of rows :" << k;

              for(c = 0; c < 3; ++c){
                  dynamiclist<< query.value(c).toString();
              }
              qDebug() << dynamiclist;
              if(k<=11){
                  if(i == 0){
                      y_pos = y_pos;
                  }
                  else{
                      height = 30;
                      y_pos = y_pos + height;
                  }
                  i++;

                   if(dynamiclist[2] == "UW"){
                  painter.fillRect(x_pos,y_pos,width,height,QColor("orange"));
                  painter.drawRect(x_pos, y_pos, width, height);
                  ry_pos = y_pos + 20;
                  rxtext_pos = x_pos + 50;
                  qDebug() << "rxtext_pos"<<rxtext_pos;
                  qDebug() << "ry_pos"<<ry_pos;
                  qDebug() << "dynamiclist[0]"<<dynamiclist[0];
//                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);
                  painter.drawText(rxtext_pos, ry_pos, srno);

                  rx_pos = x_pos + width;
                  painter.fillRect(rx_pos,y_pos,width,height,QColor("orange"));
                  painter.drawRect(rx_pos, y_pos, width, height);
                  rxtext_pos = rx_pos + 50;
 //                 painter.drawText(rxtext_pos, ry_pos, dynamiclist[1]);
                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);

                  rx_pos = rx_pos + width;
                  painter.fillRect(rx_pos,y_pos,width,height,QColor("orange"));
                  painter.drawRect(rx_pos, y_pos, width, height);
                  rxtext_pos = rx_pos + 50;

                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[1] + " g");


                  rx_pos = rx_pos + width;
                  painter.fillRect(rx_pos,y_pos,width,height,QColor("orange"));
                  painter.drawRect(rx_pos, y_pos, width, height);
                  rxtext_pos = rx_pos + 50;
                  dynWt = dynamiclist[2] + " g";
                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[2]);
                  }

                  else if(dynamiclist[2] == "OW"){
                  painter.fillRect(x_pos,y_pos,width,height,QColor("red"));
                  painter.drawRect(x_pos, y_pos, width, height);
                  ry_pos = y_pos + 20;
                  rxtext_pos = x_pos + 50;
                  qDebug() << "rxtext_pos"<<rxtext_pos;
                  qDebug() << "ry_pos"<<ry_pos;
                  qDebug() << "dynamiclist[0]"<<dynamiclist[0];
          //        painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);
                 painter.drawText(rxtext_pos, ry_pos, srno);

                 rx_pos = x_pos + width;
                 painter.fillRect(rx_pos,y_pos,width,height,QColor("red"));
                 painter.drawRect(rx_pos, y_pos, width, height);
                 rxtext_pos = rx_pos + 50;
                 painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);

                  rx_pos = rx_pos + width;
                  painter.fillRect(rx_pos,y_pos,width,height,QColor("red"));
                  painter.drawRect(rx_pos, y_pos, width, height);
                  rxtext_pos = rx_pos + 50;
                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[1] + " g");


                  rx_pos = rx_pos + width;
                  painter.fillRect(rx_pos,y_pos,width,height,QColor("red"));
                  painter.drawRect(rx_pos, y_pos, width, height);
                  rxtext_pos = rx_pos + 50;
                  painter.drawText(rxtext_pos, ry_pos, dynamiclist[2]);
                  }
                  else{
                       painter.drawRect(x_pos, y_pos, width, height);
                       ry_pos = y_pos + 20;
                       rxtext_pos = x_pos + 50;
                       qDebug() << "rxtext_pos"<<rxtext_pos;
                       qDebug() << "ry_pos"<<ry_pos;
                       qDebug() << "dynamiclist[0]"<<dynamiclist[0];
           //            painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);
                       painter.drawText(rxtext_pos, ry_pos, srno);

                       rx_pos = x_pos + width;
                       painter.drawRect(rx_pos, y_pos, width, height);
                       rxtext_pos = rx_pos + 50;
                       painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);

          //             rx_pos = x_pos + width;
                       rx_pos = rx_pos + width;
                       painter.drawRect(rx_pos, y_pos, width, height);
                       rxtext_pos = rx_pos + 50;
                       painter.drawText(rxtext_pos, ry_pos, dynamiclist[1] + " g");

                      rx_pos = rx_pos + width;
                      painter.drawRect(rx_pos, y_pos, width, height);
                      rxtext_pos = rx_pos + 50;
                      painter.drawText(rxtext_pos, ry_pos, dynamiclist[2]);
                      ry_pos = ry_pos + 40;
                  }

                  qDebug() << k << "count";
              }
              else{
                    if(k == 12){
                     pgnum++;
                     pgnumber = QString::number(pgnum);
                     painter.drawText(700, 1091, pgnumber +" of " + footerpgnum);
                     painter.drawText(100, 1091, "DONE BY ----------------");
                     painter.drawText(560, 1091, "CHECKED BY ----------------");
                    }

                  if(!pgendfg){
                      if (! printer.newPage()) {
                          qWarning("failed in flushing page to disk, disk full?");
                          //return 1;
                      }
                      else{
                          painter.fillRect(0,0,760,30,QColor("yellow"));
                          painter.drawRect(0, 0, 760, 30);
                          myPen.setColor(QColor("blue"));
                          painter.setPen(myPen);
                          painter.drawText(50, 20, "BATCH NUMBER:");
                          painter.drawText(400, 20, temp_value[2]);
                          myPen.setColor(QColor("black"));
                          painter.setPen(myPen);
                          painter.fillRect(0,30,760,30,QColor("cyan"));
                          painter.drawRect(0, 30, 760, 30);
                          painter.drawText(330, 50, "PRODUCTION DETAIL REPORT");


                          painter.fillRect(0,60,190,30,QColor("cyan"));
                          painter.drawRect(0, 60, 190, 30);
                          painter.drawText(50, 80, "SR.NO.");
                          painter.fillRect(190,60,190,30,QColor("cyan"));
                          painter.drawRect(190, 60, 190, 30);
                          painter.drawText(240, 80, "DATE & TIME");
                          painter.fillRect(380,60,190,30,QColor("cyan"));
                          painter.drawRect(380, 60, 190, 30);
                          painter.drawText(430, 80, "PRODUCT WEIGHT");
                          painter.fillRect(570,60,190,30,QColor("cyan"));
                          painter.drawRect(570, 60, 190, 30);
                          painter.drawText(620, 80, "PRODUCT RESULT");

                      }
                  }
                  qDebug() << y_pos1 << "y_pos1";
                  pgcnt = 31;                    //(1050 - y_pos1) / 30;
                  qDebug() << pgcnt << "pgcnt";
       //           if(j <= pgcnt){
                  if(j < pgcnt){
                      if(j == 0){
                          y_pos1 = y_pos1;
                      }
                      else{
                          height1 = 30;
                          y_pos1 = y_pos1 + height1;
                      }
                      j++;
                      pgendfg = 1;
                      qDebug() << "number of rows1 :" << k;
                      if(dynamiclist[2] == "UW"){
                      painter.fillRect(x_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(x_pos1, y_pos1, width1, height1);
                      ry_pos1 = y_pos1 + 20;
                      rxtext_pos1 = x_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      qDebug() << "dynamiclist[0]"<<dynamiclist[0];
         //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                      painter.drawText(rxtext_pos1, ry_pos1, srno);

                      rx_pos1 = x_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");


                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);
                      }
                     else if(dynamiclist[2] == "OW"){
                      painter.fillRect(x_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(x_pos1, y_pos1, width1, height1);
                      ry_pos1 = y_pos1 + 20;
                      rxtext_pos1 = x_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      qDebug() << "dynamiclist[0]"<<dynamiclist[0];
         //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                      painter.drawText(rxtext_pos1, ry_pos1, srno);

                      rx_pos1 = x_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");


                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);
                      }
                      else{
                          painter.drawRect(x_pos1, y_pos1, width1, height1);
                          ry_pos1 = y_pos1 + 20;
                          rxtext_pos1 = x_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          qDebug() << "dynamiclist[0]"<<dynamiclist[0];
               //           painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                          painter.drawText(rxtext_pos1, ry_pos1, srno);

                          rx_pos1 = x_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                          rx_pos1 = rx_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");

                          rx_pos1 = rx_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);

                      }
                  }
                  else{
                      height1 = 30;
                      y_pos1 = y_pos1 + height1;

                      if(dynamiclist[2] == "UW"){
                      painter.fillRect(x_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(x_pos1, y_pos1, width1, height1);
                      ry_pos1 = y_pos1 + 20;
                      rxtext_pos1 = x_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      qDebug() << "dynamiclist[0]"<<dynamiclist[0];
         //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                      painter.drawText(rxtext_pos1, ry_pos1, srno);

                      rx_pos1 = x_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");


                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);
                      }
                     else if(dynamiclist[2] == "OW"){
                      painter.fillRect(x_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(x_pos1, y_pos1, width1, height1);
                      ry_pos1 = y_pos1 + 20;
                      rxtext_pos1 = x_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      qDebug() << "dynamiclist[0]"<<dynamiclist[0];
         //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                      painter.drawText(rxtext_pos1, ry_pos1, srno);

                      rx_pos1 = x_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");


                      rx_pos1 = rx_pos1 + width1;
                      painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("red"));
                      painter.drawRect(rx_pos1, y_pos1, width1, height1);
                      rxtext_pos1 = rx_pos1 + 50;
                      qDebug() << "rxtext_pos1"<<rxtext_pos1;
                      qDebug() << "ry_pos1"<<ry_pos1;
                      painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);
                      }
                      else{
                          painter.drawRect(x_pos1, y_pos1, width1, height1);
                          ry_pos1 = y_pos1 + 20;
                          rxtext_pos1 = x_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          qDebug() << "dynamiclist[0]"<<dynamiclist[0];
               //           painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                          painter.drawText(rxtext_pos1, ry_pos1, srno);

                          rx_pos1 = x_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                          rx_pos1 = rx_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1] + " g");

                          rx_pos1 = rx_pos1 + width1;
                          painter.drawRect(rx_pos1, y_pos1, width1, height1);
                          rxtext_pos1 = rx_pos1 + 50;
                          qDebug() << "rxtext_pos1"<<rxtext_pos1;
                          qDebug() << "ry_pos1"<<ry_pos1;
                          painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);

                      }
                      pgnum++;
                      pgnumber = QString::number(pgnum);
                      painter.drawText(700, ry_pos1 + 20, pgnumber +" of "+footerpgnum);
                      j=0;
                      pgendfg = 0;
                      x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
                      y_pos1 = 90;
                      width1 = 190;
                      height1 = 30;

                      pgcnt = 0;
                      qDebug() << "number of rows2 :" << k;
                  }

              }
          }
   //       if(((r<=11) | (j <= pgcnt)) & (pgendfg == 0)){
          if(((k<=11) | (j <= pgcnt)) & (pgendfg == 0)){

  //           painter.drawText(100, 1040, "DONE BY --------------------");
  //           painter.drawText(560, 1040, "CHECKED BY --------------------");

          }
          qDebug() << "number of rows :" << k;
          qDebug() << "number of num_rows :" << num_rows;
          if(k == num_rows){
            painter.drawText(100, 1091, "DONE BY ----------------");
            painter.drawText(560, 1091, "CHECKED BY ----------------");

            if(j==0)
            {
                if(k<=12)
                {
                    pgnum++;
                    pgnumber = QString::number(pgnum);
                    painter.drawText(700, 1091, pgnumber +" of "+footerpgnum);

                }

            }
            else
            {
                pgnum++;
                pgnumber = QString::number(pgnum);
                painter.drawText(700, 1091, pgnumber +" of "+footerpgnum);
            }
           // pgnum++;
           // pgnumber = QString::number(pgnum);
            //painter.drawText(700, 1091, pgnumber +" of "+footerpgnum);
            pgnum = 0;
          }
          x_pos = 0;
          rx_pos = 0;
          ry_pos = 0;
          rxtext_pos=0;
          y_pos = 701;            //701;            //611;
       //  int width = 253;
          width = 190;            //190;
          height = 30;
           i=0;

           x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
           y_pos1 = 90;
        //   int width1 = 253;
            width1 = 190;
            height1 = 30;
           j = 0;
           pgcnt = 0;
       }

//       QDesktopServices::openUrl(QUrl(share_location));
       if(gen_reports == 0)
       {
          // QDesktopServices::openUrl(QUrl(share_location));
         //  openbatch_pdffg = 1;
       }
       else
       {
           gen_reports = 0;

       }
       if(charfg)
       {
           charfg = 0;
           if(d.at(0) == "z")
           {
              d.remove(0,1);
           }

       }
}



void Widget::open_batchpdf(QString d,QString strtDtTm,QString stpDtTm)
{

    qDebug() << d << ";" << strtDtTm << ";" << stpDtTm << "open_batchpdf";
    d.remove(" ");
    if(prodnfg)
    {
        qDebug() << "BATCH ACTIVE";
        sQL_Batch_Report(d,strtDtTm,stpDtTm);

    }
    else if(d == "SETTINGBATCH2")
    {
        qDebug() << "SETTING BATCH ACTIVE";
        sQL_Batch_Report(d,strtDtTm,stpDtTm);
    }
    else
    {
        sQL_Batch_Report(d,strtDtTm,stpDtTm);

    }

    QString share_location;

    share_location = "/home/odroid/share_batchFiles/" + d + ".pdf";

    if(QFile::exists("/home/odroid/Projects/Qt/pdffileopen.txt"))
    {
         qDebug() << "FILE ALREADY EXIST";
        QFile::remove("/home/odroid/Projects/Qt/pdffileopen.txt");
        QFile pdfOpen("/home/odroid/Projects/Qt/pdffileopen.txt");
        if(!pdfOpen.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
            qDebug() << "file already there";
        }
        QTextStream writeData(&pdfOpen);
        writeData << share_location;
        pdfOpen.close();



    }
    else
    {
        qDebug() << "FILE NEWLY CREATED";

        QFile pdfOpen("/home/odroid/Projects/Qt/pdffileopen.txt");
        if(!pdfOpen.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
            qDebug() << "file already there";
        }
        QTextStream writeData(&pdfOpen);
        writeData << share_location;
        pdfOpen.close();
    }

    QString program("/home/odroid/Projects/Qt/pdfviewer");

    pdfprocess->setProgram(program);
     pdfprocess->close();
    pdfprocess->start();

}



void Widget::open_manualpdf(void)
{



    QString share_location;

    share_location = "/home/odroid/Projects/Qt/Manual_nextGen_Checkweigher.pdf";

    if(QFile::exists("/home/odroid/Projects/Qt/pdffileopen.txt"))
    {
         qDebug() << "FILE ALREADY EXIST";
        QFile::remove("/home/odroid/Projects/Qt/pdffileopen.txt");
        QFile pdfOpen("/home/odroid/Projects/Qt/pdffileopen.txt");
        if(!pdfOpen.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
            qDebug() << "file already there";
        }
        QTextStream writeData(&pdfOpen);
        writeData << share_location;
        pdfOpen.close();



    }
    else
    {
        qDebug() << "FILE NEWLY CREATED";

        QFile pdfOpen("/home/odroid/Projects/Qt/pdffileopen.txt");
        if(!pdfOpen.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
            qDebug() << "file already there";
        }
        QTextStream writeData(&pdfOpen);
        writeData << share_location;
        pdfOpen.close();
    }

    QString program("/home/odroid/Projects/Qt/pdfviewer");
    pdfprocess->setProgram(program);
    pdfprocess->close();
    pdfprocess->start();

}




