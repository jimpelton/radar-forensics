#ifndef RECORDSMODEL_H
#define RECORDSMODEL_H

#include "record.h"

#include <QObject>
#include <QAbstractListModel>
#include <QModelIndex>
#include <QVariant>

#include <QVector>
#include <QHash>
#include <QByteArray>
#include <QList>


///////////////////////////////////////////////////////////////////////////////
class RecordsModel : public QAbstractListModel {
    Q_OBJECT
public:
    ///////////////////////////////////////////////////////////////////////////////
    enum RecordRoles {
        AttrsRole = Qt::UserRole + 1,
        ColorRole
    };


    ///////////////////////////////////////////////////////////////////////////////
    explicit RecordsModel(QObject *parent = nullptr);


    ///////////////////////////////////////////////////////////////////////////////
    virtual ~RecordsModel();


    ///////////////////////////////////////////////////////////////////////////////
    void
    addRecord(Record &r);


    ///////////////////////////////////////////////////////////////////////////////
    void
    addRecords(QVector<Record> const &v);


    ///////////////////////////////////////////////////////////////////////////////
    void
    clear();


    ///////////////////////////////////////////////////////////////////////////////
    int
    rowCount(QModelIndex const &parent = QModelIndex()) const override;


    ///////////////////////////////////////////////////////////////////////////////
    QVariant
    data(QModelIndex const &index, int role = Qt::DisplayRole) const override;


protected:
    QHash<int, QByteArray>
    roleNames() const override;

private:
    QList<Record> m_records;
};


#endif // RECORDSMODEL_H
