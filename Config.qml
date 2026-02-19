pragma Singleton

import Quickshell
import QtQuick
import qs.visuals

Singleton {

    readonly property alias dockConfig: dockConfig
    readonly property alias trayConfig: trayConfig
    readonly property alias themeConfig: themeConfig

    QtObject {
        id: dockConfig
        readonly property string monitorName: "DP-2"

        readonly property point pos: Qt.point((926), Config.themeConfig.borderThickness)
        readonly property int dockMargin: 20
        readonly property ShellScreen screen: Quickshell.screens.find(s => s.name === monitorName)
                            || Quickshell.screens[0]
    }
    QtObject {
        id: trayConfig
        readonly property string monitorName: "DP-2"

        readonly property point pos: Qt.point(Config.themeConfig.borderThickness, 200)
        readonly property ShellScreen screen: Quickshell.screens.find(s => s.name === monitorName)
                        || Quickshell.screens[0]

    }
    QtObject {
        id: themeConfig
        readonly property string borderColor: Colors.clrPrimary
        readonly property int borderThickness: 3
        readonly property int panelBorderRadius: 10
    }
}