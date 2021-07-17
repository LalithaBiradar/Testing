

#include <fstream>
#include<iostream>
#include<QtWidgets/QFileDialog>
#include<QtWidgets/QDialog>
#include<QFileInfo>
#include <QQmlContext>


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

#include <QTableView>
#include <QStandardItem>

#include "printform.h"
//#include "ui_printform.h"
#include "tableprinter.h"

#include <QPrinter>
#include <QPrintPreviewDialog>
#include <QPainter>
#include <QDebug>
//#include <QSqlDatabase>
//#include <QSqlQuery>
//#include <QSqlError>
//#include <QSqlTableModel>
//#include <QSqlRecord>

#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>

#include "handlelinechartvalue.h"
#include "savetextfield.h"
#include <QQmlProperty>
#include <QDesktopServices>

#include <QDateTime>

//#include "T4OPCServer.h"

extern bool dcomp_onfg;
extern QString dcomp_dataval1;

extern QString config_parameter[8];

extern QString stats_param[14];
extern QString batch_avgaccp_wt;



float cpp_prd_target;
float cpp_prd_tare;
unsigned int cpp_prd_length;
float cpp_prd_Ulimit;
float cpp_prd_Llimit;
unsigned int cpp_prd_speed;
unsigned int cpp_opr_delay;
unsigned int cpp_hold_delay;
unsigned int cpp_rej_cnt,cpp_md_opdly;
extern unsigned int start_delay;
extern bool static_togglefg,static_startfg,disp_staticfg,task1fg;

extern unsigned int task1ctr,staticnsetz_taskctr;
extern bool staticnsetz_taskfg;
extern QString userid,userid_audit;
QString batch_hder_userid;

extern bool CW1200fg;

unsigned int Max_len,MAX_SPEED,MIN_SPEED;
extern unsigned int platform,platform_plus;

bool duplicate_batchfg;

QString report_compname;
QString report_L1Addr;
QString report_L2Addr;
QString report_machid;


QString cpp_prd_code1,cpp_prd_name1,demo_targetwt1,demo_tarewt1,demo_length1,demo_uplimit1;
QString demo_lolimit1,demo_speed1,demo_oprdelay1,demo_holddelay1,demo_rejcnt1,demo_mdopr1;


QString cpp_prd_code;
QString cpp_prd_name;
QString cpp_prd_batchno;

QString demo_targetwt,demo_tarewt,demo_length,demo_mdopr;
QString demo_uplimit,demo_lolimit,demo_speed;
QString demo_oprdelay,demo_holddelay,demo_rejcnt;

extern QString prev_value,cur_value,event_msg;

extern QString batchstdttime;
bool blockstsfg;
void batch_stdttime(void);

extern unsigned int uw_count,ow_count,accp_count;
extern unsigned int tot_count,avg_accp_bin,std_dev_buffer;
extern float max_wt,min_wt,rej_percent,avg_accp_wt;
extern unsigned int avg_buff;

extern QFile stats_file;//("STATS.txt");
extern QFile ONOFF_file;//("ONOFFSTATUS.txt");
extern QString batch_accp_cnt;
extern QString batch_ow_cnt;
extern QString batch_uw_cnt;
extern QString batch_tot_cnt;
extern QString ONOFF_param[4];

extern QString global_datetime,global_stpdatetime;

extern QString var1;// = "Dynamic";
extern QString var2;// = "AUDIT";
extern QString var3;// = "AlARAM";
extern QString var4;// = "BATCH_NAME";

extern unsigned int dcomp_bin;
extern bool positive_dcompfg,comparefg,batch_stop,batch_endfg,batchend_errfg;
bool prodnfg,unique_bchfg;
bool indivisualblockfg;

QVariant returnedValue;
QVariantList myVl;

extern short int rtc_sec,rtc_min,rtc_hour;
extern int rtc_day,rtc_month,rtc_year;

//static const QString path = "pwd.db";
QString textFilepath = "/home/odroid/Projects/Qt/textFiles/";





FileIO::FileIO(QObject *parent): QObject(parent)
{


}


void FileIO::sendPrevilageStatus(const QString& param1)
{
   qDebug() << "previlage status for:"<<param1;
   QStringList userList;
      int r,c;
      bool alreadyExist = false;
   QSqlQuery qry;
      qry.prepare( "SELECT groupnm,code FROM GroupPrevilages WHERE groupnm = '" + param1 + "'" );
      if( !qry.exec() ){
        qDebug() << qry.lastError();
    //    emit handleSubmittFileParam("","");
      }
      else
      {
          alreadyExist = qry.next();
          if(alreadyExist){
              qDebug( "searching in GroupPrevilages!" );
              for(r=0,qry.first();qry.isValid();qry.next(),++r){
                  for(c = 0; c < 2; ++c){
                      userList<< qry.value(c).toString();
                      //  qDebug() << "The username is:"<<username;

                      // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                  }
              }
              qDebug() << "The GroupPrevilages list is:"<<userList;
              qDebug() << "The GroupPrevilages groupnm is:"<<userList[0];
              qDebug() << "The GroupPrevilages code is:"<<userList[1];
   //           emit handleSubmittFileParam(userList[0],userList[1]);
              emit previlage_status(userList[1]);
          }
          else if(param1.indexOf("ADMIN") >=0){
              qDebug() << "nothing to show";
   //           emit handleSubmittFileParam("","");
          }
          else
          {
              emit previlage_status("0");

          }
      }

//emit disablescr();

}
void FileIO::logout(const QString& param1)
{
    event_msg = param1+ " press OK to LOG OUT";//" is logged out. ";
    emit signal_savetextfield(global_datetime,event_msg,"","",userid);

}

void FileIO::disableScreen(const QString& param1)
{
    if(CW1200fg)
    {
        emit disablescr1(3,0);

    }

   qDebug() << "Value received:"<<param1;
   if(param1 == "1"){
        emit disablescr("SCRD");
   }
   if(param1 == "LE"){
        emit disablescr("LE");
   }
   if(param1 == "LD"){
        emit disablescr("LD");
   }
   if(param1 == "RT"){
        emit disablescr("RT");

   }

}
void FileIO::disableScreen1(const QString& param1)
{
   qDebug() << "Value received:"<<param1;
   if(param1 == "1"){
emit disablescr1(1,0);
   }
   if(param1 == "2"){
emit disablescr1(2,0);
   }
   if(param1 == "3"){

       static_togglefg = 0;
       static_startfg = 0;
       disp_staticfg = 0;
       task1fg = 0;
       task1ctr = 0;
       staticnsetz_taskfg = 0;
       staticnsetz_taskctr = 0;
        emit disablescr1(3,0);
   }
}

void FileIO::closeDialogue(const QString& param1)
{
   qDebug() << "close dialogue value received:"<<param1;
   if(param1 == "1"){
    emit clDialogue("1");
   }
   if(param1 == "2"){
//emit disablescr1(2,0);
   }

}



void FileIO::findPrevilages(const QString& param1)
{
QStringList userList;
   int r,c;
   bool alreadyExist = false;
QSqlQuery qry;
   qry.prepare( "SELECT groupnm,code FROM GroupPrevilages WHERE groupnm = '" + param1 + "'" );
   if( !qry.exec() ){
     qDebug() << qry.lastError();
     emit handleSubmittFileParam("","","");
   }
   else
   {
       alreadyExist = qry.next();
       if(alreadyExist){
           qDebug( "searching in GroupPrevilages!" );
           for(r=0,qry.first();qry.isValid();qry.next(),++r){
               for(c = 0; c < 2; ++c){
                   userList<< qry.value(c).toString();
                   //  qDebug() << "The username is:"<<username;

                   // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
               }
           }
           qDebug() << "The GroupPrevilages list is:"<<userList;
           qDebug() << "The GroupPrevilages groupnm is:"<<userList[0];
           qDebug() << "The GroupPrevilages code is:"<<userList[1];
           emit handleSubmittFileParam(userList[0],userList[1],"");
       }
       else{
           qDebug() << "nothing to show";
           emit handleSubmittFileParam("","","");
       }
   }
}
void FileIO::storePrevilages(const QString& param1,const QString& source)
{
    event_msg = param1 + " PREVILAGES CHANGED ";
    emit signal_savetextfield(global_datetime,event_msg,"","",userid);
    QSqlQuery qry;
bool alreadyExist = false;
int r,c;
QStringList userList;
 qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupPrevilages (groupnm VARCHAR(40),code VARCHAR(10))");
if( !qry.exec() )
  qDebug() << qry.lastError();
else
  qDebug() << "Table created GroupPrevilages"<<"GroupPrevilages(groupnm VARCHAR(40),code VARCHAR(10))";

qry.prepare( "SELECT groupnm,code FROM GroupPrevilages WHERE groupnm = '" + param1 + "'" );
if( !qry.exec() ){
  qDebug() << qry.lastError();
}
else{
    alreadyExist = qry.next();
    if(alreadyExist){
        for(r=0,qry.first();qry.isValid();qry.next(),++r){
            for(c = 0; c < 2; ++c){
                userList<< qry.value(c).toString();
                //  qDebug() << "The username is:"<<username;

                // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
            }
        }
        qDebug() << "The GroupPrevilages groupnm is:"<<userList[0];
        qDebug() << "The GroupPrevilages code is:"<<userList[1];
        qDebug() << "Incoming groupnm is:"<<param1;
        qDebug() << "Incoming code is:"<<source;
        if((userList[0] == param1) && (userList[1] != source)){

        qry.prepare( "UPDATE GroupPrevilages SET groupnm = '" + param1 + "', code = '" + source + "' WHERE groupnm = '" + param1 + "'" );
        if( !qry.exec() )
            qDebug() << qry.lastError();
        else
            qDebug() <<"UPDATED GroupPrevilages..." ;
  //      emit previlage_status("Successfully Updated !!");
        }
    }
    else{
        qry.prepare( "INSERT INTO GroupPrevilages(groupnm, code)VALUES('" + param1 + "', '" + source + "')" );
        if( !qry.exec() )
            qDebug() << qry.lastError();
        else
            qDebug() <<"Inserted" <<"INSERT INTO GroupPrevilages (groupnm, code)VALUES('" + param1 + "', '" + source + "')" ;
//        emit previlage_status("Successfully Inserted !!");
    }
}
}


void FileIO::storeDCOMP_FACT( QString param1, QString param2)
{
    QSqlQuery qry;
bool alreadyExist = false;
qDebug() << "the values are"<<param1<<param2;
//int r,c;
//QStringList userList;

 qry.prepare( "CREATE TABLE IF NOT EXISTS  DCOMP_TABLE (dcompsts VARCHAR(4),dcompfact VARCHAR(10))");
if( !qry.exec() )
  qDebug() << qry.lastError();
else
  qDebug() << "Table created DCOMP_TABLE"<<"DCOMP_TABLE(dcompsts VARCHAR(4),dcompfact VARCHAR(10))";

qry.prepare( "SELECT dcompsts,dcompfact FROM DCOMP_TABLE " );
if( !qry.exec() ){
  qDebug() << qry.lastError();
}
else{
    qDebug() <<"UPDATED DCOMP_TABLE..." ;
    alreadyExist = qry.next();
    if(alreadyExist){
        qry.prepare( "UPDATE DCOMP_TABLE SET dcompsts = '" + param1 + "', dcompfact = '" + param2 + "'" );
        if( !qry.exec() )
            qDebug() << qry.lastError();
        else
            qDebug() <<"UPDATED DCOMP_TABLE..." ;
//        emit previlage_status("Successfully Updated !!");
        }
//    }
    else{
        qry.prepare( "INSERT INTO DCOMP_TABLE(dcompsts, dcompfact)VALUES('" + param1 + "', '" + param2 + "')" );
        if( !qry.exec() )
            qDebug() << qry.lastError();
        else
            qDebug() <<"Inserted" <<"INSERT INTO DCOMP_TABLE (dcompsts, dcompfact)VALUES('" + param1 + "', '" + param2 + "')" ;
//        emit previlage_status("Successfully Inserted !!");
    }
}
}



void FileIO::recall_DCOMPFACT()
{
    int r,c;

    float val;
   QStringList userList;
   QString param1;
   bool alreadyExist = false;
   param1 = "1";
    QSqlQuery qry;
    qry.prepare( "CREATE TABLE IF NOT EXISTS  DCOMP_TABLE (dcompsts VARCHAR(4),dcompfact VARCHAR(10))");
   if( !qry.exec() )
     qDebug() << qry.lastError();
   else
     qDebug() << "Table created DCOMP_TABLE"<<"DCOMP_TABLE(dcompsts VARCHAR(4),dcompfact VARCHAR(10))";

    qry.prepare( "SELECT dcompsts,dcompfact FROM DCOMP_TABLE " );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
    {
        alreadyExist = qry.next();
        if(alreadyExist){
            qDebug( "searching in DCOMP_TABLE!" );
            for(r=0,qry.first();qry.isValid();qry.next(),++r){
                for(c = 0; c < 2; ++c){
                    userList<< qry.value(c).toString();
                    //  qDebug() << "The username is:"<<username;

                    // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                }
            }
            qDebug() << "The DCOMP_TABLE list is:"<<userList;
            qDebug() << "DCOMP_TABLE dcompsts is:"<<userList[0];
            qDebug() << "DCOMP_TABLE dcompfact is:"<<userList[1];
  //          emit handleSubmittFileParam(userList[0],userList[1]);

            param1 = userList[0];
            if(param1 == "1")
            {
                dcomp_onfg = 1;

            }
            else
            {
                dcomp_onfg = 0;

            }
            dcomp_dataval1 = userList[1];

            if(dcomp_dataval1[0] == "1")
            {
                dcomp_dataval1.remove(0,1);
                qDebug() << dcomp_dataval1 << "REMOVED VALUE";
                positive_dcompfg = 1;

            }
            else
            {
                dcomp_dataval1.remove(0,1);
                qDebug() << dcomp_dataval1;

            }
            dcomp_bin = dcomp_dataval1.toInt();
            qDebug() << dcomp_bin << "dcomp bin value";

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
//            if(!positive_dcompfg)
//            {
//                dcomp_dataval1 = "- " + dcomp_dataval1;
//            }

            if(positive_dcompfg)
            {
                dcomp_dataval1 = "(+)" + dcomp_dataval1;
            }
            else
            {
                dcomp_dataval1 = "(-)" + dcomp_dataval1;

            }




           // emit handleDcompsts(param1);
        }
       else{
 //           emit handleSubmittFileParam("@","@");
            qDebug() << "the value doesn't exist in dcomptable";
        }
    }

}



void FileIO::read(const QString& source)
{
            QString dat;
            int j = 0;



                if (source.isEmpty())
                {
                    qDebug() << "source is empty:";

                }

                QFile file(source);
                    if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite))
                     {
                      qDebug() << "file already there";
                     }
                         QTextStream in(&file);
                         while(!in.atEnd()) {
                         QString line = in.readLine();
                          qDebug() << "file read:"<<line;

                          for(int i = 5; i< 10;i++)
                          {
                              dat[j] = line[i];
                              j++;
                          }
                           emit handleSaveTextField(dat);
                     }

                          file.close();

}
void FileIO::manualOpen(){
        QDesktopServices::openUrl(QUrl("/home/odroid/Projects/Qt/Manual_nextGen_Checkweigher.pdf"));
}


