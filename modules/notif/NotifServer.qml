pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import qs

Singleton {
    property alias instance: notifServer
    property alias trackedNotifications: notifServer.trackedNotifications

    NotificationServer {
        id: notifServer
        
        keepOnReload: false
        
        imageSupported: true
        actionsSupported: true
        bodySupported: true
        persistenceSupported: true

        onNotification: (notification) => {
            if (Config.notifConfig.persistNotifHistory) {
                NotifStorageManager.addNotification(notification)
            }
        }
    }
}
