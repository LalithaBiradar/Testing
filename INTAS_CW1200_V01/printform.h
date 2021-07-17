#ifndef PRINTFORM_H
#define PRINTFORM_H

#include <QWidget>

class QPrinter;
class QSqlTableModel;


namespace Ui {
class PrintForm;
}

class PrintForm : public QWidget
{
    Q_OBJECT

public:
    explicit PrintForm(QWidget *parent = 0);
    ~PrintForm();

private:
    Ui::PrintForm *ui;

  //  void initDb();
    QSqlTableModel *model;

//public slots:

private slots:
  void print(QPrinter *printer);
  void print_two_tables(QPrinter *printer);
  void uglyPrint(QPrinter *printer);
  void on_pushButton_2_clicked();
  void on_pushButton_clicked();
  void on_pushButton_3_clicked();
//  void on_tableView_activated(const QModelIndex &index);
};

#endif // PRINTFORM_H
