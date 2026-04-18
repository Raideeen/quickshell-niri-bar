import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common

PanelWindow {
  id: bar
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: Config.barSize

  margins {
    top: Config.barMarginTop
    left: Config.barMarginLeft
    right: Config.barMarginRight
  }

  Rectangle {
    anchors.fill: parent
    color: Config.colBg
    // left
    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
        leftMargin: Config.barPaddingLeft
      }
    }

    // center
    RowLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      // Focused Window
      FocusedWindow {
        Layout.maximumWidth: 400
      }
    }

    // right
    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: Config.barPaddingRight
      }
      spacing: Config.barModuleSpacing

      Loader { active: true; sourceComponent: Sound       {} }
      Loader { active: true; sourceComponent: Spacer      {} }
      Loader { active: true; sourceComponent: CPU         {} }
      Loader { active: true; sourceComponent: Spacer      {} }
      Loader { active: true; sourceComponent: RAM         {} }
      Loader { active: true; sourceComponent: Spacer      {} }
      Loader { active: true; sourceComponent: SystemTray  {} }
      Loader { active: true; sourceComponent: Spacer      {} }
      Loader { active: true; sourceComponent: Time        {} }
      Loader { active: true; sourceComponent: Spacer      {} }
      Loader { active: true; sourceComponent: Power       {} }
    }
  }
}
