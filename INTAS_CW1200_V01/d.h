#ifndef D_H
#define D_H

#include <QDebug>
#include <QObject>
#include <QVariantList>
//#include "savetextfield.h"

class D : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QVariantList vl READ vl WRITE setVl NOTIFY vlChanged)

public:
  explicit D(QObject *parent = 0) : QObject(parent){}

  QVariantList vl(){return myVl;}

  void setVl(QVariantList vl){
      qDebug() << "Connected in setVI";
    myVl = vl;
    qDebug() << "The integer array in cpp is:"<< myVl;


  }

  Q_INVOKABLE QVariantList doVl(){
      qDebug() << "Connected here";
    qDebug() << "Size of myVl: " << myVl.size();
    for(int i = 0; i < myVl.size(); i++){
      qDebug() << "myVl.at(" << i << "): " << myVl.at(i);
    }
    setVl(myVl);
    myVl[0] = 9;
    myVl[1] = 8;
    return myVl;
  }

signals:
  void vlChanged(QVariantList);


private:
  QVariantList myVl;

};


#endif // D_H
