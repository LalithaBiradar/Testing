#ifndef WIDGETALARAM_H
#define WIDGETALARAM_H

#include <QWidget>
#include <QProcess>
namespace Ui {
class widgetalaram;
}

class widgetalaram : public QWidget
{
    Q_OBJECT

public:

 Ui::widgetalaram *ui;
    explicit widgetalaram(QWidget *parent = 0);
    ~widgetalaram();



public slots:
    void on_addAlaram_clicked();
    void sQL_Alaram_Report(QString,QString,QString);

    void gen_alaramreport();
    void open_alarampdf(QString,QString,QString);
private:
QProcess *alarampdfprocess;
};

#endif // WIDGETALARAM_H
