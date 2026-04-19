pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Reads the system time and outputs in hh:mm
Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}