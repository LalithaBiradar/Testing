#include "widgetalaram.h"
#include <QPainter>
#include <QDesktopServices>
#include <qprinter.h>
#include <QtSql>
#include <QtDebug>

QString date_time,alarm_msg,userid,alaram_dttm;

extern short int rtc_sec,rtc_min,rtc_hour;
extern int rtc_day,rtc_month,rtc_year;

QString dataval1;

extern QString batchstdttime;
extern bool gen_batchpdf,gen_auditpdf,gen_alarampdf;

extern QString report_compname;
extern QString report_L1Addr;
extern QString report_L2Addr;
extern QString report_machid;
extern QString global_datetime,global_stpdatetime;

 extern QString var3;
 extern QString cpp_prd_batchno;

extern QString btchnme,stdate,enddate;
extern QString manufnm,machinenm,equipid,prntdttm,prcsstpdttm,usrid;
bool gen_alaramreports;
extern bool prodnfg;
enum{
    alaramdttm,
    alarmmsg,
    user_id,


    };
QString almdate_time;


widgetalaram::widgetalaram(QWidget *parent) :
    QWidget(parent)
{

        const QStringList titles {"Date & Time","Alarm Message","User ID"};
        alarampdfprocess = new QProcess(this);
}

widgetalaram::~widgetalaram()
{
    delete ui;
}



void widgetalaram::on_addAlaram_clicked()
{


    almdate_time = dataval1.setNum(rtc_day,16);//ui->prcsstartdtlineEdit->text();
    almdate_time = almdate_time.append("/");
    almdate_time = almdate_time.append(dataval1.setNum(rtc_month,16));
    almdate_time = almdate_time.append("/");
    almdate_time = almdate_time.append(dataval1.setNum(rtc_year,16));
    almdate_time = almdate_time.append("  ");
    alaram_dttm = dataval1.setNum(rtc_hour,16);//ui->prcsstartdtlineEdit->text();
    alaram_dttm = alaram_dttm.append(":");
    alaram_dttm = alaram_dttm.append(dataval1.setNum(rtc_min,16));
    alaram_dttm = alaram_dttm.append(":");
    alaram_dttm = alaram_dttm.append(dataval1.setNum(rtc_sec,16));
    almdate_time = almdate_time.append(alaram_dttm);



}

void widgetalaram::gen_alaramreport()
{
    if(gen_alarampdf)
    {
    gen_alaramreports = 1;
    gen_alarampdf = 0;



    sQL_Alaram_Report(btchnme,stdate,enddate);
    }

}

