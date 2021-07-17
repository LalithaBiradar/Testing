#include "teplcwtestthread.h"
#include <QDebug>
teplcwtestthread::teplcwtestthread()
{

}

void teplcwtestthread::startService()
{
   qDebug() << "teplcwtestthread" << QThread::currentThreadId();
   teplcwtestservice::startService();


}
