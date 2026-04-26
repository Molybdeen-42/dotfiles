pragma Singleton

import QtQuick

// Main dark theme file
QtObject {
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property string fontFamilyMono: "JetBrainsMono Nerd Font Mono"

    readonly property int fontSizeSmall:  10
    readonly property int fontSizeNormal: 14
    readonly property int fontSizeLarge:  16

    readonly property color bg:          "#0e1219"
    readonly property color surface:     "#171d27"
    readonly property color widget:      "#e8e4e0"
    readonly property color border:      "#3a4862"
    readonly property color textMuted:   "#8a95a7"
    readonly property color text:        "#f0ece8"
    readonly property color accent:      "#7a9ab8"
    readonly property color accentHover: "#92b4d4"
    readonly property color warn:        "#b88a70"
    readonly property color notify:      "#d45a5a"
    readonly property color positive:    "#5a8a7a"
}

// Main light theme file
// QtObject {
//     readonly property string fontFamily: "JetBrainsMono Nerd Font"
//     readonly property string fontFamilyMono: "JetBrainsMono Nerd Font Mono"

//     readonly property int fontSizeSmall:  10
//     readonly property int fontSizeNormal: 12
//     readonly property int fontSizeLarge:  14

//     readonly property color bg:          "#f0ece8"
//     readonly property color surface:     "#e4dfd9"
//     readonly property color widget:      "#1a2230"
//     readonly property color border:      "#3a4862"
//     readonly property color textMuted:   "#6b7a8e"
//     readonly property color text:        "#0e1219"
//     readonly property color accent:      "#7a9ab8"
//     readonly property color accentHover: "#92b4d4"
//     readonly property color warn:        "#a07058"
//     readonly property color notify:      "#b84040"
//     readonly property color positive:    "#3d7a66"
// }