import QtQuick
import QtQuick.Effects
import qs.visuals

RectangularShadow {
    required property Rectangle attachedTo
    property int level: ElevationShadow.Level.Low // default, can be overridden
    property int shadowMargin: blur + spread + Math.abs(offset.y)

    enum Level {
        Low,
        Medium,
        High
    }

    anchors.fill: attachedTo
    radius: attachedTo.radius

    color: Qt.alpha(Colors.clrShadow, [0.7, 0.7, 0.9][level])
    blur: [12, 15, 20][level]
    spread: [0, -2, -1][level]
    offset.y: [8, 16, 18][level]
}