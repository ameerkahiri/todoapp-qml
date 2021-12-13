import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

// include qml model from sub prefix : include root/Repeater from root/Sub_MainFrame
// .. back to root // goto /Repeater
import '../Repeater'

import AddTask 1.0

Frame {
    id: listViewFrame
    Layout.fillWidth: true
    Layout.fillHeight: true
    background: Rectangle {
        color: "transparent"
        border.color: "#53565b"
    }

    ListView {
        id: listView
        transformOrigin: Item.Center
        clip: true
        anchors.fill: parent
        height: parent.height
        spacing: 2

        model:
            MainAddTaskModel {
                tItems: mainAddTask
            }

        delegate:
            AddedTaskElement {}

//        populate: Transition {
//            NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 750 }
//        }

        onContentXChanged: {

                var idx = 0
                if ( listView.atXBeginning ) {
                    idx = 0
                }
                else if ( listView.atXEnd ) {
                    idx = listViewModel.count - 1
                }
                else {
                    idx = listView.indexAt( listView.contentX + listView.width / 2,
                                            listView.y + listView.height / 2 )
                }

                //Do things with idx
                listView.itemAt(idx).width = listView.width

            }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 500 }
            NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 750 }
        }

        addDisplaced: Transition {
            PropertyAction { property: "opacity, scale"; value: 1 }
            NumberAnimation { properties: "y"; duration: 600; easing.type: Easing.InBack }
        }

//        remove: Transition {
//            NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 200 }
//        }

//        removeDisplaced: Transition {
//            PropertyAction { property: "opacity, scale"; value: 0 }
//            NumberAnimation { properties: "x,y"; duration: 500; easing.type: Easing.OutBack }
//        }
    }
}
