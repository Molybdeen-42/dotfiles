import QtQuick
import "../../themes"
import "data"

// The time in hh:mm
Text {
    id: clock
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeNormal
    color: Theme.widget
    text: Time.time
}
