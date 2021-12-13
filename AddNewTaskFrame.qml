import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0
import "."

Frame {
    id: mainAddTaskFrame
    Layout.fillWidth: true
    background: Rectangle {
        color: "transparent"
        border.color: "#53565b"
    }

    RowLayout {
        id: mainAddTaskLayout
        width: parent.width

        Frame {
            id: addTaskDetailsFrame
            opacity: 1
            Layout.fillWidth: true
            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            ColumnLayout {
                id: addTaskDetailsLayout
                width: parent.width

                Label {
                    id: addTaskTitle
                    color: "#ffffff"
                    Layout.fillWidth: true
                    text: qsTr("Add New Task")
                }

                TextField {
                    id: addTaskInput
                    Layout.fillWidth: true
                    placeholderText: qsTr("Today I want to...")
                    font.pixelSize: 12
                }

                Label {
                    id: addTaskDate
                    color: "#ffffff"
                    Layout.fillWidth: true
                    text: mainAddTask.dateToday
                }

            }
        }

        Button {
            id: addTaskButton
            Layout.fillHeight: true
            contentItem:
                Text {
                    text: parent.text
                    font: parent.font
                    opacity: parent.opacity
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            background:
                Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.color: "white"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: "blue" }
                        GradientStop { position: 1 ; color: "turquoise" }
                    }
                }
            text: qsTr("Add")
            scale: 1
            onClicked: {
                mainAddTask.slotAddNewTask(addTaskInput.text, addTaskDate.text)
                addTaskInput.text = "";
            }
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: addNewTaskAnimation
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
            target: addTaskDetailsFrame
            property: "leftPadding"
            Keyframe {
                value: 236
                frame: 0
            }

            Keyframe {
                value: 20
                frame: 1000
            }
        }

        KeyframeGroup {
            target: addTaskDetailsFrame
            property: "opacity"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 850
            }
        }

        KeyframeGroup {
            target: addTaskButton
            property: "scale"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 850
            }
        }
    }
}

