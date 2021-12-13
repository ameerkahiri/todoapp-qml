#include "addtaskmodel.h"

addTaskModel::addTaskModel(QObject *parent)
    : QAbstractListModel(parent)
{
    mItems = nullptr;
}

int addTaskModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return mItems->items().size();
}

QVariant addTaskModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const AddTaskItem item = mItems->items().at(index.row());

    switch(role) {
    case taskTitle :
        return QVariant(item.tasktitle);
    case taskName :
        return QVariant(item.taskname);
    case taskDate :
        return QVariant(item.taskdate);
    }

    return QVariant();
}

bool addTaskModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mItems)
        return false;

    AddTaskItem item = mItems->items().at(index.row());

    switch(role) {
    case taskTitle :
        item.tasktitle = value.toString();
        break;
    case taskName :
        item.taskname = value.toString();
        break;
    case taskDate :
        item.taskdate = value.toString();
        break;
    }

    if (mItems->setItemAt(index.row(), item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags addTaskModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}


QHash<int, QByteArray> addTaskModel::roleNames() const
{
    // bind rolename to qml var
    QHash<int, QByteArray> names;
    names[taskTitle] = "mtaskTitle";
    names[taskName] = "mtaskName";
    names[taskDate] = "mtaskDate";

    return names;
}

//bool addTaskModel::insertRows(int row, int count, const QModelIndex &parent)
//{
//    beginInsertRows(parent, row, row + count - 1);
//    // FIXME: Implement me!
//    endInsertRows();

//    return 1;
//}

//bool addTaskModel::removeRows(int row, int count, const QModelIndex &parent)
//{
//    beginRemoveRows(parent, row, row + count - 1);
//    // FIXME: Implement me!
//    endRemoveRows();

//    return 1;
//}

AddTask *addTaskModel::items() const
{
    return mItems;
}

void addTaskModel::setItems(AddTask *items)
{
    beginResetModel();

    if(mItems)
        mItems->disconnect(this);

    mItems = items;

    if(mItems) {
        connect(mItems, &AddTask::preItemAppended, this, &addTaskModel::slotPreInsertTask);
        connect(mItems, &AddTask::postItemAppended, this, &addTaskModel::slotPostInsertTask);
        connect(mItems, &AddTask::preItemRemoved, this, &addTaskModel::slotPreMoveTask);
        connect(mItems, &AddTask::postItemRemoved, this, &addTaskModel::slotPostMoveTask);
    }

    endResetModel();

}


void addTaskModel::slotPreInsertTask(){

    qDebug() << QString("a is slotPreInsertTask");

    const int index = mItems->items().size();
    beginInsertRows(QModelIndex(), index, index); // add only one and at index

}


void addTaskModel::slotPostInsertTask(){

    qDebug() << QString("a is slotPostInsertTask");

    endInsertRows();

}


void addTaskModel::slotPreMoveTask(int index){

    qDebug() << QString("a is slotPreMoveTask ") + QString::number(index);

    beginRemoveRows(QModelIndex(), index, index);

}


void addTaskModel::slotPostMoveTask(){

    qDebug() << QString("a is slotPostMoveTask");

    endRemoveRows();

}
