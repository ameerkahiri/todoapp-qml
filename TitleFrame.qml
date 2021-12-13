import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0

Frame {
    id: titleframe
    scale: 1
    Layout.fillWidth:  true
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    background: Rectangle {
        color: "transparent"
        border.color: "#53565b"
    }

    Label {
        id: titlelabel
        color: "#ffffff"
        text: qsTr("To-Do List")
        font.pointSize: 12
        anchors.top: parent.top
        scale: 0
        anchors.horizontalCenter: parent.horizontalCenter
        transformOrigin: Item.Center
    }

    Timeline {
        id: titleTimeline
        animations: [
            TimelineAnimation {
                id: titleAnimation
                running: true
                duration: 1000
                loops: 1
                to: 1000
                from: 0
            }
        ]
        startFrame: 0
        enabled: true
        endFrame: 1000

        KeyframeGroup {
            target: titlelabel
            property: "scale"
            Keyframe {
                value: 1
                frame: 399
            }

            Keyframe {
                value: 0
                frame: 201
            }
        }
    }
}
