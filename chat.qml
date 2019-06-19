import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import client 1.0


Page{
    id:chatCom
    property string username
    property string password
    anchors.fill: parent
    property var newMsgs: []
    UdpClient{
        id:client
    }
    Column{
        spacing: 4
        anchors.fill:parent
        Rectangle{
            height: 100
            width: parent.width
            Button{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "back"
                onClicked: {
                    chatCom.visible=false;
                    chatCom.destroy();
                }
            }
            Button{
                 anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                text:"clear"
                onClicked: {
                    console.log("US")
                    console.log(username)
                }
                Material.background: Material.Red
            }
        }
        ListView{
            spacing: 8
            id:charView
            model: 1
            height: 400
            clip: true;
            width: parent.width
            delegate: chatDelegate
            Component.onCompleted: {
                positionViewAtEnd();
            }
            Component{
                id:chatDelegate

                Rectangle{
                    //color: "red"
                    width: parent.width-20
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: childrenRect.height
                    Text {
                        id:textContent
                        color: "black"
                        width: parent.width-40
                        font.pointSize: 13
                        wrapMode: Text.WrapAnywhere
                        Connections{
                            target: client
                                  onSignalMsg: {
                                      textContent.text=ipAddr
                        }
                        }

                    }
                }
            }//chatDelegate-end
        }//chatView-end
        Row{
            // input & send
            height: 50
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            TextArea{
                id:send_content
                anchors.bottom: btn_send.bottom
                focus: true
                width: 200

                KeyNavigation.priority: KeyNavigation.BeforeItem;
                KeyNavigation.tab: btn_send;
            }
            Button{
                id:btn_send
                text:"send"
                Keys.onEnterPressed: {
                    clicked();
                }
                onClicked: {
                    if(send_content.text.trim().length==0){
                        send_content.focus=true;
                        return;
                    }

                    var type = 0
                    client.sndMsg(client.Msg,send_content.text);//send
                    send_content.text="";
                    send_content.focus=true;

                }
            }
        }

        Row{

            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                id:sendFile
                text:"F";
                background: Rectangle {
                    implicitWidth: 40
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: sendFile.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 22
                }
                onClicked: {
                    var comp=Qt.createComponent("chooseFile.qml");
                    comp.createObject(chatCom
                                      ,{
                                          "frindIpv4":frindIpv4,
                                          "frindName":friendName.text
                                      }
                                      );
                }
            }
       }
    }
}



