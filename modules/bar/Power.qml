import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.modules.icons
import qs.modules.icons.power
import qs.modules.common
import qs.modules.widgets

Item {
  id: root

  implicitWidth: {
    let w = 0;
    let visibleCount = 0;
    if (shutdownButtonBar.visible) { w+= shutdownButtonBar.implicitWidth; visibleCount++ }
    return w;
  }
  implicitHeight: Config.barContentHeight

  Process { id: shutdownProc}
  Process { id: restartProc }
  Process { id: sleepProc }

  function shutdown(): void {
    shutdownProc.exec(["systemctl", "poweroff"])
  }

  function restart(): void {
    restartProc.exec(["systemctl", "reboot"])
  }

  function sleep(): void {
    sleepProc.exec(["systemctl", "sleep"])
  }

  PowerButton {
    id: shutdownButtonBar
    anchors.verticalCenter: parent.verticalCenter
    iconComponent: Component {
      PowerIcon {
        id: icon
        visible: Config.powerIconEnabled
        color: Config.powerIconColor
        scale: Config.powerIconScale * root.height
      }
    }
    hoverColor: Config.colRed
  }

  ToggleWindow {
    anchors.centerIn: shutdownButtonBar
    hoverTarget: shutdownButtonBar
    contentComponent: Component {
      ColumnLayout {
        spacing: 8
        PowerButton {
          id: shutdownButton
          iconComponent: Component {
            PowerIcon {
              id: icon1
              visible: Config.powerIconEnabled
              color: Config.powerIconColor
              scale: Config.powerIconScale * root.height
            }
          }
          clickAction: root.shutdown
          hoverColor: Config.colRed
        }

        PowerButton {
          id: restartButton
          iconComponent: Component {
            RestartIcon {
              id: icon2
              visible: Config.powerIconEnabled
              color: Config.powerIconColor
              scale: Config.powerIconScale * root.height
            }
          }
          clickAction: root.restart
          hoverColor: Config.colYellow
        }

        PowerButton {
          id: sleepButton
          iconComponent: Component {
            SleepIcon {
              id: icon3
              visible: Config.powerIconEnabled
              color: Config.powerIconColor
              scale: Config.powerIconScale * root.height
            }
          }
          clickAction: root.sleep
          hoverColor: Config.colBlue
        }
      }
    }
  }
}
