pragma Singleton

import QtQuick

// Main theme file
QtObject {
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property string fontFamilyMono: "JetBrainsMono Nerd Font Mono"

    readonly property int fontSizeSmall:  12
    readonly property int fontSizeNormal: 14
    readonly property int fontSizeLarge:  18

    readonly property color bg: "#ede8e3"
    readonly property color surface: "#e0d9d2"
    readonly property color widget: "#252b38"
    readonly property color border: "#3d4758"
    readonly property color textMuted: "#3d4758"
    readonly property color text: "#181c24"
    readonly property color accent: "#c97a6e"
    readonly property color accentHover: "#b85448"
    readonly property color warn: "#e8b8b2"
    readonly property color notify: "#7a1f18"
    readonly property color positive: "#4a6b5a"
}