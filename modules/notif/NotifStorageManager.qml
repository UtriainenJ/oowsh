pragma Singleton

import QtQuick
import QtQuick.LocalStorage
import Quickshell

Singleton {
    //db location usually ~/.local/share/quickshell/QML/OfflineStorage/
    property var db

    Component.onCompleted: {
        try {
            db = LocalStorage.openDatabaseSync("qs_notifs", "1.0", "Database for Quickshell Notifications", 1000000);
            initializeNotifsTable();

        } catch (e) {
            console.error("Failed to open database for notifications", e);
        }
    }

    function initializeNotifsTable() {
        if (!db) { return };

        db.transaction((tx) => {
            tx.executeSql(`
            CREATE TABLE IF NOT EXISTS notification_history (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    client_id INTEGER,
                    app_name TEXT,
                    app_icon TEXT,
                    summary TEXT,
                    body TEXT,
                    urgency INTEGER,
                    hints TEXT,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
                )
            `);
        });
    }

    function addNotification(notification) {
        if (!db) {
            console.error("Database not initialized, cannot add notification");
            return;
        }

        db.transaction((tx) => {
            tx.executeSql(`
                INSERT INTO notification_history (client_id, app_name, app_icon, summary, body, urgency, hints)
                VALUES (?, ?, ?, ?, ?, ?, ?)`, 
                [notification.clientId,
                notification.appName,
                notification.appIcon,
                notification.summary,
                notification.body,
                notification.urgency,
                JSON.stringify(notification.hints)]);
        });
    }
}