pragma Singleton

import QtQuick
import QtQuick.LocalStorage
import Quickshell
import qs

Singleton {
    //db location usually ~/.local/share/quickshell/QML/OfflineStorage/
    property var db
    property ListModel notifHistoryModel

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
                    desktop_entry TEXT,
                    app_icon TEXT,
                    image TEXT,
                    summary TEXT,
                    body TEXT,
                    urgency INTEGER,
                    hints TEXT,
                    actions TEXT,
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
                INSERT INTO notification_history (client_id, app_name, desktop_entry, app_icon, image, summary, body, urgency, hints, actions)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
                [notification.id,
                notification.appName,
                notification.desktopEntry,
                notification.appIcon,
                notification.image,
                notification.summary,
                notification.body,
                notification.urgency,
                JSON.stringify(notification.hints),
                JSON.stringify(notification.actions)]);
        });
    }

    function getHistory(limit = 50) {
        if (!db) return [];

        let notifHistory = [];

        db.readTransaction((tx) => {
            const data = tx.executeSql(
                "SELECT * FROM notification_history ORDER BY timestamp DESC LIMIT ?",
                [limit]
            );

    
            for (let i = 0; i < data.rows.length; i++) {
                const readOnlyRow = data.rows.item(i);
                let row = {};
                for (let key in readOnlyRow) {
                    row[key] = (readOnlyRow[key] === null) ? "" : readOnlyRow[key];
                };

                row.hints = JSON.parse(row.hints);
                row.actions = JSON.parse(row.actions);

                notifHistory.push(row);
            }
        });
        return notifHistory;
    }
}