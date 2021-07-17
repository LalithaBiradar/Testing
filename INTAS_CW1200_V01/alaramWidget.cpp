#include "alaramWidget.h"
#include "ui_alaramWidget.h"
#include <qtrpt.h>


#include <QtSql>
#include <QtDebug>

QString date_time,alarm_msg,userid,manufnm,machinenm,equipid,prntdttm,prcssrtdttm,prcsstpdttm,usrid;

alaramWidget::alaramWidget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::alaramWidget)
{
    ui->setupUi(this);
  //  const QStringList titles {"ID","Number","Age","Salary"};
 //   const QStringList titles {"Recipe Parameter Name","Recipe Parameter Value","BATCH NUMBER","TW","TW1","PL","UL","LL","SPD","OD","HD","RC"};
 //   ui->tableWidget->setColumnCount(titles.size());
 //   ui->tableWidget->setHorizontalHeaderLabels(titles);

    const QStringList titles {"Date & Time","Alarm Message","User ID"};
    ui->tableWidget->setColumnCount(titles.size());
    ui->tableWidget->setHorizontalHeaderLabels(titles);

 //   ui->idSpinBox->setMinimum(0);
 //   ui->idSpinBox->setMaximum(INT_MAX);
//    ui->ageSpinBox->setMinimum(0);
//    ui->ageSpinBox->setMaximum(INT_MAX);
//    ui->salaryDoubleSpinBox->setMinimum(0.0);
//    ui->salaryDoubleSpinBox->setMaximum(999999999.0);
 //    on_toPrintBtn_clicked();

}

alaramWidget::~alaramWidget()
{
    delete ui;
}

//void Widget::on_addPushBtn_clicked()
//{
//// const QString id = QString::number(ui->idSpinBox->value());
////  const QString number = ui->numberLineEdit->text();
////  const QString age = QString::number(ui->ageSpinBox->value());
////  const QString salary = QString::number(ui->salaryDoubleSpinBox->value());
//// const int rowCount = ui->tableWidget->rowCount();
//// ui->tableWidget->insertRow(rowCount);
//// ui->tableWidget->setItem(rowCount,Recipe_Parameter_Name,new QTableWidgetItem(recipe_param_name));
//// ui->tableWidget->setItem(rowCount,Number,new QTableWidgetItem(number));



//// ui->tableWidget->setItem(rowCount,Age,new QTableWidgetItem(age));
//// ui->tableWidget->setItem(rowCount,Salary,new QTableWidgetItem(salary));
//// ui->idSpinBox->clear();
//// ui->numberLineEdit->clear();
//// ui->ageSpinBox->clear();
//// ui->salaryDoubleSpinBox->clear();
//// ui->idSpinBox->setFocus();

//    date_time = "17-05-2018 11:50:00";// ui->prdwtlineEdit->text();
//    alarm_msg = "S1 not sensed";//ui->prdresultlineEdit->text();
//    userid = "Administrator";//ui->prcsstartdtlineEdit->text();

//    const int rowCount = ui->tableWidget->rowCount();
//    ui->tableWidget->insertRow(rowCount);
//    ui->tableWidget->setItem(rowCount,dttm,new QTableWidgetItem(date_time));
//    ui->tableWidget->setItem(rowCount,alarmmsg,new QTableWidgetItem(alarm_msg));
//    ui->tableWidget->setItem(rowCount,user_id,new QTableWidgetItem(userid));
//    manufnm = "Technofour Electronics Pvt. Ltd.";//ui->manuflineEdit->text();
//    machinenm = "CW1200";//ui->machinenamelineEdit->text();
//    equipid = "TEPL123";//ui->eqidlineEdit->text();
//    prntdttm = "17-05-2018 12:00:00";//ui->printdtlineEdit->text();
//    prcssrtdttm = "17-05-2018 11:50:00";//ui->prcsstartdtlineEdit->text();
//    prcsstpdttm = "17-05-2018 11:59:00";//ui->prcsstpdtlineEdit->text();
//    usrid = "Administrator";//ui->usridlineEdit->text();



//}

