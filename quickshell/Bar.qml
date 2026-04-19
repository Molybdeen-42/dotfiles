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

                implicitHeight: cornerRadius + shadowThickness
                implicitWidth: cornerRadius + shadowThickness
                color: "transparent"
                exclusiveZone: 0

                Shape {
                    anchors.fill: parent

                    // Shadow
                    ShapePath {
                        strokeWidth: 0
                        fillGradient: RadialGradient {
                            centerX: cornerRadius
                            centerY: cornerRadius
                            centerRadius: cornerRadius + shadowThickness
                            
                            focalX: cornerRadius
                            focalY: cornerRadius
                            focalRadius: cornerRadius

                            GradientStop { position: 0.0; color: shadowColor }
                            GradientStop { position: 1.0; color: shadowEdge }
                        }

                        startX: cornerRadius; startY: 0
                        PathLine { x: cornerRadius + shadowThickness; y: 0 }
                        PathArc {
                            x: 0
                            y: cornerRadius + shadowThickness
                            radiusX: cornerRadius + shadowThickness
                            radiusY: cornerRadius + shadowThickness
                            direction: PathArc.Counterclockwise
                        }
                        PathLine { x: 0; y: cornerRadius }
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

                implicitHeight: cornerRadius
                implicitWidth: cornerRadius
                color: "transparent"

                Shape {
                    anchors.fill: parent

                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: 0; startY: 0

                        PathArc {
                            x: cornerRadius
                            y: cornerRadius
                            radiusX: cornerRadius
                            radiusY: cornerRadius
                            direction: PathArc.Counterclockwise
                        }
                        PathLine { x: 0; y: cornerRadius }
                        PathLine { x: 0; y: 0 }
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

                implicitHeight: cornerRadius
                implicitWidth: cornerRadius
                color: "transparent"

                Shape {
                    anchors.fill: parent
                    
                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: cornerRadius; startY: 0

                        PathLine { x: cornerRadius; y: cornerRadius }
                        PathLine { x: 0; y: cornerRadius}
                        PathArc {
                            x: cornerRadius
                            y: 0
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

                implicitHeight: cornerRadius
                implicitWidth: cornerRadius
                color: "transparent"

                Shape {
                    anchors.fill: parent

                    // Fills corner
                    ShapePath {
                        fillColor: Theme.colorBgPrimary
                        strokeWidth: 0
                        startX: 0; startY: 0

                        PathLine { x: cornerRadius; y: 0 }
                        PathLine { x: cornerRadius; y: cornerRadius}
                        PathArc {
                            x: 0
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
