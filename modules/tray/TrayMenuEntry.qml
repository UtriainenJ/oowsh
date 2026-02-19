import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.visuals
import qs.visuals.effects


Item {
    id: root
    required property QsMenuEntry menuItem
    required property int menuWidth
    signal submenuRequest() // current entry requests submenu

    implicitWidth: contentLoader.implicitWidth
    implicitHeight: contentLoader.implicitHeight

    ElevationShadow {
        attachedTo: backgroundRect
        visible: entryMouseArea.containsMouse
    }

    Rectangle{
        id: backgroundRect
        color: Colors.clrPrimaryContainer
        radius: 6
        implicitWidth: menuWidth
        implicitHeight: contentLoader.implicitHeight
    }

    // Anchored to fill background however contents implicit size gets propagated up to the menuLayout,
    // this way we can have the whole menu width be determined by the widest entry
    Loader {
        id: contentLoader
        anchors.fill: backgroundRect

        sourceComponent: Item {
            implicitHeight: textContent.implicitHeight + 4
            implicitWidth: textContent.implicitWidth + icon.implicitWidth +
                               buttons.implicitWidth + submenuIndicator.implicitWidth + 20

            Text {
                anchors.centerIn: parent
                id: textContent
                text: menuItem.text
                color: Colors.clrOnPrimaryContainer
            }

            Loader {
                id: icon
                active: menuItem.icon !== ""

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                sourceComponent: IconImage {
                    id: iconImage
                    source: menuItem.icon
                    implicitSize: 20
                    asynchronous: true
                }
            }

            Loader {
                id: submenuIndicator
                active: menuItem.hasChildren

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                sourceComponent: Text {
                    id: extenderIcon
                    visible: menuItem.hasChildren
                    text: "> " // note whitespace
                }
            }

            Loader {
                id: buttons
                active: menuItem.buttonType !== QsMenuButtonType.None
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                sourceComponent: Item {
                    implicitWidth: checkBox.implicitWidth
                    implicitHeight: checkBox.implicitHeight

                    CheckBox {
                        id: checkBox
                        visible: menuItem.buttonType === QsMenuButtonType.Checkbox
                        checked: menuItem.checkState
                        padding: 0
                    }

                    RadioButton {
                        id: radioButton
                        visible: menuItem.buttonType === QsMenuButtonType.RadioButton
                        checked: menuItem.checkState
                        padding: 0
                    }
                }
            }
        }
    }

    MouseArea {
        id: entryMouseArea
        anchors.fill: backgroundRect

        acceptedButtons: Qt.LeftButton
        onClicked: event => {
            if (event.button === Qt.LeftButton) {
                if (menuItem.hasChildren) {
                    root.submenuRequest();
                }
                else {
                    menuItem.triggered();
                }
            }
        }

        hoverEnabled: true
        onEntered: {
            backgroundRect.color = Colors.hoverTone(Colors.clrPrimaryContainer)
        }
        onExited: { 
            backgroundRect.color = Colors.clrPrimaryContainer
        }
    }
}