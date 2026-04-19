pragma Singleton

import QtQuick

// Main theme file
QtObject {
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property string fontFamilyMono: "JetBrainsMono Nerd Font Mono"

    readonly property int fontSizeSmall:  12
    readonly property int fontSizeNormal: 14
    readonly property int fontSizeLarge:  18

    readonly property color colorBgPrimary: "#a9b0b7"
    readonly property color colorBorderPrimary: "#3b4352"
    readonly property color colorTextPrimary: "#21242a"
}