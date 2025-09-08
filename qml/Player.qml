import QtQuick

Item {
    id: player
    property string playerName
    property color teamColor
    property string teamType
    property double playerSize: 0.04
    property double playerFontSize: 0.4
    property bool isClicked
    property bool isPlayerArea
    property bool savedDrawingState
    property Rectangle playerShapeRef: playerShape
    property bool hasBall: false

    Rectangle {
        id: playerShape
        property double normalizedX
        property double normalizedY
        property double startingPositionX:1
        property double startingPositionY:1


        color:
            if(isClicked){
                return Qt.darker(teamColor)
            }
            else if(playerMouseArea.containsMouse){
                return Qt.lighter(teamColor)
            }
            else{
                return teamColor
            }
        width: window.width * playerSize
        height: width
        radius: width/2
        x: normalizedX * court.width
        y: normalizedY * court.height
        Text{
            id: playerText
            anchors.centerIn: parent
            color: "white"
            text: playerName
            font.bold: true
            font.pointSize: Math.max(1, parent.width * playerFontSize)
        }
        MouseArea{
            id: playerMouseArea
            anchors.fill: parent
            drag.target: parent
            hoverEnabled: true
            onPositionChanged: {
                playerShape.normalizedX = playerShape.x / court.width
                playerShape.normalizedY = playerShape.y / court.height
                console.log("player.x",player.playerName, ": ", playerShape.x)
                console.log("player.y",player.playerName, ": ", playerShape.y)
            }
            onEntered:{
                player.isPlayerArea = true
                savedDrawingState = drawButton.isDrawing
                drawButton.isDrawing = false

            }
            onExited:{
                drawButton.isDrawing = savedDrawingState
                player.isPlayerArea = false
            }
            onClicked:{
                isClicked = !isClicked
                console.log("isClicked", isClicked)
            }
        }
        Component.onCompleted: {
                normalizedX = startingPositionX / court.width
                normalizedY = startingPositionY / court.height
            }
    }
    Component.onDestruction: {
        hasBall: false
    }
}
