#ifndef ADDTASKMODEL_H
#define ADDTASKMODEL_H

#include <QAbstractListModel>
#include "addtask.h"

class AddTask;

class addTaskModel : public QAbstractListModel
{
    Q_OBJECT


    Q_PROPERTY(AddTask *tItems READ items WRITE setItems);
    AddTask *items() const;
    void setItems(AddTask *items);


public:
    enum {
        taskTitle = Qt::UserRole,
        taskName,
        taskDate
    };


    explicit addTaskModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int , QByteArray> roleNames() const override;

//    // Add data:
//    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

//    // Remove data:
//    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;


public slots:
    void slotPreInsertTask();
    void slotPostInsertTask();
    void slotPreMoveTask(int index);
    void slotPostMoveTask();


private:
    AddTask *mItems;

};

#endif // ADDTASKMODEL_H
