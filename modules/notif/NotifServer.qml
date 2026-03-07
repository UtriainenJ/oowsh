pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    property alias instance: notifServer
    property alias trackedNotifications: notifServer.trackedNotifications

    NotificationServer {
        id: notifServer
        
        keepOnReload: true
        
        imageSupported: true
        actionsSupported: true
    }
}
