import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: root
  width: Screen.width
  height: Screen.height

  Image {
    source: "assets/background.jpg"
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
    onStatusChanged: if (status !== Image.Ready) source = "assets/background-alt.jpg"
  }

  Pane {
    id: loginform
    width: 480
    height: 360

    anchors {
      right: parent.right
      bottom: parent.bottom
      rightMargin: 32
      bottomMargin: 32
    }

    background: Rectangle {
      color: "#1D202F40"
      border.color: "#A9B1D6"
    }

    Column {
      anchors.centerIn: parent
      spacing: 32

      TextField { 
        id: username
        width: 360
        placeholderText: "Username"
        placeholderTextColor: "#A9B1D6"
        font.pixelSize: 16
        color: "#C0CAF5"
        padding: 8
        focus: true
        Component.onCompleted: forceActiveFocus()

        background: Rectangle {
          color: "transparent"
          border.color: "#A9B1D6"
          border.width: 1
        }
      }

      TextField {
        id: password
        width: 360
        placeholderText: "Password"
        placeholderTextColor: "#A9B1D6"
        echoMode: TextInput.Password
        font.pixelSize: 16
        color: "#A9B1D6"
        padding: 8

        background: Rectangle {
          color: "transparent"
          border.color: "#A9B1D6"
          border.width: 1
        }

        onAccepted: loginButton.clicked()
      }

      Button {
        id: loginButton
        width: 120
        padding: 4
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Login"
        font.pixelSize: 16

        background: Rectangle {
          id: buttonBackground
          color: "transparent"
          border.color: "#A9B1D6"
          border.width: 1
        }

        contentItem: Text {
          text: loginButton.text
          font: loginButton.font
          color: "#A9B1D6"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        states: [
          State {
            name: "hovered"
            when: loginButton.hovered
            PropertyChanges {
              target: buttonBackground
              color: "#1D202F"
            }
          }
        ]

        transitions: Transition {
          PropertyAnimation {
            properties: "color"
            duration: 250
          }
        }

        onClicked: sddm.login(username.text, password.text, sessionModel)
      }
    }
  }

  Connections {
    target: sddm
    function onLoginFailed() {
      password.text = ""
      password.focus = true
    }
  }
}
