#include "dbmanagers.h"

#include <QDebug>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>
#include <QTimer>
#include<QFileInfo>
#include "savetextfield.h"
#include<wiringPi.h>

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

constexpr int wpGPIO_OUT_PIN11            = 0;


void counts_fromsql();
void create_countstable();
void update_counts_sql();
void create_triggertable();
extern void trigger_table_sql();
bool gen_batchpdf,gen_auditpdf,gen_alarampdf;
extern float val;
//extern QString cpp_prd_batchno;
extern QString batch_accp_cnt,batch_ow_cnt,batch_uw_cnt,batch_tot_cnt;
extern QString cpp_prd_code;
extern QString cpp_prd_name;
extern QString cpp_prd_batchno,prev_value,batch_rej_percnt;
extern QString stats_param[14];

extern QString batch_avgaccp_wt;

extern bool duplicate_batchfg,poweron_stats_updatefg,comparefg;

extern QString cpp_prd_code1,cpp_prd_name1,demo_targetwt1,demo_tarewt1,demo_length1,demo_uplimit1;
extern QString demo_lolimit1,demo_speed1,demo_oprdelay1,demo_holddelay1,demo_rejcnt1,demo_mdopr1;

extern unsigned int uw_count,ow_count,accp_count,avg_accp_bin,std_dev_buffer,avg_buff;
extern QString demo_targetwt,demo_tarewt,demo_length;
extern QString demo_uplimit,demo_lolimit,demo_speed,demo_mdopr;
extern QString demo_oprdelay,demo_holddelay,demo_rejcnt;
extern QString ONOFF_param[4];
extern QFile ONOFF_file;//("ONOFFSTATUS.txt");
//static const QString path = "example2.db";
static const QString path = "/home/odroid/Projects/Qt/share_database/example2.db";
extern float max_wt,min_wt,rej_percent,avg_accp_wt;
  QString var1;// = "Dynamic";
  QString var2;// = "AUDIT";
  QString var3;// = "AlARAM";
  QString var4 = "BATCH_NAME1";

extern QString global_datetime,global_stpdatetime;

extern bool OKdynamic_sql_logfg,prodnfg,unique_bchfg;

bool batch_endfg,batchend_errfg;

//void addDynamicwt_sql(QString date_time,QString dynwt, QString status);
extern FileIO saveTextField;
dbmanagers::dbmanagers(QObject *parent) : QObject(parent)
{

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(path);

    if (!m_db.open())
    {
        qDebug() << "Error: connection with database fail";
    }
    else
    {
        qDebug() << "Database: connection ok";
    }

    connect(&saveTextField,SIGNAL(batch_change(QString)),
            this,SLOT(createTable(QString)));
    connect(&saveTextField,SIGNAL(uniquebatch_change()),
            this,SLOT(create_uniquebchfg()));
    connect(&saveTextField,SIGNAL(signal_savetextfield(QString,QString,QString,QString,QString)),
                    this,SLOT(addAuditdata(QString,QString,QString,QString,QString)));


}



dbmanagers::~dbmanagers()
{
    if (m_db.isOpen())
    {
        m_db.close();
    }
}

bool dbmanagers::isOpen() const
{
    return m_db.isOpen();
}

bool dbmanagers::createTable(QString pass_batchname)
{
    bool success = false;

QString reportbatchNum;
        reportbatchNum = pass_batchname;//cpp_prd_batchno;
        reportbatchNum.remove(" "); //sql space error prb
        if(reportbatchNum.at(0) >= '0' && reportbatchNum.at(0) <= '9')
        {
            reportbatchNum = "z"+reportbatchNum;

        }
qDebug() <<"the batch name in create table is:"<<reportbatchNum << cpp_prd_batchno;
    QSqlQuery query;

//    emit completeBatchNamedetails();  //was used to END Batch
    //if(unique_bchfg == 0)
    {
    query.prepare( "CREATE TABLE " + reportbatchNum + "(prd_cod_nm VARCHAR(40),prd_name_nm VARCHAR(40),batch_name_nm VARCHAR(40),target_wt_nm VARCHAR(10),tare_wt_nm VARCHAR(10),prd_length_nm VARCHAR(4),up_lmt_nm VARCHAR(10),lw_lmt_nm VARCHAR(10),speed_nm VARCHAR(4),opr_dly_nm VARCHAR(4),hld_dly_nm VARCHAR(4),rej_cnt_nm VARCHAR(4),md_dly_nm VARCHAR(4),uw_cnt VARCHAR(10),ok_cnt VARCHAR(10),ow_cnt VARCHAR(10),tot_cnt VARCHAR(10),std_dev VARCHAR(10),min_wt VARCHAR(10),max_wt VARCHAR(10),avg_acp_wt VARCHAR(10),batch_rej_per VARCHAR(10))" );
    if (!query.exec())
    {
        qDebug() << "Couldn't create the table 'people': one might already exist.DUPLICATE BATCH";
        success = false;
        duplicate_batchfg = 1;
    }
    else
    {                
        //batch_endfg = 0;
        duplicate_batchfg = 0;
        qDebug() << "UNIQUE NEW BATCH CREATED";
//        emit audit_createTable(reportbatchNum);
//        emit alaram_createTable(reportbatchNum);
//        emit createdynamicTable(reportbatchNum);
//        emit addBatchdetails(reportbatchNum);
//        emit createBatchNameTable();
//        emit addBatchNamedetails(reportbatchNum);

    }
    }


    return success;
}


