#ifndef ALARAMWIDGET_H
#define ALARAMWIDGET_H



#include <QWidget>

namespace Ui {
class alaramWidget;
}

class alaramWidget : public QWidget
{
    Q_OBJECT

public:

    Ui::alaramWidget *ui;
    explicit alaramWidget(QWidget *parent =nullptr);
    ~alaramWidget();

private slots:
//    void on_addPushBtn_clicked();
//    void on_removeBtn_clicked();
//    void on_toPrintBtn_clicked();

    void on_addAlaram_clicked();
    void on_toPrintAlaram_clicked();




};

#endif // WIDGET_H
