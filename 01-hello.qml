//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Light
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray

ShellRoot {
    // Repeat the bar on all the screens.
    // The "model" represents the screen (e.g. monitor) that has to have a bar on it
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            // Theme
            property color colBg: "#141414"
            property color colFg: "#a9b1d6"
            property color colMuted: "#444b6a"
            property color colCyan: "#0db9d7"
            property color colBlue: "#7aa2f7"
            property color colYellow: "#e0af68"
            property string fontFamily: "JetBrainsMono Nerd Font"
            property int fontSize: 14
            property var colors: ["red", "green", "blue", "yellow", "cyan"]

            // System data
            property int cpuUsage: 0
            property int memUsage: 0
            property var lastCpuIdle: 0
            property var lastCpuTotal: 0

            // Processes and timers here...

            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: 40
            margins.top: 10
            margins.left: 25
            margins.right: 25
            color: root.colBg

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                // Clock
                Text {
                    id: clock
                    color: root.colBlue
                    font {
                        family: root.fontFamily
                        pixelSize: root.fontSize
                        bold: true
                    }
                    text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
                    anchors.centerIn: parent
                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                // CPU
                Text {
                    text: "CPU: " + cpuUsage + "%"
                    color: root.colYellow
                    font {
                        family: root.fontFamily
                        pixelSize: root.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    width: 1
                    height: 16
                    color: root.colMuted
                }

                // Memory
                Text {
                    text: "Mem: " + memUsage + "%"
                    color: root.colCyan
                    font {
                        family: root.fontFamily
                        pixelSize: root.fontSize
                        bold: true
                    }
                }

                Rectangle {
                    width: 1
                    height: 16
                    color: root.colMuted
                }


                Rectangle {
                    width: 1
                    height: 16
                    color: root.colMuted
                }

                Row {
                    spacing: 8

                    Repeater {
                        model: colors // Number of rectangles that will be created

                        Rectangle {
                            width: 80
                            height: 10
                            color: modelData
                        }
                    }
                }
            }
        }
    }
}
