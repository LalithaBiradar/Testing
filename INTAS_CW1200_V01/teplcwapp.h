#ifndef TEPLCWAPP_H
#define TEPLCWAPP_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QDebug>

#include <qqmlcontext.h>

#include <memory>
#include <wiringPi.h>

//#include "gpio.h"
#include "teplcwservice.h"
#include "teplcwuartservice.h"
#include "teplcwtestthread.h"
#include "teplcwtestservice.h"

class TEPLCWApp : public QObject
{
    Q_OBJECT
public:
    explicit TEPLCWApp(const QGuiApplication &a,
                       const QQmlApplicationEngine &e,
                       QObject *parent = nullptr);


    ~TEPLCWApp();
signals:

public slots:
    void quit();

private:
    constexpr static int wpGPIO_OUT_PIN = 1;
    constexpr static int wpGPIO_IN_PIN  = 4;

    const QQmlApplicationEngine &m_engine;
    const QGuiApplication &m_guiapp;

    // Observe that dtors of all the unique_ptrs get called w/o
    // having to explicitly call delete.
//    std::unique_ptr<GPIO> m_pGPOut;
//    std::unique_ptr<GPIO> m_pGPIn;

    std::unique_ptr<TEPLCWService> m_pCWS;
    QThread m_serviceThread;

    std::unique_ptr<teplcwtestservice> m_pTESTSVC;
    QThread m_testserviceThread;

    void initGPIO();
};

#endif // TEPLCWAPP_H
