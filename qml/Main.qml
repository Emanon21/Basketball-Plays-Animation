import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Court {
        id:court  
        anchors.centerIn: parent
        width: parent.width * courtSize
        height: width * nbaCourtRatio
    }

    AddPlayerButton{
        z:1
        id: addPlayerButton
        court: court
    }

    DrawButton{
        id: drawButton
        court: court
    }

    BallButton{
        id: ballButton
        court: court
    }
}
