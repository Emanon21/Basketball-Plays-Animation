import QtQuick
import QtQuick.Controls

Item {
    id: addBallButton
    anchors.fill: parent
    property double buttonShape: 0.10
    property Item court

    Button{
        id: ballButton
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: buttonShape * window.width
        height: buttonShape * window.height
        text: "add ball"
        onClicked: {
            var selected = null
            var children = court.children
            for (var i = 0; i < children.length; ++i){
                if(children[i].isClicked){
                    selected = children[i]
                }
            }
            if(selected){
                if(!selected.hasBall){
                    var newBall = ballComponent.createObject(selected.playerShapeRef, {x: 0, y: 0})
                    selected.hasBall = true
                    console.log("Ball created for", selected.playerName)
                }
            }
            else {
                console.warn("No player selected to add a ball")
            }
        }
    }

    Component{
        id: ballComponent
        Ball{}
    }
}
