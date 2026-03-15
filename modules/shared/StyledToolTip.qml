import QtQuick
import QtQuick.Controls
import qs.visuals
import qs

ToolTip {
    required property string toolTipText

    delay: 1000
    timeout: 6000

    background: Rectangle {
        color: Colors.clrSecondaryContainer
        radius: 4

        border.color: Colors.clrSecondary
        border.width: Config.BorderThicknessEnum.Thin
    }
    contentItem: Text {
        color: Colors.clrOnSecondaryContainer
        font.pixelSize: 12
        text: toolTipText
    }
}