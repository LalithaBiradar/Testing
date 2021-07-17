
#ifndef FILEIO_H
#define FILEIO_H

#include<QObject>
#include<QDebug>
#include<QFile>
#include<QTextStream>

#include <QtSql/QSqlDatabase>

class FileIO : public QObject
{
    Q_OBJECT



public:
     explicit FileIO(QObject *parent = 0);


private:
    QMap<QString, QString> contacts;
    QMap<QString, QString> OTPcontacts;
    QMap<QString, QString> Groupcontacts;
    QMap<QString, QString> GroupcontactsName;
    QMap<QString, QString> UserStatus;

signals:
    void handleSaveTextField(QVariant text);

    void handleSaveFileList(QVariant text);
    void handleUserStatusFile(QVariant text);
    void handleErrorExistFile(QVariant text);

    void handleUserProfileList(QVariant text);
    void handleIntArrList(QVariant text);
    void chkFileExist(QVariant text);
    void handleSubmittFileParam(QVariant text1,QVariant text2,QVariant text3);
    void lineChartData(QVariant xVal,QVariant yVal);

    void signal_savetextfield(QString,QString,QString,QString,QString);
    void view_audit_report();

    void online_okcounts(QVariant,QVariant,QVariant,QVariant,QVariant);

    void online_uwcounts(QVariant);
    void online_owcounts(QVariant);

    void batch_change(QString);
    void uniquebatch_change();
     void disablescr(QVariant text);
     void disablescr1(int cnt, QString cnt1);
    void clDialogue(QVariant text);
    void previlage_status(QVariant text);

    void handleDcompsts(QString cnt);

    void handleMachine_sts(unsigned int cnt);


private:
        QSqlDatabase pwd_db;

public slots:


    void read(const QString& source);
    void submittFileParam(const QString& param1,const QString& param2);
    void submittFileParamOTP(const QString& param1,const QString& param2);
    void previous(const QString& param1);
    void next(const QString& param1);
    void nextOTP(const QString& param1,const QString& param2);
    void findGroupNameUserName(const QString& param1);
    void findUserStatus(const QString& param1);

    void saveToFile();
    void saveToFileOTP();
    void saveAsGroupnameUsrnm();
    void saveUserStatus();
     void disableScreen(const QString& param1);
     void disableScreen1(const QString& param1);
     void closeDialogue(const QString& param1);
    void removeFromOTP(const QString& param1);

    void saveToGroupFile(const QString& source);
    void changepwd(const QString& param1);
    void remove(const QString& param1);
    void removeOTP(const QString& param1);
    void saveToLib(const QString& source,QStringList adata,qint8 length);

    void saveParamInFile(const QString& source,QStringList adata,qint8 length);
    void saveParamInReporthdrFile(QStringList adata,qint8 length);


    void createNsaveToLib(const QString& source,QStringList adata,qint8 length);
    void chkDuplicateFile(const QString& source);

    void loadFromFile();
    void loadUserProfileFile();
    void loadUserStatusFile();
    void loadFromLib(const QString& source);
    void powerOnLoadFromLib(const QString& source);
    void createListFileNames(const QString& source);
    void createLoginNames(const QString& source,const QString& param1,const QString& param2);
    void addNewUser(const QString& source,const QString& param1,const QString& param2);
    void overWriteFile(const QString& source,const QString& param1);
    void overWriteFileAdmin(const QString& source,const QString& param1);
    void logout(const QString& param1);


     void statusFile(const QString& param1,const QString& source,const QString& param2);

    void loadFromLoginNames(const QString& source);
    void loadFromListFileNames(const QString& source);
    void loadParamFromListFileName(const QString& source);
    void removeFromLib(const QString& source);

    void storePrevilages(const QString& param1,const QString& source);
    void findPrevilages(const QString& param1);
    void sendPrevilageStatus(const QString& param1);

    void storeDCOMP_FACT(QString param1, QString param2);
    void recall_DCOMPFACT();

    void Poweron_saveParamInFile(void);
    void lastTwoSave(const QString& param1,const QString& param2);
    void manualOpen();
    void storeLogout_time(QString param1);

    void machine_sts(unsigned int);

    void batch_end_auditlog();


    bool write(const QString& source, const QString& data)
     {
         qDebug() << "c++:this is the data:"<< data;
            if (source.isEmpty())
            {
                qDebug() << "source is empty:";
          //      return false;
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
                     }

                       qDebug() << "file written:";
                       QTextStream out(&file);
                       out << data;
                       file.close();

          return true;
}

};

#endif // SAVETEXTFIELD_H
