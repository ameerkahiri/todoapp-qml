#include "addtask.h"

AddTask::AddTask(QObject *parent) : QObject(parent)
{
    //appendItem("Ameer", "1/1/1");
}


QString AddTask::getDateText() const
{
    return QDate::currentDate().toString();
}


void AddTask::setDateText(const QString &value)
{
    dateText = value;
}


// retrieve all items
QVector<AddTaskItem> AddTask::items() const {

    return mItems;

}


// adding item
void AddTask::appendItem(QString name, QString date) {

    emit preItemAppended();

    qDebug() << QString("appendItem ") + name;

    AddTaskItem item;
    item.tasktitle = "Task #" + QString::number(items().size() + 1);
    item.taskname = (name.isEmpty() ? generateRandomLazyText() : name);
    item.taskdate = date;
    mItems.append(item);

    emit postItemAppended();

}


bool AddTask::setItemAt(int index, const AddTaskItem &item) {

    // check index valid
    if(index < 0 || index >= mItems.size())
        return false;

    // check difference old and current item data
    const AddTaskItem &oldItem = mItems.at(index);
    if(item.tasktitle == oldItem.tasktitle && item.taskname == oldItem.taskname)
        return false;

    mItems[index] = item;
    return true;

}


// removing item
void AddTask::removeItemAt(int index) {

    // check index valid
    if(index < 0 || index >= mItems.size())
        return;

    qDebug() << QString("removeItemAt ") + QString::number(index);

    emit preItemRemoved(index);

    // check if item is same
    mItems.removeAt(index);

    emit postItemRemoved();

}


QString AddTask::generateRandomLazyText() {

    int n = randomGen();
    std::random_shuffle ( randomText.begin(), randomText.end());
    return randomText[n];

}


void AddTask::slotAddNewTask(QString taskName, QString taskdate) {

    appendItem(taskName, taskdate);

}


void AddTask::slotDeleteTask(int index) {

    removeItemAt(index);

}
