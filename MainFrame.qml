import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

// include qml model from sub prefix : root/Sub_MainFrame
import "Sub_MainFrame"

ColumnLayout {

    // frame : title
    TitleFrame { }

    ColumnLayout {
        id: taskLayout
        Layout.fillHeight:  true
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

        // frame : add new task
        AddNewTaskFrame { }

        // frame : added tasks
        AddedTaskFrame { }

    }

    // columnlayout : main add and added task

    // rowlayout : main add task
    //// columnlayout : details Input
    ////// label : title
    ////// lineedit : task name
    ////// label : today date
    //// button : add button

    // listview : scroller added tasks
    //// rowlayout : main added task
    ////// columnlayout : details
    //////// label : title #taskno
    //////// label : task name
    //////// label : date
    ////// button : delete button

}
