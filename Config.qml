pragma Singleton

import Quickshell
import QtQuick
import qs.visuals

Singleton {

    readonly property alias dockConfig: dockConfig
    readonly property alias trayConfig: trayConfig
    readonly property alias themeConfig: themeConfig
    readonly property alias notifConfig: notifConfig

    QtObject {
        id: dockConfig
        readonly property string monitorName: "DP-2"

        readonly property point pos: Qt.point(926, Config.themeConfig.borderThickness)
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

        readonly property int borderThickness: Config.BorderThicknessEnum.Medium

        readonly property int panelBorderRadius: 10
        
        // a very generous and rough approximation pulled out of my ass to use as a shortcut statically.
        // see ElevationShadow for more precise calculations
        readonly property int maxShadowMargin: 50 
    }

    enum BorderThicknessEnum {
        Thin = 1,
        Medium = 3,
        Thick = 5
    }
    
    QtObject {
        id: notifConfig
        readonly property string monitorName: "DP-2"

        readonly property point pos: Qt.point(Config.themeConfig.borderThickness, Config.themeConfig.borderThickness)
        readonly property ShellScreen screen: Quickshell.screens.find(s => s.name === monitorName)
                        || Quickshell.screens[0]

        readonly property bool persistNotifHistory: true
        readonly property int padding: 8
        readonly property int notifWidth: 300
        readonly property int notifHistoryDisplayLimit: 100
    }
}