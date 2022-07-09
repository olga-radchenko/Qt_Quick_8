import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: loginForm
    width: 260
    height: 180
    property int current_x: mainRect.x

    signal loginSuccess(string login)
    signal accountCreate()
    signal recoverRequest()

    FontLoader
    {
        id: mvBoli ;
        source: "mvboli.ttf"
    }

    state:"Invisible"

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: loginForm; opacity: 1.0}
            PropertyChanges{target: loginForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: loginForm; opacity: 0.0}
            PropertyChanges{target: loginForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation{
               NumberAnimation {
                   target: loginForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: loginForm
                   property: "visible"
                   duration: 0
               }
            }
        },
        Transition {
            from: "Invisible"
            to: "Visible"
            SequentialAnimation {
                NumberAnimation {
                    target: loginForm
                    duration: 1000
                }
                NumberAnimation {
                   target: loginForm
                   property: "visible"
                   duration: 0
               }
                NumberAnimation {
                   target: loginForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    ParallelAnimation {
        id: failAnimation
        SequentialAnimation {
            PropertyAnimation {
                targets: [usrnameLabel, usrswrdLabel]
                property: "color"
                to: "red"
                duration: 400
            }
            PropertyAnimation {
                targets: [usrnameLabel, usrswrdLabel]
                property: "color"
                to: "black"
                duration: 400
            }
            loops: 2
        }

        SequentialAnimation {
            NumberAnimation { target: mainRect; property:
            "x"; to: current_x-5; duration: 50 }
            NumberAnimation { target: mainRect; property:
            "x"; to: current_x+5; duration: 100 }
            NumberAnimation { target: mainRect; property:
            "x"; to: current_x; duration: 50    }
        }
    }

    Rectangle {
        id:mainRect
        Layout.alignment: Qt.AlignHCenter
        width: parent.width
        height: parent.height
        color: "white"
        radius: 10
        opacity: 0.5
    }

    Column {
        id: mainColumn
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 10
        anchors.top: parent.top
        anchors.topMargin: 10

        Row {
            id: row1
            width: 240
            height: 60
            anchors.top: parent.top
            anchors.topMargin: 10
            Column {
                id: column
                width: 55
                height: 60
                anchors.left: parent.left
                anchors.leftMargin: 0
                spacing: 20
                Label {
                    id:usrnameLabel
                    text:"Login: "
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    horizontalAlignment: Text.AlignRight
                    font.pointSize: 10
                    width: 55
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                }
                Label {
                    id:usrswrdLabel
                    text:"Password: "
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignRight
                    font.pointSize: 10
                    width: 55
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                }
            }
            Column {
                id: column1
                width: 180
                height: 60
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing: 10
                Layout.fillWidth: true

                TextField {
                    id:usr_login;
                    width: 175
                    height: 26
                    font.pointSize: 9
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    background: Rectangle {
                        color: "white"
                        opacity: 0.9
                        radius: 10
                    }
                    onAccepted: enterBttn.clicked()
                }
                TextField {
                    id:usr_psswrd;
                    echoMode: TextInput.Password
                    width: 175
                    height: 26
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    font.pointSize: 9
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    background: Rectangle {
                        color: "white"
                        opacity: 0.9
                        radius: 10
                    }
                    onAccepted: enterBttn.clicked()
                }
            }
        }
        Row {
            id: row2
            width: 240
            height: 20
            anchors.top: row1.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Button {
                id: enterBttn
                text: "Login"
                anchors.fill: parent
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                font.pointSize: 10
                font.family: mvBoli.name
                font.styleName: "My MV Boli"
                Layout.alignment: Qt.AlignHCenter

                background: Rectangle {
                    id: bttnRect
                    color: "#ff69b4"
                    opacity: 0.7
                    radius: 5
                    anchors.fill: parent
                }
                onPressed:  { bttnRect.color = "#dda0dd" }
                onReleased: { bttnRect.color = "#ff69b4" }
                onClicked:
                {
                    if(findNamePswdCombination(usr_login.text, usr_psswrd.text) !== -1)
                    {
                           loginForm.loginSuccess(usr_login.text)
                    }
                    else { failAnimation.start() }
                }
            }
        }

        Row {
            id: row3
            height: 20
            anchors.top: row2.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Label {
                id: label
                height: 20
                font.pointSize: 10
                font.family: mvBoli.name
                font.styleName: "My MV Boli"
                text: qsTr("Not registered yet?")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
            }

            Button {
                height: 20
                contentItem: Text {
                    id:regBttnText
                    text:"Create an account"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                    color: "#ff69b4"
                    font.pointSize: 10
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                    font.underline: true
                }

                background: Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                }

                onPressed:  { regBttnText.color = "#dda0dd" }
                onReleased: { regBttnText.color = "#ff69b4" }
                onClicked:  { loginForm.accountCreate()     }
            }
        }

        Row {
            id: row4
            width: 240
            height: 20
            anchors.top: row3.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Button {
                id: forgotBttn
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true

                contentItem: Text {
                    id:forgotBttnText
                    text:"Forgot your password?"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "#ff69b4"
                    font.pointSize: 10
                    font.family: mvBoli.name
                    font.styleName: "My MV Boli"
                    font.underline: true
                }

                background: Rectangle {
                    color: "transparent"
                    radius: 5
                    anchors.fill: parent
                }

                onPressed:  { forgotBttnText.color = "#dda0dd" }
                onReleased: { forgotBttnText.color = "#ff69b4" }
                onClicked:  { loginForm.recoverRequest()       }
            }
        }
    }
}

/*##^##
Designer {
    D{i:37;anchors_height:20;anchors_width:240}D{i:46;anchors_height:20}
}
##^##*/
