import QtQuick
import QtQuick.Shapes
import Quickshell

Item {
  id: root
  property real scale: 1
  property color color: "white"

  width: scale
  height: scale

  // Icon from Phosphor by Phosphor Icons
  // https://github.com/phosphor-icons/core/blob/main/LICENSE

  Shape {
    anchors.centerIn: parent
    width: root.width
    height: root.height
    preferredRendererType: Shape.CurveRenderer
    fillMode: Shape.PreserveAspectFit
    transformOrigin: Item.TopLeft

    ShapePath {
      fillColor: "transparent"
      strokeColor: root.color
      strokeWidth: 16
      PathSvg { path: "M108.11,28.11A96.09,96.09,0,0,0,227.89,147.89,96,96,0,1,1,108.11,28.11Z" }
    }
  }
}
