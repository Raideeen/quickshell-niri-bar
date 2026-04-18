import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.common

Item {
  id: root
  implicitWidth: iconLoader.item ? iconLoader.item.width : 0
  implicitHeight: iconLoader.item ? iconLoader.item.height : 0

  property Component iconComponent   : null;
  property var clickAction           : null;
  property color hoverColor          : Config.colBlue;

  MouseArea {
    anchors.fill: parent;
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: if(clickAction) clickAction()
    onEntered: if(iconLoader.item) iconLoader.item.color = hoverColor;
    onExited: if(iconLoader.item) iconLoader.item.color = Config.powerIconColor
  }

  Loader {
    id: iconLoader
    sourceComponent: root.iconComponent
  }
}
