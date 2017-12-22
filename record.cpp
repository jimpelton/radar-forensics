
#include "record.h"



Record::Record(QObject *parent)
    : Record(QJsonObject(), parent)
{

}


///////////////////////////////////////////////////////////////////////////////
Record::Record(QJsonObject const &json, QObject *parent)
    : Record(json, QColor(255,255,255,255), parent)
{
}


///////////////////////////////////////////////////////////////////////////////
Record::Record(QJsonObject const &json, QColor const &c, QObject *parent)
    : QObject(parent)
    , attrs()
    , c(c)
    , ts(0)
{
    attrs = json.toVariantMap();
    ts = attrs["timestamp"].toReal();
    attrs["text"] = "";
}


///////////////////////////////////////////////////////////////////////////////
Record::Record(Record const &o)
    : QObject(o.parent())
    , attrs( o.attrs )
    , c( o.c )
    , ts( o.ts )
{
}



///////////////////////////////////////////////////////////////////////////////
Record::~Record() {}


///////////////////////////////////////////////////////////////////////////////
Record&
Record::operator=(Record const &o)
{
    if (this != &o) {
        this->attrs = o.attrs;
        this->c = o.c;
        this->ts = o.ts;
    }
    return *this;
}


///////////////////////////////////////////////////////////////////////////////
QVariantMap const &
Record::attributes() const {
    return attrs;
}


///////////////////////////////////////////////////////////////////////////////
QColor const &
Record::color() const
{
    return c;
}


///////////////////////////////////////////////////////////////////////////////
double
Record::timestamp() const
{
    return ts;
}

void
Record::setText(QString const &s) {
    attrs["text"] = s;
}