void FileIO::submittFileParam(const QString& param1,const QString& param2)
{



      qDebug( "Connected!" );
    QSqlQuery qry;
   // int r,c;
    bool alreadyExist = false;
  //  QStringList userList;
    qry.prepare( "CREATE TABLE IF NOT EXISTS  sandy (usernm VARCHAR(40),password VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created sandy"<<"sandy(usernm VARCHAR(40),password VARCHAR(40))";

    qry.prepare( "SELECT usernm,password FROM sandy WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qry.prepare( "UPDATE sandy SET usernm = '" + param1 + "', password = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED SANDY..." ;
        }
        else{
            qry.prepare( "INSERT INTO sandy(usernm, password)VALUES('" + param1 + "', '" + param2 + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"Inserted" <<"INSERT INTO sandy (usernm, password)VALUES('" + param1 + "', '" + param2 + "')" ;
        }
    }
}



void FileIO::submittFileParamOTP(const QString& param1,const QString& param2)
{

  int r,c,cnt = 0;
  bool last2savefg = 0;
  QStringList userList;
    QSqlQuery qry;
    bool alreadyExist = false;


    //**********last two save checking****************

//    qry.prepare( "CREATE TABLE IF NOT EXISTS  LASTTWOSAVE (usernm VARCHAR(40),password VARCHAR(2))");
//    if( !qry.exec() )
//        qDebug() << qry.lastError();
//    else
//        qDebug() << "Table created LASTTWOSAVE!"<<"LASTTWOSAVE(usernm VARCHAR(40),password VARCHAR(2))";

 //   qry.prepare( "SELECT usernm,password FROM LASTTWOSAVE WHERE usernm = '" + param1 + "'" );
    qry.prepare( "SELECT usernm,password FROM OTP WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
        qDebug() << qry.lastError();
        //     emit handleSubmittFileParam("","");
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qDebug( "searching in LASTTWOSAVE!" );
            for(r=0,qry.first();qry.isValid();qry.next(),++r){
                for(c = 0; c < 2; ++c){
                    userList<< qry.value(c).toString();

                    if(param2 == qry.value(c).toString()){
                     last2savefg = 1;
                     emit chkFileExist("Exist");
                     qDebug() << "The password entered matches with last two save";
                    }
                    else{
                        qDebug() << "The password entered not matches with last two save";
                        emit chkFileExist(" ");
                    }

                }
            }
            qDebug() << "The LASTTWOSAVE list is:"<<userList;
            qDebug() << "The LASTTWOSAVE usernm is:"<<userList[0];
            qDebug() << "The LASTTWOSAVE password is:"<<userList[1];
            qDebug() << "The password save are:"<<cnt/2;


        }
        else{

        }

    }

if(!last2savefg){
    qry.prepare( "CREATE TABLE IF NOT EXISTS  OTP (usernm VARCHAR(40),password VARCHAR(40))");
    if( !qry.exec() )
        qDebug() << qry.lastError();
    else
        qDebug() << "Table created OTP!"<<"OTP(usernm VARCHAR(40),password VARCHAR(40))";

    qry.prepare( "SELECT usernm,password FROM OTP WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
        qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qry.prepare( "UPDATE OTP SET usernm = '" + param1 + "', password = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED OTP..." ;
        }
        else{
            qry.prepare( "INSERT INTO OTP(usernm, password)VALUES('" + param1 + "', '" + param2 + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"Inserted" <<"INSERT INTO OTP (usernm, password)VALUES('" + param1 + "', '" + param2 + "')" ;
        }
    }
}
}

void FileIO::changepwd(const QString& param1)
{
    QSqlQuery qry;

    qry.prepare( "DELETE FROM sandy WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else
    {
      qDebug() <<"CHANGE PWD:" <<param1;
      event_msg = "PASSWORD CHANGED " + param1;
      emit signal_savetextfield(global_datetime,event_msg,"","",userid);
    }

}

void FileIO::remove(const QString& param1)
{
    QSqlQuery qry;

    qry.prepare( "DELETE FROM sandy WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
      qDebug() <<"deleted:" <<param1;
      event_msg = "USER REMOVED " + param1;
      emit signal_savetextfield(global_datetime,event_msg,"","",userid);
    }

}
void FileIO::removeOTP(const QString& param1)
{
    QSqlQuery qry;

    qry.prepare( "DELETE FROM sandy WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
//      qDebug() <<"deleted:" <<param1;
//      event_msg = "USER REMOVED " + param1;
//      emit signal_savetextfield(global_datetime,event_msg,"","",userid);
    }

}
void FileIO::removeFromOTP(const QString& param1)
{

    QSqlQuery qry;

    qry.prepare( "DELETE FROM OTP WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"deleted from OTP:" <<param1;

    qry.prepare( "DELETE FROM LoginFileNames WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"deleted from LoginFileNames:" <<param1;

    qry.prepare( "DELETE FROM UserStatusFile WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"deleted from UserStatusFile:" <<param1;

    qry.prepare( "DELETE FROM UserStatus WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"deleted from UserStatus:" <<param1;
    qry.prepare( "DELETE FROM UserProfileFile WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"deleted from UserProfileFile:" <<param1;

}







void FileIO::previous(const QString& param1)
{
    QMap<QString, QString>::iterator i = contacts.find(param1);

    if (i == contacts.end()) {

        return;
    }

    if (i == contacts.begin())
        i = contacts.end();

    i--;




}



void FileIO::next(const QString& param1)
{
    QStringList userList;
    int r,c;
QSqlQuery qry;
bool alreadyExist = false;
    qry.prepare( "SELECT usernm,password FROM sandy WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else
    {
        alreadyExist = qry.next();
        if(alreadyExist){
            qDebug( "searching in sandy!" );
            for(r=0,qry.first();qry.isValid();qry.next(),++r){
                for(c = 0; c < 2; ++c){
                    userList<< qry.value(c).toString();
                    //  qDebug() << "The username is:"<<username;

                    // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                }
            }
            qDebug() << "The username list is:"<<userList;
            qDebug() << "The username is:"<<userList[0];
            qDebug() << "The password is:"<<userList[1];
            emit handleSubmittFileParam(userList[0],userList[1],"");
        }
    }

}

void FileIO::nextOTP(const QString& param1,const QString& param2)
{


    qDebug( "Connected!" );
    QStringList userList,userList1;
    int r,c,blkcnt = 0;
    bool alreadyExist = false;
    QString blkcnt_strng;
    QSqlQuery qry;
    qry.prepare( "SELECT usernm,password FROM OTP WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
        qDebug() << qry.lastError();
    else
    {
        alreadyExist = qry.next();
        if(alreadyExist){
            qDebug( "searching in OTP!" );
            for(r=0,qry.first();qry.isValid();qry.next(),++r){
                for(c = 0; c < 2; ++c){
                    userList<< qry.value(c).toString();

                    // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                }
            }

            qDebug() << "The OTP list is:"<<userList;
            qDebug() << "The OTP username is:"<<userList[0];
            qDebug() << "The OTP password is:"<<userList[1];
            qDebug() << "The incoming password is:"<<param2;
            //      emit handleSubmittFileParam(userList[0],userList[1]);

            if((param1 == userList[0]) && (param2 != userList[1])){
                //          QSqlQuery qry;
                //      bool alreadyExist = false;


                //      int r,c;
                //      QStringList userList;
                qry.prepare( "CREATE TABLE IF NOT EXISTS  ConsBlkCnt (usernm VARCHAR(40),count VARCHAR(2))");
                if( !qry.exec() )
                    qDebug() << qry.lastError();
                else
                    qDebug() << "Table created ConsBlkCnt"<<"ConsBlkCnt(usernm VARCHAR(40),count VARCHAR(10))";

                qry.prepare( "SELECT usernm,count FROM ConsBlkCnt WHERE usernm = '" + param1 + "'" );
                if( !qry.exec() ){
                    qDebug() << qry.lastError();
                }
                else{
                    alreadyExist = qry.next();
                    if(alreadyExist){
                        for(r=0,qry.first();qry.isValid();qry.next(),++r){
                            for(c = 0; c < 2; ++c){
                                userList1<< qry.value(c).toString();
                                //  qDebug() << "The username is:"<<username;

                                // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                            }
                        }
                        qDebug() << "The ConsBlkCnt usernm is:"<<userList1[0];
                        qDebug() << "The ConsBlkCnt count is:"<<userList1[1];
                        qDebug() << "Incoming usernm is:"<<param1;
                        //        qDebug() << "Incoming count is:"<<param2;
                        blkcnt_strng = userList1[1];
                        blkcnt = blkcnt_strng.toInt();
                        qDebug() << "The blkcnt from sql is:"<<blkcnt;
                        if(blkcnt < 3){
                            blkcnt++;
                            qDebug() << "The blkcnt incement is:"<<blkcnt;
                        }

                        blkcnt_strng = QString::number(blkcnt);
                        if(blkcnt_strng == "3"){
                            //              emit handleSubmittFileParam(userList1[0],"Blocked");
                            indivisualblockfg = 1;
                            statusFile(param1,"Blocked","Expired");
                            emit handleSubmittFileParam(param1,"Blocked","");
                        }
                        else{
                            qry.prepare( "UPDATE ConsBlkCnt SET usernm = '" + param1 + "', count = '" + blkcnt_strng + "' WHERE usernm = '" + param1 + "'" );
                            if( !qry.exec() )
                                qDebug() << qry.lastError();
                            else
                                qDebug() <<"UPDATED ConsBlkCnt..." ;

                        }
                    }
                    else{
                        blkcnt++;
                        blkcnt_strng = QString::number(blkcnt);
                        qry.prepare( "INSERT INTO ConsBlkCnt(usernm, count)VALUES('" + param1 + "', '" + blkcnt_strng + "')" );
                        if( !qry.exec() )
                            qDebug() << qry.lastError();
                        else
                            qDebug() <<"Inserted" <<"INSERT INTO ConsBlkCnt (usernm, count)VALUES('" + param1 + "', '" + blkcnt_strng + "')" ;

                    }
                }


            }
            else if((param1 == userList[0]) && (param2 == userList[1])){

                blkcnt = 0;
                blkcnt_strng = QString::number(blkcnt);

                qry.prepare( "SELECT usernm,count FROM ConsBlkCnt WHERE usernm = '" + param1 + "'" );
                if(!qry.exec()){
                    qDebug() << qry.lastError();
                }
                else{
                    alreadyExist = qry.next();
                    if(alreadyExist){



                            qry.prepare( "UPDATE ConsBlkCnt SET usernm = '" + param1 + "', count = '" + blkcnt_strng + "' WHERE usernm = '" + param1 + "'" );
                            if( !qry.exec() )
                            qDebug() << qry.lastError();
                             else
                             qDebug() <<"UPDATED ConsBlkCnt..." ;
//                            emit handleSubmittFileParam(userList[0],userList[1],"");
                             }


                    else{

                        qry.prepare( "CREATE TABLE IF NOT EXISTS  ConsBlkCnt (usernm VARCHAR(40),count VARCHAR(2))");
                        if( !qry.exec() )
                            qDebug() << qry.lastError();
                        else
                            qDebug() << "Table created ConsBlkCnt"<<"ConsBlkCnt(usernm VARCHAR(40),count VARCHAR(10))";

                        qry.prepare( "INSERT INTO ConsBlkCnt(usernm, count)VALUES('" + param1 + "', '" + blkcnt_strng + "')" );
                        if( !qry.exec() )
                            qDebug() << qry.lastError();
                        else
                            qDebug() <<"Inserted" <<"INSERT INTO ConsBlkCnt (usernm, count)VALUES('" + param1 + "', '" + blkcnt_strng + "')" ;
 //                       emit handleSubmittFileParam(userList[0],userList[1]);


                    }


                }
 //               else{

                    emit handleSubmittFileParam(userList[0],userList[1],"");
//               }
            }
            else{
                emit handleSubmittFileParam("@","@","@");
            }
        }


    }

}



void FileIO::findGroupNameUserName(const QString& param1)
{
    int r,c;
   QStringList userList;
   bool alreadyExist = false;
    QSqlQuery qry;
    qry.prepare( "SELECT usernm,groupnm,expiryDays FROM GroupNameUserName WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
    {
        alreadyExist = qry.next();
        if(alreadyExist){
            qDebug( "searching in GroupNameUserName!" );
            for(r=0,qry.first();qry.isValid();qry.next(),++r){
                for(c = 0; c < 3; ++c){
                    userList<< qry.value(c).toString();
                    //  qDebug() << "The username is:"<<username;

                    // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                }
            }
            qDebug() << "The GroupNameUserName list is:"<<userList;
            qDebug() << "GroupNameUserName username is:"<<userList[0];
            qDebug() << "GroupNameUserName groupname is:"<<userList[1];
            qDebug() << "GroupNameUserName expiryDays is:"<<userList[2];
            emit handleSubmittFileParam(userList[0],userList[1],userList[2]);
        }
        else{
            emit handleSubmittFileParam("@","@","@");
        }
    }

}

void FileIO::findUserStatus(const QString& param1)
{

    QStringList userList;
       int r,c;
       bool alreadyExist = false;
   QSqlQuery qry;
       qry.prepare( "SELECT usernm,status FROM UserStatus WHERE usernm = '" + param1 + "'" );
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
       {
           alreadyExist = qry.next();
           if(alreadyExist){
               qDebug( "searching in UserStatus!" );
               for(r=0,qry.first();qry.isValid();qry.next(),++r){
                   for(c = 0; c < 2; ++c){
                       userList<< qry.value(c).toString();
                       //  qDebug() << "The username is:"<<username;

                       // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
                   }
               }
               qDebug() << "The UserStatus list is:"<<userList;
               qDebug() << "The UserStatus username is:"<<userList[0];
               qDebug() << "The UserStatus status is:"<<userList[1];
               emit handleSubmittFileParam(userList[0],userList[1],"");
           }
           else{
             //  emit handleSubmittFileParam("@","@","@");
           }
       }

}





void FileIO::saveToFile(){

}
void FileIO::saveToFileOTP(){

        QFile file("F:\\ OTP.abk");

        if (!file.open(QIODevice::WriteOnly)) {

            qDebug()  << "is already in your OTP address book." << file.errorString();

            return;
        }

        QDataStream out(&file);
        out.setVersion(QDataStream::Qt_4_3);
        out << OTPcontacts;

}

void FileIO::saveToLib(const QString& source,QStringList adata,qint8 length){
    QString cmpFileNames;

//    for(int i=4;i<source.length();i++){

//        cmpFileNames.append(source[i]);
//    }
    qDebug() << "cmpfilename is :" << cmpFileNames ;
    if (source.isEmpty())
    {
        qDebug() << "source is empty:";

    }

    QFile file(textFilepath+source);

    if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
        qDebug()  << "is already in your address book." << file.errorString();
        //return;
    }
    for(int i=0;i<length;i++) {
        qDebug() <<"The data saved in:"<<source <<adata[i];
        QTextStream out(&file);
        out << adata[i] <<'\n';
    }

    if (QFile::exists(textFilepath + "dummy.txt"))
    {

        QFile::remove(textFilepath + "dummy.txt");
    }


    QFile::copy(source,textFilepath + "dummy.txt");

    file.close();
    //------------------------------code for copying file name into compare file-------------------------//

    if (QFile::exists(textFilepath + "compare.txt"))

    {

        //QFile::remove(textFilepath + "compare.txt");
    }

    QFile file1(textFilepath + "compare.txt");

    if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
        qDebug()  << "is already in your address book." << file1.errorString();
        return;
    }

    qDebug() <<"The name of file saved in :" <<cmpFileNames;
    QTextStream out(&file1);
    out << cmpFileNames;    // source;

    file1.close();
             //-----------------------------------------------------------------------------------------------//

}

void FileIO::saveParamInReporthdrFile(QStringList adata,qint8 length){
 qDebug() <<"The report header parameters are:"<<adata;
 //---------------------to save report header parameter---------------


 //if (QFile::exists(textFilepath + "reportFileParam.txt"))
 QFileInfo check_batchfile(textFilepath + "reportFileParam.txt");
 if(check_batchfile.exists())
 {

    // QFile::remove(textFilepath + "reportFileParam.txt");
 }

 QFile batchfile(textFilepath + "reportFileParam.txt");


 if(!batchfile.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
     qDebug() << "file already there";
 }
       for(int i= 0;i<length;i++) {
       qDebug() <<"The data saved in reportFileParam.txt:"<< adata[i];
       QTextStream out(&batchfile);
       out << " " <<'\n';
       }

         batchfile.close();

 if(!batchfile.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
 qDebug() << "file already there";
 }
       for(int i= 0;i<length;i++) {
       qDebug() <<"The data saved in reportFileParam.txt:"<< adata[i];
       QTextStream out(&batchfile);
       out << adata[i] <<'\n';
       }

       report_compname = adata[0];
       report_L1Addr = adata[1];
       report_L2Addr = adata[2];
       report_machid = adata[3];

     batchfile.close();
 //---------------------------------------

}

void FileIO::saveParamInFile(const QString& source,QStringList adata,qint8 length){

    QString param[13];
     QString currentFile,temp_speed;

     QString locationOfFile;

     locationOfFile = textFilepath + source;
     qDebug() <<"The location of file is:"<<locationOfFile;

    unsigned int chk_mtrs_permin,mtrs_mm,fileSpeed;


//***************TESTING CODE**********************************************

    if(config_parameter[0] == "CW3000" || (config_parameter[0] == "CW3000HSA") || (config_parameter[0] == "CW3000_1"))
    {
        temp_speed = adata[3];
        temp_speed.replace(".1",".0");
        temp_speed.replace(".3",".2");
        temp_speed.replace(".5",".4");
        temp_speed.replace(".7",".6");
        temp_speed.replace(".9",".8");
        adata[3] = temp_speed;

        qDebug() << "dsadsadsadsadsadMAX SPEED_SAVE";


        temp_speed = adata[4];
        temp_speed.replace(".1",".0");
        temp_speed.replace(".3",".2");
        temp_speed.replace(".5",".4");
        temp_speed.replace(".7",".6");
        temp_speed.replace(".9",".8");
        adata[4] = temp_speed;

        temp_speed = adata[6];
        temp_speed.replace(".1",".0");
        temp_speed.replace(".3",".2");
        temp_speed.replace(".5",".4");
        temp_speed.replace(".7",".6");
        temp_speed.replace(".9",".8");
        adata[6] = temp_speed;


        temp_speed = adata[7];
        temp_speed.replace(".1",".0");
        temp_speed.replace(".3",".2");
        temp_speed.replace(".5",".4");
        temp_speed.replace(".7",".6");
        temp_speed.replace(".9",".8");
        adata[7] = temp_speed;


        emit disablescr1(126,adata[3]);
        emit disablescr1(127,adata[4]);
        emit disablescr1(128,adata[6]);
        emit disablescr1(129,adata[7]);


    }

    if((config_parameter[0] == "CW6000"))
    {
        temp_speed = adata[3];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(5,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(5,1,QString("5"));

        }
        adata[3] = temp_speed;

        temp_speed = adata[4];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(5,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(5,1,QString("5"));

        }
        adata[4] = temp_speed;

        temp_speed = adata[6];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(3,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(3,1,QString("5"));

        }
        adata[6] = temp_speed;

        temp_speed = adata[7];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(3,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(3,1,QString("5"));

        }
        adata[7] = temp_speed;



        emit disablescr1(126,adata[3]);
        emit disablescr1(127,adata[4]);
        emit disablescr1(128,adata[6]);
        emit disablescr1(129,adata[7]);

    }



    if((config_parameter[0] == "CW600HSA"))
    {
        temp_speed = adata[3];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(5,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(5,1,QString("5"));

        }
        adata[3] = temp_speed;

        temp_speed = adata[4];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(5,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(5,1,QString("5"));

        }
        adata[4] = temp_speed;

        temp_speed = adata[6];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(4,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(4,1,QString("5"));

        }
        adata[6] = temp_speed;

        temp_speed = adata[7];
        if(temp_speed.right(1)=="1" || temp_speed.right(1)=="2" || temp_speed.right(1)=="3" || temp_speed.right(1)=="4")
        {
            temp_speed.replace(4,1,QString("0"));
        }
        else if(temp_speed.right(1)=="6" || temp_speed.right(1)=="7" || temp_speed.right(1)=="8" || temp_speed.right(1)=="9")
        {
            temp_speed.replace(4,1,QString("5"));

        }
        adata[7] = temp_speed;



        emit disablescr1(126,adata[3]);
        emit disablescr1(127,adata[4]);
        emit disablescr1(128,adata[6]);
        emit disablescr1(129,adata[7]);

    }



//----------------------------------------------------------------

    cpp_opr_delay = adata[9].toInt();
    if(cpp_opr_delay >= 91)//81
    {
        adata[9] = QString::number(90);//80
        cpp_opr_delay = 90;//80;
        emit disablescr1(130,adata[9]);
    }
    cpp_prd_length = adata[5].toInt();
    if(cpp_prd_length > Max_len)
    {
        adata[5] = QString::number(Max_len);
        cpp_prd_length = Max_len;
        emit disablescr1(121,adata[5]);
    }

    cpp_prd_length = adata[5].toInt();
    if(cpp_prd_length <= 11)
    {
        adata[5] = QString::number(10);
        cpp_prd_length = 10;
        emit disablescr1(131,adata[5]);
    }

            cpp_prd_speed = adata[8].toInt();
            if(config_parameter[0] == "CW3000HSA")
            {

                mtrs_mm = (platform - cpp_prd_length) * 60 / ((start_delay * 5) + 20);
            }
            else if(CW1200fg)
            {
                mtrs_mm = (platform - cpp_prd_length) * 60 / 140;							//170
            }
            else
            {

                mtrs_mm = (platform - cpp_prd_length) * 60 / ((start_delay * 5) + 25);//10,15							//170

            }
            mtrs_mm = mtrs_mm * 1000 / platform_plus;
            chk_mtrs_permin = mtrs_mm;
            if(cpp_prd_speed > chk_mtrs_permin)
            {
                adata[8] = QString::number(chk_mtrs_permin);
                cpp_prd_speed = chk_mtrs_permin;
                //adata[8] = param[8];
                emit disablescr1(120,adata[8]);
            }



//******************************************************************




    fileSpeed = adata[8].toInt();

qDebug() <<"The data saved in:"<<adata;

    if(fileSpeed <= MIN_SPEED)
    {

       fileSpeed = MIN_SPEED;
       temp_speed = QString::number(fileSpeed);
       adata[8] = temp_speed;
        emit disablescr1(122,temp_speed);
    }
    if(fileSpeed >= MAX_SPEED)
    {
        fileSpeed = MAX_SPEED;
        temp_speed = QString::number(fileSpeed);
        adata[8] = temp_speed;
        emit disablescr1(123,temp_speed);
    }
   // fileSpeed = adata[3];
    qDebug() <<"TARGET WT:"<<adata[3];
    if(adata[3] >= config_parameter[7])
    {
        adata[3] = config_parameter[7];
        emit disablescr1(124,config_parameter[7]);

    }


    if(adata[4] >= config_parameter[7])
    {
        adata[4] = config_parameter[7];
        emit disablescr1(125,config_parameter[7]);

    }


//QFileInfo check_currentfile(source);
QFileInfo check_currentfile(locationOfFile);
if(check_currentfile.exists() && check_currentfile.isFile()){
    qDebug() << "file exist";
 //   QFile file1(source);
    QFile file1(locationOfFile);

    if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
    }
    QTextStream in1(&file1);
    while(!in1.atEnd()) {
        //             QString line1 = in.readLine();
        currentFile = in1.readLine();
        qDebug() << "current file in currentfile.txt read in saveParamInFile call:"<<currentFile;

    }

    file1.close();

}
else{

    qDebug() << "file doesnt exist";

}


    if (QFile::exists(textFilepath + currentFile))
    {
       // QFile::remove(textFilepath + currentFile);
    }
  QFile file(textFilepath + currentFile);

  if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
    qDebug() << "file already there";
   }


  {

      param[2] = cpp_prd_batchno;
      qDebug() << "length of File" << length;

          for(int i=0;i<length;i++) {
          qDebug() <<"The data saved in:"<< source << adata[i];
          QTextStream out(&file);
          if((i == 2) && (cpp_prd_batchno != adata[2]) && (batch_endfg == 1) ){
                    qDebug() << "NEW BATCH RUNNING";

                   // cpp_prd_batchno = adata[2];

                    emit batch_change(adata[2]);

                    if(duplicate_batchfg)
                    {
                        adata[2] = param[2];
                      //  qDebug() << "NEW BATCH RUNNING"<<adata[2]<<param[0];

                    }
                    else
                    {
                        emit chkFileExist("Recipe SAVE successfully");
                        unique_bchfg = 1;
                        ONOFF_param[3] = "2";

                        if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
                        {
                            qDebug() << "Failed to create";
                        }
                        QTextStream in1(&ONOFF_file);

                        in1 << ONOFF_param[0] << '\n';
                        in1 << ONOFF_param[1] << '\n';
                        in1 << ONOFF_param[2] << '\n';
                        in1 << ONOFF_param[3] << '\n';

                        ONOFF_file.close();

                    }
          }
          else if((i == 2) && (cpp_prd_batchno != adata[2]) && (batch_endfg == 0)){
                    adata[2] = cpp_prd_batchno;
                    qDebug() << "BATCH RUNNING";
                    emit chkFileExist("WARNING -> PREVIOUS BATCH IS RUNNING");

          }

          out << adata[i] <<'\n';

          }

        file.close();


            if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
               qDebug()  << "is already in your address book." << file.errorString();
                return;
            }



            param[0] = file.readLine();
            qDebug() << param[0];
            param[1] = file.readLine();
            qDebug() << param[1];
            param[2] = file.readLine();
            qDebug() << param[2];
            param[3] = file.readLine();
            qDebug() << param[3];
            param[4] = file.readLine();
            qDebug() << param[4];
            param[5] = file.readLine();
            qDebug() << param[5];
            param[6] = file.readLine();
            qDebug() << param[6];
            param[7] = file.readLine();
            qDebug() << param[7];
            param[8] = file.readLine();
            qDebug() << param[8];
            param[9] = file.readLine();
            qDebug() << param[9];
            param[10] = file.readLine();
            qDebug() << param[10];
            param[11] = file.readLine();
            qDebug() << param[11];

            param[12] = file.readLine();
            qDebug() << param[12];

            file.close();
        qDebug() << adata[3] << "dsadsadsadsadsadsdsds";

        param[0] = adata[0];
        param[1] = adata[1];
        param[2] = adata[2];
        param[3] = adata[3];
        param[4] = adata[4];
        param[5] = adata[5];
        param[6] = adata[6];
        param[7] = adata[7];
        param[8] = adata[8];
        param[9] = adata[9];
        param[10] = adata[10];
        param[11] = adata[11];

        param[12] = adata[12];

        qDebug() << adata[2];// * 100;

        if(cpp_prd_batchno != param[2] && duplicate_batchfg == 0)
        {
            prev_value = cpp_prd_batchno;
            cur_value = param[2];
            qDebug() << "AUDIT TRIAL" << param[2];// * 100;
            event_msg = "BATCH NUMBER";
            batch_hder_userid = userid;
           batch_stdttime();

            cpp_prd_batchno = param[2];

            cpp_prd_code1 = param[0];
            cpp_prd_name1 = param[1];
            demo_targetwt1 = param[3];
            demo_tarewt1 = param[4];
            demo_length1 = param[5];
            demo_uplimit1 = param[6];
            demo_lolimit1 = param[7];
            demo_speed1 = param[8];
            demo_oprdelay1 = param[9];
            demo_holddelay1 = param[10];
            demo_rejcnt1 = param[11];
            demo_mdopr1 = param[12];

           if(duplicate_batchfg == 0)
           {



            uw_count = 0;
            ow_count = 0;
            accp_count = 0;
            tot_count=0;
            avg_accp_bin = 0;
            max_wt = 0;
            min_wt = 0;
            avg_accp_wt = 0;
            batch_accp_cnt = "0";
            batch_ow_cnt = "0";
            batch_uw_cnt = "0";
            batch_tot_cnt = "0";
            std_dev_buffer = 0;
            avg_buff = 0;
            comparefg = 0;
            batch_stop = 1;
            batch_avgaccp_wt = "0";

            cpp_prd_batchno = param[2];

            cpp_prd_code1 = param[0];
            cpp_prd_name1 = param[1];
            demo_targetwt1 = param[3];
            demo_tarewt1 = param[4];
            demo_length1 = param[5];
            demo_uplimit1 = param[6];
            demo_lolimit1 = param[7];
            demo_speed1 = param[8];
            demo_oprdelay1 = param[9];
            demo_holddelay1 = param[10];
            demo_rejcnt1 = param[11];
            demo_mdopr1 = param[12];


            //emit online_okcounts(accp_count,0,0);
            emit online_okcounts(accp_count,0,0,uw_count,ow_count);
//            emit online_uwcounts(uw_count);
//            emit online_owcounts(ow_count);
           // emit batch_change();
            emit signal_savetextfield(global_datetime,event_msg,prev_value,cpp_prd_batchno,userid);


            if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
            {
                qDebug() << "Failed to create";
            }
             QTextStream in(&stats_file);

                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";
                      in << 0 << "\n";

                        stats_param[0] = "0";
                        stats_param[1] = "0";
                        stats_param[2] = "0";
                        stats_param[3] = "0";
                        stats_param[4] = "0";
                        stats_param[5] = "0";
                        stats_param[6] = "0";
                        stats_param[7] = "0";
                        stats_param[8] = "0";
                        stats_param[9] = "0";
                        stats_param[10] = "0";
                        stats_param[11] = "0";
                        stats_param[12] = "0";
                        stats_param[13] = "0";

             stats_file.close();


           }
           else
           {
               //ONOFF_param[1] = "1";

           }


        }
        //if(batchend_errfg == 0)
        {
            cpp_prd_batchno = param[2];
            qDebug() << batchend_errfg << "batchenderrfg";// * 100;
        }
        qDebug() << cpp_prd_batchno;// * 100;


        if(duplicate_batchfg == 0)
        {


        if(cpp_prd_code != param[0])
        {
            prev_value = cpp_prd_code;
            cur_value = param[0];
            qDebug() << "AUDIT TRIAL";// * 100;

            event_msg = "PRODUCT CODE";
//            emit signal_savetextfield();
            cpp_prd_code = param[0];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,cpp_prd_code,userid);

        }
        cpp_prd_code = param[0];
        qDebug() << cpp_prd_code;// * 100;


        if(cpp_prd_name != param[1])
        {
            prev_value = cpp_prd_name;
            cur_value = param[1];
            qDebug() << "AUDIT TRIAL";// * 100;

            event_msg = "PRODUCT NAME";
//            emit signal_savetextfield();
            cpp_prd_name = param[1];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,cpp_prd_name,userid);






        }
        cpp_prd_name = param[1];
        qDebug() << cpp_prd_name;// * 100;

        if(demo_targetwt != param[3])
        {
            prev_value = demo_targetwt;
            cur_value = param[3];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "TARGET WEIGHT";
            demo_targetwt = param[3];

            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_targetwt,userid);

        }


        demo_targetwt = param[3];
        qDebug() << demo_targetwt;// * 100;

        if(demo_tarewt != param[4])
        {
            prev_value = demo_tarewt;
            cur_value = param[4];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "TARE WEIGHT";
//            emit signal_savetextfield();
             demo_tarewt = param[4];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_tarewt,userid);





        }

        demo_tarewt = param[4];
        qDebug() << demo_tarewt;// * 100;

        cpp_prd_length = param[5].toInt();
        if(cpp_prd_length > Max_len)
        {
            param[5] = QString::number(Max_len);
            cpp_prd_length = Max_len;
            emit disablescr1(121,param[5]);
        }


        if(demo_length != param[5])
        {
            prev_value = demo_length;
            cur_value = param[5];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "PRODUCT LENGTH";
//            emit signal_savetextfield();
            demo_length = param[5];

            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_length,userid);

        }

        demo_length = param[5];
        qDebug() << demo_length;// * 100;


        if(demo_uplimit != param[6])
        {
            prev_value = demo_uplimit;
            cur_value = param[6];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "UPPER LIMIT";
//            emit signal_savetextfield();
             demo_uplimit = param[6];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_uplimit,userid);


        }

        demo_uplimit = param[6];
        qDebug() << demo_uplimit;// * 100;
        if(demo_lolimit != param[7])
        {
            prev_value = demo_lolimit;
            cur_value = param[7];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "LOWER LIMIT";
            //emit signal_savetextfield();
             demo_lolimit = param[7];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_lolimit,userid);






        }

        demo_lolimit = param[7];
        qDebug() << demo_lolimit;// * 100;
        start_delay = config_parameter[2].toInt();
        start_delay = start_delay / 5;

        cpp_prd_speed = param[8].toInt();
        if(config_parameter[0] == "CW3000HSA")
        {

            mtrs_mm = (platform - cpp_prd_length) * 60 / ((start_delay * 5) + 20);
        }
        else if(CW1200fg)
        {
            mtrs_mm = (platform - cpp_prd_length) * 60 / 140;							//170
        }
        else
        {

            mtrs_mm = (platform - cpp_prd_length) * 60 / ((start_delay * 5) + 25);//10,15							//170

        }
        mtrs_mm = mtrs_mm * 1000 / platform_plus;
        chk_mtrs_permin = mtrs_mm;
        if(cpp_prd_speed > chk_mtrs_permin)
        {
            param[8] = QString::number(chk_mtrs_permin);
            cpp_prd_speed = chk_mtrs_permin;
            adata[8] = param[8];
            emit disablescr1(120,param[8]);
        }

        if(demo_speed != param[8])
        {
            prev_value = demo_speed;
            cur_value = param[8];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "SPEED";
            demo_speed = param[8];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_speed,userid);





        }

        demo_speed = param[8];
        qDebug() << demo_speed;// * 100;
        if(demo_oprdelay != param[9])
        {
            prev_value = demo_oprdelay;
            cur_value = param[9];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "OPERATE DELAY(CW)";
            //emit signal_savetextfield();
             demo_oprdelay = param[9];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_oprdelay,userid);





        }

        demo_oprdelay = param[9];
        qDebug() << demo_oprdelay;// * 100;
        if(demo_holddelay != param[10])
        {
            prev_value = demo_holddelay;
            cur_value = param[10];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "HOLD DELAY";
            //emit signal_savetextfield();
             demo_holddelay = param[10];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_holddelay,userid);

        }

        demo_holddelay = param[10];
        qDebug() << demo_holddelay;// * 100;

        if(demo_rejcnt != param[11])
        {
            prev_value = demo_rejcnt;
            cur_value = param[11];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "REJECT COUNT";
            //emit signal_savetextfield();
            demo_rejcnt = param[11];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_rejcnt,userid);

        }

        demo_rejcnt = param[11];
        qDebug() << demo_rejcnt;// * 100;


        if(demo_mdopr != param[12])
        {
            prev_value = demo_mdopr;
            cur_value = param[12];
            qDebug() << "AUDIT TRIAL";// * 100;
            event_msg = "OPERATE DELAY(MD)";
            //emit signal_savetextfield();
            demo_mdopr = param[12];
            emit signal_savetextfield(global_datetime,event_msg,prev_value,demo_mdopr,userid);

        }

        demo_mdopr = param[12];
        qDebug() << demo_mdopr;// * 100;


        demo_targetwt = param[3];
        cpp_prd_target = param[3].toFloat();
         qDebug() << cpp_prd_target;
        if(CW1200fg)
        {
            cpp_prd_target = cpp_prd_target * 10;

        }
        else
        {
            cpp_prd_target = cpp_prd_target * 100;
        }
        qDebug() << cpp_prd_target;// * 100;



        cpp_prd_tare = param[4].toFloat();

        if(CW1200fg)
        {
            cpp_prd_tare = cpp_prd_tare * 10;

        }
        else
        {
            cpp_prd_tare = cpp_prd_tare * 100;
        }


        qDebug() << cpp_prd_tare;
        cpp_prd_length = param[5].toInt();
        qDebug() << cpp_prd_length;
       // param[5] = 200;

        cpp_prd_Ulimit = param[6].toFloat();
        if(CW1200fg)
        {
            cpp_prd_Ulimit = cpp_prd_Ulimit * 10;

        }
        else
        {
            cpp_prd_Ulimit = cpp_prd_Ulimit * 100;
        }



        qDebug() << cpp_prd_Ulimit;
        cpp_prd_Llimit = param[7].toFloat();
        if(CW1200fg)
        {
            cpp_prd_Llimit = cpp_prd_Llimit * 10;

        }
        else
        {
            cpp_prd_Llimit = cpp_prd_Llimit * 100;
        }



        qDebug() << cpp_prd_Llimit;
        cpp_prd_speed = param[8].toInt();
        qDebug() << cpp_prd_speed;



        cpp_opr_delay = param[9].toInt();
        qDebug() << cpp_opr_delay;
        cpp_hold_delay = param[10].toInt();
        cpp_hold_delay = cpp_hold_delay * config_parameter[6].toInt();
        qDebug() << cpp_hold_delay << "HAHAHA" << cpp_opr_delay;

        cpp_rej_cnt = param[11].toInt();
        qDebug() << cpp_rej_cnt;

        cpp_md_opdly = param[12].toInt();
        qDebug() << cpp_md_opdly;


       // file.close();//1



    }

        if(duplicate_batchfg == 1)
        {
             emit disablescr1(5,0);
            qDebug() << "DUPLICATE BATCH";
            duplicate_batchfg = 0;

        }


