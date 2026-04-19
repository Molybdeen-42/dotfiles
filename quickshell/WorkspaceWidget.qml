import Quickshell
import QtQuick
import Quickshell.Hyprland

// Creates a workspace menu for each screen
Row {
    id: root
    spacing: 6
    required property var screenData

    Repeater {
        model: (Hyprland.workspaces.values
            .filter(ws => ws.monitor && ws.monitor.name === root.screenData.name)
            .sort((x, y) => x.id - y.id)
        )

        delegate: Rectangle {
            id: chip
            required property var modelData

            // Manages color and width for current and active workspaces
            width: modelData.active ? 25 : 17
            height: 17
            radius: 10
            color: modelData.active ? Theme.colorTextPrimary : modelData.focused ? Theme.colorBgPrimary : Theme.colorBgPrimary

            border.width: 1
            border.color: Theme.colorBorderPrimary

            // Time between width and color adjustment on swapping workspace
            Behavior on width { NumberAnimation { duration: 500 } }
            Behavior on color { ColorAnimation { duration: 500 } }

            // Text {
            //     anchors.centerIn: parent
            //     text: chip.modelData.id
            //     color: chip.modelData.active ? Theme.colorBgPrimary : Theme.colorTextPrimary
            //     font.family: Theme.fontFamilyMono
            //     font.pixelSize: Theme.fontSizeSmall
            //     font.bold: chip.modelData.active
            // }

            // Allows clicking of workspaces to swap between them
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + chip.modelData.id)
            }
        }
    }
}