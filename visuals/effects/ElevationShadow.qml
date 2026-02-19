import QtQuick
import QtQuick.Effects
import qs.visuals

RectangularShadow {
    required property Rectangle attachedTo

    anchors.fill: attachedTo
    color: Qt.alpha(Colors.clrShadow, 0.7) // darkness of shadow
    radius: attachedTo.radius
    blur: 10
    spread: 5

    offset.y: 5
    offset.x: 5
}