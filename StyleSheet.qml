pragma Singleton

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

QtObject {

    property QtObject rectBorder : QtObject {
//        property Rectangle none: Rectangle {
//            border.color: none
//        }
        property Rectangle grey: Rectangle {
            border.color: "red"
        }
    }


    property QtObject Rectangle: QtObject {
        property color background: "white"
    }
    property QtObject border: QtObject {
        property QtObject width: QtObject {
            property int normal: 1
            property int big: 3
        }
        property QtObject color: QtObject {
            property color normal: "gray"
            property color focus: "blue"
            property color disabled: "red"
        }
    }
}
