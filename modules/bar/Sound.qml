import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import qs.modules.common
import qs.modules.icons
import qs.modules.widgets

Item {
  id: root

  property var lastSink: null

  Connections {
    target: Pipewire
    function onDefaultAudioSinkChanged() {
      if (Pipewire.defaultAudioSink) lastSink = Pipewire.defaultAudioSink
    }
  }

  readonly property var sink: Pipewire.defaultAudioSink ?? lastSink

  implicitWidth: (Config.soundIconEnabled ? icon.width : 0)+ fm.boundingRect("100%").width + iconLayout.spacing
  implicitHeight: Config.barContentHeight

  PwObjectTracker {
    objects: [root.sink]
  }

  Timer {
    id: volumeWheelTimer
    interval: 30
  }

  Process { id: soundPanelProc }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: soundPanelProc.exec(["pwvucontrol"])
    onWheel: (event) => {
      if (!root.sink || !root.sink.audio) return
      if (volumeWheelTimer.running) return
      const delta = event.angleDelta.y > 0 ? 0.02 : -0.02
      root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta))
      volumeWheelTimer.start()
    }
  }

  RowLayout {
    id: iconLayout
    anchors.fill: parent
    spacing: 8

    SpeakerIcon {
      id: icon
      visible: Config.soundIconEnabled
      color: Config.soundIconColor
      scale: Config.soundIconScale * root.height
      Layout.alignment: Qt.AlignHCenter
    }

    FontMetrics {
      id: fm
      font: text.font
    }

    Text {
      id: text
      color: Config.colFg
      Layout.preferredWidth: fm.boundingRect("100%").width
      text: {
        const vol = root.sink?.audio?.volume
        return isNaN(vol) || vol === undefined ? "..." : Math.round(vol * 100) + "%"
      }
    }
  }
}
