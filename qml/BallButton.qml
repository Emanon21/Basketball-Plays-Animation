import QtQuick
import QtQuick.Controls

Item {
    id: addBallButton
    anchors.fill: parent
    property double buttonSizeWidth: 0.10
    property double buttonSizeHeight: 0.05
    property Item court
    property Item newBall: null
    property Item toPlayer: null
    property Item fromPlayer: null
    property Item selected: null

    Button{
        id: ballButton
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: buttonSizeWidth * parent.width
        height: buttonSizeHeight * parent.height
        text: "add ball"
        onClicked: {
            var children = court.children
            for (var i = 0; i < children.length; ++i){
                if(children[i].isClicked){
                    selected = children[i]
                    break;
                }
            }
            if(selected){
                if(!selected.hasBall){
                    newBall = ballComponent.createObject(selected.playerShapeRef, {x: 0, y: 0})
                    selected.hasBall = true
                }
            }
            else {
                console.warn("No player selected to add a ball")
            }
        }
    }



    Button{
        id: passButton
        anchors.left: deleteBall.right
        anchors.bottom: parent.bottom
        width: buttonSizeWidth * parent.width
        height: buttonSizeHeight * parent.height
        text: "pass ball"
        onClicked: {
            if (!newBall) return;
                var children = court.children

                for (var i = 0; i < children.length; ++i) {
                    if (children[i].hasBall) { fromPlayer = children[i]; break }
                }

                for (var j = 0; j < children.length; ++j) {
                    if (children[j].isClicked && children[j] !== fromPlayer) { toPlayer = children[j]; break }
                }

                if (!fromPlayer || !toPlayer) {
                    console.warn("Cannot pass: missing from or to player")
                    return
                }

                var targetPos = toPlayer.playerShapeRef.mapToItem(newBall.parent, 0, 0)

                ballXAnim.target = newBall
                ballYAnim.target = newBall

                ballXAnim.from = newBall.x
                ballXAnim.to = targetPos.x
                ballYAnim.from = newBall.y
                ballYAnim.to = targetPos.y

                passAnim.running = true

                fromPlayer.hasBall = false
                toPlayer.hasBall = true
            }
    }

    Button{
        id: deleteBall
        anchors.left: ballButton.right
        anchors.bottom: parent.bottom
        width: buttonSizeWidth * parent.width
        height: buttonSizeHeight * parent.height
        text: "delete ball"
        onClicked:{
            var children = court.children
            var ballOwner = null
            for (var i = 0; i < children.length; ++i) {
                if (children[i].hasBall) {
                    ballOwner = children[i]
                    break
                }
            }

            if (ballOwner) {
                newBall.destroy()
                ballOwner.hasBall = false
            }
        }
    }



    NumberAnimation {
        id: ballXAnim
        property: "x"
        duration: 1000
        easing.type: Easing.OutSine
    }

    NumberAnimation {
        id: ballYAnim
        property: "y"
        duration: 1000
        easing.type: Easing.OutSine
    }

    ParallelAnimation {
        id: passAnim
        animations: [ballXAnim, ballYAnim]
        running: true
        onStopped:{
            if (newBall && toPlayer) {
                    newBall.destroy()
                    newBall = ballComponent.createObject(toPlayer.playerShapeRef, {x: 0, y: 0})
                }
        }
    }


    Component{
        id: ballComponent
        Ball{}
    }
}