void alaramWidget::on_removeBtn_clicked()
{

//ui->tableWidget->removeRow(ui->tableWidget->currentRow());
QSqlDatabase db = QSqlDatabase::addDatabase( "QSQLITE" );


  db.setHostName( "localhost" );
  db.setDatabaseName( "f:/tecemp" );

  db.setUserName( "root" );
  db.setPassword( "ganeshay" );

  if( !db.open() )
  {
    qDebug() << db.lastError();
    qFatal( "Failed to connect." );
  }

  qDebug( "Connected!" );
    int num_rows,r,c;
  QSqlQuery qry;

        qry.prepare( "CREATE TABLE IF NOT EXISTS cw_header_name(prd_cod_nm VARCHAR(40),prd_name_nm VARCHAR(40),batch_name_nm VARCHAR(40),target_wt_nm VARCHAR(25),tare_wt_nm VARCHAR(25),prd_length_nm VARCHAR(25),up_lmt_nm VARCHAR(25),lw_lmt_nm VARCHAR(25),speed_nm VARCHAR(25),opr_dly_nm VARCHAR(25),hld_dly_nm VARCHAR(25),rej_cnt_nm VARCHAR(25))" );
        if( !qry.exec() )
          qDebug() << qry.lastError();
        else
          qDebug() << "Table created!";


        qry.prepare( "INSERT INTO cw_header_name (prd_cod_nm, prd_name_nm, batch_name_nm, target_wt_nm, tare_wt_nm, prd_length_nm, up_lmt_nm, lw_lmt_nm, speed_nm, opr_dly_nm, hld_dly_nm, rej_cnt_nm)VALUES('PRODUCT CODE : SANDEEP', 'PRODUCT NAME : DATTATRAY', 'BATCH NUMBER : KURHADE', 'TARGET WEIGHT : 0100.0 g', 'TARE WEIGHT : 0000.0 g', 'PRODUCT LENGTH : 100mm', 'UPPER LIMIT : 01.0 g', 'LOWER LIMIT : 01.0 g', 'SPEED : 120 ppm', 'OPERATE DELAY : 10', 'HOLD DELAY : 20', 'REJECT COUNT : 99')" );
        if( !qry.exec() )
          qDebug() << qry.lastError();
        else
          qDebug( "Inserted!" );


    qry.prepare( "SELECT	count(rowid) as num_rows FROM 	cw_header_name" );
    if( !qry.exec() ) qDebug() << qry.lastError();
    qry.first();
    num_rows = qry.value(0).toInt();
    qDebug() << "the number of rows = "<<num_rows;
    ui->tableWidget->setRowCount(num_rows);
  //  qry.prepare( "SELECT 	recipe_param_name,recipe_param_val FROM recipe_cw" );
    qry.prepare( "SELECT prd_cod_nm,prd_name_nm,batch_name_nm,target_wt_nm,tare_wt_nm,prd_length_nm,up_lmt_nm,lw_lmt_nm,speed_nm,opr_dly_nm,hld_dly_nm,rej_cnt_nm FROM cw_header_name" );

    if( !qry.exec() )
      qDebug() << qry.lastError();
    else
    {
      qDebug( "Selected!" );
      for(r=0,qry.first();qry.isValid();qry.next(),++r){
          for(c = 0; c < 12; ++c){
           ui->tableWidget->setItem(r,c,new QTableWidgetItem(qry.value(c).toString()));
          }
      }
    }

}

//void Widget::on_toPrintBtn_clicked()
//{
//QtRPT *report = new QtRPT(this);
//report->loadReport(":/Alarmreporte.xml");
//report ->recordCount.append(ui->tableWidget->rowCount());
//qDebug()<<"the record count = "<<ui->tableWidget->rowCount();
//connect(report,&QtRPT::setValue,[&](const int recNo,
//        const QString paramName, QVariant &paramValue,
//        const int reportPage){
//    (void) reportPage;

//    if(paramName == "date_time"){
//        paramValue = ui->tableWidget->item(recNo,dttm)->text();
//    }
//    if(paramName == "alarm_msg"){
//        paramValue = ui->tableWidget->item(recNo,alarmmsg)->text();
//    }
//    if(paramName == "user_id"){
//        paramValue = ui->tableWidget->item(recNo,user_id)->text();
//    }

//    if(paramName == "manf_name_val"){
//       paramValue = manufnm ;
//    }
//     if(paramName == "machine_name_val"){
//      paramValue = machinenm ;
//    }
//     if(paramName == "machine_id_val"){
//      paramValue = equipid ;
//     }
//     if(paramName == "prd_date_time_val"){
//     paramValue = prntdttm ;
//     }
//     if(paramName == "process_srt_dt_tm_val"){
//      paramValue = prcssrtdttm ;
//     }
//     if(paramName == "process_stp_dt_tm_val"){
//     paramValue = prcsstpdttm ;
//     }
//     if(paramName == "user_id_val"){
//     paramValue = usrid ;
//     }



