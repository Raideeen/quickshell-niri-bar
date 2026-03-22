import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
  property int memUsed: 0
  property int memTotal: 0

  property int memUsage: 0

  // Memory process
  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used/total)

        memUsed = used
        memTotal = total
      }
    }
    Component.onCompleted: running = true
  }

  // Timer to get memory periodically
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      memProc.running = true
    }
  }

  // Memory
  Text {
    id: memBlock
    anchors {
        verticalCenter: parent.verticalCenter
    }
    text: "Mem: " + memUsage + "% "
    color: Theme.colCyan
    font {
        family: Theme.fontFamily
        pixelSize: Theme.fontSize
        bold: true
    }
    Component.onCompleted: {
        parent.width = memBlock.contentWidth
    }
  }
}
