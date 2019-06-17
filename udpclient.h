#ifndef SOCKETSETTING_H
#define SOCKETSETTING_H

#include<QObject>
#include<QUdpSocket>
#include<QList>
#include<QTcpServer>
#include<QTcpSocket>
//#include<QFile>
#include<QString>





class UdpClient :public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:

    UdpClient();
    Q_INVOKABLE enum MsgType{Msg, UsrEnter, UsrLeft, FileName, Refuse};
    Q_INVOKABLE void test();
    Q_INVOKABLE void socketSetting();
    Q_INVOKABLE void setName(QString nekename);
    //Q_INVOKABLE void UsrEnter(QString usrName, QString ipAddr);
   // Q_INVOKABLE void usrLeft(QString usrName, QString time);
    Q_INVOKABLE void sndMsg(QString msg);
    Q_INVOKABLE QString getIP();
    Q_INVOKABLE QString getUsr();
   // Q_INVOKABLE QString getMsg(QString msg);
protected:
   // QString name() const{return u_name;}

private:
    QUdpSocket *udpSocket;
    qint16 port;
    QString u_name;
    QString u_ipAddr;
signals:
    void nameChanged();
    void signalEnter(QString usrName, QString ipAddr);
    void signalLeft(QString usrName, QString time);
    void signalMsg(QString usrName,QString ipAddr ,QString msg);
private slots:
    void processPendingDatagrams();
};


#endif // SOCKETSETTING_H