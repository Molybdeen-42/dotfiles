import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls
import "../widgets"
import "../widgets/data"
import "../../themes"

// The standard minimalistic bar
Scope {
    property bool isExpanded: true

    Variants {
        model: Quickshell.screens

        Scope {
            id: screenBorder
        
            required property var modelData
            readonly property int topThickness: 30
            readonly property int edgeThickness: 6
            readonly property int radius: 5
            readonly property int borderThickness: 1
            readonly property int slantDistance: 6
            readonly property int interTabDistance: 20

            readonly property int shadowThickness: 4
            readonly property int cornerShadowModifier: 13
            readonly property color shadowColor: Theme.border
            readonly property color shadowEdge: "transparent"

            readonly property int wsWidth: 24
            readonly property int wsWidthExtend: 6 // Extends the active workspace in the workspace widget. Must be an even number!
            
            readonly property int chevronWidth: 14
            readonly property int itemSpacing: 8
            readonly property int iconSize: 12

            PanelWindow {
                screen: screenBorder.modelData
                color: "transparent"
                implicitHeight: topThickness
                exclusiveZone: topThickness - 7

                anchors {
                    left: true
                    top: true
                    right: true
                }

                Item {
                    anchors.fill: parent

                    Row {
                        id: leftRow
                        spacing: -slantDistance

                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: clockShape.left
                            rightMargin: interTabDistance + slantDistance
                        }

                        Repeater {
                            id: wsRepeater
                            model: (Hyprland.workspaces.values
                                .filter(ws => ws.monitor && ws.monitor.name === modelData.name)
                                .sort((x, y) => x.id - y.id)
                            )
                            

                            Shape {
                                id: wsShape

                                property bool isFirst: index === 0
                                property bool isLast: index === wsRepeater.count - 1
                                property bool isActive: modelData === Hyprland.focusedMonitor.activeWorkspace

                                width: wsWidth + (isActive ? wsWidthExtend : 0) + ((isFirst || isLast) ? radius : slantDistance) + slantDistance
                                implicitHeight: clockWidget.implicitHeight

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 500
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                ShapePath {
                                    fillColor: isActive ? Theme.accent : Theme.bg
                                    strokeColor: Theme.border
                                    strokeWidth: borderThickness

                                    startX: isFirst ? radius : 0
                                    startY: clockWidget.height

                                    PathLine {
                                        x: isLast ? wsShape.width - radius : wsShape.width - slantDistance
                                        y: clockWidget.height
                                    }

                                    PathArc {
                                        x: isLast ? wsShape.width - radius : wsShape.width
                                        y: 0
                                        radiusX: isLast ? radius : 0
                                        radiusY: isLast ? radius : 0
                                        direction: PathArc.Counterclockwise
                                    }

                                    PathLine {
                                        x: isFirst ? radius : slantDistance
                                        y: 0
                                    }

                                    PathArc {
                                        x: isFirst ? radius : 0
                                        y: clockWidget.height
                                        radiusX: isFirst ? radius : 0
                                        radiusY: isFirst ? radius : 0
                                        direction: PathArc.Counterclockwise
                                    }
                                }
                            }
                        }
                    }

                    Shape {
                        id: clockShape
                        anchors.centerIn: parent
                        implicitWidth: clockWidget.implicitWidth + (2 * radius)
                        implicitHeight: clockWidget.implicitHeight

                        ClockWidget {
                            id: clockWidget
                            anchors.centerIn: parent
                            rightPadding: radius + 5
                            leftPadding: radius
                        }

                        ShapePath {
                            fillColor: Theme.bg
                            strokeColor: Theme.border
                            strokeWidth: borderThickness

                            startX: radius
                            startY: clockWidget.height

                            PathLine {
                                x: clockWidget.width - radius
                                y: clockWidget.height
                            }

                            PathArc {
                                x: clockWidget.width - radius
                                y: 0
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }

                            PathLine {
                                x: radius
                                y: 0
                            }

                            PathArc {
                                x: radius
                                y: clockWidget.height
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }
                        }
                    }

                    Shape {
                        id: widgetShape
                        implicitHeight: clockWidget.implicitHeight
                        width: widgetRow.width + (2 * radius)

                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: clockShape.right
                            leftMargin: interTabDistance
                        }

                        Row {
                            id: widgetRow
                            anchors.centerIn: parent
                            spacing: 16
                            height: clockWidget.height

                            Item {
                                id: cpuTemp
                                width: cpuRow.width
                                height: parent.height

                                readonly property real temperature: Temperature.cpuTemperature

                                readonly property color cpuColor: {
                                    if (cpuTemp.temperature >= 80) return Theme.notify
                                    if (cpuTemp.temperature >= 65) return Theme.accentHover
                                    return Theme.widget
                                }

                                Row {
                                    id: cpuRow
                                    anchors.centerIn: parent
                                    spacing: 4

                                    Text {
                                        text: "\uf4bc"
                                        font.family: Theme.fontFamily
                                        font.pixelSize: Theme.fontSizeNormal
                                        color: cpuTemp.cpuColor
                                    }

                                    Text {
                                        text: Math.round(cpuTemp.temperature) + "°C"
                                        font.family: Theme.fontFamily
                                        font.pixelSize: Theme.fontSizeNormal
                                        color: cpuTemp.cpuColor
                                    }
                                }
                            }

                            Item {
                                id: battery
                                width: batteryRow.width
                                height: parent.height

                                readonly property var power: UPower.displayDevice

                                property string batteryIcon: {
                                    if (!power) return ""

                                    var pct = power.percentage * 100

                                    if (power.state === UPowerDeviceState.Charging ||
                                        power.state === UPowerDeviceState.FullyCharged) {
                                        if (Math.round(pct) === 100) return "󰁹"
                                        if (pct >= 90) return "󰂅"
                                        if (pct >= 80) return "󰂋"
                                        if (pct >= 70) return "󰂊"
                                        if (pct >= 60) return "󰢞"
                                        if (pct >= 50) return "󰂉"
                                        if (pct >= 40) return "󰢝"
                                        if (pct >= 30) return "󰂈"
                                        if (pct >= 20) return "󰂇"
                                        if (pct >= 10) return "󰂆"
                                        return "󰢜"
                                    }

                                    if (Math.round(pct) === 100) return "󰁹"
                                    if (pct >= 90) return "󰁹"
                                    if (pct >= 80) return "󰂂"
                                    if (pct >= 70) return "󰂁"
                                    if (pct >= 60) return "󰂀"
                                    if (pct >= 50) return "󰁿"
                                    if (pct >= 40) return "󰁾"
                                    if (pct >= 30) return "󰁽"
                                    if (pct >= 20) return "󰁼"
                                    if (pct >= 10) return "󰁻"
                                    return "󰁺"
                                }

                                readonly property color iconColor: {
                                    if (!battery.power) return Theme.widget
                                    if (Math.round(battery.power.percentage * 100) === 100) return Theme.widget
                                    if (battery.power.state === UPowerDeviceState.Charging) return Theme.positive
                                    if (battery.power.percentage * 100 <= 10) return Theme.notify
                                    if (battery.power.percentage * 100 <= 20) return Theme.warn
                                    return Theme.widget
                                }

                                Row {
                                    id: batteryRow
                                    anchors.centerIn: parent
                                    spacing: 4

                                    Text {
                                        text: battery.batteryIcon
                                        color: battery.iconColor
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Theme.fontFamily
                                    }

                                    Text {
                                        text: battery.power ? Math.round(battery.power.percentage * 100) + "%" : "N/A"
                                        color: battery.iconColor
                                        font.pixelSize: Theme.fontSizeNormal
                                    }
                                }
                            }
                        }

                        ShapePath {
                            fillColor: Theme.bg
                            strokeColor: Theme.border
                            strokeWidth: borderThickness

                            startX: radius
                            startY: clockWidget.height

                            PathLine {
                                x: widgetShape.width - radius
                                y: clockWidget.height
                            }

                            PathArc {
                                x: widgetShape.width - radius
                                y: 0
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }

                            PathLine {
                                x: radius
                                y: 0
                            }

                            PathArc {
                                x: radius
                                y: clockWidget.height
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }
                        }
                    }

                    Shape {
                        id: tray
                        implicitHeight: clockWidget.implicitHeight
                        height: clockWidget.height
                        width: chevronWidth + (isExpanded ? trayItems.implicitWidth : 0)

                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: widgetShape.right
                            leftMargin: interTabDistance / 2
                        }

                        Behavior on implicitWidth {
                            NumberAnimation {
                                duration: 220
                                easing.type: Easing.OutCubic
                            }
                        }

                        ShapePath {
                            fillColor: Theme.bg
                            strokeColor: Theme.border
                            strokeWidth: borderThickness

                            startX: radius
                            startY: tray.height

                            PathLine {
                                x: tray.width - radius
                                y: tray.height
                            }

                            PathArc {
                                x: tray.width - radius
                                y: 0
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }

                            PathLine {
                                x: radius
                                y: 0
                            }

                            PathArc {
                                x: radius
                                y: tray.height
                                radiusX: radius
                                radiusY: radius
                                direction: PathArc.Counterclockwise
                            }
                        }

                        Shape {
                            id: chevron
                            width: chevronWidth
                            height: tray.height

                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }

                            ShapePath {
                                fillColor: isExpanded ? Theme.accentHover : Theme.accent
                                strokeColor: Theme.border
                                strokeWidth: borderThickness

                                startX: radius
                                startY: tray.height

                                PathLine {
                                    x: chevron.width - radius
                                    y: tray.height
                                }

                                PathArc {
                                    x: chevron.width - radius
                                    y: 0
                                    radiusX: radius
                                    radiusY: radius
                                    direction: PathArc.Counterclockwise
                                }

                                PathLine {
                                    x: radius
                                    y: 0
                                }

                                PathArc {
                                    x: radius
                                    y: tray.height
                                    radiusX: radius
                                    radiusY: radius
                                    direction: PathArc.Counterclockwise
                                }
                            }

                            Text {
                                text: "❯"
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSizeNormal
                                anchors.centerIn: parent
                                color: Theme.widget
                                rotation: isExpanded ? 0 : 90

                                Behavior on rotation {
                                    NumberAnimation {
                                        duration: 220
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: isExpanded = !isExpanded
                            }
                        }

                        Row {
                            id: trayItems
                            spacing: itemSpacing
                            opacity: isExpanded ? 1 : 0
                            visible: opacity > 0.01
                            rightPadding: slantDistance * 2

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 180
                                }
                            }

                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: chevron.right
                                leftMargin: slantDistance
                            }

                            Repeater {
                                model: SystemTray.items

                                delegate: Item {
                                    id: trayItem
                                    width: iconSize
                                    height: iconSize
                                    required property var modelData

                                    Image {
                                        anchors.fill: parent
                                        source: trayItem.modelData.icon
                                        sourceSize.width: iconSize
                                        sourceSize.height: iconSize
                                        smooth: true
                                        asynchronous: true
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                        cursorShape: Qt.PointingHandCursor

                                        onClicked: (mouse) => {
                                            if (mouse.button === Qt.LeftButton) {
                                                trayItem.modelData.activate()
                                            } else if (mouse.button === Qt.MiddleButton) {
                                                trayItem.modelData.secondaryActivate()
                                            } else if (mouse.button === Qt.RightButton) {
                                                trayItem.modelData.display(
                                                    QsWindow.window,
                                                    trayItem.mapToItem(null, 0, trayItem.height).x,
                                                    trayItem.mapToItem(null, 0, trayItem.height).y
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
