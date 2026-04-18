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
      PathSvg { path: "M176,56c24.08,15.7,40,41.11,40,72a88,88,0,0,1-176,0c0-30.89,15.92-56.3,40-72 M128,24 L128,128" }
    }
  }
}
