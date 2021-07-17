#include "teplcwapp.h"

// TODO: App settings in a QSettings object

/* Note peculiar definition for static constexprs: You have
 * to provide the definition of the static member as well as
 * the declaration. The declaration *AND* the initializer go
 * inside the class definition, but the member definition has
 * to be separate.
 * https://stackoverflow.com/a/8016853
 */
constexpr int TEPLCWApp::wpGPIO_OUT_PIN;
constexpr int TEPLCWApp::wpGPIO_IN_PIN;

TEPLCWApp::TEPLCWApp(const QGuiApplication &a,
                     const QQmlApplicationEngine &e,
                     QObject *parent) : QObject(parent),
                                        m_engine(e),
                                        m_guiapp(a)
{
  //  initGPIO();

    QObject *rootObject = m_engine.rootObjects().first();
    //QObject *btnGPOut = rootObject->findChild<QObject *>("gpOUT");

 //   m_pGPOut = std::make_unique<GPIO>(wpGPIO_OUT_PIN, GpioType::OP);
  //  m_pGPIn  = std::make_unique<GPIO>(wpGPIO_IN_PIN,  GpioType::IP);

//    connect(btnGPOut, SIGNAL(toggleGPIO()),
//            m_pGPOut.get(), SLOT(toggle()));

//    m_engine.rootContext()->setContextProperty("gpIN", m_pGPIn.get());

//    QObject *uartForm   = rootObject->findChild<QObject *>("uartForm");
//    QObject *gpioForm   = rootObject->findChild<QObject *>("gpioForm");
//    QObject *swipeView  = rootObject->findChild<QObject *>("swipeView");

    m_serviceThread.setObjectName("CWApp SvcThread");
    m_testserviceThread.setObjectName("CWApp TestThread");
    m_pCWS = std::make_unique<TEPLCWUARTService>();
    m_pCWS->moveToThread(&m_serviceThread);

    m_pTESTSVC = std::make_unique<teplcwtestthread>();
    m_pTESTSVC->moveToThread(&m_testserviceThread);


    // QML signals to C++ slots. Note: cannot use direct calls via
    // Q_INVOKABLE here since target object has been moved to different thread!
    // Non-basic argument types (e.g. arrays) must be of type QVariant
//    connect(uartForm,       SIGNAL(write(QVariant)),
//            m_pCWS.get(),   SLOT(write(QVariant)));

//    connect(uartForm,       SIGNAL(setBaudRate(int)),
//            m_pCWS.get(),   SLOT(deleteLaterSetBaudRate(int)));

    // Resume service whenever swipeView switches to UART
//    connect(swipeView,      SIGNAL(resumeUART()),
//            m_pCWS.get(),   SLOT(resumeService()));

    // Pause service when swipeView switches away from UART (e.g. into settings)
//    connect(swipeView,      SIGNAL(pauseUART()),
//            m_pCWS.get(),   SLOT(pauseService()));

    // Baudrate update slot (Note: C++ signal to QML slot - ALL params must be
    // passed as type QVariant regardless of original type)
//    connect(m_pCWS.get(),   SIGNAL(dbgUpdateBps(QVariant)),
//            uartForm,       SLOT(updateBps(QVariant)));

    // Data byte string update slot (Also C++ signal to QML slot - ALL params must
    // be passed as type QVariant regardless of original type)
//    connect(m_pCWS.get(),   SIGNAL(dbgUpdateBytesRead(QVariant)),
//            uartForm,       SLOT(updateByteString(QVariant)));

    // TODO: investigate why lambda forms don't work
    //QObject::connect(&engine, SIGNAL(quit()), [=](){ m_pCWS->quitTest(); });
    //QObject::connect(&engine, &QQmlApplicationEngine::quit(), [=](){ m_pCWS->quitTest(); });
    //engine.connect(&engine, &QQmlApplicationEngine::quit(), [=](){ m_pCWS->quitTest(); });

    connect(&m_serviceThread, SIGNAL(started()),
            m_pCWS.get(),     SLOT(startService()));
    connect(&m_testserviceThread, SIGNAL(started()),
            m_pTESTSVC.get(),     SLOT(startService()));


    // --- Shutdown ---
    // 1.   Quit buttons pressed on the gui result in stopService() getting called
    //      (in the child thread). That emits a finished() signal from that thread...
//    connect(uartForm,      SIGNAL(quit()),
//            m_pCWS.get(),  SLOT(stopService()));

//    connect(gpioForm,      SIGNAL(quit()),
//            m_pCWS.get(),  SLOT(stopService()));

    // 2.   Which is caught here and calls TEPLCWApp.quit() in the main thread. This
    //      shuts down the child thread and terminates the app.
//    connect(m_pCWS.get(),  SIGNAL(finished()),
//            this,          SLOT(quit()));

    m_serviceThread.start();
    m_testserviceThread.start();
    qDebug() << "Service thread started";
    qDebug("Main thread running as threadId %p", QThread::currentThreadId());

}

TEPLCWApp::~TEPLCWApp()
{
    qDebug() << "CWApp dtor";
}

// Slot called by CWService.finished(). Terminate serviceThread here.
void TEPLCWApp::quit()
{
    m_serviceThread.quit();
    m_serviceThread.wait();
    qDebug() << "Service thread terminated";
    m_testserviceThread.quit();
    m_testserviceThread.wait();
    qDebug() << "TEST Service thread terminated";


    m_guiapp.quit();
}

void TEPLCWApp::initGPIO()
{
    //wiringPiSetup();
}
