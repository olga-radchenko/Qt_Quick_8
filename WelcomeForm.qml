import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: welcomeForm
    width: 320
    height: 180

    signal logout()

    state:"Invisible"

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: welcomeForm; opacity: 1.0}
            PropertyChanges{target: welcomeForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: welcomeForm; opacity: 0.0}
            PropertyChanges{target: welcomeForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation{

               NumberAnimation {
                   target: welcomeForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: welcomeForm
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
                    target: welcomeForm
                    duration: 1000
                }
                NumberAnimation {
                   target: welcomeForm
                   property: "visible"
                   duration: 0
               }
                NumberAnimation {
                   target: welcomeForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    Column {
        id: mainColumn
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent

        Row {
            id: row1
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            Label {
                id: label
                text: `Hello, ${userName}!`
                anchors.fill: parent
                font.italic: false
                font.weight: Font.Thin
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font.pointSize: 24
                font.family: "MV Boli"
            }
        }

        Row {
            id: row2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
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
                onClicked:  { welcomeForm.logout() }
            }
        }
    }
}

/*##^##
Designer {
    D{i:16;anchors_height:100;anchors_width:100;anchors_x:80;anchors_y:40}
}
##^##*/
