import QtQuick
import "../../themes"
import "data"

// The time in hh:mm
Text {
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeSmall
    color: Theme.text
    text: Time.time
}
