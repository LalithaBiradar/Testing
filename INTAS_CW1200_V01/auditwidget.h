#ifndef AUDITWIDGET_H
#define AUDITWIDGET_H

#include <QWidget>
#include <QProcess>
namespace Ui {
class auditwidget;
}

class auditwidget : public QWidget
{
    Q_OBJECT

public:
     Ui::auditwidget *ui;
    explicit auditwidget(QWidget *parent = 0);
    ~auditwidget();

public slots:
    void on_addAudit_clicked();
    void on_toPrintAudit_clicked();
    void sQL_Audit_Report(QString,QString,QString);
    void gen_auditreport();
    void open_auditpdf(QString,QString,QString);
private:
QProcess *auditpdfprocess;
};

#endif // AUDITWIDGET_H