//        char *aff;
//        double opc_var;


//        aff = userid.toUtf8().data();
//        T4OPC_WriteTagString("UserID", aff);

//        aff = report_machid.toUtf8().data();
//        T4OPC_WriteTagString("MachineId", aff);

//        aff = cpp_prd_code.toUtf8().data();
//        T4OPC_WriteTagString("ProductCode", aff);
//        aff = cpp_prd_name.toUtf8().data();
//        T4OPC_WriteTagString("ProductName", aff);
//        aff = cpp_prd_batchno.toUtf8().data();
//        T4OPC_WriteTagString("BatchNum", aff);
//        opc_var = param[3].toDouble();
//        T4OPC_WriteTagDouble("TargetWeight",opc_var);
//        opc_var = param[4].toDouble();
//        T4OPC_WriteTagDouble("TareWeight",opc_var);

//        opc_var = ((param[3].toDouble()) + (param[6].toDouble()));
//        //  opc_var = param[6].toDouble();
//        T4OPC_WriteTagDouble("UpperLimit",opc_var);
//        opc_var = ((param[3].toDouble()) - (param[7].toDouble()));
//        //   opc_var = param[7].toDouble();
//        T4OPC_WriteTagDouble("LowerLimit",opc_var);



//        T4OPC_WriteTagInt("Speed",cpp_prd_speed);
//        T4OPC_WriteTagInt("OperateDelayCW",cpp_opr_delay);
//        T4OPC_WriteTagInt("OperateDelayMD",cpp_md_opdly);
//        T4OPC_WriteTagInt("ProductLength",cpp_prd_length);
//        T4OPC_WriteTagInt("RejectCount",cpp_rej_cnt);




    }


}


