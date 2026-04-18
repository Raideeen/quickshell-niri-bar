import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common

Item {
  id: root

  implicitWidth: {
    let w = 0;
    let visibleCount = 0;
    if (rowLayout.visible) { w+= rowLayout.implicitWidth; visibleCount++ }
    return w;
  }
  implicitHeight: Config.barContentHeight

  RowLayout {
    id: rowLayout
    anchors.fill: parent
    spacing: 6

    Repeater {
      model: SystemTray.items

      MouseArea {
        id: trayItem
        property SystemTrayItem item: modelData
        implicitWidth: Config.trayIconSize
        implicitHeight: Config.trayIconSize

        acceptedButtons: Qt.LeftButtons | Qt.RightButton

        onClicked: event => {
          if (event.button === Qt.LeftButton) {
            modelData.activate();
          } else {
            trayMenu.anchor.rect.x = mouseX,
            trayMenu.anchor.rect.y = mouseY,
            trayMenu.open();
          }
        }

        IconImage {
          id: trayIcon
          source: trayItem.item.icon
          anchors.centerIn: parent
          width: parent.width
          height: parent.height
          visible: false
        }

        QsMenuAnchor {
          id: trayMenu
          menu: trayItem.item.menu
          anchor.item: trayIcon
        }

        HoverHandler {
          id: mouse
          acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
          cursorShape: Qt.PointingHandCursor
        }

        Loader {
          anchors.fill: trayIcon
          sourceComponent: MultiEffect {
            source: trayIcon
            opacity: mouse.hovered || trayMenu.visible ? 1 : 0.8
            blurEnabled: false
            shadowEnabled: true
          }
        }
      }
    }
  }

}
