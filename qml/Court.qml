import QtQuick
import QtQuick.Shapes




Item {
    id: courtItem
    property double courtSize: 0.9 // the court will take 90% of the screen
    property double nbaCourtWidth: 94
    property double nbaCourtHeight: 50
    property double nbaCourtRatio: nbaCourtHeight/nbaCourtWidth

    Rectangle{
        id: court
        border.color: "black"
        border.width: 2
        anchors.fill: parent

        Rectangle{
            id: halfCourtLine
            border.color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: 2
        }
        Rectangle {
            id: halfCourtCircle
            color: "transparent"
            border.color: "black"
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            property double nbaCenterCircleDia: 12
            width: parent.width * (nbaCenterCircleDia/nbaCourtWidth)
            height: width
            radius: width / 2
        }

        HalfCourt{
            id:leftCourt
            anchors.left: parent.left
        }
        HalfCourt{
            id:rightCourt
            anchors.right: parent.right
            scale: -1
            transformOrigin: Item.Center
        }
    }
}
