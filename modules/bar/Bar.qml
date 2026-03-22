import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    margins {
      top: 10
      left: 25
      right: 25
    }

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.colBg 
        // left
        RowLayout {
            anchors {
                left: parent.left
                leftMargin: 25
            }
            // Loader { active: true; sourceComponent: Workspaces {} }
        }

        // center
        RowLayout {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Text {
                text: niri.focusedWindow?.title ?? ""
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                color: Theme.colFg

                // Trim text that is too long
                Layout.maximumWidth: 400
                elide: Text.ElideRight
              }
        }

        // right
        RowLayout {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 25
            }
            spacing: 10
            // Loader { active: true; sourceComponent: SystemTray {} }
            Loader { active: true; sourceComponent: Spacer {} }
            Loader { active: true; sourceComponent: Memory {} }
            Loader { active: true; sourceComponent: Spacer {} }
            Loader { active: true; sourceComponent: Time {} }
        }
    }
}
