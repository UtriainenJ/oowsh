import QtQuick
import Quickshell
import Quickshell.Wayland
import qs

PanelWindow {
    // should be attached to a panel window as a sibling
    required property PanelWindow attachedTo

    color: "transparent"
    WlrLayershell.namespace: "Qs-panel-border"

    anchors: attachedTo.anchors
    screen: attachedTo.screen

    margins.top: attachedTo.margins.top - Config.themeConfig.borderThickness
    margins.left: attachedTo.margins.left - Config.themeConfig.borderThickness
    implicitWidth: attachedTo.width + Config.themeConfig.borderThickness * 2
    implicitHeight: attachedTo.height + Config.themeConfig.borderThickness * 2

    // make the border window click-through
    mask: Region {
        item: borderRect
        intersection: Intersection.Xor
    }

    Rectangle {
        id: borderRect

        anchors.fill: parent
        color: "transparent"
        radius: Config.themeConfig.panelBorderRadius
        border.color: Config.themeConfig.borderColor
        border.width: Config.themeConfig.borderThickness
    }
}