void FileIO::Poweron_saveParamInFile()
{
    QString param[13];
    QString currentFile;

    QFileInfo check_currentfile(textFilepath + "currentFile.txt");

    if(check_currentfile.exists() && check_currentfile.isFile()){
      qDebug() << "file existPPPPPP";

       QFile file1(textFilepath + "currentFile.txt");

      if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file1);
           while(!in.atEnd()) {
 //             QString line1 = in.readLine();
              currentFile = in.readLine();
              qDebug() << "current file in currentfile.txt read:"<<currentFile;

           }

           file1.close();

    }
    else{

        qDebug() << "file doesnt exist";

    }


//     QFile file(currentFile);
     QFile file(textFilepath + currentFile);

        if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
           qDebug()  << "is already in your address book." << file.errorString();
            //return;
        }



        param[0] = file.readLine();


        param[0].truncate(param[0].lastIndexOf(QChar('\n')));



        qDebug() << param[0];
        param[1] = file.readLine();
        qDebug() << param[1];
        param[2] = file.readLine();
        qDebug() << param[2];
        param[3] = file.readLine();
        qDebug() << param[3];
        param[4] = file.readLine();
        qDebug() << param[4];
        param[5] = file.readLine();
        qDebug() << param[5];
        param[6] = file.readLine();
        qDebug() << param[6];
        param[7] = file.readLine();
        qDebug() << param[7];
        param[8] = file.readLine();
        qDebug() << param[8];
        param[9] = file.readLine();
        qDebug() << param[9];
        param[10] = file.readLine();
        qDebug() << param[10];
        param[11] = file.readLine();
        qDebug() << param[11];

        param[12] = file.readLine();
        qDebug() << param[12];

         file.close();

        param[1].truncate(param[1].lastIndexOf(QChar('\n')));
        param[2].truncate(param[2].lastIndexOf(QChar('\n')));
        param[3].truncate(param[3].lastIndexOf(QChar('\n')));
        param[4].truncate(param[4].lastIndexOf(QChar('\n')));
        param[5].truncate(param[5].lastIndexOf(QChar('\n')));
        param[6].truncate(param[6].lastIndexOf(QChar('\n')));
        param[7].truncate(param[7].lastIndexOf(QChar('\n')));
        param[8].truncate(param[8].lastIndexOf(QChar('\n')));
        param[9].truncate(param[9].lastIndexOf(QChar('\n')));
        param[10].truncate(param[10].lastIndexOf(QChar('\n')));
        param[11].truncate(param[11].lastIndexOf(QChar('\n')));

        param[12].truncate(param[12].lastIndexOf(QChar('\n')));


        cpp_prd_code = param[0];
        qDebug() << cpp_prd_code;// * 100;

        cpp_prd_name = param[1];
        qDebug() << cpp_prd_name;// * 100;

        cpp_prd_batchno = param[2];
        qDebug() << cpp_prd_batchno;// * 100;

        var1 = "/0";
        var1 = "Dynamic" + cpp_prd_batchno;
        var2 = "/0";
        var2 = "AUDIT" + cpp_prd_batchno;
        var3 = "/0";
        var3 = "ALARAM" + cpp_prd_batchno;
        var4 = "BATCH_NAME1";



        demo_targetwt = param[3];
        qDebug() << demo_targetwt;// * 100;
        demo_tarewt = param[4];
        qDebug() << demo_tarewt;// * 100;
        demo_length = param[5];
        qDebug() << demo_length;// * 100;
        demo_uplimit = param[6];
        qDebug() << demo_uplimit;// * 100;
        demo_lolimit = param[7];
        qDebug() << demo_lolimit;// * 100;
        demo_speed = param[8];
        qDebug() << demo_speed;// * 100;
        demo_oprdelay = param[9];
        qDebug() << demo_oprdelay;// * 100;
        demo_holddelay = param[10];
        qDebug() << demo_holddelay;// * 100;
        demo_rejcnt = param[11];
        qDebug() << demo_rejcnt;// * 100;

        demo_mdopr = param[12];
        qDebug() << demo_mdopr;// * 100;

        cpp_prd_target = param[3].toFloat();
        if(CW1200fg)
        {
            cpp_prd_target = cpp_prd_target * 10;

        }
        else
        {
            cpp_prd_target = cpp_prd_target * 100;
        }

        qDebug() << cpp_prd_target;

        cpp_prd_tare = param[4].toFloat();
        if(CW1200fg)
        {
            cpp_prd_tare = cpp_prd_tare * 10;

        }
        else
        {
            cpp_prd_tare = cpp_prd_tare * 100;
        }

        qDebug() << cpp_prd_tare;
        cpp_prd_length = param[5].toInt();
        qDebug() << cpp_prd_length;
      //  adata[5] = 200;

        cpp_prd_Ulimit = param[6].toFloat();
        if(CW1200fg)
        {
            cpp_prd_Ulimit = cpp_prd_Ulimit * 10;

        }
        else
        {
            cpp_prd_Ulimit = cpp_prd_Ulimit * 100;
        }


        qDebug() << cpp_prd_Ulimit;
        cpp_prd_Llimit = param[7].toFloat();
        if(CW1200fg)
        {
            cpp_prd_Llimit = cpp_prd_Llimit * 10;

        }
        else
        {
            cpp_prd_Llimit = cpp_prd_Llimit * 100;
        }



        qDebug() << cpp_prd_Llimit;
        cpp_prd_speed = param[8].toInt();
        qDebug() << cpp_prd_speed;


        cpp_opr_delay = param[9].toInt();
        qDebug() << cpp_opr_delay;
        cpp_hold_delay = param[10].toInt();
        qDebug() << cpp_hold_delay;

        cpp_rej_cnt = param[11].toInt();
        qDebug() << cpp_rej_cnt;

        cpp_md_opdly = param[12].toInt();
        qDebug() << cpp_md_opdly;

      //  file.close();

        //---------------------------------------------------------------------


        QFileInfo check_batchfile(textFilepath + "reportFileParam.txt");
        if(check_batchfile.exists() && check_batchfile.isFile()){
          qDebug() << "file existTTTTT";
           QFile batchfile(textFilepath + "reportFileParam.txt");

          if(!batchfile.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
            qDebug() << "file already there";
           }
               QTextStream in1(&batchfile);


//               in1.readLine() = report_compname;
//               in1.readLine() = report_L1Addr;
//               in1.readLine() = report_L2Addr;
//               in1.readLine() = report_machid;

               report_compname = in1.readLine();
               report_L1Addr = in1.readLine();
               report_L2Addr = in1.readLine();
               report_machid = in1.readLine();

               qDebug() << report_compname << "NAMEEEE";



               batchfile.close();

        }
        else{

            qDebug() << "file doesnt exist";

        }



        cpp_prd_code1 = param[0];
        cpp_prd_name1 = param[1];
        demo_targetwt1 = param[3];
        demo_tarewt1 = param[4];
        demo_length1 = param[5];
        demo_uplimit1 = param[6];
        demo_lolimit1 = param[7];
        demo_speed1 = param[8];
        demo_oprdelay1 = param[9];
        demo_holddelay1 = param[10];
        demo_rejcnt1 = param[11];
        demo_mdopr1 = param[12];

        if(prodnfg)
        {
            handleMachine_sts(1);
            qDebug() << "PRODUCTION";
        }
        else
        {
            handleMachine_sts(0);
            qDebug() << "SETTING";

        }


