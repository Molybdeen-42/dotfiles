pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    readonly property int clockingInterval: 5000
    property real cpuTemperature

    function cpuTempGet(data) {
        for (const chip in data) {
            if (chip.startsWith("coretemp-")) {
                for (const label in data[chip]) {
                    if (label.startsWith("Package id")) {
                        return data[chip][label].temp1_input
                    }
                }
            }
        }

        for (const chip in data) {
            if (chip.startsWith("k10temp-")|| chip.startsWith("zenpower-")) {
                for (const key of ["Tctl", "Tdie", "Tccd1"]) {
                    const section = data[chip][key]

                    for (const k in section) {
                        if (k.endsWith("_input")) {
                            return section[k]
                        }
                    }
                }
            }
        }

        for (const chip in data) {
            for (const label in data[chip]) {
                const section = data[chip][label]

                if (typeof section === "object") {
                    for (const k in section) {
                        if (k.endsWith("_input")) {
                            return section[k]
                        }
                    }
                }
            }
        }
    }

    Process {
        id: sensors
        command: ["sensors", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.cpuTemperature = cpuTempGet(JSON.parse(this.text))
                } catch (e) {
                    console.warn("sensors parse failed:", e)
                }
            }
        }
    }

    Timer {
        interval: clockingInterval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            sensors.running = false
            sensors.running = true
        }
    }
}