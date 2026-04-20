import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes

// The standard bar that shows a border around the screen.
Scope {
    Variants {
        model: Quickshell.screens

        Scope {
            id: screenBorder
        
            required property var modelData
            readonly property int topThickness: 25
            readonly property int edgeThickness: 5
            readonly property int cornerRadius: 10
            readonly property int borderThickness: 1
            readonly property int shadowThickness: 4
            readonly property int cornerShadowModifier: 13
            readonly property color shadowColor: Theme.colorBorderPrimary
            readonly property color shadowEdge: "#00000000"

            // Top bar
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    left: true
                    top: true
                    right: true
                }

                color: "transparent"
                implicitHeight: topThickness + shadowThickness
                exclusiveZone: topThickness

                // Bar
                Rectangle {
                    id: topBar
                    
                    anchors {
                        left: parent.left
                        top: parent.top
                        right: parent.right
                    }

                    height: topThickness
                    color: Theme.colorBgPrimary

                    // Center widget row
                    Row {
                        anchors.centerIn: parent
                        spacing: 20

                        // Workspaces sorted by monitor
                        WorkspaceWidget {
                            anchors.verticalCenter: parent.verticalCenter
                            screenData: modelData
                        }

                        // Clock hh:mm
                        ClockWidget {
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // Shadow
                Rectangle {
                    anchors {
                        left: parent.left
                        top: topBar.bottom
                        right: parent.right
                    }

                    height: shadowThickness

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: shadowColor }
                        GradientStop { position: 1.0; color: shadowEdge }
                    }
                }
            }

            // Left bar
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    top: true
                    left: true
                    bottom: true
                }

                color: "transparent"
                implicitWidth: edgeThickness + shadowThickness
                exclusiveZone: edgeThickness

                // Shadow
                Rectangle {
                    id: leftBar

                    anchors {
                        top: parent.top
                        left: parent.left
                        bottom: parent.bottom
                    }

                    width: edgeThickness
                    color: Theme.colorBgPrimary
                }

                // Bar
                Rectangle {
                    anchors {
                        top: parent.top
                        left: leftBar.right
                        bottom: parent.bottom
                    }

                    width: shadowThickness

                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: shadowColor }
                        GradientStop { position: 1.0; color: shadowEdge }
                    }
                }
            }

            // Bottom bar
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    left: true
                    bottom: true
                    right: true
                }

                color: "transparent"
                implicitHeight: edgeThickness + shadowThickness
                exclusiveZone: edgeThickness

                // Bar
                Rectangle {
                    id: bottomBar

                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                        right: parent.right
                    }

                    height: edgeThickness
                    color: Theme.colorBgPrimary
                }

                // Shadow
                Rectangle {
                    anchors {
                        left: parent.left
                        bottom: bottomBar.top
                        right: parent.right
                    }

                    height: shadowThickness

                    gradient: Gradient {
                        GradientStop { position: 1.0; color: shadowColor }
                        GradientStop { position: 0.0; color: shadowEdge }
                    }
                }
            }

            // Right bar
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    top: true
                    right: true
                    bottom: true
                }

                color: "transparent"
                implicitWidth: edgeThickness + shadowThickness
                exclusiveZone: edgeThickness

                // Bar
                Rectangle {
                    id: rightBar

                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }

                    width: edgeThickness
                    color: Theme.colorBgPrimary
                }

                // Shadow
                Rectangle {
                    anchors {
                        top: parent.top
                        right: rightBar.left
                        bottom: parent.bottom
                    }

                    width: shadowThickness

                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 1.0; color: shadowColor }
                        GradientStop { position: 0.0; color: shadowEdge }
                    }
                }
            }

            // Top left corner
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    top: true
                    left: true
                }

                implicitHeight: cornerRadius + cornerShadowModifier
                implicitWidth: cornerRadius + cornerShadowModifier
                color: "transparent"
                exclusiveZone: 0

                Shape {
                    anchors.fill: parent

                    // Shadow
                    ShapePath {
                        strokeWidth: 0
                        fillGradient: RadialGradient {
                            centerX: cornerRadius + cornerShadowModifier
                            centerY: cornerRadius + cornerShadowModifier
                            centerRadius: cornerRadius + cornerShadowModifier

                            // Testing data
                            // GradientStop { position: 0.0; color: "black" }
                            // GradientStop { position: 0.2; color: "magenta" }
                            // GradientStop { position: 0.4; color: "yellow" }
                            // GradientStop { position: 0.6; color: "blue" }
                            // GradientStop { position: 0.8; color: "green" }
                            // GradientStop { position: 1.0; color: "red" }

                            GradientStop { position: 0.0; color: shadowColor }
                            GradientStop {
                                position: cornerRadius / (cornerRadius + cornerShadowModifier)
                                color: shadowColor
                            }
                            GradientStop { position: 1.0; color: "#00000000" }
                        }

                        startX: cornerRadius; startY: 0
                        PathLine { x: cornerRadius + cornerShadowModifier; y: 0 }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius + cornerShadowModifier}
                        PathLine { x: 0; y: cornerRadius + cornerShadowModifier}
                        PathLine { x: 0; y: cornerRadius}
                        PathArc {
                            x: cornerRadius
                            y: 0
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Clockwise
                        }
                    }

                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: 0; startY: 0

                        PathLine { x: cornerRadius; y: 0 }
                        PathArc {
                            x: 0
                            y: cornerRadius
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                        PathLine { x: 0; y: 0 }
                    }
                }
            }

            // Bottom left corner
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    bottom: true
                    left: true
                }

                implicitHeight: cornerRadius + cornerShadowModifier
                implicitWidth: cornerRadius + cornerShadowModifier
                color: "transparent"

                Shape {
                    anchors.fill: parent

                    // Shadow
                    ShapePath {
                        strokeWidth: 0
                        fillGradient: RadialGradient {
                            centerX: cornerRadius + cornerShadowModifier
                            centerY: 0
                            centerRadius: cornerRadius + cornerShadowModifier

                            focalY: cornerRadius + cornerShadowModifier
                            
                            // Testing data
                            // GradientStop { position: 0.0; color: "black" }
                            // GradientStop { position: 0.2; color: "magenta" }
                            // GradientStop { position: 0.4; color: "yellow" }
                            // GradientStop { position: 0.6; color: "blue" }
                            // GradientStop { position: 0.8; color: "green" }
                            // GradientStop { position: 1.0; color: "red" }

                            GradientStop { position: 0.0; color: shadowColor }
                            GradientStop {
                                position: cornerRadius / (cornerRadius + cornerShadowModifier)
                                color: shadowColor
                            }
                            GradientStop { position: 1.0; color: "#00000000" }
                        }

                        startX: cornerRadius; startY: cornerRadius + cornerShadowModifier
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: 0 }
                        PathLine { x: 0; y: 0 }
                        PathLine { x: 0; y: cornerShadowModifier }
                        PathArc {
                            x: cornerRadius
                            y: cornerRadius + cornerShadowModifier
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                    }

                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: 0; startY: cornerShadowModifier

                        PathArc {
                            x: cornerRadius
                            y: cornerRadius + cornerShadowModifier
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                        PathLine { x: 0; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: 0; y: cornerShadowModifier }
                    }
                }
            }

            // Bottom right corner
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    bottom: true
                    right: true
                }

                implicitHeight: cornerRadius + cornerShadowModifier
                implicitWidth: cornerRadius + cornerShadowModifier
                color: "transparent"

                Shape {
                    anchors.fill: parent

                    // Shadow
                    ShapePath {
                        strokeWidth: 0
                        fillGradient: RadialGradient {
                            centerX: 0
                            centerY: 0
                            centerRadius: cornerRadius + cornerShadowModifier

                            focalX: cornerRadius + cornerShadowModifier
                            focalY: cornerRadius + cornerShadowModifier

                            // Testing data
                            // GradientStop { position: 0.0; color: "black" }
                            // GradientStop { position: 0.2; color: "magenta" }
                            // GradientStop { position: 0.4; color: "yellow" }
                            // GradientStop { position: 0.6; color: "blue" }
                            // GradientStop { position: 0.8; color: "green" }
                            // GradientStop { position: 1.0; color: "red" }

                            GradientStop { position: 0.0; color: shadowColor }
                            GradientStop {
                                position: cornerRadius / (cornerRadius + cornerShadowModifier)
                                color: shadowColor
                            }
                            GradientStop { position: 1.0; color: "#00000000" }
                        }

                        startX: cornerShadowModifier; startY: cornerRadius + cornerShadowModifier
                        PathLine { x: 0; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: 0; y: 0 }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: 0 }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerShadowModifier }
                        PathArc {
                            x: cornerShadowModifier
                            y: cornerRadius + cornerShadowModifier
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Clockwise
                        }
                    }
                    
                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: cornerRadius + cornerShadowModifier; startY: cornerShadowModifier

                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: cornerShadowModifier; y: cornerRadius + cornerShadowModifier}
                        PathArc {
                            x: cornerRadius + cornerShadowModifier
                            y: cornerShadowModifier
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                    }
                }
            }

            // Top right corner
            PanelWindow {
                screen: screenBorder.modelData

                anchors {
                    top: true
                    right: true
                }

                implicitHeight: cornerRadius + cornerShadowModifier
                implicitWidth: cornerRadius + cornerShadowModifier
                color: "transparent"

                Shape {
                    anchors.fill: parent

                    // Shadow
                    ShapePath {
                        strokeWidth: 0
                        fillGradient: RadialGradient {
                            centerX: 0
                            centerY: cornerRadius + cornerShadowModifier
                            centerRadius: cornerRadius + cornerShadowModifier

                            focalX: cornerRadius + cornerShadowModifier

                            // Testing data
                            // GradientStop { position: 0.0; color: "black" }
                            // GradientStop { position: 0.2; color: "magenta" }
                            // GradientStop { position: 0.4; color: "yellow" }
                            // GradientStop { position: 0.6; color: "blue" }
                            // GradientStop { position: 0.8; color: "green" }
                            // GradientStop { position: 1.0; color: "red" }

                            GradientStop { position: 0.0; color: shadowColor }
                            GradientStop {
                                position: cornerRadius / (cornerRadius + cornerShadowModifier)
                                color: shadowColor
                            }
                            GradientStop { position: 1.0; color: "#00000000" }
                        }

                        startX: cornerShadowModifier; startY: 0
                        PathLine { x: 0; y: 0 }
                        PathLine { x: 0; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius + cornerShadowModifier }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius }
                        PathArc {
                            x: cornerShadowModifier
                            y: 0
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                    }

                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: cornerShadowModifier; startY: 0

                        PathLine { x: cornerRadius + cornerShadowModifier; y: 0 }
                        PathLine { x: cornerRadius + cornerShadowModifier; y: cornerRadius}
                        PathArc {
                            x: cornerShadowModifier
                            y: 0
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                    }
                }
            }
        }
    }
}
