import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Niri 0.1
import "./modules/bar/"
import "./modules/utils"

ShellRoot{
    id: root

    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.info("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Niri error:", error)
        }
    }

    // Configurations are located at ./modules/bar/Theme.qml
    LazyLoader{ active: true; component: Bar{} }
}
