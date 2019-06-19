import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import client 1.0

Page{
    id:loginCom;
    //property alias US:loginCom
    property alias username:username.text
    anchors.fill: parent
    signal login(var name,var password);
    //signal login(var password);
    UdpClient{
        id:client
    }
    Column{
        anchors.centerIn: parent
Column{
        Row{
            spacing: 8
            Label{
                text: "USERNAME"
                topPadding: 10
            }

            TextField{
                focus: true;
                id:username;
                width: 200;
               // property alias usernameT:usrname.text
            }
        }
        Row{
            Label{
                text: "Password "
                topPadding:6
            }

            TextField{
                focus: true;
                id:psword;
                width: 200;
            }
        }
}
        Button{
            id:btnLogin
            anchors.right: parent.right
            text:"login"
            onClicked:{
                if(username.text==""){
                    console.log("empty input")
                    return
                }
                else if(psword.text=="")
                {
                    console.log("empty input")
                    return
                }
                loginCom.visible=false;
                // when login success
                client.test();
                client.setName(username.text);
                client.setPsword(psword.text);
                //client.socketSetting();
                //UsrEnter();
                //sendMsg(UsrEnter);
                //@ emit login signal,to delete this Component
                loginCom.login(username.text,psword.text);
            }
            Material.background: Material.Teal
        }
    }
}
