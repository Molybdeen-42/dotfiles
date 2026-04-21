import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../themes"

Item {
    id: battery
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

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
        if (Math.round(power.percentage * 100) === 100) return Theme.widget
        if (power.state === UPowerDeviceState.Charging) return Theme.positive
        if (power.percentage * 100 <= 10) return Theme.notify
        if (power.percentage * 100 <= 20) return Theme.warn
        return Theme.widget
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 4

        Text {
            text: battery.batteryIcon
            color: battery.iconColor
            font.pixelSize: Theme.fontSizeSmall
            font.family: Theme.fontFamily
        }

        Text {
            text: power ? Math.round(power.percentage * 100) + "%" : "N/A"
            color: battery.iconColor
            font.pixelSize: Theme.fontSizeSmall
        }
    }
}