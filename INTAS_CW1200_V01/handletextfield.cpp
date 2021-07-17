#include "handletextfield.h"

HandleTextField::HandleTextField(QObject *parent): QObject(parent)
{

}

void HandleTextField::handleSubmitTextField(const QString &in)
{
    qDebug() << "c++:HandleTextField::handleSubmitTextField:"<< in;
  //  emit setTextField(in.toUpper());
        emit setTextField(in.toUpper());



}

void HandleTextField::handleSubmitTextField1(const QString &in)
{
    qDebug() << "c++:HandleTextField::handleSubmitTextField1:"<< in;
    qDebug() << "CONV ON:"<< in;

    emit setTextField(in.toLower());



}
