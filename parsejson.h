#ifndef PARSEJSON_H
#define PARSEJSON_H

#include <QObject>
#include <QUrl>
#include <QJsonObject>
#include <QMap>
#include <QVariant>
#include <QVariantMap>
#include <QVector>
#include <QAbstractItemModel>
#include <QSharedPointer>
#include <QHash>
#include <QString>
#include <QByteArray>
#include <QModelIndex>
#include <QTimer>
#include <QColor>
#include <QDebug>

///////////////////////////////////////////////////////////////////////////////
class Record : public QObject {
    Q_OBJECT
//    Q_PROPERTY(QVarantMap attrs READ attributes)
//    Q_PROPERTY(double ts READ timestamp)

public:
    explicit Record(QObject *parent = nullptr)
        : QObject(parent)
        , ts(0)
        , c(QColor(255,255,255,255))
    {

    }


    explicit Record(QJsonObject const &json, QObject *parent = nullptr)
        : Record(json, QColor(255,255,255,255), parent)
    {
    }

    explicit Record(QJsonObject const &json, QColor const &c, QObject *parent = nullptr)
        : QObject(parent)
        , c(c)
    {
       attrs = json.toVariantMap();
       ts = attrs["timestamp"].toReal();
    }

    Record(Record const &o)
        : QObject(o.parent())
        , attrs{ o.attrs }
        , c( o.c )
        , ts( o.ts )
    {
    }

    Record&
    operator=(Record const &o) {
        if (this != &o) {
            this->attrs = o.attrs;
            this->c = o.c;
            this->ts = o.ts;
        }
        return *this;
    }

    virtual ~Record() {}

    QVariantMap
    attributes() const {
        return attrs;
    }

    QColor const &
    color() const {
        return c;
    }

    double
    timestamp() const {
        return ts;
    }

private:
    QVariantMap attrs;
    QColor c;
    double ts;
};


///////////////////////////////////////////////////////////////////////////////
class RecordsModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum RecordRoles {
        AttrsRole = Qt::UserRole + 1,
        ColorRole
    };

    explicit RecordsModel(QObject *parent = nullptr);

    void addRecord(Record const &r);
    void addRecords(const QVector<Record> &v);
    void clear();

    int rowCount(QModelIndex const &parent = QModelIndex()) const override;

    QVariant data(QModelIndex const &index, int role = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<Record> m_records;
};

///////////////////////////////////////////////////////////////////////////////
class ParseJson : public QObject
{
    Q_OBJECT
public:
    explicit ParseJson(QObject *parent = 0);
    virtual ~ParseJson();

    Q_INVOKABLE void parse(QUrl file);

    void setModel(QSharedPointer<RecordsModel> model);

signals:

public slots:
    void addNextRecord();
    void startTimeChanged(double percent);   ///< set percent into total runtime
    void endTimeChanged(double percent);
    void stopTimer();
    void startTimer();

private:
    QString m_fileName;
    QVector<Record> m_records;
    QSharedPointer<RecordsModel> m_model;
    QTimer m_timer;
    size_t m_index;
    size_t m_endIndex;
};

#endif // PARSEJSON_H