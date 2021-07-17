#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QProcess>
namespace Ui {
class Widget;
}

class Widget : public QWidget
{
    Q_OBJECT

public:


     Ui::Widget *ui;
    explicit Widget(QWidget *parent =nullptr);


    ~Widget();

signals:


public slots:
    void on_addPushBtn_clicked();
    void sQL_Batch_Report(QString,QString,QString);
    void addBatchdetails();
    void addBatchdetails_setting();

    void gen_batchreport();
    void open_batchpdf(QString,QString,QString);
    void open_manualpdf(void);

public:


private:

    QProcess *pdfprocess;

};

#endif // WIDGET_H
