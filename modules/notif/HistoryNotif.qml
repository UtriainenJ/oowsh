import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs
import qs.modules.shared
import qs.visuals
import qs.visuals.effects

Item {
    readonly property var notifData: model

    implicitHeight: childrenRect.height
    implicitWidth: childrenRect.width

    ElevationShadow {
        attachedTo: notifRect
        level: ElevationShadow.Level.Low
    }

    Rectangle {
        id: notifRect
        implicitHeight: appNameText.implicitHeight + summaryText.implicitHeight + bodyText.implicitHeight
                        + actionsLoader.implicitHeight + Config.notifConfig.padding * 5 
        implicitWidth: Config.notifConfig.notifWidth
        color: Colors.clrSurfaceContainer
        radius: 10

        Text {
            id: appNameText
            anchors.top: parent.top
            anchors.left: iconLoader.right
            anchors.margins: Config.notifConfig.padding

            text: notifData.app_name
            font.pixelSize: 12
            color: Colors.clrTertiary
        }

        Text {
            id: summaryText
            anchors.top: appNameText.bottom
            anchors.margins: Config.notifConfig.padding
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.92

            text: notifData.summary
            color: Colors.clrSecondary
            font.bold: true
            wrapMode: Text.Wrap
        }

        Text {
            id: bodyText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top : summaryText.bottom
            anchors.margins: Config.notifConfig.padding
            width: parent.width * 0.92

            text: notifData.body
            font.pixelSize: 10
            color: Colors.clrSecondary
            wrapMode: Text.Wrap
        }

        Text {
            id: timeText
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: Config.notifConfig.padding
            text: notifData.timestamp
            font.pixelSize: 8
            color: Colors.clrSecondary
        }

        Loader {
            id: iconLoader
            active: notifData.app_icon !== ""

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: Config.notifConfig.padding / 2

            sourceComponent: IconImage {
                source: notifData.app_icon.startsWith("/") ? notifData.app_icon : "image://icon/" + notifData.app_icon
                implicitSize: 24
                asynchronous: true
            }
        }

        Loader {
            id: actionsLoader
            active: notifData.actions.count > 0

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: Config.notifConfig.padding

            sourceComponent: RowLayout {
                spacing: 10

                Repeater {
                    model: notifData.actions

                    delegate: Rectangle {

                        id: actionButton
                        color: buttonMA.containsMouse ? Qt.alpha(Colors.clrErrorContainer, 0.3): Colors.clrPrimaryContainer
                        radius: 5
                        implicitWidth: buttonText.implicitWidth + Config.notifConfig.padding * 2
                        implicitHeight: buttonText.implicitHeight + Config.notifConfig.padding

                        Text {
                            id: buttonText
                            anchors.centerIn: parent
                            text: model.text
                            color: buttonMA.containsMouse ? Qt.alpha(Colors.clrError, 0.5) : Colors.clrOnPrimaryContainer
                        }

                        MouseArea {
                            id: buttonMA
                            anchors.fill: parent
                            hoverEnabled: true
                        }

                        StyledToolTip {
                            visible: buttonMA.containsMouse
                            toolTipText: "Actions cannot be used on historical notifications"
                        }
                    }
                }
            }
        }
    }
}
