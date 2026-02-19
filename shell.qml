import Quickshell
import qs.modules.dock
import qs.modules.tray
import qs.modules.shared

ShellRoot {
    Dock {}

    Tray { id: tray }
    PanelBorder { attachedTo: tray }
}