void widgetalaram::sQL_Alaram_Report(QString local_batch,QString strtDtTm,QString stpDtTm)
{

    unsigned int r = 0,c = 0,num_rows = 0,k = 0,pgnum = 0;
    //QString btch_name = var3.append(cpp_prd_batchno);

    QSqlQuery query;
      QStringList temp_value;
    bool charfg;
      var3 = "/0";
      var3 = "AlARAM" + local_batch;

      var3.remove(" ");

      local_batch = local_batch.remove(" ");

      if(local_batch.at(0) >= '0' && local_batch.at(0) <= '9')
      {
          local_batch = "z"+local_batch;
          charfg = 1;

      }


//    //----------------------------------------------------------temp above code --------------------




    prcsstpdttm = dataval1.setNum(rtc_day,16);//ui->prcsstartdtlineEdit->text();
    prcsstpdttm = prcsstpdttm.append("/");

    prcsstpdttm = prcsstpdttm.append(dataval1.setNum(rtc_month,16));
    prcsstpdttm = prcsstpdttm.append("/");

    prcsstpdttm = prcsstpdttm.append(dataval1.setNum(rtc_year,16));
    prcsstpdttm = prcsstpdttm.append("  ");


    alaram_dttm = dataval1.setNum(rtc_hour,16);//ui->prcsstartdtlineEdit->text();
    alaram_dttm = alaram_dttm.append(":");

    alaram_dttm = alaram_dttm.append(dataval1.setNum(rtc_min,16));
    alaram_dttm = alaram_dttm.append(":");
    alaram_dttm = alaram_dttm.append(dataval1.setNum(rtc_sec,16));
    prcsstpdttm = prcsstpdttm.append(alaram_dttm);

    prntdttm = prcsstpdttm;



            QPrinter printer;
            bool pgendfg = 0;
            QString footerpgnum,pgnumber;
            unsigned int totalpgs = 0;

            //------------------to find the number of pages-------------------------------
               query.prepare( "SELECT date_time,event_msg,username FROM " + var3);
              if( !query.exec())
                qDebug() << query.lastError();
              else
              {
              for(k=0,query.first();query.isValid();query.next(),++k){

               num_rows = k +1;
              }
              }


              qDebug() << "the number of rows = "<<num_rows;
              if(num_rows >= 28){
              totalpgs = num_rows - 28;
              totalpgs = totalpgs / 34;
              qDebug() << "the number of pages = "<<totalpgs;
                if(((totalpgs * 34) != (num_rows - 27)) && (totalpgs != 0)){
                    qDebug() << "add one more page ";
                    totalpgs = totalpgs + 2;
                    footerpgnum = QString::number(totalpgs);

                 qDebug() << "modified number of pages = "<<totalpgs;
                }
                else if((totalpgs == 0) && (num_rows > 27)){   // && (num_rows < 34)){
                    qDebug() << "only one page present ";
                    totalpgs = totalpgs + 2;
                    footerpgnum = QString::number(totalpgs);
                }

              }
              else{
                totalpgs = 0;
                qDebug() << "the number of pages = "<<totalpgs;
                 if((totalpgs == 0) && (num_rows < 28)){
                    qDebug() << "only one page present ";
                    totalpgs = totalpgs + 1;
                    footerpgnum = QString::number(totalpgs);
                }
              }

            //----------------------------------------------------------------------------

            query.prepare( "SELECT prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per FROM " + local_batch );
             if( !query.exec() )
                 qDebug() << query.lastError();
               else
               {

                 qDebug( "Selected!" );
                // for(r=0,query.first();query.isValid();query.next(),++r)
                 {
                       //qDebug() << "in rowwwwwwwwwwwww";
                     query.first();
                     for(c = 0; c < 22; ++c){
                        // qDebug() << "in Cowwwwwwwwwwwww";
                         temp_value<<query.value(c).toString();
                     }

                     qDebug() << r << "number of rows batch report header";
                     qDebug() << temp_value << "temp";

                 }
               }
               QString share_location;
               share_location = "/home/odroid/share_batchFiles/" + var3 + ".pdf";
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
               painter.drawText(330, 5, "ALARM REPORT");
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


               painter.fillRect(0,221,100,30,QColor("cyan"));
               painter.drawRect(0, 221, 100, 30);
               painter.drawText(1, 241, "EVENT DATE TIME");

               painter.fillRect(100,221,560,30,QColor("cyan"));
               painter.drawRect(100, 221, 560, 30);
               painter.drawText(101, 241, "ALARM MESSAGE");

               painter.fillRect(660,221,100,30,QColor("cyan"));
               painter.drawRect(660, 221, 100, 30);
               painter.drawText(662, 241, "USERNAME");

               QStringList dynamiclist;

               query.prepare( "SELECT date_time,event_msg,username FROM " + var3);
               if( !query.exec())
                 qDebug() << query.lastError();
               else
               {
                 qDebug( "Selected!" );

                 int x_pos = 0,rx_pos,ry_pos,rxtext_pos=0;
                 int y_pos = 251;            //701;            //611;
               //  int width = 253;
                 int width = 100;            //190;
                  int height = 30;
                  int i=0;

                  int x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
                  int y_pos1 = 30;
                //   int width1 = 253;
                   int width1 = 100;
                  int  height1 = 30;
                  int j = 0;
                  int pgcnt = 0;
                  QString srno;

                  for(r=0,query.first();query.isValid();query.next(),++r){
                      dynamiclist.clear();
                       srno = QString::number(r + 1);

                      for(c = 0; c < 3; ++c){
                          dynamiclist<< query.value(c).toString();
                      }
                      qDebug() << dynamiclist;
                      if(r<=26){
                          if(i == 0){
                              y_pos = y_pos;
                          }
                          else{
                              height = 30;
                              y_pos = y_pos + height;
                          }
                          i++;

        //                  painter.fillRect(x_pos,y_pos,width,height,QColor("orange"));
                          painter.drawRect(x_pos, y_pos, width, height);
                          ry_pos = y_pos + 20;
                          rxtext_pos = x_pos + 10;
                          qDebug() << "rxtext_pos"<<rxtext_pos;
                          qDebug() << "ry_pos"<<ry_pos;
                          qDebug() << "dynamiclist[0]"<<dynamiclist[0];
                          painter.drawText(rxtext_pos, ry_pos, dynamiclist[0]);   //event time

                          rx_pos = x_pos + width;
                          width = width + 460;
        //                  painter.fillRect(rx_pos,y_pos,width,height,QColor("orange"));
                          painter.drawRect(rx_pos, y_pos, width, height);
                          rxtext_pos = rx_pos + 2;
         //                 painter.drawText(rxtext_pos, ry_pos, dynamiclist[1]);
                          painter.drawText(rxtext_pos, ry_pos, dynamiclist[1]);  //event msg



                          rx_pos = rx_pos + width;
                          width = 100;
        //                  painter.fillRect(rx_pos,y_pos,width,height,QColor("orange"));
                          painter.drawRect(rx_pos, y_pos, width, height);
                          rxtext_pos = rx_pos + 2;
                          painter.drawText(rxtext_pos, ry_pos, dynamiclist[2]);     //username
                          ry_pos = ry_pos + 40;
                          qDebug() << r << "count";
                      }
                      else{
                            if(r == 27){
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

                                  painter.fillRect(0,0,100,30,QColor("cyan"));
                                  painter.drawRect(0, 0, 100, 30);
                                  painter.drawText(1, 20, "EVENT DATE TIME");

                                  painter.fillRect(100,0,560,30,QColor("cyan"));
                                  painter.drawRect(100, 0, 560, 30);
                                  painter.drawText(101, 20, "ALARM MESSAGE");

                                  painter.fillRect(660,0,100,30,QColor("cyan"));
                                  painter.drawRect(660, 0, 100, 30);
                                  painter.drawText(662, 20, "USER NAME");


                              }
                          }
                          qDebug() << y_pos1 << "y_pos1";
                          pgcnt = 33;                    //(1050 - y_pos1) / 30;
                          qDebug() << pgcnt << "pgcnt";
            //              if(j <= pgcnt){
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
        //                      if(dynamiclist[2] == "UW"){
        //                      painter.fillRect(x_pos1,y_pos1,width1,height1,QColor("orange"));
                              painter.drawRect(x_pos1, y_pos1, width1, height1);
                              ry_pos1 = y_pos1 + 20;
                              rxtext_pos1 = x_pos1 + 10;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              qDebug() << "dynamiclist[0]"<<dynamiclist[0];
                 //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                              rx_pos1 = x_pos1 + width1;
                              width1 = width1 + 460;
                 //             painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                              painter.drawRect(rx_pos1, y_pos1, width1, height1);
                              rxtext_pos1 = rx_pos1 + 2;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1]);

                              rx_pos1 = rx_pos1 + width1;
                              width1 = 100;
                 //             painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                              painter.drawRect(rx_pos1, y_pos1, width1, height1);
                              rxtext_pos1 = rx_pos1 + 2;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);

                          }
                          else{
                              height1 = 30;
                              y_pos1 = y_pos1 + height1;

                              painter.drawRect(x_pos1, y_pos1, width1, height1);
                              ry_pos1 = y_pos1 + 20;
                              rxtext_pos1 = x_pos1 + 10;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              qDebug() << "dynamiclist[0]"<<dynamiclist[0];
                 //             painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[0]);

                              rx_pos1 = x_pos1 + width1;
                              width1 = width1 + 460;
                 //             painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                              painter.drawRect(rx_pos1, y_pos1, width1, height1);
                              rxtext_pos1 = rx_pos1 + 2;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[1]);

                              rx_pos1 = rx_pos1 + width1;
                              width1 = 100;
                 //             painter.fillRect(rx_pos1,y_pos1,width1,height1,QColor("orange"));
                              painter.drawRect(rx_pos1, y_pos1, width1, height1);
                              rxtext_pos1 = rx_pos1 + 2;
                              qDebug() << "rxtext_pos1"<<rxtext_pos1;
                              qDebug() << "ry_pos1"<<ry_pos1;
                              painter.drawText(rxtext_pos1, ry_pos1, dynamiclist[2]);

                              pgnum++;
                              pgnumber = QString::number(pgnum);
                              painter.drawText(700, ry_pos1 + 20, pgnumber +" of "+footerpgnum);
                              j=0;
                              pgendfg = 0;
                              x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
                              y_pos1 = 30;
                              width1 = 100;
                              height1 = 30;
                              pgcnt = 0;
                          }

                      }
                  }
                  if(((r<=26) | (j <= pgcnt)) & (pgendfg == 0)){

           //          painter.drawText(100, 1040, "DONE BY --------------------");
           //          painter.drawText(560, 1040, "CHECKED BY --------------------");

                  }
                  qDebug() << "number of rows :" << r;
                  qDebug() << "number of num_rows :" << num_rows;
                  if(r == num_rows){
                    painter.drawText(100, 1091, "DONE BY ----------------");
                    painter.drawText(560, 1091, "CHECKED BY ----------------");

                    if(j==0)
                    {
                        if(r<=27)
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


                  //  pgnum++;
                   // pgnumber = QString::number(pgnum);
                  //  painter.drawText(700, 1091, pgnumber +" of "+footerpgnum);
                    pgnum = 0;
                  }
                   x_pos = 0,
                   rx_pos = 0;
                   ry_pos = 0;
                   rxtext_pos=0;
                   y_pos = 0;            //701;            //611;
                //  int width = 253;
                   width = 0;            //190;
                   height = 0;
                    i=0;

                    x_pos1 = 0,rx_pos1=0,ry_pos1 = 0,rxtext_pos1 = 0;
                    y_pos1 = 0;
                 //   int width1 = 253;
                     width1 = 0;
                     height1 = 0;
                    j = 0;
                    pgcnt = 0;
               }

               //QDesktopServices::openUrl(QUrl(share_location));
               if(gen_alaramreports == 0)
               {
                  // QDesktopServices::openUrl(QUrl(share_location));
               }
               else
               {
                   gen_alaramreports = 0;
               }

               if(charfg)
               {
                   charfg = 0;
                   if(local_batch.at(0) == "z")
                   {
                      local_batch.remove(0,1);
                   }

               }



}

void widgetalaram::open_alarampdf(QString d,QString strtDtTm,QString stpDtTm)
{
    d.remove(" ");
    if(prodnfg)
    {
        qDebug() << "BATCH ACTIVE";
        sQL_Alaram_Report(d,strtDtTm,stpDtTm);

    }
    else if(d == "SETTINGBATCH2")
    {
        qDebug() << "SETTING BATCH ACTIVE";
        sQL_Alaram_Report(d,strtDtTm,stpDtTm);
    }
    else
    {
        sQL_Alaram_Report(d,strtDtTm,stpDtTm);

    }
    QString share_location;

    share_location = "/home/odroid/share_batchFiles/AlARAM" + d + ".pdf";

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
    alarampdfprocess->setProgram(program);
    alarampdfprocess->close();
    alarampdfprocess->start();

}
