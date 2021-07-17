#ifndef TIMERTHREAD_H
#define TIMERTHREAD_H
#include <QTimer>
#include <QObject>
#include <QThread>
#include "loadcellcalls.h"
class timerthread : public QObject
{
    Q_OBJECT
public:
    explicit timerthread(QObject *parent = nullptr);

    QByteArray bytes1;
     void DoSetup(QThread &thread_timer);

signals:
 void log_dynamic_wt(QString,QString,QString);
  void signal_command();

public slots:

    void RTC50_read_timer();
    void init_timerthread();
    void static_loop();
     void set_raw_bytes(QByteArray bytes[50],QByteArray bytes1);
     void static_tranfer();
     void serial_FivemsLoop();
       void xfer_dynamiccommand(void);
     void xfer_zrdynamiccommand();

private:

     QTimer* serial_Fivemstimer;
      QTimer* sql_logtimer;
};

#endif // TIMERTHREAD_H