void dbmanagers::createTable_testmode()
{

    QString reportbatchNum;
        reportbatchNum = "SETTINGBATCH2";


//        reportbatchNum.remove(" "); //sql space error prb
//qDebug() <<"the batch name in create table is:"<<reportbatchNum;
    QSqlQuery query;

//    if(!ONOFF_file.open(QIODevice::ReadOnly|QIODevice::Text|QIODevice::ReadWrite))
//    {
//        qDebug() << "Failed to create";
//    }
//    QTextStream in1(&ONOFF_file);

    emit completeBatchNamedetails();  //was used to END Batch
    prodnfg = 0;
    ONOFF_param[1] = "0";

    query.prepare( "CREATE TABLE  " + reportbatchNum + "(prd_cod_nm VARCHAR(40),prd_name_nm VARCHAR(40),batch_name_nm VARCHAR(40),target_wt_nm VARCHAR(10),tare_wt_nm VARCHAR(10),prd_length_nm VARCHAR(4),up_lmt_nm VARCHAR(10),lw_lmt_nm VARCHAR(10),speed_nm VARCHAR(4),opr_dly_nm VARCHAR(4),hld_dly_nm VARCHAR(4),rej_cnt_nm VARCHAR(4),md_dly_nm VARCHAR(4),uw_cnt VARCHAR(10),ok_cnt VARCHAR(10),ow_cnt VARCHAR(10),tot_cnt VARCHAR(10),std_dev VARCHAR(10),min_wt VARCHAR(10),max_wt VARCHAR(10),avg_acp_wt VARCHAR(10),batch_rej_per VARCHAR(10))" );

    if (!query.exec())
    {
        qDebug() << "Couldn't create the table SETTING BATCH: one might already exist.DUPLICATE BATCH";


    }
    else
    {

        qDebug() << "SETTING BATCH CREATED";

    emit audit_createTable(reportbatchNum);
    emit alaram_createTable(reportbatchNum);
    emit createdynamicTable(reportbatchNum);
    emit addBatchdetails(reportbatchNum);
    emit createBatchNameTable();
    emit addBatchNamedetails(reportbatchNum);

    //emit start_settingbatch(reportbatchNum);
    }

    emit start_settingbatch(reportbatchNum);
     emit create_countstable();
    emit create_triggertable();

    ONOFF_file.close();
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


void dbmanagers::create_uniquebchfg()
{
    QString reportbatchNum;
            reportbatchNum = cpp_prd_batchno;
            reportbatchNum.remove(" "); //sql space error prb
    qDebug() <<"the batch name in create table is:"<<reportbatchNum << cpp_prd_batchno;

    if(unique_bchfg)
    {
        batch_endfg = 0;
         ONOFF_param[3] = "0";
        unique_bchfg = 0;
        qDebug() << "UNIQUE NEW BATCH CREATED.....";
        emit audit_createTable(reportbatchNum);
        emit alaram_createTable(reportbatchNum);
        emit createdynamicTable(reportbatchNum);
        emit addBatchdetails(reportbatchNum);
        emit createBatchNameTable();
        emit addBatchNamedetails(reportbatchNum);

        emit pause_settingbatch("SETTINGBATCH2");
         emit create_countstable();
        emit create_triggertable();

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


bool dbmanagers::createBatchNameTable()
{
    bool success = false;



    //var4 = "/0";            //ADD just now
   // var4 = "BATCH_NAME" + cpp_prd_batchno;

  // var4.remove(" "); //sql space prb

    QSqlQuery query;

//    query.prepare( "CREATE TABLE " + var4 + "(batch_name_nm VARCHAR(40),date_time VARCHAR(40))" );
    query.prepare( "CREATE TABLE IF NOT EXISTS " + var4 + "(batch_name_nm VARCHAR(40),date_time VARCHAR(40),stp_date_time VARCHAR(40))" );

       qDebug() << var4 << "VAR4";

    if (!query.exec())
    {
        qDebug() << "Couldn't create the table BatchName Details";
        success = false;
    }
    else
    {
        qDebug() << "DUPLICATE BATCH";

    }


    return success;
}

bool dbmanagers::audit_createTable(QString batch_name_pass)
{
    bool success = false;

    QSqlQuery query;

    var2 = "/0";
    var2 = "AUDIT" + batch_name_pass;//cpp_prd_batchno;

    var2.remove(" "); //sql space prb

    qDebug() << "Audit name is"<<var2;
//    query.prepare("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT);");


    query.prepare( "CREATE TABLE " + var2 + " (date_time VARCHAR(40),event_msg VARCHAR(40),value VARCHAR(40),prev_value VARCHAR(25),username VARCHAR(25))" );
 // query.prepare( "CREATE TABLE IF NOT EXISTS " + var2 + " (date_time VARCHAR(40),event_msg VARCHAR(40),value VARCHAR(40),prev_value VARCHAR(25),username VARCHAR(25))" );
    if (!query.exec())
    {
        qDebug() << "Couldn't create the table 'Audit': one might already exist.";
        success = false;
    }
    else
    {
       qDebug() << "Audit success";

    }

    return success;
}

bool dbmanagers::alaram_createTable(QString batch_name_pass)
{
    bool success = false;
    var3 = "/0";
    var3 = "ALARAM" + batch_name_pass;//cpp_prd_batchno;

    var3.remove(" ");

    QSqlQuery query;
//    query.prepare("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT);");


    query.prepare( "CREATE TABLE " + var3 + " (date_time VARCHAR(40),event_msg VARCHAR(40),username VARCHAR(25))" );
  //  query.prepare( "CREATE TABLE IF NOT EXISTS " + var3 + " (date_time VARCHAR(40),event_msg VARCHAR(40),username VARCHAR(25))" );

    if (!query.exec())
    {
        qDebug() << "Couldn't create the table 'alaram': one might already exist.";
        success = false;
    }
    else
    {
       qDebug() << "alaram success";

    }

    return success;
}



bool dbmanagers::createdynamicTable(QString batch_name_pass)
{
    bool success = false;

 //   QString var1 = cpp_prd_batchno.append("_dyn");
    var1 = "/0";
    var1 = "Dynamic" + batch_name_pass;//cpp_prd_batchno;

    var1.remove(" ");

    QSqlQuery query;
//    query.prepare("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT);");


    query.prepare( "CREATE TABLE " + var1 + "(date_time VARCHAR(30),dyn_wt VARCHAR(50),status VARCHAR(10))" );
  //   query.prepare( "CREATE TABLE IF NOT EXISTS " + var1 + "(date_time VARCHAR(30),dyn_wt VARCHAR(50),status VARCHAR(10))" );


    if (!query.exec())
    {
        qDebug() << "Couldn't create the table 'people': one might already exist.";
        success = false;
    }
    else
    {
        qDebug() << "sucess....table";

    }

//    queryAdd.prepare( "INSERT INTO " + cpp_prd_batchno + " (dyn_wt)VALUES('" + dynwt + "')" );
//    if (!query.exec())
//    {
//        qDebug() << "Couldn't create the table 'people': one might already exist.";
//        success = false;
//    }


    return success;
}


bool dbmanagers::addPerson(const QString& name)
{
    bool success = false;

    if (!name.isEmpty())
    {
        QSqlQuery queryAdd;
        queryAdd.prepare("INSERT INTO people (name) VALUES (:name)");
        queryAdd.bindValue(":name", name);

        if(queryAdd.exec())
        {
            success = true;
        }
        else
        {
            qDebug() << "add person failed: " << queryAdd.lastError();
        }
    }
    else
    {
        qDebug() << "add person failed: name cannot be empty";
    }

    return success;
}


void dbmanagers::addBatchdetails(QString batch_name_pass)
{

    QString reportbatchNum;
    reportbatchNum = batch_name_pass;//cpp_prd_batchno;
    reportbatchNum.remove(" "); //spl space prb
    if(reportbatchNum.at(0) >= '0' && reportbatchNum.at(0) <= '9')
    {
        reportbatchNum = "z"+reportbatchNum;

    }
qDebug() <<"ADD BATCH DETAILS:"<<cpp_prd_batchno;
    //if (!name.isEmpty())
    {
        QSqlQuery queryAdd;


        queryAdd.prepare( "INSERT INTO " + reportbatchNum + " (prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per)VALUES('" + cpp_prd_code1 + "', '" + cpp_prd_name1 + "', '" + batch_name_pass + "', '" + demo_targetwt1 + "', '" + demo_tarewt1 + "', '" + demo_length1 + "', '" + demo_uplimit1 + "', '" + demo_lolimit1 + "', '" + demo_speed1 + "', '" + demo_oprdelay1 + "', '" + demo_holddelay1 + "', '" + demo_rejcnt1 + "', '" + demo_mdopr1 + "', '" + stats_param[1] + "', '" + stats_param[2] + "', '" + stats_param[3] + "', '" + stats_param[4] + "', '" + stats_param[5] + "', '" + stats_param[7] + "', '" + stats_param[8] + "', '" + batch_avgaccp_wt + "', '" + batch_rej_percnt + "')" );


        if(queryAdd.exec())
        {

            qDebug() << "Insert into SETTING_BATCH2:"<<"INSERT INTO " + reportbatchNum + " (prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm,md_dly_nm,uw_cnt,ok_cnt,ow_cnt,tot_cnt,std_dev,min_wt,max_wt,avg_acp_wt,batch_rej_per)VALUES('" + cpp_prd_code1 + "', '" + cpp_prd_name1 + "', '" + cpp_prd_batchno + "', '" + demo_targetwt1 + "', '" + demo_tarewt1 + "', '" + demo_length1 + "', '" + demo_uplimit1 + "', '" + demo_lolimit1 + "', '" + demo_speed1 + "', '" + demo_oprdelay1 + "', '" + demo_holddelay1 + "', '" + demo_rejcnt1 + "', '" + demo_mdopr1 + "', '" + stats_param[1] + "', '" + stats_param[2] + "', '" + stats_param[3] + "', '" + stats_param[4] + "', '" + stats_param[5] + "', '" + stats_param[7] + "', '" + stats_param[8] + "', '" + batch_avgaccp_wt + "', '" + batch_rej_percnt + "')";
        }
        else
        {
            qDebug() << "Batch details add failed: " << queryAdd.lastError();
        }
    }
  //  else
    {
  //      qDebug() << "add person failed: name cannot be empty";
    }


}


bool dbmanagers::pause_settingbatch(QString batch_name_pass)
{
    bool success = false;
    QString paused = "PAUSED";

    {
        QSqlQuery queryAdd;

       // queryAdd.prepare( "INSERT INTO " + var4 + " (batch_name_nm,date_time,stp_date_time)VALUES('" + batch_name_pass + "', '" + global_datetime + "','" + "PAUSED " + "')" );
        queryAdd.prepare( "UPDATE " + var4 +  " SET batch_name_nm = '" + batch_name_pass +  "', stp_date_time = '" + paused + "' WHERE batch_name_nm = '" + batch_name_pass + "'" );

        if(queryAdd.exec())
        {
            success = true;
        }
        else
        {
            qDebug() << "BatchName details add failed: " << queryAdd.lastError();
        }
    }

    return success;


}

bool dbmanagers::start_settingbatch(QString batch_name_pass)
{
    bool success = false;
    QString start = "IN PROCESS";

    {
        QSqlQuery queryAdd;

       // queryAdd.prepare( "INSERT INTO " + var4 + " (batch_name_nm,date_time,stp_date_time)VALUES('" + batch_name_pass + "', '" + global_datetime + "','" + "PAUSED " + "')" );
        queryAdd.prepare( "UPDATE " + var4 +  " SET batch_name_nm = '" + batch_name_pass +  "', stp_date_time = '" + start + "' WHERE batch_name_nm = '" + batch_name_pass + "'" );

        if(queryAdd.exec())
        {
            success = true;
        }
        else
        {
            qDebug() << "BatchName details add failed: " << queryAdd.lastError();
        }
    }

    return success;


}




bool dbmanagers::addBatchNamedetails(QString batch_name_pass)
{
    bool success = false;
//    QSqlQuery queryAdd;
//QString name,name2,name3;
//--------------------------------------
//    QSqlQuery query("SELECT * FROM BATCH_NAME1");

//    int idName = query.record().indexOf("batch_name_nm");
//    int idName2 = query.record().indexOf("date_time");
//    int idName3 = query.record().indexOf("stp_date_time");

//   do
//    {
//         name = query.value(idName).toString();
//         name2 = query.value(idName2).toString();
//         name3 = query.value(idName3).toString();

//        qDebug() << "===" << name;
//        qDebug() << "===" << name2;
//        qDebug() << "===" << name3;
//        if((name2.isEmpty()) | (name2.isNull())){

//            queryAdd.prepare( "INSERT INTO " + var4 + " (batch_name_nm,date_time,stp_date_time)VALUES('" + cpp_prd_batchno + "', '" + global_datetime + "','" +"" + "')" );

//            if(queryAdd.exec())
//            {
//                success = true;
//            }
//            else
//            {
//                qDebug() << "BatchName details add failed: " << queryAdd.lastError();
//            }

//        }
//        else{
//            if((name3.isEmpty()) | (name3.isNull())){

//                qDebug() << "STOP DTTIME";
//                queryAdd.prepare( "UPDATE " + var4 +  " SET batch_name_nm = '" + name + "', date_time = '" + name2 + "', stp_date_time = '" + global_stpdatetime + "' WHERE batch_name_nm = '" + name + "'" );
//                if( !queryAdd.exec() )
//                    qDebug() << queryAdd.lastError();
//                else
//                    qDebug() <<"UPDATED batch_name_nm..." ;
//           }
//        }

//    }while(query.next());


//---------------------------------------

    {
        QSqlQuery queryAdd;

//        queryAdd.prepare( "INSERT INTO " + var4 + " (batch_name_nm,date_time,stp_date_time)VALUES('" + cpp_prd_batchno + "', '" + global_datetime + "','" + "IN PROCESS" + "')" );
        queryAdd.prepare( "INSERT INTO " + var4 + " (batch_name_nm,date_time,stp_date_time)VALUES('" + batch_name_pass + "', '" + global_datetime + "','" + "IN PROCESS" + "')" );

        if(queryAdd.exec())
        {
            success = true;
        }
        else
        {
            qDebug() << "BatchName details add failed: " << queryAdd.lastError();
        }
    }

    return success;
}


//=======================

bool dbmanagers::completeBatchNamedetails()
{


    bool success = false;
    QString prev_value1;
     prev_value1 = cpp_prd_batchno;
     prev_value1.remove(" ");

//---------------------------------------

        QSqlQuery queryAdd;

        if(prodnfg == 1 || unique_bchfg == 1)
        {
            batchend_errfg = 0;
            batch_endfg = 1;
            unique_bchfg = 0;
            ONOFF_param[3] = "1";
            qDebug() << "BATCH END";

            queryAdd.prepare( "UPDATE " + var4 +  " SET batch_name_nm = '" + prev_value1 +  "', stp_date_time = '" + global_datetime + "' WHERE batch_name_nm = '" + prev_value1 + "'" );
            if(prodnfg == 1)
            {
                gen_batchpdf = 1;
                gen_auditpdf = 1;
                gen_alarampdf = 1;

                if(queryAdd.exec())
                {
                    success = true;
                }
                else
                {
                    qDebug() << " update BatchName details add failed: " << queryAdd.lastError();
                }
            }
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




    return success;
}

//========================


void dbmanagers::addDynamicwt(QString date_time,QString dynwt, QString status)
{

    {


  //  digitalWrite(wpGPIO_OUT_PIN11, 1);

        var1.remove(" ");


   // QString var1 = cpp_prd_batchno.append("_dyn");

    //if (!name.isEmpty())
    {
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
  //  else
    {
  //      qDebug() << "add person failed: name cannot be empty";
    }



    }

}


//void addDynamicwt_sql(QString date_time,QString dynwt, QString status)
//{

//    var1.remove(" ");

//    QSqlQuery queryAdd;
//    queryAdd.prepare( "INSERT INTO " + var1 + " (date_time,dyn_wt,status)VALUES('" + date_time + "', '" + dynwt + "', '" + status + "')" );


//    if(queryAdd.exec())//TODO
//    {

//        qDebug() << "Dynamic Wt add success: " << queryAdd.lastError();

//    }
//    else
//    {
//        qDebug() << "Dynamic Wt add failed: " << queryAdd.lastError() << "VAR1 = " << var1;
//    }



//}


bool dbmanagers::addAuditdata(QString date_time, QString event_msg, QString value, QString prev_value, QString username)
{
    bool success = false;

    qDebug() << "Audit dsdsdsdsdsd"<<var2;
    var2.remove(" ");

    //if (!name.isEmpty())
    {
        QSqlQuery queryAdd;
//        queryAdd.prepare("INSERT INTO cpp_prd_batchno (dynwt) VALUES (:dynwt)");
//        queryAdd.bindValue(":dynwt", dynwt);

        //queryAdd.prepare( "INSERT INTO" + var2 + " (date_time,event_msg,value,prev_value,username)VALUES('" + date_time + "', '" + event_msg + "', '" + value + "','" + prev_value + "','" + username + "')" );

        queryAdd.prepare( "INSERT INTO " + var2 + " (date_time,event_msg,value,prev_value,username)VALUES('" + date_time + "', '" + event_msg + "', '" + value + "','" + prev_value + "','" + username + "')" );

        if(queryAdd.exec())
        {
            success = true;
            qDebug() << "Audit add success: " << queryAdd.lastError();

        }
        else
        {
            qDebug() << "Audit Wt add failed: " << queryAdd.lastError();
        }
    }

     trigger_table_sql();


    return success;
}

bool dbmanagers::addAlaramdata(QString date_time, QString event_msg,QString username)
{
    bool success = false;

    qDebug() << "Audit dsdsdsdsdsd";

    var3.remove(" ");

    //if (!name.isEmpty())
    {
        QSqlQuery queryAdd;

        queryAdd.prepare( "INSERT INTO " + var3 + " (date_time,event_msg,username)VALUES('" + date_time + "', '" + event_msg + "','" + username + "')" );

        if(queryAdd.exec())
        {
            success = true;
            qDebug() << "Alaram add success: " << queryAdd.lastError();

        }
        else
        {
            qDebug() << "Alaram Wt add failed: " << queryAdd.lastError();
        }
    }

     trigger_table_sql();


    return success;
}



bool dbmanagers::removePerson(const QString& name)
{
    bool success = false;

    if (personExists(name))
    {
        QSqlQuery queryDelete;
        queryDelete.prepare("DELETE FROM people WHERE name = (:name)");
        queryDelete.bindValue(":name", name);
        success = queryDelete.exec();

        if(!success)
        {
            qDebug() << "remove person failed: " << queryDelete.lastError();
        }
    }
    else
    {
        qDebug() << "remove person failed: person doesnt exist";
    }

    return success;
}


void dbmanagers::loadSQLBatches()
{

    QSqlQuery query("SELECT * FROM BATCH_NAME1");
//    QSqlQuery query("SELECT * FROM '" + var4 + "'");//Add now

    int idName = query.record().indexOf("batch_name_nm");
    int idName2 = query.record().indexOf("date_time");
    int idName3 = query.record().indexOf("stp_date_time");

    while (query.next())
    {
        QString name = query.value(idName).toString();
        QString name2 = query.value(idName2).toString();
        QString name3 = query.value(idName3).toString();

        qDebug() << "===" << name;
        qDebug() << "===" << name2;
        qDebug() << "===" << name3;
//        emit handleSQL_batch(name,name2);
        emit handleSQL_batch(name,name2,name3);
    }
//    QStringList userList;
//       int r,c;
//       bool alreadyExist = false;
//    QSqlQuery qry;

//       qry.prepare( "SELECT batch_name_nm,date_time,stp_date_time FROM BATCH_NAME");

//    if( !qry.exec() ){
//      qDebug() << qry.lastError();
//  //    emit handleSubmittFileParam("","");
//    }
//    else
//    {
//        alreadyExist = qry.next();
//        if(alreadyExist){
//            qDebug( "searching in Batch Name table!" );
//            for(r=0,qry.first();qry.isValid();qry.next(),++r){
//                for(c = 0; c < 3; ++c){
//                    userList<< qry.value(c).toString();
//                    //  qDebug() << "The username is:"<<username;

//                    // ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
//                }
//            }
//            qDebug() << "The BATCH_NAME bach name is:"<<userList;
//            qDebug() << "The BATCH_NAME start date time is:"<<userList[0];
//            qDebug() << "The BATCH_NAME stop date time is:"<<userList[1];
//            emit handleSQL_batch(userList[0],userList[1],userList[2]);
//        }
//        else{
//            qDebug() << "nothing to show";
//     //       emit handleSubmittFileParam("","");
//        }
//    }


}




void dbmanagers::printAllPersons() const
{
    qDebug() << "Persons in db:";
    QSqlQuery query("SELECT * FROM people");
    int idName = query.record().indexOf("name");
    while (query.next())
    {
        QString name = query.value(idName).toString();
        qDebug() << "===" << name;
    }
}

bool dbmanagers::personExists(const QString& name) const
{
    bool exists = false;



    QSqlQuery checkQuery;
    checkQuery.prepare("SELECT name FROM people WHERE name = (:name)");
    checkQuery.bindValue(":name", name);

    if (checkQuery.exec())
    {
        if (checkQuery.next())
        {
            exists = true;
        }
    }
    else
    {
        qDebug() << "person exists failed: " << checkQuery.lastError();
    }

    return exists;
}

bool dbmanagers::removeAllPersons()
{
    bool success = false;

    QSqlQuery removeQuery;
    removeQuery.prepare("DELETE FROM people");

    if (removeQuery.exec())
    {
        success = true;
    }
    else
    {
        qDebug() << "remove all persons failed: " << removeQuery.lastError();
    }

    return success;
}



void dbmanagers::slot_viewSQLbatch(QString local_batch)
{
    qDebug() << local_batch << "M here";
    emit viewSQL_batch(local_batch);
}


void create_countstable()
{


    QString counts_table;
    counts_table = "COUNTS";
    QSqlQuery query;

//    query.prepare( "DROP TABLE COUNTS" );
//    if (!query.exec())
//    {
//        qDebug() << "Couldn't DROP the COUNTS TABLE";
//        //success = false;
//    }

//    query.prepare( "CREATE TABLE " + counts_table + "(COMPARE VARCHAR(20),UW_COUNT VARCHAR(20),OK_COUNTS VARCHAR(20),OW_COUNTS VARCHAR(20),TOT_COUNTS VARCHAR(20),STD_DEV VARCHAR(20),MIN_WT VARCHAR(20),MAX_WT VARCHAR(20),AVG_ACP_BIN VARCHAR(20))" );

    query.prepare( "CREATE TABLE " + counts_table + "(COMPARE VARCHAR(20),UW_COUNT VARCHAR(20),OK_COUNTS VARCHAR(20),OW_COUNTS VARCHAR(20),TOT_COUNTS VARCHAR(20),STD_DEV VARCHAR(20),MIN_WT VARCHAR(20),MAX_WT VARCHAR(20),AVG_ACP_BIN VARCHAR(20),MIN_WT_BIN VARCHAR(20),MAX_WT_BIN VARCHAR(20),STD_DEV_BUFF VARCHAR(20),AVG_BUFF_BATCH VARCHAR(20))" );
    if (!query.exec())
    {
        qDebug() << "Couldn't create the COUNTS TABLE";
        //success = false;
    }
    else
    {
        qDebug() << "COUNT TABLE";
        query.prepare( "INSERT INTO " + counts_table + " (COMPARE,UW_COUNT, OK_COUNTS, OW_COUNTS, TOT_COUNTS, STD_DEV, MIN_WT, MAX_WT, AVG_ACP_BIN,MIN_WT_BIN,MAX_WT_BIN,STD_DEV_BUFF,AVG_BUFF_BATCH)VALUES('" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "', '" + "0" + "')" );

        if(query.exec())
        {

        }
        else
        {
            qDebug() << "COUNT TABLE details add failed: " << query.lastError();
        }


    }



    update_counts_sql();


}





void counts_fromsql()
{

  QString countstable;
  QSqlQuery query;

  countstable = "COUNTS";

  query.prepare("SELECT * FROM " + countstable);

    if( !query.exec() )
        qDebug() << query.lastError();
    else
    {
        if(query.next())
        {

        qDebug( "Selected!" );
        qDebug() << query.value(0).toString();
        qDebug() << query.value(1).toString();
        qDebug() << query.value(2).toString();
        qDebug() << query.value(3).toString();
        qDebug() << query.value(4).toString();
        qDebug() << query.value(5).toString();
        qDebug() << query.value(6).toString();
        qDebug() << query.value(7).toString();
        qDebug() << query.value(8).toString();
        qDebug() << query.value(9).toString();
        qDebug() << query.value(10).toString();
        qDebug() << query.value(11).toString();
        qDebug() << query.value(12).toString();


        stats_param[0] = query.value(0).toString();
        stats_param[1] = query.value(1).toString();
        stats_param[2] = query.value(2).toString();
        stats_param[3] = query.value(3).toString();
        stats_param[4] = query.value(4).toString();
        stats_param[5] = query.value(5).toString();
        stats_param[7] = query.value(6).toString();
        stats_param[8] = query.value(7).toString();
        stats_param[6] = query.value(8).toString();

        stats_param[9] = query.value(9).toString();
        stats_param[10] = query.value(10).toString();
        stats_param[11] = query.value(11).toString();
        stats_param[12] = query.value(12).toString();


        uw_count = stats_param[1].toInt();
        accp_count = stats_param[2].toInt();
        ow_count = stats_param[3].toInt();
        batch_tot_cnt = stats_param[4];
        batch_accp_cnt = stats_param[2];
        batch_ow_cnt = stats_param[3];
        batch_uw_cnt = stats_param[1];

        if(stats_param[0] == "1")
        {
            comparefg = 1;
            min_wt = stats_param[9].toFloat();
            max_wt = stats_param[10].toFloat();
           avg_accp_bin = stats_param[6].toInt();
        }

        std_dev_buffer = stats_param[11].toInt();
        avg_buff = stats_param[12].toInt();


            if(config_param.CW_600HSA)
            {
                val = (float)avg_buff / 100;
                batch_avgaccp_wt =  QString::number(val,'f',2);

            }
            else
            {
                val = (float)avg_buff / 10;
                batch_avgaccp_wt =  QString::number(val,'f',1);

            }

            qDebug() << batch_avgaccp_wt << "AVG ACCP WT";




        }

    }


    poweron_stats_updatefg = 1;

}

//void update_counts_sql()
//{

//    QSqlQuery querycount;
//    QString counts_table;
//    counts_table = "COUNTS";


////    querycount.prepare( "UPDATE " + counts_table +  " SET COMPARE = '" + stats_param[0] +  "',UW_COUNT = '" + QString::number(uw_count) +  "', OK_COUNTS = '" + QString::number(accp_count) + "', OW_COUNTS = '" + QString::number(ow_count) + "', TOT_COUNTS = '" + batch_tot_cnt + "', STD_DEV = '" + stats_param[5] + "', MIN_WT = '" + stats_param[7] + "', MAX_WT = '" + stats_param[8] + "', AVG_ACP_BIN = '" + stats_param[6] + "'" );
//    querycount.prepare( "UPDATE " + counts_table +  " SET COMPARE = '" + stats_param[0] +  "',UW_COUNT = '" + QString::number(uw_count) +  "', OK_COUNTS = '" + QString::number(accp_count) + "', OW_COUNTS = '" + QString::number(ow_count) + "', TOT_COUNTS = '" + batch_tot_cnt + "', STD_DEV = '" + stats_param[5] + "', MIN_WT = '" + stats_param[7] + "', MAX_WT = '" + stats_param[8] + "', AVG_ACP_BIN = '" + stats_param[6] + "', MIN_WT_BIN = '" + stats_param[9] + "', MAX_WT_BIN = '" + stats_param[10] + "', STD_DEV_BUFF = '" + stats_param[11] + "', AVG_BUFF_BATCH = '" + stats_param[12] + "'" );

//    if(querycount.exec())
//    {

//        qDebug() << "COUNTS UPDATED: ";
//    }
//    else
//    {
//        qDebug() << "COUNTS UPDATED FAILED " << querycount.lastError();
//    }



//}


void create_triggertable()
{


    QString trigger_table;
    trigger_table = "triggersql";
    QSqlQuery query;


    query.prepare( "CREATE TABLE " + trigger_table + "(trigger VARCHAR(10))" );
    if (!query.exec())
    {
        qDebug() << "Couldn't create the COUNTS TABLE";

    }
    else
    {
        qDebug() << "COUNT TABLE";
        query.prepare( "INSERT INTO " + trigger_table + " (trigger)VALUES('" + "0" + "')" );

        if(query.exec())
        {

        }
        else
        {
            qDebug() << "COUNT TABLE details add failed: " << query.lastError();
        }


    }

    trigger_table_sql();


}

