#ifndef DBMANAGERS_H
#define DBMANAGERS_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QTimer>

class dbmanagers : public QObject
{
    Q_OBJECT
public:
    explicit dbmanagers(QObject *parent = nullptr);

    /**
     * @brief Constructor
     *
     * Constructor sets up connection with db and opens it
     * @param path - absolute path to db file
     */


    /**
     * @brief Destructor
     *
     * Close the db connection
     */
    ~dbmanagers();

    bool isOpen() const;


    /**
     * @brief Add person data to db
     * @param name - name of person to add
     * @return true - person added successfully, false - person not added
     */
    bool addPerson(const QString& name);
 //   bool addBatchdetails(void);


    /**
     * @brief Remove person data from db
     * @param name - name of person to remove.
     * @return true - person removed successfully, false - person not removed
     */
    bool removePerson(const QString& name);

    /**
     * @brief Check if person of name "name" exists in db
     * @param name - name of person to check.
     * @return true - person exists, false - person does not exist
     */
    bool personExists(const QString& name) const;

    /**
     * @brief Print names of all persons in db
     */
    void printAllPersons() const;

    /**
     * @brief Remove all persons from db
     * @return true - all persons removed successfully, false - not removed
     */
    bool removeAllPersons();

signals:

      //   void handleSQL_batch(QString sql_data1,QString sql_data2);
         void handleSQL_batch(QString sql_data1,QString sql_data2,QString sql_data3);
         void viewSQL_batch(QString gfg);

public slots:
   // void updateRTCString1(QString,QString,QString);
     void addDynamicwt(QString prntdttm, QString wt, QString);
    bool createTable(QString);
     void addBatchdetails(QString);
      bool createdynamicTable(QString);
    bool addAuditdata(QString date_time,QString event_msg, QString value,QString prev_value,QString username);
    bool addAlaramdata(QString date_time,QString event_msg,QString username);

    bool createBatchNameTable();

    bool audit_createTable(QString);
    bool alaram_createTable(QString);
    bool addBatchNamedetails(QString);
    bool completeBatchNamedetails();

     void loadSQLBatches();
     void slot_viewSQLbatch(QString gfg);
     void createTable_testmode();
     void create_uniquebchfg();
     bool pause_settingbatch(QString);
     bool start_settingbatch(QString);

private:
    QSqlDatabase m_db;
    QTimer* sql_log_timer1;
};

#endif // DBMANAGERS_H
