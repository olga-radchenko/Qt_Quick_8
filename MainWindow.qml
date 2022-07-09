import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Window {
    id: root
    width: 320
    height: 480
    visible: true

    property string userName:""
    property ListModel loginList: LoginListModel {}

    Item {

        anchors.fill: parent

        Timer {
            id: timer
            interval : 1000
            repeat:false;
        }

        LinearGradient {
           id: gradient
           start: Qt.point(50, 0)
           end: Qt.point(100, 480)
           anchors.fill: parent
           gradient: Gradient {
                GradientStop { position: 0.0; color: "#87ceeb" }
                GradientStop { position: 0.5; color: "#dda0dd" }
                GradientStop { position: 1.0; color: "#ff69b4" }
           }
           opacity: 0.6
        }
        Column {
            id:mainView
            spacing: 5
            width: root.width
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: logoPic
                width: 100
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/LogoPic/logo.png"
                Layout.alignment: Qt.AlignHCenter

                state: "Visible"
                states: [
                    State{
                        name: "Visible"
                        PropertyChanges{target: logoPic; opacity: 1.0}
                        PropertyChanges{target: logoPic; visible: true}
                    },
                    State{
                        name:"Invisible"
                        PropertyChanges{target: logoPic; opacity: 0.0}
                        PropertyChanges{target: logoPic; visible: false}
                    }
                ]

                transitions: [
                    Transition {
                        from: "Visible"
                        to: "Invisible"

                        SequentialAnimation {
                           NumberAnimation {
                               target: logoPic
                               property: "opacity"
                               duration: 1000
                               easing.type: Easing.InOutQuad
                           }
                           NumberAnimation {
                               target: logoPic
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
                                target: logoPic
                                duration: 1000
                            }
                            NumberAnimation {
                               target: logoPic
                               property: "visible"
                               duration: 0
                            }
                            NumberAnimation {
                               target: logoPic
                               property: "opacity"
                               duration: 1000
                               easing.type: Easing.InOutQuad
                            }
                        }
                    }
                ]
            }

            state : "loginForm"
            states: [
                State {
                    name: "loginForm"
                    PropertyChanges { target: loader;  source: "LoginForm.qml" }
                },
                State {
                    name: "accountCreate"
                    PropertyChanges { target: loader;  source:  "RegistrationForm.qml"}
                },
                State {
                    name: "loginSuccess"
                    PropertyChanges { target: loader;  source: "WelcomeForm.qml"}
                    PropertyChanges { target: logoPic;  state: "Invisible" }
                },
                State {
                    name: "recoverRequest"
                    PropertyChanges { target: loader;  source:  "PswRecoverForm.qml"}
                }
            ]

            Loader {
                id: loader
                anchors.top: parent.top
                anchors.topMargin: 100
                asynchronous: true
                anchors.horizontalCenter: parent.horizontalCenter
                onStatusChanged: if (loader.status == Loader.Ready) loader.item.state = "Visible"
            }

            Connections {
                target: loader.item

                function onLoginSuccess(login) {
                    loader.item.state = "Invisible"
                    delay(1000,function() {userName = login; mainView.state = "loginSuccess"})
                }

                function onAccountCreate() {
                    loader.item.state = "Invisible"
                    delay( 1000, function() { mainView.state = "accountCreate"} );
                }

                function onRecoverRequest() {
                    loader.item.state = "Invisible"
                    delay(1000,function() { mainView.state = "recoverRequest"})
                }
                function onBack() {
                    loader.item.state = "Invisible"
                    delay(1000,function() {mainView.state = "loginForm"})
                }

                function onRegistrationSuccess() {
                    loader.item.state = "Invisible"
                    delay(1000,function() {mainView.state = "loginForm"})
                }
                function onLogout() {
                    loader.item.state = "Invisible"
                    delay(1000,function() {mainView.state = "loginForm"})
                }
            }
        }
    }

    function printUserRegisteredData(id) {
        console.log("Email:",loginList.get(id).email)
        console.log("Username:",loginList.get(id).username)
        console.log("Password:",loginList.get(id).password)
    }

    function findNamePswdCombination(username, password) {
        for(var i = 0; i < loginList.count; ++i) {
            if ((loginList.get(i).username === username) && (loginList.get(i).password === password))
            {
              return i
            }
        }
        return -1
    }

    function findEmail(email) {
        for(var i = 0; i < loginList.count; ++i) {
            if (loginList.get(i).email === email)
            {
              return i
            }
        }
        return -1
    }

    function findName(name) {
        for(var i = 0; i < loginList.count; ++i) {
            if (loginList.get(i).username === name)
            {
              return i
            }
        }
        return -1
    }

    function delay(delayTime, cb) {
        timer.triggered.connect(cb);
        timer.start();
    }
}