//        char *aff;
//        double opc_var;


//        aff = userid.toUtf8().data();
//        T4OPC_WriteTagString("UserID", aff);

//        aff = report_machid.toUtf8().data();
//        T4OPC_WriteTagString("MachineId", aff);

//        aff = cpp_prd_code.toUtf8().data();
//        T4OPC_WriteTagString("ProductCode", aff);
//        aff = cpp_prd_name.toUtf8().data();
//        T4OPC_WriteTagString("ProductName", aff);
//        aff = cpp_prd_batchno.toUtf8().data();
//        T4OPC_WriteTagString("BatchNum", aff);
//        opc_var = param[3].toDouble();
//        T4OPC_WriteTagDouble("TargetWeight",opc_var);
//        opc_var = param[4].toDouble();
//        T4OPC_WriteTagDouble("TareWeight",opc_var);

//        opc_var = ((param[3].toDouble()) + (param[6].toDouble()));
//        //  opc_var = param[6].toDouble();
//        T4OPC_WriteTagDouble("UpperLimit",opc_var);
//        opc_var = ((param[3].toDouble()) - (param[7].toDouble()));
//        //   opc_var = param[7].toDouble();
//        T4OPC_WriteTagDouble("LowerLimit",opc_var);


//        T4OPC_WriteTagInt("Speed",cpp_prd_speed);
//        T4OPC_WriteTagInt("OperateDelayCW",cpp_opr_delay);
//        T4OPC_WriteTagInt("OperateDelayMD",cpp_md_opdly);
//        T4OPC_WriteTagInt("ProductLength",cpp_prd_length);
//        T4OPC_WriteTagInt("RejectCount",cpp_rej_cnt);


}


