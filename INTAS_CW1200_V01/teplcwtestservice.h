#ifndef TEPLCWTESTSERVICE_H
#define TEPLCWTESTSERVICE_H

#include <QObject>
#include <QThread>
#include <QTimer>
#include <memory>

class teplcwtestservice : public QObject
{
    Q_OBJECT
public:
    explicit teplcwtestservice(QObject *parent = nullptr);

signals:
    void sqllog();

public slots:
    virtual void startService();
    void medLatPoll();
    void sqleventPoll();
    void event_mediumlatinput_checked();
    void event_softpolling_checked();
    void addAlaramdata(QString date_time,QString event_msg,QString username);
    void sqllogdata();


private:
    std::unique_ptr<QTimer> mupMedLatPollTimer;
    std::unique_ptr<QTimer> mupSqlLogTimer;



};

#endif // TEPLCWTESTSERVICE_H
