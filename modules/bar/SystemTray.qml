// @ pragma UseQApplication
// @ pragma IconTheme Papirus-Light
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray


Row {
    spacing: 5

    Repeater {
        model: SystemTray.items

        Item {
            width: 24
            height: 24
            Image {
                id: trayIcon
                source: modelData.icon
                width: 24
                height: 24
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        modelData.activate();
                    } else {
                        trayMenu.anchor.rect.x = mouseX, trayMenu.anchor.rect.y = mouseY, trayMenu.open();
                    }
                }

                QsMenuAnchor {
                    id: trayMenu
                    anchor.item: trayIcon
                    menu: modelData.menu
                }
            }
        }
    }
}
