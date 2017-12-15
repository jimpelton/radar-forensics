#include "parsejson.h"
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QVariantList>
#include <QTimer>


///////////////////////////////////////////////////////////////////////////////
RecordsModel::RecordsModel(QObject *parent)
    : QAbstractListModel(parent)
{

}


///////////////////////////////////////////////////////////////////////////////
RecordsModel::~RecordsModel() {}

///////////////////////////////////////////////////////////////////////////////
void
RecordsModel::addRecord(const Record &r)
{
//    qDebug() << "  Adding a record: " << r.attributes();
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_records << r;
    endInsertRows();
}


///////////////////////////////////////////////////////////////////////////////
void
RecordsModel::addRecords(QVector<Record> const &v)
{

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


///////////////////////////////////////////////////////////////////////////////
ParseJson::ParseJson(QObject *parent)
    : QObject(parent)
    , m_index(0)
    , m_timer()
{
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(addNextRecord()));
}

///////////////////////////////////////////////////////////////////////////////
ParseJson::~ParseJson()
{

}

///////////////////////////////////////////////////////////////////////////////
void
ParseJson::addNextRecord(){
    if (m_index < m_records.size()){
        m_model->addRecord(m_records[m_index++]);
    }
}


///////////////////////////////////////////////////////////////////////////////
void
ParseJson::startTimeChanged(double percent)
{
    qDebug() << "startTimeChanged";
    stopTimer();
    m_model->clear();
    size_t idx = float(m_records.size() * percent) + 0.5f;
    size_t const max_idx = m_records.size() - 1;
    if (idx > max_idx) {
        idx = max_idx;
    }
    m_index = idx;
//    for(; idx < m_endIndex && idx < m_records.size(); ++idx){
//        m_model->addRecord(m_records[idx]);
//    }
}


///////////////////////////////////////////////////////////////////////////////
void
ParseJson::endTimeChanged(double percent)
{
    qDebug() << "endTimeChanged";
    stopTimer();
    m_model->clear();
    size_t idx = (m_records.size() * percent) + 0.5f;
    size_t const max_idx = m_records.size() - 1;
    if (idx > max_idx) {
        idx = max_idx;
    }
    m_endIndex = idx;
//    for(; idx < m_records.size(); ++idx){
//        m_model->addRecord(m_records[idx]);
//    }
}

void
ParseJson::stopTimer()
{
    m_timer.stop();
}


void
ParseJson::startTimer()
{
   if (m_records.size() > 0){
       m_model->clear();
       qDebug() << "Timer started.";
       m_timer.start(200);
   }
}

namespace {
    ///////////////////////////////////////////////////////////////////////////////
    bool
    byTimeStamp(Record const &lhs, Record const &rhs) {
        return lhs.timestamp() < rhs.timestamp();
    }
}

///////////////////////////////////////////////////////////////////////////////
void
ParseJson::parse(QUrl fileUrl)
{
    qDebug() << fileUrl.toLocalFile();
    QFile f(fileUrl.toLocalFile());
    if (! f.exists()){
        qDebug() << "Document does not exist";
        return;
    }

    f.open(QIODevice::ReadOnly);
    QByteArray bytes( f.readAll() );
    QJsonDocument doc( QJsonDocument::fromJson(bytes) );
    if (doc.isNull()) {
        qDebug() << "Json document was empty.";
        return;
    }
    QJsonObject top( doc.object() );
    QJsonArray rows = top.value("rows").toArray();
    QJsonArray::iterator it = rows.begin();
    for(; it != rows.end(); ++it) {
        QJsonObject obj = it->toObject();
        if (obj.value("id").toString().startsWith("_design")){
            qInfo() << "Skipping design document.";
            continue;
        }
        QJsonValue doc = obj.value("doc");
        m_records.push_back(Record(doc.toObject(), QColor(255, 0, 0, 255)));
    }

    std::sort(m_records.begin(), m_records.end(), byTimeStamp);
    m_timer.start(200);
}


void
ParseJson::setModel(QSharedPointer<RecordsModel> model){
    m_model = model;
}



