import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Config.barSize

    margins {
      top: 10
      left: 25
      right: 25
    }

    Rectangle {
        anchors.fill: parent
        color: Config.colBg 
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

            // Focused Window
            FocusedWindow {
              Layout.maximumWidth: 400
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

            Loader { active: true; sourceComponent: RAM {} }
            Loader { active: true; sourceComponent: Spacer {} }
            Loader { active: true; sourceComponent: Time {} }
        }
    }
}
