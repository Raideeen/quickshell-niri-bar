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
      PathSvg { path: "M67.59,192A88,88,0,1,0,65.77,65.77L24,104 M24,56 L24,104 L72,104" }
    }
  }
}
