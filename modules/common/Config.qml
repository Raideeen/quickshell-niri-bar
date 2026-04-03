pragma Singleton
import Quickshell
import QtQuick

Singleton {
  // Bar
  readonly property int barSize                : 30
  readonly property int barMarginTop           : 10

  // Colors 
  readonly property color colBg                : "#141414"
  readonly property color colFg                : "#BAB7B6"

  readonly property color colBlack             : "#000000"
  readonly property color colRed               : "#CF494C"
  readonly property color colGreen             : "#60B442"
  readonly property color colYellow            : "#DB9C11"
  readonly property color colBlue              : "#0575D8"
  readonly property color colMagenta           : "#AF5ED2"
  readonly property color colCyan              : "#1DB6BB"
  readonly property color colWhite             : "#BAB7B6"

  readonly property color colBrightBlack       : "#817E7E"
  readonly property color colBrightRed         : "#FF643B"
  readonly property color colBrightGreen       : "#37E57B"
  readonly property color colBrightYellow      : "#FCCD1A"
  readonly property color colBrightBlue        : "#688DFD"
  readonly property color colBrightMagenta     : "#ED6FE9"
  readonly property color colBrightCyan        : "#32E0FB"
  readonly property color colBrightWhite       : "#DEE3E4"

  readonly property color colMuted             : "#979797"

  // Fonts
  readonly property string fontFamily          : "JetBrainsMono Nerd Font"
  readonly property real fontSize              : 14

  readonly property string fontFamilyMono      : "Monospace"
  readonly property real fontSizeMono          : 14

  // CPU Module Configuration
  property int cpuNumTopProcesses              : 5
  property real cpuUpdateInterval              : 1000 // Milliseconds
  property real cpuScale                       : 1

  property bool cpuIconEnabled                 : true
  property real cpuIconScale                   : 0.85
  property color cpuIconColor                  : colFg

  property bool cpuQuickIndicatorEnabled       : true

  property bool cpuGraphEnabled                : true
  property int  cpuCoreCanvasHeight            : 10
  property real cpuGraphHistory                : 30 // Seconds
  property color cpuGraphLineColor             : colFg
  property color cpuGraphLowUsageColor         : colBrightBlue
  property color cpuGraphHighUsageColor        : colBrightRed

  // RAM Module Configuration
  property real ramScale                       : 1
  property real ramUpdateInterval              : 1000  // Milliseconds
  property int ramNumTopProcesses              : 5
  property string ramSizeUnit                  : "GiB"

  property bool ramIconEnabled                 : true
  property real ramIconScale                   : 1
  property color ramIconColor                  : colFg

  property bool ramQuickIndicatorEnabled       : true

  property bool ramGraphEnabled                : false

  property color ramMenuUsedColor              : colBrightBlue
  property color ramMenuSharedColor            : colBlue
  property color ramMenuBuffersCachedColor     : colMagenta
  property color ramMenuFreeColor              : colWhite
}
