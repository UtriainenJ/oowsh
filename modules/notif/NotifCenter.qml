import Quickshell
import QtQuick
import QtQuick.Layouts
import qs

FloatingWindow {
    id: notifCenterWindow

    property ListModel notifHistory: ListModel {}

    color: "transparent"
    implicitHeight: 400
    implicitWidth: 400

    ListView {
        anchors.fill: parent
        spacing: 12
        model: notifHistory
        delegate: HistoryNotif {}
    }

    function refreshHistoryModel() {
        if (notifHistory) { notifHistory.clear() };
        let data = NotifStorageManager.getHistory(Config.notifConfig.notifHistoryDisplayLimit);
        data.forEach(item => notifHistory.append(item));
    }

    Component.onCompleted: {
        refreshHistoryModel();
    }
}

    