////   // if(paramName == "id"){
////        if(paramName == "prd_cod_nm"){
////        paramValue = ui->tableWidget->item(recNo,PRODUCT_CODE_NM)->text();
////      //  paramValue = ui->tableWidget->item(recNo,recipe_param_name)->text();
////    }
////  //  if(paramName == "number"){
////        if(paramName == "prd_name_nm"){
////        paramValue = ui->tableWidget->item(recNo,PRODUCT_NAME_NM)->text();
////     //   paramValue = ui->tableWidget->item(recNo,recipe_param_val)->text();
////    }
////        if(paramName == "batch_name_nm"){
////            paramValue = ui->tableWidget->item(recNo,BATCH_NUMBER_NM)->text();
////        }
////        if(paramName == "target_wt_nm"){
////            paramValue = ui->tableWidget->item(recNo,TARGET_WEIGHT_NM)->text();
////        }
////        if(paramName == "tare_wt_nm"){
////            paramValue = ui->tableWidget->item(recNo,TARE_WEIGHT_NM)->text();
////        }
////        if(paramName == "prd_length_nm"){
////            paramValue = ui->tableWidget->item(recNo,PRODUCT_LENGTH)->text();
////        }
////        if(paramName == "up_lmt_nm"){
////            paramValue = ui->tableWidget->item(recNo,UP_LIMIT_NM)->text();
////        }
////        if(paramName == "lw_lmt_nm"){
////            paramValue = ui->tableWidget->item(recNo,LW_LIMIT_NM)->text();
////        }
////        if(paramName == "speed_nm"){
////            paramValue = ui->tableWidget->item(recNo,SPPED_NM)->text();
////        }
////        if(paramName == "opr_dly_nm"){
////            paramValue = ui->tableWidget->item(recNo,OPR_DLY_NM)->text();
////        }
////        if(paramName == "hld_dly_nm"){
////            paramValue = ui->tableWidget->item(recNo,HLD_DLY_NM)->text();
////        }
////        if(paramName == "rej_cnt_nm"){
////            paramValue = ui->tableWidget->item(recNo,REJECT_CNT_NM)->text();
////        }

////    if(paramName == "age"){
////        paramValue = ui->tableWidget->item(recNo,Age)->text();
////    }
////    if(paramName == "salary"){
////        paramValue = ui->tableWidget->item(recNo,Salary)->text();
////    }

//});
//report->printExec();

//}


void alaramWidget::on_addAlaram_clicked()
{
    const QStringList titles {"Date & Time","Alarm Message","User ID"};
       ui->tableWidget->setColumnCount(titles.size());
       ui->tableWidget->setHorizontalHeaderLabels(titles);

    almdate_time = "17-05-2018 11:50:00";// ui->prdwtlineEdit->text();
     alarm_msg = "S1 not sensed";//ui->prdresultlineEdit->text();
     userid = "Administrator";//ui->prcsstartdtlineEdit->text();


     const int rowCount = ui->tableWidget->rowCount();
     ui->tableWidget->insertRow(rowCount);
     ui->tableWidget->setItem(rowCount,alaramdttm,new QTableWidgetItem(almdate_time));
     ui->tableWidget->setItem(rowCount,alarmmsg,new QTableWidgetItem(alarm_msg));
     ui->tableWidget->setItem(rowCount,user_id,new QTableWidgetItem(userid));
     manufnm = "Technofour Electronics Pvt. Ltd.";//ui->manuflineEdit->text();
     machinenm = "CW1200";//ui->machinenamelineEdit->text();
     equipid = "TEPL123";//ui->eqidlineEdit->text();
     prntdttm = "17-05-2018 12:00:00";//ui->printdtlineEdit->text();
     prcssrtdttm = "17-05-2018 11:50:00";//ui->prcsstartdtlineEdit->text();
     prcsstpdttm = "17-05-2018 11:59:00";//ui->prcsstpdtlineEdit->text();
     usrid = "Administrator";//ui->usridlineEdit->text();




}

void alaramWidget::on_toPrintAlaram_clicked()
{


    QtRPT *report = new QtRPT(this);
    report->loadReport(":/Alarmreporte.xml");
    report ->recordCount.append(ui->tableWidget->rowCount());
    qDebug()<<"the record count = "<<ui->tableWidget->rowCount();
    connect(report,&QtRPT::setValue,[&](const int recNo,
            const QString paramName, QVariant &paramValue,
            const int reportPage){
        (void) reportPage;

        if(paramName == "date_time"){
            paramValue = ui->tableWidget->item(recNo,alaramdttm)->text();
        }
        if(paramName == "alarm_msg"){
            paramValue = ui->tableWidget->item(recNo,alarmmsg)->text();
        }
        if(paramName == "user_id"){
            paramValue = ui->tableWidget->item(recNo,user_id)->text();
        }

        if(paramName == "manf_name_val"){
           paramValue = manufnm ;
        }
         if(paramName == "machine_name_val"){
          paramValue = machinenm ;
        }
         if(paramName == "machine_id_val"){
          paramValue = equipid ;
         }
         if(paramName == "prd_date_time_val"){
         paramValue = prntdttm ;
         }
         if(paramName == "process_srt_dt_tm_val"){
          paramValue = prcssrtdttm ;
         }
         if(paramName == "process_stp_dt_tm_val"){
         paramValue = prcsstpdttm ;
         }
         if(paramName == "user_id_val"){
         paramValue = usrid ;
         }
    });
    report->printExec();




}




