import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common

Rectangle {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    Text {
        id: timeBlock
        anchors {
            verticalCenter: parent.verticalCenter
        }
        text: Qt.formatDateTime(clock.date, "hh:mm dd MMM, yyyy")
        color: Config.colFg
        font.family: Config.fontFamily
        font.pixelSize: Config.fontSize
        Component.onCompleted: {
            parent.width = timeBlock.contentWidth
        }
    }
}
