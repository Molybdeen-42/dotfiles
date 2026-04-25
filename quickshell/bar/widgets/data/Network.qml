pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string networkType: "disconnected"

    Component.onCompleted: {
        nmcliProc.running = true
    }

    Process {
        id: nmcliProc
        command: ["nmcli", "-t", "-f", "TYPE,STATE", "device"]

        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("ethernet:") && data.includes(":connected")) {
                    root.networkType = "ethernet"
                } else if (data.startsWith("wifi:") && data.includes(":connected") && root.networkType !== "ethernet") {
                    root.networkType = "wifi"
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            root.networkType = "disconnected"
            nmcliProc.running = true;
        }
    }
}