void FileIO::createNsaveToLib(const QString& source,QStringList adata,qint8 length){
QString cmpFileNames,recipeFilename;
cmpFileNames.clear();
cmpFileNames.append(source);
recipeFilename = textFilepath + source;

qDebug() << "create and save library is :" << source ;
qDebug() << "create and save library path is  :" << recipeFilename ;
// for(int i=4;i<source.length();i++){

 //   cmpFileNames.append(source[i]);
// }
 qDebug() << "cmpfilename is :" << cmpFileNames ;
  //  if (source.isEmpty())
    if (recipeFilename.isEmpty())
    {
        qDebug() << "source is empty:";

    }
    if (QFile::exists(recipeFilename))
    {
 //       QFile::remove(recipeFilename);
       emit handleErrorExistFile("DF");
    }

else{
    QFile file(recipeFilename);

        if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
           qDebug()  << "is already in your address book." << file.errorString();
           // return;
        }
        for(int i=0;i<length;i++) {
        qDebug() <<"The data saved in:"<<recipeFilename <<adata[i];
        QTextStream out(&file);
        out << adata[i] <<'\n';
        }


            file.close();
            //------------------------------code for copying file name into compare file-------------------------//

                         if (QFile::exists(textFilepath + "compare.txt"))
                     {

                        //  QFile::remove(textFilepath + "compare.txt");
                     }

                     QFile file1(textFilepath + "compare.txt");


                         if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
                            qDebug()  << "is already in your address book." << file1.errorString();
                             return;
                         }

                         qDebug() <<"The name of file saved in :" <<cmpFileNames;
                         QTextStream out(&file1);
                         out << cmpFileNames;    // source;

                         file1.close();
             //-----------------------------------------------------------------------------------------------//


    }
}

void FileIO::chkDuplicateFile(const QString& source){
QString recipeFilename;
recipeFilename = textFilepath + source;

qDebug() << "create and save library in duplicateFile :" << source ;
qDebug() << "create and save library path in duplicateFile  :" << recipeFilename ;


  //  if (source.isEmpty())
    if (recipeFilename.isEmpty())
    {
        qDebug() << "source is empty:";

    }
    if (QFile::exists(recipeFilename))
    {
 //       QFile::remove(recipeFilename);
        qDebug() << "duplicate file";
       emit handleErrorExistFile("DF");
    }

else{
        qDebug() << "NO duplicate file";
        emit handleErrorExistFile("NDF");


    }
}

void FileIO::loadFromFile(){

        QFile file("F:\\ manoj.abk");

            if (!file.open(QIODevice::ReadOnly)) {
                qDebug()  << "Unable to open file" << file.errorString();
                return;
            }

            QDataStream in(&file);
            in.setVersion(QDataStream::Qt_4_3);
            in >> contacts;

            QMap<QString, QString>::iterator i = contacts.begin();

            while (i != contacts.end()) {
                qDebug() << i.value() << "is already in your address book.";
                emit handleSubmittFileParam(i.key(),i.value(),"");
                   i++ ;

            }
            if (i == contacts.end())
                 i = contacts.begin();



}

void FileIO::loadFromLib(const QString& source){

    QStringList strList;
    QString cmpFileNames;
    QString locationOfFile;
    locationOfFile = textFilepath + source;
    cmpFileNames.clear();

    cmpFileNames.append(source);

    if (locationOfFile.isEmpty())
    {
        qDebug() << "source is empty:";

    }


     QFileInfo check_file(locationOfFile);
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist";

      QFile file(locationOfFile);
      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           while(!in.atEnd()) {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              strList<< line;
              qDebug() << "send read....:"<<strList;
           }

            file.close();

           emit handleSaveTextField(strList);



           //------------------------------code for copying file name into current file-------------------------//

                    if(QFile::exists(textFilepath + "currentFile.txt"))
                    {
                         QFile::resize(textFilepath + "currentFile.txt",0);
                    }
                    QFile file2(textFilepath + "currentFile.txt");

                        if(!file2.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
                           qDebug()  << "is already in your address book." << file2.errorString();
                            //return;
                        }

                        qDebug() <<"The name of file saved in current file is :" <<source;
                        QTextStream out2(&file2);
                        out2 << source;    // source;


                        file2.close();
            //-----------------------------------------------------------------------------------------------//



           //------------------------------code for copying file name into compare file-------------------------//

                    if (QFile::exists(textFilepath + "compare.txt"))
                    {
                        QFile::resize(textFilepath + "compare.txt",0);
                    }

                    QFile file1(textFilepath + "compare.txt");

                        if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
                           qDebug()  << "is already in your address book." << file1.errorString();
                            //return;
                        }
                        qDebug() <<"The name of file saved in :" <<cmpFileNames;
                        QTextStream out(&file1);

                        out << cmpFileNames;    // source;



                        file1.close();
            //-----------------------------------------------------------------------------------------------//

    }
    else{

        qDebug() << "file doesnt exist";

    }


}
void FileIO::loadParamFromListFileName(const QString& source){

    QStringList strList;
    QString recipeFilename;
    recipeFilename = textFilepath + source;

    event_msg = source+" recipe is loaded.";
    emit signal_savetextfield(global_datetime,event_msg,"","",userid);
   // if (source.isEmpty())
        if (recipeFilename.isEmpty())
    {
        qDebug() << "source is empty:";

    }

  //  QFileInfo check_file(source);
    QFileInfo check_file(recipeFilename);
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist";
   //   QFile file(source);
      QFile file(recipeFilename);

      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           while(!in.atEnd()) {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              strList<< line;
              qDebug() << "send read:"<<strList;
           }

            file.close();
           emit handleSaveTextField(strList);



//           //------------------------------code for copying file name into compare file-------------------------//

//            //-----------------------------------------------------------------------------------------------//

    }
    else{
    //    emit chkFileExist("File doesn't exist");
        qDebug() << "file doesnt exist";

    }


}


void FileIO::powerOnLoadFromLib(const QString& source){

    QStringList strList;
    QString currentFile;
    QString locationOfFile;
    locationOfFile = textFilepath + source;
    if(CW1200fg)
    {
        emit disablescr1(3,0);

    }
    if (locationOfFile.isEmpty())
    {
        qDebug() << "source is empty:";

    }
     QFileInfo check_currentfile(locationOfFile);
    if(check_currentfile.exists() && check_currentfile.isFile()){
      qDebug() << "file exist.....";

      QFile file1(locationOfFile);

      if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file1);
           while(!in.atEnd())
           {
              currentFile = in.readLine();
              qDebug() << "current file in currentfile.txt read:"<<currentFile;

           }

           file1.close();

    }
    else{

        qDebug() << "file doesnt exist";

    }
    QFileInfo check_file(textFilepath + currentFile);
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist>>>>";

      QFile file(textFilepath + currentFile);

      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           //while(!in.atEnd())
           for(int i = 0;i<=12;i++)
           {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              strList<< line;
              qDebug() << "send read:"<<strList;
           }
           file.close();

    }
    else{

        qDebug() << "file doesnt exist";
        emit chkFileExist("Load Recipe");

    }

//-------------to read parameter and send to qml-----------------------------

    QFileInfo check_batchfile(textFilepath + "reportFileParam.txt");
    if(check_batchfile.exists() && check_batchfile.isFile()){
      qDebug() << "file exist<<<<<";

      QFile batchfile(textFilepath + "reportFileParam.txt");

      if(!batchfile.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in1(&batchfile);
           //while(!in1.atEnd())
            for(int i = 0;i<=3;i++)
           {
              QString line1 = in1.readLine();
              qDebug() << "file read from reportFileParam.txt:"<<line1;
              strList<< line1;

           }



           batchfile.close();
           emit handleSaveTextField(strList);

    }
    else{

        qDebug() << "file doesnt exist";

    }
//-------------------------------------------------------------------------------------------

}
void FileIO::loadFromListFileNames(const QString& source){

    QStringList strList;
    QString locationOfFile;
    locationOfFile = textFilepath + source;
   if (locationOfFile.isEmpty())
    {
        qDebug() << "source is empty:";

    }


    QFileInfo check_file(locationOfFile);
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist";

      QFile file(locationOfFile);
      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           while(!in.atEnd()) {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              strList<< line;
              qDebug() << "send read:"<<strList;
           }
            file.close();
           emit handleSaveFileList(strList);


    }
    else{

        qDebug() << "file doesnt exist";

    }


}
void FileIO::createListFileNames(const QString& source){


    bool singlesavefg = false;
    if (source.isEmpty())
    {
        qDebug() << "source is empty:";

    }


    QFile file(textFilepath + "LibraryFiles.txt");

      //  if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
     if(!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::ReadWrite)) {
           qDebug()  << "is already in your address book." << file.errorString();
            return;
        }
        QTextStream in(&file);

        while(!in.atEnd()) {
        QString line = in.readLine();
        if(line == source){
            singlesavefg = true;
        }
        else{
            singlesavefg = false;
        }
        qDebug() << "the line read from LibraryFiles.txt is :"<<line;
        }

        if(!singlesavefg){
          QTextStream out(&file);
          out << source<<'\n';
          event_msg = "Recipe " + source+" is created ";
          emit signal_savetextfield(global_datetime,event_msg,"","",userid);

        }
        file.close();
          emit chkFileExist("Recipe SAVE successfully");


}




void FileIO::createLoginNames(const QString& source,const QString& param1,const QString& param2){
    QString groupFileName;
    groupFileName = "F:\\ " + source + ".abk";
    if (groupFileName.isEmpty())
    {
        qDebug() << "file is empty:";
    }


      qDebug( "Connected to createloginNames!" );


//---------------------this code is not doing anything--------------------------------------------------------
    QSqlQuery qry;
    qry.prepare( "CREATE TABLE IF NOT EXISTS  LoginGroupNames (usernm VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created!"<<"LoginGroupNames (usernm VARCHAR(40))";


    qry.prepare( "INSERT INTO  LoginGroupNames (usernm)VALUES('" + param1 + "')" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"Inserted" <<"INSERT INTO  LoginGroupNames (usernm)VALUES('" + param1 + "')" ;
//-------------------------------------------------------------------------------------------------------------------

   bool alreadyExist = false;
//    qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40))");
    qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))");
   if( !qry.exec() )
     qDebug() << qry.lastError();
   else
     qDebug() << "Table created GroupNameUserName"<<"GroupNameUserName(usernm VARCHAR(40),groupnm VARCHAR(40),,expiryDays VARCHAR(12))";

   qry.prepare( "SELECT usernm,groupnm,expiryDays FROM GroupNameUserName WHERE usernm = '" + param1 + "'" );
   if( !qry.exec() ){
     qDebug() << qry.lastError();
   }
   else{
       alreadyExist = qry.next();
       if(alreadyExist){
           if(source == "Group"){
           qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', expiryDays = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
           if( !qry.exec() )
               qDebug() << qry.lastError();
           else
               qDebug() <<"UPDATED GroupNameUserName..." ;
           }
           else{
               qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', groupnm = '" + source + "', expiryDays = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"UPDATED GroupNameUserName..." ;
           }
       }
       else{
           qry.prepare( "INSERT INTO GroupNameUserName(usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" );
           if( !qry.exec() )
               qDebug() << qry.lastError();
           else
               qDebug() <<"Inserted" <<"INSERT INTO GroupNameUserName (usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" ;
       }
   }


 //-----------------------------------------------------------------------------
}

void FileIO::addNewUser(const QString& source,const QString& param1,const QString& param2){
    QString groupFileName;
    groupFileName = "F:\\ " + source + ".abk";
    if (groupFileName.isEmpty())
    {
        qDebug() << "file is empty:";
    }


      qDebug( "Connected to createloginNames!" );

      event_msg = "CREATED NEW USER: " + param1;
      emit signal_savetextfield(global_datetime,event_msg,"","",userid);

//---------------------this code is not doing anything--------------------------------------------------------
    QSqlQuery qry;
    qry.prepare( "CREATE TABLE IF NOT EXISTS  LoginGroupNames (usernm VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created!"<<"LoginGroupNames (usernm VARCHAR(40))";


    qry.prepare( "INSERT INTO  LoginGroupNames (usernm)VALUES('" + param1 + "')" );
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() <<"Inserted" <<"INSERT INTO  LoginGroupNames (usernm)VALUES('" + param1 + "')" ;
//-------------------------------------------------------------------------------------------------------------------

   bool alreadyExist = false;
//    qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40))");
    qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))");
   if( !qry.exec() )
     qDebug() << qry.lastError();
   else
     qDebug() << "Table created GroupNameUserName"<<"GroupNameUserName(usernm VARCHAR(40),groupnm VARCHAR(40),,expiryDays VARCHAR(12))";

   qry.prepare( "SELECT usernm,groupnm,expiryDays FROM GroupNameUserName WHERE usernm = '" + param1 + "'" );
   if( !qry.exec() ){
     qDebug() << qry.lastError();
   }
   else{
       alreadyExist = qry.next();
       if(alreadyExist){
           if(source == "Group"){
           qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', expiryDays = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
           if( !qry.exec() )
               qDebug() << qry.lastError();
           else
               qDebug() <<"UPDATED GroupNameUserName..." ;
           }
           else{
               qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', groupnm = '" + source + "', expiryDays = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"UPDATED GroupNameUserName..." ;
           }
       }
       else{
           qry.prepare( "INSERT INTO GroupNameUserName(usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" );
           if( !qry.exec() )
               qDebug() << qry.lastError();
           else
               qDebug() <<"Inserted" <<"INSERT INTO GroupNameUserName (usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" ;
       }
   }


 //-----------------------------------------------------------------------------
}


