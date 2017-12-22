
#include "recordsmodel.h"
#include <QDebug>

///////////////////////////////////////////////////////////////////////////////
RecordsModel::RecordsModel(QObject *parent)
    : QAbstractListModel(parent)
{

}


///////////////////////////////////////////////////////////////////////////////
RecordsModel::~RecordsModel() {}

///////////////////////////////////////////////////////////////////////////////
void
RecordsModel::addRecord(Record &r)
{
//    qDebug() << "  Adding a record: " << r.attributes();
    if (m_records.size() > 0){
        m_records.back().setText("");
    }

//    QVariant t = r.attributes()["name"];
    r.setText("newest");

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_records << r;
    endInsertRows();
}


///////////////////////////////////////////////////////////////////////////////
void
RecordsModel::addRecords(QVector<Record> const &v)
{
    Q_UNUSED(v)
}


///////////////////////////////////////////////////////////////////////////////
void
RecordsModel::clear()
{
    qDebug() << "Removing all records.";
    beginResetModel();
    m_records.clear();
    endResetModel();
}


///////////////////////////////////////////////////////////////////////////////
int
RecordsModel::rowCount(QModelIndex const &parent) const
{
    Q_UNUSED(parent);
    return m_records.size();
}

///////////////////////////////////////////////////////////////////////////////
QVariant
RecordsModel::data(QModelIndex const &index, int role) const {
    if (index.row() < 0 || index.row() >= m_records.size()) {
        return QVariant();
    }
    const Record &record = m_records[index.row()];
    if (role == AttrsRole) {
        // returning the entire QVariantMap not just the attribute names.
        return record.attributes();
    } else if (role == ColorRole) {
        return record.color();
    }
    return QVariant();
}

///////////////////////////////////////////////////////////////////////////////
QHash<int, QByteArray>
RecordsModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[AttrsRole] = "attrs";
    roles[ColorRole] = "color";
    return roles;
}



