import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: window
    visible: true
    width: 480
    height: 640
    color: "#2d2b2b"
    title: qsTr("To-Do List")

    // model based on qml file name
    MainFrame {
        anchors.fill: parent
        transformOrigin: Item.Top
    }
}
