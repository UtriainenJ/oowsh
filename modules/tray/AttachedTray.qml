import Quickshell

Scope {
    required property PanelWindow attachedTo

    Tray {
        color: "transparent"

        anchors: attachedTo.anchors
        margins.top: attachedTo.margins.top
        margins.left: attachedTo.margins.left + attachedTo.implicitWidth

        implicitHeight: attachedTo.implicitHeight
    }   
}