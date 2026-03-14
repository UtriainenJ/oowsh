import QtQml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import qs
import qs.visuals
import qs.modules.shared

Rectangle {
    property Notification notifData: modelData
    property string notifAge: "just now"
    implicitHeight: appNameText.implicitHeight + summaryText.implicitHeight + bodyText.implicitHeight
                     + actionsLoader.implicitHeight + Config.notifConfig.padding * 5 
    implicitWidth: imageLoader.active ? Config.notifConfig.notifWidth + imageLoader.implicitWidth: Config.notifConfig.notifWidth
    color: Colors.clrSurfaceContainer
    radius: 10

    ElapsedTimer { id: ageTimer }
    Timer {
        id: ageUpdateTimer
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            const totalSec = Math.floor(ageTimer.elapsed());
            
            const h = Math.floor(totalSec / 3600);
            const m = Math.floor((totalSec % 3600) / 60);
            const s = totalSec % 60;

            let ageString;

            if (h > 0) {
                ageString = `${h} h ${m} min`;
            } else if (m >= 10) {
                ageString = `${m} minutes`;
            } else if (m > 0) {
                ageString = `${m} min ${s} sec`;
            } else {
                ageString = `${s} seconds`;
            }

            notifAge = `${ageString} ago`;
        }
    }

    Text {
        id: appNameText
        anchors.top: parent.top
        anchors.left: iconLoader.right
        anchors.margins: Config.notifConfig.padding

        text: notifData.appName
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
        text: notifAge
        font.pixelSize: 8
        color: Colors.clrSecondary
    }

    Loader {
        id: iconLoader
        active: notifData.appIcon !== ""

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: Config.notifConfig.padding / 2

        sourceComponent: IconImage {
            source: notifData.appIcon.startsWith("/") ? notifData.appIcon : "image://icon/" + notifData.appIcon
            implicitSize: 24
            asynchronous: true
        }
    }

    Loader {
        id: imageLoader
        active: notifData.image !== ""

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Config.notifConfig.padding

        sourceComponent: IconImage {
            source: notifData.image
            asynchronous: true

            implicitSize: 48
        }
    }
    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (event.button === Qt.RightButton) {
                notifData.dismiss();
            }
        }
    }

    Loader {
        id: actionsLoader
        active: notifData.actions.length > 0

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: Config.notifConfig.padding

        sourceComponent: RowLayout {
            spacing: 10

            Repeater {
                model: notifData.actions

                delegate: Rectangle {
                    id: actionButton
                    color: actionMouseArea.containsMouse ? Colors.hoverTone(Colors.clrPrimaryContainer) : Colors.clrPrimaryContainer
                    radius: 5
                    implicitWidth: buttonText.implicitWidth + Config.notifConfig.padding * 2
                    implicitHeight: buttonText.implicitHeight + Config.notifConfig.padding

                    Text {
                        id: buttonText
                        anchors.centerIn: parent
                        text: modelData.text
                        color: Colors.clrOnPrimaryContainer
                    }

                    MouseArea {
                        id: actionMouseArea
                        anchors.fill: parent
                        onClicked: {
                            console.log("Action triggered:", modelData.text);
                            modelData.invoke();
                        }
                        hoverEnabled: true
                    }
                }
            }
        }
    }
}