//void FileIO::statusFile(const QString& param1,const QString& source){
  void FileIO::statusFile(const QString& param1,const QString& source,const QString& param2){

    QSqlQuery qry;
    bool alreadyExist = false;



    if(indivisualblockfg){
        indivisualblockfg = 0;
        blockstsfg = 1;
        event_msg = "3 Wrong Attempts ->"+param1+" "+source;
        emit signal_savetextfield(global_datetime,event_msg,"","",userid);

    }
    else{
        if(source == "Blocked"){
        event_msg = param1+" is Blocked by Admin ";
        emit signal_savetextfield(global_datetime,event_msg,"","",userid);
        }
        else if(source == "Inactive"){
            event_msg = param1+" is Unblocked by Admin ";
            emit signal_savetextfield(global_datetime,event_msg,"","",userid);
        }
        else if(source == "UserExp"){
            userid = param1;
            event_msg = "Password change after expiry " ;
            emit signal_savetextfield(global_datetime,event_msg," -- "," -- ",userid);
        }
        else if(blockstsfg==0)
        {
             userid = param1;
              qDebug() << param1 << "USERID";
              event_msg = param1+" is logged in";
              emit signal_savetextfield(global_datetime,event_msg,"","",userid);


        }
        else
        {
            blockstsfg = 0;
        }

    }


     qry.prepare( "CREATE TABLE IF NOT EXISTS  LoginFileNames (usernm VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created LoginFileNames"<<"LoginFileNames(usernm VARCHAR(40))";

    qry.prepare( "SELECT usernm FROM LoginFileNames WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qry.prepare( "UPDATE LoginFileNames SET usernm = '" + param1 + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED LoginFileNames..." ;
        }
        else{
            qry.prepare( "INSERT INTO LoginFileNames(usernm)VALUES('" + param1 + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"Inserted" <<"INSERT INTO LoginFileNames (usernm)VALUES('" + param1 + "')" ;
        }
    }


  //   qry.prepare( "CREATE TABLE IF NOT EXISTS  UserStatusFile (usernm VARCHAR(40),status VARCHAR(40))");
     qry.prepare( "CREATE TABLE IF NOT EXISTS  UserStatusFile (usernm VARCHAR(40),status VARCHAR(40),expiryDate VARCHAR(12))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
 //     qDebug() << "Table created UserStatusFile"<<"UserStatusFile(usernm VARCHAR(40),status VARCHAR(40))";
    qDebug() << "Table created UserStatusFile"<<"UserStatusFile(usernm VARCHAR(40),status VARCHAR(40),expiryDate VARCHAR(12))";

    qry.prepare( "SELECT usernm,status,expiryDate FROM UserStatusFile WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
   //         qry.prepare( "UPDATE UserStatusFile SET usernm = '" + param1 + "', status = '" + source + "' WHERE usernm = '" + param1 + "'" );
            qry.prepare( "UPDATE UserStatusFile SET usernm = '" + param1 + "', status = '" + source + "', expiryDate = '" + param2 + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED UserStatusFile..."<<"UPDATE UserStatusFile SET usernm = '" + param1 + "', status = '" + source + "', expiryDate = '" + param2 + "' WHERE usernm = '" + param1 + "'" ;
        }
        else{
            qry.prepare( "INSERT INTO UserStatusFile(usernm, status,expiryDate)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" );
        //    qry.prepare( "INSERT INTO UserStatusFile(usernm, status)VALUES('" + param1 + "', '" + source + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
           //     qDebug() <<"Inserted" <<"INSERT INTO UserStatusFile (usernm, status)VALUES('" + param1 + "', '" + source + "')" ;
            qDebug() <<"Inserted" <<"INSERT INTO UserStatusFile (usernm, status,expiryDate)VALUES('" + param1 + "', '" + source + "', '" + param2 + "')" ;
        }
    }


        qry.prepare( "CREATE TABLE IF NOT EXISTS  UserStatus (usernm VARCHAR(40),status VARCHAR(40))");
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
         qDebug() << "Table created UserStatus"<<"UserStatus(usernm VARCHAR(40),status VARCHAR(40))";

       qry.prepare( "SELECT usernm,status FROM UserStatus WHERE usernm = '" + param1 + "'" );
       if( !qry.exec() ){
         qDebug() << qry.lastError();
       }
       else{
           alreadyExist = qry.next();
           if(alreadyExist){
               qry.prepare( "UPDATE UserStatus SET usernm = '" + param1 + "', status = '" + source + "' WHERE usernm = '" + param1 + "'" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"UPDATED UserStatus..."<< "UPDATE UserStatus SET usernm = '" + param1 + "', status = '" + source + "' WHERE usernm = '" + param1 + "'";
           }
           else{
               qry.prepare( "INSERT INTO UserStatus(usernm, status)VALUES('" + param1 + "', '" + source + "')" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"Inserted" <<"INSERT INTO UserStatus (usernm, status)VALUES('" + param1 + "', '" + source + "')" ;
           }
       }

}

void FileIO::lastTwoSave(const QString& param1,const QString& param2){
           QSqlQuery qry;
           bool alreadyExist = false;
           int r,c,cnt = 0;
           bool last2savefg = 0;
           QStringList userList;

             //**********last two save****************

             qry.prepare( "CREATE TABLE IF NOT EXISTS  LASTTWOSAVE (usernm VARCHAR(40),password1 VARCHAR(16),password2 VARCHAR(16),password3 VARCHAR(16),password4 VARCHAR(16),password5 VARCHAR(16))");
             if( !qry.exec() )
                 qDebug() << qry.lastError();
             else
                 qDebug() << "Table created LASTTWOSAVE!";

             qry.prepare( "SELECT usernm,password1,password2,password3,password4,password5 FROM LASTTWOSAVE WHERE usernm = '" + param1 + "'" );
             if( !qry.exec() ){
                 qDebug() << qry.lastError();

             }
             else{
                 alreadyExist = qry.next();
                 if(alreadyExist){
                     qDebug( "searching in LASTTWOSAVE11111!" );
                     for(r=0,qry.first();qry.isValid();qry.next(),++r){
                         for(c = 1; c < 6; ++c){
                             userList<< qry.value(c).toString();
                        //     cnt++;
                             qDebug() << "The password from"<<qry.value(c).toString() <<param2;
                             if((qry.value(c).toString() != NULL) | (qry.value(c).toString() !="")){
                                 cnt++;
                             if(param2 == qry.value(c).toString()){
                              last2savefg = 1;
                              cnt = 0;
                              emit chkFileExist("Exist");
                              qDebug() << "The password entered matches with last two save";
                              break;
                             }
                             else{
                                 qDebug() << "The password entered not matches with last two save";

                             }
                         }

                         }
                     }
                     qDebug() << "The LASTTWOSAVE list is:"<<userList;

                     if((cnt== 1) && (!last2savefg)){
                         qry.prepare("UPDATE LASTTWOSAVE SET password2 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",param2);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.finish();
                          qDebug() <<"INSERTED second in LASTTWOSAVE..." ;
                     }
                     if((cnt== 2) && (!last2savefg)){
                         qry.prepare("UPDATE LASTTWOSAVE SET password3 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",param2);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.finish();
                          qDebug() <<"INSERTED 3 in LASTTWOSAVE..." ;
                     }
                     if((cnt== 3) && (!last2savefg)){
                         qry.prepare("UPDATE LASTTWOSAVE SET password4 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",param2);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.finish();
                          qDebug() <<"INSERTED 4 in LASTTWOSAVE..." ;
                     }
                     if((cnt== 4) && (!last2savefg)){
                         qry.prepare("UPDATE LASTTWOSAVE SET password5 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",param2);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.finish();
                          qDebug() <<"INSERTED 5 in LASTTWOSAVE..." ;
                     }
                     if((cnt== 5) && (!last2savefg)){
                         QStringList tempPass;
                         tempPass.clear();
                         for(int i=1;i<userList.length();i++){
                           tempPass<<userList[i];

                         }
                         userList.clear();
                         tempPass<<param2;
                         qDebug() <<"modified password list"<< tempPass;
                         qry.prepare("UPDATE LASTTWOSAVE SET password1 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",tempPass[0]);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.prepare("UPDATE LASTTWOSAVE SET password2 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",tempPass[1]);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.prepare("UPDATE LASTTWOSAVE SET password3 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",tempPass[2]);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.prepare("UPDATE LASTTWOSAVE SET password4 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",tempPass[3]);
                         qry.bindValue(":uname",param1);
                         qry.exec();
                         qry.prepare("UPDATE LASTTWOSAVE SET password5 = :value WHERE usernm = :uname");
                         qry.bindValue(":value",tempPass[4]);
                         qry.bindValue(":uname",param1);

                         qry.exec();
                         qry.finish();
                     }

                 }
                 else{
                     cnt = 0;
                     QStringList defaultPass;
                     defaultPass<<"";
                     defaultPass<<"";
                     defaultPass<<"";
                     defaultPass<<"";

                     qry.prepare( "INSERT INTO LASTTWOSAVE(usernm, password1,password2,password3,password4,password5)VALUES('" + param1 + "', '" + param2 + "', '" + defaultPass[0] + "', '" + defaultPass[1] + "', '" + defaultPass[2] + "', '" + defaultPass[3] + "')" );
                     if( !qry.exec() )
                         qDebug() << qry.lastError();
                     else
                         qDebug() <<"Inserted first";

                 }

             }
}


void FileIO::overWriteFile(const QString& source,const QString& param1){


    QSqlQuery qry;
    bool alreadyExist = false;
     qry.prepare( "CREATE TABLE IF NOT EXISTS  UserProfileFile (usernm VARCHAR(40),groupnm VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created UserProfileFile"<<"UserProfileFile(usernm VARCHAR(40),groupnm VARCHAR(40))";

    qry.prepare( "SELECT usernm,groupnm FROM UserProfileFile WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qry.prepare( "UPDATE UserProfileFile SET usernm = '" + param1 + "', groupnm = '" + source + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED UserProfileFile..." ;
        }
        else{
            qry.prepare( "INSERT INTO UserProfileFile(usernm, groupnm)VALUES('" + param1 + "', '" + source + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"Inserted" <<"INSERT INTO UserProfileFile (usernm, groupnm)VALUES('" + param1 + "', '" + source + "')" ;
        }
    }


        qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))");
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
         qDebug() << "Table created GroupNameUserName"<<"GroupNameUserName(usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))";

       qry.prepare( "SELECT usernm,groupnm,expiryDays FROM GroupNameUserName WHERE usernm = '" + param1 + "'" );
       if( !qry.exec() ){
         qDebug() << qry.lastError();
       }
       else{
           alreadyExist = qry.next();
           if(alreadyExist){
               qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', groupnm = '" + source + "' WHERE usernm = '" + param1 + "'" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"UPDATED GroupNameUserName..." ;
           }
           else{
               qry.prepare( "INSERT INTO GroupNameUserName(usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "')" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"Inserted" <<"INSERT INTO GroupNameUserName (usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "')" ;
           }
       }

}

void FileIO::overWriteFileAdmin(const QString& source,const QString& param1){
qDebug() << "overwrite file"<<userid;

    //if(userid == "Administrator")//to make the audit of profile change by any admin.
    {
        qDebug() << "overwrite file1"<<userid;
        event_msg = param1+" is changed to "+source+" group";
        emit signal_savetextfield(global_datetime,event_msg,"","",userid);
    }

    QSqlQuery qry;
    bool alreadyExist = false;
     qry.prepare( "CREATE TABLE IF NOT EXISTS  UserProfileFile (usernm VARCHAR(40),groupnm VARCHAR(40))");
    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
      qDebug() << "Table created UserProfileFile"<<"UserProfileFile(usernm VARCHAR(40),groupnm VARCHAR(40))";

    qry.prepare( "SELECT usernm,groupnm FROM UserProfileFile WHERE usernm = '" + param1 + "'" );
    if( !qry.exec() ){
      qDebug() << qry.lastError();
    }
    else{
        alreadyExist = qry.next();
        if(alreadyExist){
            qry.prepare( "UPDATE UserProfileFile SET usernm = '" + param1 + "', groupnm = '" + source + "' WHERE usernm = '" + param1 + "'" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"UPDATED UserProfileFile..." ;
        }
        else{
            qry.prepare( "INSERT INTO UserProfileFile(usernm, groupnm)VALUES('" + param1 + "', '" + source + "')" );
            if( !qry.exec() )
                qDebug() << qry.lastError();
            else
                qDebug() <<"Inserted" <<"INSERT INTO UserProfileFile (usernm, groupnm)VALUES('" + param1 + "', '" + source + "')" ;
        }
    }


        qry.prepare( "CREATE TABLE IF NOT EXISTS  GroupNameUserName (usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))");
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
         qDebug() << "Table created GroupNameUserName"<<"GroupNameUserName(usernm VARCHAR(40),groupnm VARCHAR(40),expiryDays VARCHAR(12))";

       qry.prepare( "SELECT usernm,groupnm,expiryDays FROM GroupNameUserName WHERE usernm = '" + param1 + "'" );
       if( !qry.exec() ){
         qDebug() << qry.lastError();
       }
       else{
           alreadyExist = qry.next();
           if(alreadyExist){
               qry.prepare( "UPDATE GroupNameUserName SET usernm = '" + param1 + "', groupnm = '" + source + "' WHERE usernm = '" + param1 + "'" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"UPDATED GroupNameUserName..." ;
           }
           else{
               qry.prepare( "INSERT INTO GroupNameUserName(usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "')" );
               if( !qry.exec() )
                   qDebug() << qry.lastError();
               else
                   qDebug() <<"Inserted" <<"INSERT INTO GroupNameUserName (usernm, groupnm,expiryDays)VALUES('" + param1 + "', '" + source + "')" ;
           }
       }

}

void FileIO::loadUserStatusFile(){

    QStringList userList;
       int r,c;
       bool alreadyExist = false;
   QSqlQuery qry;
       qry.prepare( "SELECT usernm,status,expiryDate FROM UserStatusFile" );
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
       {
           alreadyExist = qry.next();
           if(alreadyExist){
               qDebug( "searching in UserStatusFile!" );
               for(r=0,qry.first();qry.isValid();qry.next(),++r){
                 //  for(c = 0; c < 2; ++c){
                       for(c = 0; c < 3; ++c){
                       userList<< qry.value(c).toString();
                  }
                   qDebug() << "The UserStatusFile list is:"<<userList;
              //     emit handleSaveFileList(userList);
                    emit handleUserStatusFile(userList);
                  userList.clear();
               }
           }
           else{
         //      emit handleSaveFileList("");
               emit handleUserStatusFile("");
           }
       }

}

void FileIO::loadUserProfileFile(){

    QStringList userList;
       int r,c;
       bool alreadyExist = false;
   QSqlQuery qry;
       qry.prepare( "SELECT usernm,groupnm FROM UserProfileFile" );
       if( !qry.exec() )
         qDebug() << qry.lastError();
       else
       {
           alreadyExist = qry.next();
           if(alreadyExist){
               qDebug( "searching in UserProfileFile!" );
               for(r=0,qry.first();qry.isValid();qry.next(),++r){
                   for(c = 0; c < 2; ++c){
                       userList<< qry.value(c).toString();
                  }
                   qDebug() << "The UserProfileFile list is:"<<userList;
                   emit handleUserProfileList(userList);
                  userList.clear();
               }
            }
           else{
               emit handleUserProfileList("");
           }
       }


}


void FileIO::saveAsGroupnameUsrnm(){

        QFile file("F:\\ GroupNameUserName.abk");
   //     QFile file(source);

        if (!file.open(QIODevice::WriteOnly)) {

            qDebug()  << "saving is already in your address book." << file.errorString();

            return;
        }

        QDataStream out(&file);
        out.setVersion(QDataStream::Qt_4_3);
        out << GroupcontactsName;




}

void FileIO::saveUserStatus(){

        QFile file("F:\\ UserStatus.abk");
   //     QFile file(source);

        if (!file.open(QIODevice::WriteOnly)) {

            qDebug()  << "saving is already in your address book." << file.errorString();

            return;
        }

        QDataStream out(&file);
        out.setVersion(QDataStream::Qt_4_3);
        out << UserStatus;




}

void FileIO::saveToGroupFile(const QString& source){

   //     QFile file("F:\\ GroupNames.abk");
        QFile file(source);

        if (!file.open(QIODevice::WriteOnly)) {

            qDebug()  << "saving is already in your address book." << file.errorString();

            return;
        }

        QDataStream out(&file);
        out.setVersion(QDataStream::Qt_4_3);
        out << Groupcontacts;
}

void FileIO::loadFromLoginNames(const QString& source){

    QStringList strList;
    QString loginNameFile;
    loginNameFile = textFilepath + source;
  //  QFile file("F:\\ sandy.txt");
 //   if (source.isEmpty())
        if (loginNameFile.isEmpty())
    {
        qDebug() << "source is empty:";

    }

  //  QFileInfo check_file(source);
     QFileInfo check_file(loginNameFile);
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist";
 //     QFile file(source);
      QFile file(loginNameFile);


     // QFile::copy(source,"F:\\ dummy.txt");
      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           while(!in.atEnd()) {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              strList<< line;
              qDebug() << "send read:"<<strList;
           }


     //      emit chkFileExist("File Loaded sucessfully");
           emit handleSaveFileList(strList);
           file.close();

    }
    else{
    //    emit chkFileExist("File doesn't exist");
        qDebug() << "file doesnt exist";

    }


}




void FileIO::removeFromLib(const QString& source){

  QStringList strList;
  QString cmpfileline,cmpsource;
   QString event_msg;
  cmpsource = source;
  //  QFile file("F:\\ sandy.txt");
    if (source.isEmpty())
    {
        qDebug() << "source is empty:";

    }

     QFile cmpfile(textFilepath + "compare.txt");

    if(!cmpfile.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
      qDebug() << "file already there";
     }
    QTextStream incmpfile(&cmpfile);
    while(!incmpfile.atEnd()) {
       cmpfileline = incmpfile.readLine();
       qDebug() << "line read from compare.txt:"<<cmpfileline;

    }
    cmpfile.close();


 //   QFileInfo check_file("F:\\ LibraryFiles.txt");
    QFileInfo check_file(textFilepath + "LibraryFiles.txt");
    if(check_file.exists() && check_file.isFile()){
      qDebug() << "file exist";

      QFile file(textFilepath + "LibraryFiles.txt");

      if(!file.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)){
        qDebug() << "file already there";
       }
           QTextStream in(&file);
           while(!in.atEnd()) {
              QString line = in.readLine();
              qDebug() << "file read:"<<line;
              qDebug() << "file selected is:"<<source;
              qDebug() << "file compared is:"<<cmpfileline;
              if(source == line){
                  qDebug() << "matched name";
                  if(cmpfileline == source){
                      qDebug() << "You cant delete file:" << cmpfileline;
                    strList<< line;
                    emit chkFileExist("Current File");
                  }

                event_msg = "RECIPE DELETED" + source;
                emit signal_savetextfield(global_datetime,event_msg,"","",userid);

              }
              else{
                 strList<< line;
              }

              qDebug() << "the modified library list is:"<<strList;
           }

            file.close();

            QFile::remove(textFilepath + "LibraryFiles.txt");

             QFile file1(textFilepath + "LibraryFiles.txt");

                if(!file1.open(QIODevice::ReadOnly | QIODevice::Text | QIODevice::ReadWrite)) {
                   qDebug()  << "is already in your address book." << file1.errorString();
                    return;
                }
                for(int i=0;i<strList.length();i++) {
                qDebug() <<"The data is:" <<strList[i];
                QTextStream out(&file1);
                out << strList[i] <<'\n';
                }
                file1.close();

    }
    else{
         qDebug() << "file doesnt exist";

    }


}


void batch_stdttime()
{

    QString temp,dataval;

    batchstdttime = dataval.setNum(rtc_day,16);//ui->prcsstartdtlineEdit->text();
    batchstdttime = batchstdttime.append("/");

    batchstdttime = batchstdttime.append(dataval.setNum(rtc_month,16));
    batchstdttime = batchstdttime.append("/");

    batchstdttime = batchstdttime.append(dataval.setNum(rtc_year,16));
    batchstdttime = batchstdttime.append("  ");


    temp = dataval.setNum(rtc_hour,16);//ui->prcsstartdtlineEdit->text();
    temp = temp.append(":");

    temp = temp.append(dataval.setNum(rtc_min,16));
    temp = temp.append(":");

    temp = temp.append(dataval.setNum(rtc_sec,16));


    batchstdttime = batchstdttime.append(temp);



}
void FileIO::storeLogout_time(QString param1){
    qDebug()<<"logout time is:"<<param1;

    event_msg = "Logout Time changed to -> "+param1+" min";
    emit signal_savetextfield(global_datetime,event_msg,"","",userid);

    ONOFF_param[2] = param1;

    if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }
    QTextStream in1(&ONOFF_file);

    in1 << ONOFF_param[0] << '\n';
    in1 << ONOFF_param[1] << '\n';
    in1 << ONOFF_param[2] << '\n';
    in1 << ONOFF_param[3] << '\n';

    ONOFF_file.close();

}


void FileIO::machine_sts(unsigned int cnt)
{
    QString event_msg;

    qDebug() << cnt << "machine sts";
    ONOFF_file.close();


    if(cnt == 1)
    {

        //prodnfg = 1;
        if(unique_bchfg)
        {

              qDebug() << unique_bchfg << "ssmachine sts";

           // cpp_prd_batchno = param[2];
            cpp_prd_code1 = cpp_prd_code;
            cpp_prd_name1 = cpp_prd_name;
            demo_targetwt1 = demo_targetwt;
            demo_tarewt1 = demo_tarewt;
            demo_length1 = demo_length;
            demo_uplimit1 = demo_uplimit;
            demo_lolimit1 = demo_lolimit;
            demo_speed1 = demo_speed;
            demo_oprdelay1 = demo_oprdelay;
            demo_holddelay1 = demo_holddelay;
            demo_rejcnt1 = demo_rejcnt;
            demo_mdopr1 = demo_mdopr;




            prodnfg = 1;
            emit uniquebatch_change();
            ONOFF_param[1] = "1";

            uw_count = 0;
            ow_count = 0;
            accp_count = 0;
            tot_count=0;
            avg_accp_bin = 0;
            max_wt = 0;
            min_wt = 0;
            avg_accp_wt = 0;
            batch_accp_cnt = "0";
            batch_ow_cnt = "0";
            batch_uw_cnt = "0";
            batch_tot_cnt = "0";
            std_dev_buffer = 0;
            avg_buff = 0;
            comparefg = 0;
            batch_stop = 1;
            batch_avgaccp_wt = "0";
            //emit online_okcounts(accp_count,0,0);
            emit online_okcounts(accp_count,0,0,uw_count,ow_count);
            //emit online_uwcounts(uw_count);
            //emit online_owcounts(ow_count);

            emit recall_DCOMPFACT();


            event_msg = "MODE CHANGED TO PRODUCTION";
            emit signal_savetextfield(global_datetime,event_msg,"","",userid);


        }
        else
        {
         //   prodnfg = 0;
            handleMachine_sts(2);
            qDebug() << unique_bchfg << "ddssmachine sts";

        }
    }
    else if(prodnfg == 1)
    {
        //handleMachine_sts(0);
        //prodnfg = 0;
        handleMachine_sts(3);

    }

    if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }
    QTextStream in1(&ONOFF_file);

    in1 << ONOFF_param[0] << '\n';
    in1 << ONOFF_param[1] << '\n';
    in1 << ONOFF_param[2] << '\n';
    in1 << ONOFF_param[3] << '\n';

    ONOFF_file.close();


}
void FileIO::batch_end_auditlog()
{

        QString event_msg;

    if(prodnfg)
    {
        qDebug() << cpp_prd_batchno;
        event_msg = "BATCH ENDED :- " + cpp_prd_batchno;
        emit signal_savetextfield(global_datetime,event_msg,"","",userid);

        event_msg = "MODE CHANGED TO SETTING";
        emit signal_savetextfield(global_datetime,event_msg,"","",userid);


    }
    uw_count = 0;
    ow_count = 0;
    accp_count = 0;
    tot_count=0;
    avg_accp_bin = 0;
    max_wt = 0;
    min_wt = 0;
    avg_accp_wt = 0;
    batch_accp_cnt = "0";
    batch_ow_cnt = "0";
    batch_uw_cnt = "0";
    batch_tot_cnt = "0";
    std_dev_buffer = 0;
    avg_buff = 0;
    comparefg = 0;
    batch_avgaccp_wt = "0";
    //emit online_okcounts(0,0,0);
    emit online_okcounts(0,0,0,0,0);
    //emit online_uwcounts(0);
    //emit online_owcounts(0);

     stats_file.close();

    if(!stats_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
    {
        qDebug() << "Failed to create";
    }
            QTextStream in(&stats_file);
             in << stats_param[0] << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << "0" << "\n";
             in << stats_param[9] << "\n";
             in << stats_param[10] << "\n";
             in << stats_param[11] << "\n";
             in << "0" << "\n";

             stats_file.close();

                     stats_param[1] = "0";
                     stats_param[2] = "0";
                     stats_param[3] = "0";
                     stats_param[4] = "0";
                     stats_param[5] = "0";
                     stats_param[6] = "0";
                     stats_param[7] = "0";
                     stats_param[8] = "0";



}




