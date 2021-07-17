#include "handlelinechartvalue.h"
#include <fstream>
#include<iostream>
#include<QtWidgets/QFileDialog>
#include<QtWidgets/QDialog>
#include<QFileInfo>
#include <QQmlContext>

CHARTCOMM::CHARTCOMM(QObject *parent): QObject(parent)
{

}
void CHARTCOMM::chartsig()
{
    qDebug() << "i connected to StatsPage.qml";
    emit connectExist("Connected sucessfully");
}
