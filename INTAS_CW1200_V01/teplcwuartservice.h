#ifndef TEPLCWUARTSERVICE_H
#define TEPLCWUARTSERVICE_H

#include <QSerialPort>
#include <QSerialPortInfo>

#include "teplcwservice.h"

class TEPLCWUARTService : public TEPLCWService
{
public:
    explicit TEPLCWUARTService();
    std::unique_ptr<QTimer> m_pDbgTimer1;

    ~TEPLCWUARTService();

public slots:
    void write(const char *out, int length);
    void write(QVariant qmlWdata);
   // void write(const char* bytes,int length);
    void deleteLaterSetBaudRate(int br);
    void read();
    void startService();
    void resumeService();
    void pauseService();
    void stopService();
    void dbgCalcStats();
    void static_loop();
     void set_raw_bytes(QByteArray bytes[50],QByteArray bytes1);

private:
    // There must NOT be any variables declared directly as
    // members of this class, because the service object will
    // be moved to a new thread. All members must be constructed
    // inside that new thread, in the startService() routine. So
    // the only members must be unique_ptrs to the objects you
    // will create in startService().
    // Otherwise, get error:
    // "QObject: Cannot create children for a parent that is in a different thread."

    std::unique_ptr<QSerialPort> m_pUart;


};

#endif // TEPLCWUARTSERVICE_H
