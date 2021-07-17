#ifndef TEPLCWSERVICE_H
#define TEPLCWSERVICE_H

#include <QObject>
#include <QByteArray>
#include <QVariant>
#include <QString>
#include <QThread>
#include <QTimer>

#include <memory>

class TEPLCWService : public QObject
{
    // Q_OBJECT is a macro that gets expanded by the preprocessor
    // to declare several member functions that are implemented by the moc.
    Q_OBJECT
public:
    explicit TEPLCWService(QObject *parent = nullptr);

    // Polymorphic base class dtors MUST be virtual! Else derived objects
    // are not destroyed.
    virtual ~TEPLCWService();

public slots:
    virtual void write(QVariant qmlWdata) = 0;
    virtual void write(const char *out,int length) = 0;
   // virtual void write(const char* bytes,int length);
    // The following function is here only for the sake of this UART demo.
    // This does not belong in the base class. Remove in real application.
    virtual void deleteLaterSetBaudRate(int br) = 0;
    virtual void read() = 0;
    virtual void startService();    // Things to do before starting readData
    virtual void resumeService();
    virtual void pauseService();
    virtual void stopService();     // Things to do when application is quit
    void dbgCalcStats();            // BPS calculation and raw data bytes capture
    void teplfivems();
    void xfer_dynamiccommand();
    void static_tranfer();
    void xfer_zrdynamiccommand();
    virtual void static_loop() = 0;


signals:
    void finished();
    void dbgUpdateBps(QVariant bps);
    void dbgUpdateBytesRead(QVariant bytes);

protected:
    void processRawData(const char& recvBuffer, int numBytes);

    std::unique_ptr<char[]> m_pRecvBuffer;
    std::unique_ptr<QTimer> m_pDbgTimer;
    int m_dbgSigmaNumRd;

    constexpr static int BUFSIZE = 4096;

private:
    bool m_pauseFlag;
};

#endif // TEPLCWSERVICE_H
