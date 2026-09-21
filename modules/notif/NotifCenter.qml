import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import qs.visuals

FloatingWindow {
    id: notifCenterWindow

    property ListModel notifHistory: ListModel {}

    color: "transparent"
    implicitHeight: 400
    implicitWidth: 400

    onVisibleChanged: if (!visible) destroy()
    
    ListView {
        id: notifList

        property var selectedNotif: null

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        implicitWidth: Config.notifConfig.notifWidth
        spacing: 10

        model: notifHistory
        delegate: HistoryNotif {
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    notifList.selectedNotif = model
                    notifList.currentIndex = index
                }
            }
        }
    }

    function open() {
        notifCenterWindow.visible = true;
    }

    function refreshHistoryModel() {
        if (notifHistory) { notifHistory.clear() };
        let data = NotifStorageManager.getHistory(Config.notifConfig.notifHistoryDisplayLimit);
        data.forEach(item => notifHistory.append(item));
    }

    Component.onCompleted: {
        refreshHistoryModel();
    }

    Rectangle {
        id: detailsRect
        color: Colors.clrSurface
        anchors {
            left: notifList.right
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            margins: Config.notifConfig.padding
        }
        radius: 10
        z: -1

        Column {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            Text {
                text: "NOTIFICATION DETAILS"
                font.pixelSize: 24
                font.bold: true
                color: Colors.clrOnPrimaryContainer
            }

            Separator { }

            DetailRow { label: "id"; value: notifList.selectedNotif?.id ?? "" }
            DetailRow { label: "client_id"; value: notifList.selectedNotif?.client_id ?? "" }
            DetailRow { label: "app_name"; value: notifList.selectedNotif?.app_name ?? ""}
            DetailRow { label: "desktop_entry"; value: notifList.selectedNotif?.desktop_entry ?? "" }
            DetailRow { label: "app_icon"; value: notifList.selectedNotif?.app_icon ?? "" }
            DetailRow { label: "image"; value: notifList.selectedNotif?.image ?? "" }
            DetailRow { label: "summary";  value: notifList.selectedNotif?.summary ?? ""}
            DetailRow { label: "urgency";  value: notifList.selectedNotif?.urgency ?? ""}
            DetailRow { label: "timestamp"; value: notifList.selectedNotif?.timestamp ?? "" }

            DetailMultiRow { 
                label: "body"
                value: notifList.selectedNotif?.body ?? "" 
            }

            DetailMultiRow { 
                label: "hints"
                value: notifList.selectedNotif?.hints ?? {} 
            }

            DetailMultiRow { 
                label: "actions"
                value: {
                    const actions = notifList.selectedNotif?.actions ?? [];
                    let actionArray = [];
                    for (let i = 0; i < actions.count; i++) {
                        actionArray.push(actions.get(i));
                    }
                    return actionArray;
                }
            }
        }
    }

    component DetailRow : Row {
        property string label
        property string value
        spacing: 8
        width: parent.width

        Text {
            text: label + ":"
            color: Colors.clrPrimary
            font.family: "Monospace"
            font.pixelSize: 13
            width: 105
        }

        Text {
            text: value
            color: Colors.clrOnSurface
            font.family: "Monospace"
            font.pixelSize: 13
            elide: Text.ElideRight
            width: parent.width - 100
        }
    }

    component Separator : Rectangle {
        width: parent.width
        height: 1
        color: Colors.clrOutline
    }

    component DetailMultiRow : Row {
        property string label
        property var value
        spacing: 8
        width: parent.width

        Text {
            text: label + ":"
            color: Colors.clrPrimary
            font.family: "Monospace"; font.pixelSize: 13
            width: 105 
        }

        Text {
            text: stringifyValue(value)

            color: Colors.clrOnSurface
            font.family: "Monospace"
            font.pixelSize: 13
            width: parent.width - 100
            wrapMode: Text.WrapAnywhere
        }

        function stringifyValue(newValue) {
            return JSON.stringify(newValue, null, 2);
        }
    }
}

