#ifndef ADDTASK_H
#define ADDTASK_H

#include <QObject>
#include <QDebug>
#include <QDate>


struct AddTaskItem {
    QString tasktitle;
    QString taskname;
    QString taskdate;
};


class AddTask : public QObject
{
    Q_OBJECT


    Q_PROPERTY(QString dateToday READ getDateText WRITE setDateText)
    QString getDateText() const;
    void setDateText(const QString &value);


public:
    explicit AddTask(QObject *parent = nullptr);


private:
    // store all items in list views
    QVector<AddTaskItem> mItems;
    // store date text string
    QString dateText;
    QVector<QString> randomText = {
        "I'm so lazy today!",
        "I just want to sleep!",
        "I'm so lazy today. Please just leave me.",
        "Weather today looks lovely. I might just sleep.",
        "Nope. I am a koala."
    };


public:
    // retrieve all items
    QVector<AddTaskItem> items() const;

    // adding item
    void appendItem(QString name, QString date);

    // setting item
    bool setItemAt(int index, const AddTaskItem &item);

    // modifying item
    void removeItemAt(int index);

    QString generateRandomLazyText();
    int randomGen() { return (((rand() % 50) % 23) % (randomText.size() - 1));}


signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();


public slots:
    void slotAddNewTask(QString taskName, QString taskdate);
    void slotDeleteTask(int index);

};

#endif // ADDTASK_H
