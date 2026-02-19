import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.visuals

ColumnLayout {
    id: menuLayout

    required property QsMenuHandle menuHandle
    signal forwardSubmenuReq(QsMenuHandle menuHandle)

    
    Repeater { 
        model: menuOpener.children

        // entries: content blocks & separators
        delegate: Item {
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
            Loader {
                active: !modelData.isSeparator
                sourceComponent: TrayMenuEntry { 
                    menuItem: modelData
                    menuWidth: menuLayout.implicitWidth

                    onSubmenuRequest: forwardSubmenuReq(modelData)
                }
            }

            Loader {
                active: modelData.isSeparator
                sourceComponent:
                    Rectangle {
                        id: separator
                        implicitHeight: 2
                        color: Colors.clrSecondary
                        implicitWidth: menuLayout.implicitWidth
                    } 
            }
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: menuHandle
    }
}