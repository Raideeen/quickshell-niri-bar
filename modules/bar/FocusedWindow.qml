import Quickshell
import QtQuick
import qs.modules.common

Text {
  property int maxWidth: 400 // default value

  text: niri.focusedWindow?.title ?? ""
  font.family: Config.fontFamily
  font.pixelSize: Config.fontSize
  color: Config.colFg

  // Trim text that is too long
  width: maxWidth
  elide: Text.ElideRight
}
