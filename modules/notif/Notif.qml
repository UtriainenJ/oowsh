import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Widgets
import qs.visuals

Rectangle {
    property Notification notifData: modelData
    implicitHeight: appNameText.implicitHeight + summaryText.implicitHeight + bodyText.implicitHeight + actionsLoader.implicitHeight + 40
    implicitWidth: 300
    color: Colors.clrSurfaceContainer
    radius: 10

    Text {
        id: appNameText
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10

        text: notifData.appName
        font.pixelSize: 12
        color: Colors.clrTertiary
    }

    Text {
        id: summaryText
        anchors.top: appNameText.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter

        text: notifData.summary
        color: Colors.clrSecondary
    }


    Text {
        id: bodyText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : summaryText.bottom
        anchors.topMargin: 10
        width: parent.width - 20

        text: notifData.body
        font.pixelSize: 10
        color: Colors.clrSecondary
        wrapMode: Text.Wrap
    }

    Loader {
        id: iconLoader
        active: notifData.image !== ""

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.topMargin: 5

        sourceComponent: IconImage {
            source: notifData.image
            implicitSize: 48
            asynchronous: true
        }
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (event.button === Qt.LeftButton) {
                console.log("Notification m1 clicked:", notifData.summary);
            }
            else {
                console.log("Notification m2 clicked:", notifData.summary);
                notifData.dismiss();
            }
        }
    }

    Loader {
        id: actionsLoader
        active: notifData.actions.length > 0

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.leftMargin: 5

        sourceComponent: RowLayout {
            spacing: 10

            Repeater {
                model: notifData.actions

                delegate: Rectangle {
                    id: actionButton
                    color: Colors.clrPrimaryContainer
                    radius: 5
                    implicitWidth: buttonText.implicitWidth + 20
                    implicitHeight: buttonText.implicitHeight + 10

                    Text {
                        id: buttonText
                        anchors.centerIn: parent
                        text: modelData.text
                        color: Colors.clrOnPrimaryContainer
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Action triggered:", modelData.text);
                            modelData.invoke();
                        }
                        hoverEnabled: true
                        onEntered: {
                            actionButton.color = Colors.hoverTone(Colors.clrPrimaryContainer)
                        }
                        onExited: { 
                            actionButton.color = Colors.clrPrimaryContainer
                        }
                    }
                }
            }
        }
    }
}