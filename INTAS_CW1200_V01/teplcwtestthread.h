#ifndef TEPLCWTESTTHREAD_H
#define TEPLCWTESTTHREAD_H

#include <QObject>
#include "teplcwtestservice.h"
#include <QThread>


class teplcwtestthread : public teplcwtestservice
{
    Q_OBJECT
public:
    explicit teplcwtestthread();

signals:

public slots:

    void startService();

};

#endif // TEPLCWTESTTHREAD_H
