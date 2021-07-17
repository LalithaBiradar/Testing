//#ifndef HANDLELINECHARTVALUE_H
//#define HANDLELINECHARTVALUE_H

#ifndef CHARTCOMM_H
#define CHARTCOMM_H

#include<QObject>
#include<QDebug>
#include<QFile>
#include<QTextStream>

class CHARTCOMM : public QObject
{
    Q_OBJECT


public:
    //explicit SaveTextField(QObject *parent = 0);
 //   FileIO(){}
  //  ~FileIO(){}
    explicit CHARTCOMM(QObject *parent = 0);

private:


signals:
void connectExist(QVariant text);


public slots:
    void chartsig();

};


#endif // HANDLELINECHARTVALUE_H
