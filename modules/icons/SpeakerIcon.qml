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
      fillColor: root.color
      strokeColor: "transparent"
      PathSvg { path: "M56,96v64a8,8,0,0,1-16,0V96a8,8,0,0,1,16,0ZM88,24a8,8,0,0,0-8,8V224a8,8,0,0,0,16,0V32A8,8,0,0,0,88,24Zm40,32a8,8,0,0,0-8,8V192a8,8,0,0,0,16,0V64A8,8,0,0,0,128,56Zm40,32a8,8,0,0,0-8,8v64a8,8,0,0,0,16,0V96A8,8,0,0,0,168,88Zm40-16a8,8,0,0,0-8,8v96a8,8,0,0,0,16,0V80A8,8,0,0,0,208,72Z" }
    }
  }
}
