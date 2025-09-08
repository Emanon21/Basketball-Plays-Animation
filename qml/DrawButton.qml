import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent
    property bool isDrawing: false
    property Item court
    property double buttonSize: 0.10

    Canvas {
        id: paintCanvas
        z:-1
        property var lastPoint: null
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            enabled: isDrawing
            acceptedButtons: {Qt.LeftButton | Qt.RightButton}
            onPressed: function(mouse){
                paintCanvas.lastPoint = Qt.point(mouse.x, mouse.y)
            }
            onPositionChanged: function(mouse){
                if (mouse.buttons & Qt.LeftButton | mouse.buttons & Qt.RightButton) {
                    var ctx = paintCanvas.getContext("2d")
                    ctx.beginPath()
                    ctx.moveTo(paintCanvas.lastPoint.x, paintCanvas.lastPoint.y)
                    ctx.lineTo(mouse.x, mouse.y)
                    if(mouse.buttons & Qt.RightButton){
                        ctx.globalCompositeOperation = "destination-out"
                        ctx.lineWidth = 100
                    }
                    else{
                        ctx.globalCompositeOperation = "source-over"
                        ctx.lineWidth = 2
                        ctx.strokeStyle = "black"
                    }

                    ctx.stroke()
                    paintCanvas.requestPaint()
                    paintCanvas.lastPoint = Qt.point(mouse.x, mouse.y)
                }
            }
        }
    }

    Button{
        id:clearButton
        width: buttonSize * parent.width
        height: buttonSize * parent.height
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        text: "clear"
        onClicked: {
            var ctx = paintCanvas.getContext("2d")
            ctx.clearRect(0, 0, paintCanvas.width, paintCanvas.height)
            paintCanvas.requestPaint()
        }
    }

    Button{
        id: drawButton
        width: buttonSize * parent.width
        height: buttonSize * parent.height
        anchors.bottom: parent.bottom
        anchors.right: clearButton.left
        text: "draw"
        onClicked:{
            root.isDrawing = !root.isDrawing
            console.log("isDrawing: ", root.isDrawing)
        }
    }
}
