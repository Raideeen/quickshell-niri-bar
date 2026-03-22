import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.icons
import qs.modules.utils
import qs.modules.widgets
import qs.services

Item {
    id: root

    property real scale: Config.ramScale || 1.0

    implicitWidth: (icon.visible ? icon.width : 0)
        + (graph.visible ? graph.width : 0) + 4
    implicitHeight: Config.barSize - Config.barSize * 0.2

    RAMIcon {
        id: icon
        visible: Config.ramIconEnabled
        color: Config.ramIconColor
        scale: Config.ramIconScale * root.height
        anchors.verticalCenter: parent.verticalCenter
    }

    Canvas {
        id: graph
        visible: Config.ramGraphEnabled
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        width: 100 * root.scale

        onPaint: {
            if (RAM.total === 0) return;

            let ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            let usedRatio = RAM.used / RAM.total;
            let sharedRatio = RAM.shared / RAM.total;
            let buffersCachedRatio = (RAM.buffers + RAM.cached + RAM.sreclaimable) / RAM.total;
            let freeRatio = RAM.free / RAM.total;

            // Clamp small ratios to minimum visible width
            let minVisible = 1 / width;
            usedRatio = Math.max(usedRatio, minVisible);
            sharedRatio = Math.max(sharedRatio, minVisible);
            buffersCachedRatio = Math.max(buffersCachedRatio, minVisible);
            freeRatio = Math.max(freeRatio, minVisible);

            let cumulativeX = 0;

            // Draw segments from left to right
            if (usedRatio > 0) {
                ctx.fillStyle = Config.ramMenuUsedColor;
                ctx.fillRect(cumulativeX, 0, usedRatio * width, height);
                cumulativeX += usedRatio * width;
            }
            if (sharedRatio > 0) {
                ctx.fillStyle = Config.ramMenuSharedColor;
                ctx.fillRect(cumulativeX, 0, sharedRatio * width, height);
                cumulativeX += sharedRatio * width;
            }
            if (buffersCachedRatio > 0) {
                ctx.fillStyle = Config.ramMenuBuffersCachedColor;
                ctx.fillRect(cumulativeX, 0, buffersCachedRatio * width, height);
                cumulativeX += buffersCachedRatio * width;
            }
            if (freeRatio > 0) {
                ctx.fillStyle = Config.MenuFreeColor;
                ctx.fillRect(cumulativeX, 0, freeRatio * width, height);
            }
        }
    }

    Connections {
        target: RAM
        function onStatsUpdated() {
            graph.requestPaint()
        }
    }

    HoverPopup {
        anchors.centerIn: root
        hoverTarget: root
        contentComponent: Component {
            ColumnLayout {
                id: contentColumn
                spacing: 2

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "RAM Usage"
                    font.family: Config.fontFamily
                    font.pixelSize: Config.fontSize
                    font.bold: true
                    color: Config.colFg
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    font.family: Config.fontFamily
                    font.pixelSize: Config.fontSize
                    color: Config.colFg
                    textFormat: Text.RichText

                    text: {
                        let rows = [
                            {
                                label: "Total",
                                source: ['total'],
                                color: Config.colFg,
                            },
                            {
                                label: "Used",
                                source: ['used'],
                                color: Config.ramMenuUsedColor,
                            },
                            {
                                label: "Shared",
                                source: ['shared'],
                                color: Config.ramMenuSharedColor,
                            },
                            {
                                label: "Buff/Cache",
                                source: ['buffers', 'cached', 'sreclaimable'],
                                color: Config.ramMenuBuffersCachedColor,
                            },
                            {
                                label: "Free",
                                source: ['free'],
                                color: Config.ramMenuFreeColor,
                            },
                            {
                                label: "Available",
                                source: ['available'],
                                color: Config.colFg,
                            },
                        ];

                        let total = FileUtils.convertSizeUnit(RAM.total, "KiB", Config.ramSizeUnit);

                        for (let i = 0; i < rows.length; ++i) {
                            let val = 0.0;
                            for (let j = 0; j < rows[i].source.length; ++j) {
                                val += RAM[rows[i].source[j]];
                            }
                            if (rows[i].label === 'Total') {
                                rows[i].value = total;
                            } else {
                                rows[i].value = FileUtils.convertSizeUnit(val, "KiB", Config.ramSizeUnit);
                                rows[i].pct = (rows[i].value / total)*100;
                            }
                        }

                        let createRow = function(rowData) {
                            return `
<tr>
  <td align="left" width="60"><span style="color: ${rowData.color}">${rowData.label}</span>:</td>
  <td align="right" width="70"><span style="font-family: '${Config.fontFamilyMono}'; font-size: ${Config.fontSizeMono}px;">${rowData.value.toFixed(2)}${Config.ramSizeUnit}</span></td>
  <td align="right" width="60"><span style="font-family: '${Config.fontFamilyMono}'; font-size: ${Config.fontSizeMono}px;">${typeof rowData.pct !== 'undefined' ? rowData.pct.toFixed(2) + "%" : ""}</span></td>
</tr>`;
                        };

                        return `<table>${rows.map(r => createRow(r)).join("")}</table>`;
                    }
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Top Processes"
                    font.family: Config.fontFamily
                    font.pixelSize: Config.fontSize
                    font.bold: true
                    color: Config.colFg
                    Layout.topMargin: 6
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    font.family: Config.fontFamilyMono
                    font.pixelSize: Config.fontSizeMono
                    color: Config.colFg
                    text: {
                        let out = [];
                        for (let p of RAM.topProcesses) {
                            let pidStr = p.pid.toString().padStart(6);
                            let commStr = p.comm.slice(0, 15).padEnd(15);
                            let memStr = `${p.mem.toFixed(1)}%`;
                            out.push(`${pidStr} ${commStr}\t${memStr.padStart(6)}`);
                        }
                        return out.join("\n");
                    }
                }
            }
        }
    }
}
