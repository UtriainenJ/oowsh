import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import qs

PanelWindow {
    id: notifArea
    color: "transparent"

    WlrLayershell.namespace: "qs-no-blur"

    screen: Config.notifConfig.screen
    anchors.top: true
    anchors.left: true
    margins.top: Config.notifConfig.pos.y
    margins.left: Config.notifConfig.pos.x
    implicitHeight: notifLayout.implicitHeight + Config.themeConfig.maxShadowMargin
    implicitWidth: notifLayout.implicitWidth + Config.themeConfig.maxShadowMargin

    Connections {
        target: NotifServer.instance
        
        function onNotification(notif){
            console.log("New notification:", notif.summary);
            notif.tracked = true;
        }
    }

    ColumnLayout {
        id: notifLayout
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 12

        Repeater {
            model: NotifServer.trackedNotifications
            delegate: LiveNotif { }
        }
    }
}