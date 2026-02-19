import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs

PanelWindow {
    id: root
    color: "transparent"

    screen: Config.trayConfig.screen

    anchors.left: true
    anchors.top: true
    margins.left: Config.trayConfig.pos.x
    margins.top: Config.trayConfig.pos.y

    implicitHeight: Math.max(trayIconsLayout.implicitHeight, menuStackView.implicitHeight)
    implicitWidth: trayIconsLayout.implicitWidth + menuStackView.implicitWidth

    ColumnLayout {
    id: trayIconsLayout
     spacing: 6 // spacing between tray icons
        Repeater {
            model: SystemTray.items
            delegate: IconImage {
                required property SystemTrayItem modelData
                source: modelData.icon
                implicitSize: 24

                MouseArea {
                    id: iconMouseArea
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: event => {
                        if (event.button === Qt.LeftButton) {
                            modelData.activate();
                        }
                        else {
                            modelData.secondaryActivate();
                        }
                    }

                    onWheel: event => {
                        modelData.scroll(event.angleDelta.y, false); // Vertical scroll
                        modelData.scroll(event.angleDelta.x, true);  // Horizontal scroll
                    }

                    hoverEnabled: true
                    onEntered: {
                        if (modelData.hasMenu) {
                            menuStackView.pushItem(trayMenuComp, { menuHandle: modelData.menu });
                            menuCloseTimer.stop();
                        }
                    }
                    onExited: { menuCloseTimer.start(); }
                }
            }
        }
    }

    // hoverhandlers instead of mouseareas to avoid stealing mouse events from the menu entries
    HoverHandler {
        id: menuHoverHandler
        target: menuStackView.currentItem

        onHoveredChanged: {
            if (hovered) {
                menuCloseTimer.stop();
            }
            else {
                menuCloseTimer.start();
            }
        }
    }
    HoverHandler {
        id: trayHoverHandler
        target: trayIconsLayout
    }

    Timer {
        id: menuCloseTimer
        interval: 500
        repeat: false
        onTriggered: {
            if (!menuHoverHandler.hovered &&
                !trayHoverHandler.hovered) {
                menuStackView.clear();
            }
        }
    }

    StackView {
        id: menuStackView
        anchors.left: trayIconsLayout.right

        implicitWidth: currentItem === null ? 0 : currentItem.implicitWidth + 14
        implicitHeight: currentItem === null ? 0 : currentItem.implicitHeight

        pushEnter: NoAnim {}
        pushExit: NoAnim {}
        popEnter: NoAnim {}
        popExit: NoAnim {}

        component NoAnim: Transition {
            NumberAnimation {
                duration: 0
            }
        }
    }

    Component {
        id: trayMenuComp
        TrayMenu {
            onForwardSubmenuReq: menuHandle => {
                menuStackView.pushItem(trayMenuComp, { menuHandle: menuHandle });
            }
        }
    }
}