import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0


Frame {
    id: itemElement
    property int indexOfThisDelegate: index //or itemElement.index
    width: listView.width

//    width: itemElement.visible === true ? listView.width : 0  // the magnifying/shrinking
//    Behavior on width {                    // added to smooth the resizing
//        NumberAnimation { duration: 100 }
//    }

    scale: 1
    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0 ; color: Qt.rgba(Math.random(),0,Math.random(),1); }
            GradientStop { position: 1 ; color: "#2D2B2B" }
        }
        radius: 2
        border.color: "#53565b"
    }

    RowLayout {
        width: parent.width

        Frame {
            Layout.fillWidth: true
            background: Rectangle {
                border.color: "transparent"
                color: "transparent"
            }

            ColumnLayout {
                width: parent.width

                Label {
                    id: addedTaskTitle
                    color: "white"
                    Layout.fillWidth: true
                    text: model.mtaskTitle
                }

                Label {
                    id: addedTaskName
                    font.pixelSize: 13
                    font.bold: true
                    color: "white"
                    Layout.fillWidth: true
                    text: model.mtaskName
                }

                Label {
                    id: addedTaskDate
                    color: "white"
                    Layout.fillWidth: true
                    text: model.mtaskDate
                }

            }
        }

        Button {
            id: addedTaskButton
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.fillHeight: true
            contentItem:
                Text {
                    text: addedTaskButton.text
                    font: addedTaskButton.font
                    opacity: addedTaskButton.opacity
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
                        GradientStop { position: 0 ; color: "red" }
                        GradientStop { position: 1 ; color: "orange" }
                    }
                }
            text: qsTr("Delete")
            onClicked: {
                itemElement.state = 'deletedState'
                //mainAddTask.slotDeleteTask(indexOfThisDelegate) //or indexOfThisDelegate = itemElement.index
            }
        }

    }

    Timeline {
        id: addedTaskTimeline
        animations: [
            TimelineAnimation {
                id: deleteAddedTaskAnimation
                running: false
                duration: 1000
                loops: 1
                to: 1000
                from: 0
                onFinished: mainAddTask.slotDeleteTask(indexOfThisDelegate)
            },
            TimelineAnimation {
                id: introAddedTaskAnimation
                running: true
                duration: 1000
                loops: 1
                to: 2000
                from: 1050
            }
        ]
        startFrame: 0
        enabled: true
        endFrame: 3000

        KeyframeGroup {
            target: itemElement
            property: "leftPadding"
            Keyframe {
                value: 300
                frame: 1000
            }

            Keyframe {
                value: 15
                frame: 1051
            }

            Keyframe {
                value: 12
                frame: 1050
            }
        }

        KeyframeGroup {
            target: itemElement
            property: "opacity"
            Keyframe {
                value: 1
                frame: 0
            }

            Keyframe {
                value: 0
                frame: 851
            }

            Keyframe {
                value: 1
                frame: 2000
            }

            Keyframe {
                value: 0
                frame: 1050
            }
        }

        KeyframeGroup {
            target: itemElement
            property: "scale"

            Keyframe {
                easing.bezierCurve: [0.23,1,0.32,1,1,1]
                value: 0
                frame: 1051
            }

            Keyframe {
                easing.bezierCurve: [0.23,1,0.32,1,1,1]
                value: 1
                frame: 2001
            }

            Keyframe {
                value: 1
                frame: 1000
            }
        }
    }
    states: [
        State {
            name: "deletedState"

            PropertyChanges {
                target: deleteAddedTaskAnimation
                running: true
            }
        }
    ]

}
