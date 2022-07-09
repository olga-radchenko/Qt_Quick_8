import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: pswRecoverForm
    width: 260
    height: 180

    property int current_x: mainRect.x

    signal recovered()
    signal back()

    FontLoader
    {
        id: mvBoli ;
        source: "mvboli.ttf"
    }

    state:"Invisible"

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: pswRecoverForm; opacity: 1.0}
            PropertyChanges{target: pswRecoverForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: pswRecoverForm; opacity: 0.0}
            PropertyChanges{target: pswRecoverForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation {
               NumberAnimation {
                   target: pswRecoverForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: pswRecoverForm
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
                    target: pswRecoverForm
                    duration: 1000
                }
                NumberAnimation {
                   target: pswRecoverForm
                   property: "visible"
                   duration: 0
                }
                NumberAnimation {
                   target: pswRecoverForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    Rectangle {
        id:mainRect
        Layout.alignment: Qt.AlignHCenter
        width: parent.width
        height: parent.height
        color: "white"
        radius: 10
        opacity: 0.5

        ParallelAnimation {
            id: failAnimation
            SequentialAnimation {
                PropertyAnimation {
                    targets: [ oldUsrMailLabel ]
                    property: "color"
                    to: "red"
                    duration: 400
                }
                PropertyAnimation {
                    targets: [ oldUsrMailLabel ]
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
                "x"; to: current_x; duration: 50 }
            }
        }
    }

    Column {
        id:mainColumn
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        Row {
            id: row1
            width: 240
            height: 26
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.alignment: Qt.AlignHCenter
            Label {
                id:oldUsrMailLabel
                text:"Enter username or registration email:"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                font.family: mvBoli.name
                font.styleName: "MV Boli"
            }
        }

        Row {
            id: row2
            width: 240
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            TextField {
                id:oldUsrField;
                width: 240
                height: 26
                font.pointSize: 9
                font.family: "MV Boli"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "white"
                    opacity: 0.9
                    radius: 10
                }
                onAccepted: acceptBttn.clicked()
            }
        }

        Row {
            id: row3
            width: 240
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true

            Label {
                id:sendNewPswdLabel
                text:'<font>If this user exists, we have sent you a password reset on <del>Email</del> console </font> :)'
                anchors.fill: parent
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                font.family: mvBoli.name
                font.styleName: "MV Boli"
                opacity: 0
                states: [
                    State {
                    name: "labelInvisible"
                    PropertyChanges { target: sendNewPswdLabel; opacity: 0 }},

                    State {
                    name: "labelVisible"
                    PropertyChanges { target: sendNewPswdLabel; opacity: 1 }}
                ]

                transitions: [
                    Transition {
                    to: "labelVisible";
                    NumberAnimation { property: "opacity"; duration: 1000 }},
                    Transition {
                    to: "labelInvisible";
                    NumberAnimation { property: "opacity"; duration: 1 }} ]
                }
            }

        Row {
            id: row4
            width: 240
            height: 20
            spacing: 15
            anchors.top: parent.top
            anchors.topMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                id:acceptBttn
                width: 175
                height: 20
                text: "Change password"
                font.pointSize: 10
                font.family: mvBoli.name
                font.styleName: "MV Boli"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                background: Rectangle {
                    id:acceptBttnRect
                    color: "#ff69b4"
                    opacity: 0.7
                    radius: 5
                    anchors.fill: parent
                }

                onPressed: {
                    acceptBttnRect.color = "#dda0dd"
                }

                onReleased: {
                    acceptBttnRect.color = "#ff69b4"
                }

                onClicked: {
                    if(oldUsrField.text == "") { failAnimation.start() }
                    else {
                        if(findEmail(oldUsrField.text) !== -1) {
                            printUserRegisteredData(findEmail(oldUsrField.text))
                        }
                        else if(findName(oldUsrField.text) !== -1) {
                            printUserRegisteredData(findName(oldUsrField.text))
                        }
                        sendNewPswdLabel.state = "labelVisible"
                    }
                }
            }
            Button {
                width: 50
                height: 20
                text: "Back"
                font.pointSize: 10
                font.family: mvBoli.name
                font.styleName: "MV Boli"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                background: Rectangle {
                    id:backBttnRect
                    color: "#ff69b4"
                    opacity: 0.7
                    radius: 5
                    anchors.fill: parent
                }
                onPressed:  { backBttnRect.color = "#dda0dd" }
                onReleased: { backBttnRect.color = "#ff69b4" }
                onClicked:  { pswRecoverForm.back()}
            }
        }
    }
}

/*##^##
Designer {
    D{i:33;anchors_height:40;anchors_width:240}
}
##^##*/
