import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import qs

PanelWindow {
    id: notifArea
    color: "transparent"

    screen: Config.notifConfig.screen
    anchors.top: true
    anchors.left: true
    margins.top: Config.notifConfig.pos.y
    margins.left: Config.notifConfig.pos.x
    implicitHeight: notifLayout.implicitHeight
    implicitWidth: notifLayout.implicitWidth

    Connections {
        target: NotifServer.instance
        
        function onNotification(notif){
            console.log("New notification:", notif.summary);
            notif.tracked = true;
        }
    }

    ColumnLayout {
        id: notifLayout
        anchors.fill: parent
        spacing: 10

        Repeater {
            model: NotifServer.trackedNotifications
            delegate: LiveNotif { notifData: modelData }
        }
    }
}