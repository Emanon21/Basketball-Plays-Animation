import QtQuick
import QtQuick.Shapes

Item {
    id:halfCourt
    anchors.fill: parent
    property double nbaCourtWidth: 94
    property double nbaCourtHeight: 50
    property double ftWidth: 19
    property double ftHeigth: 16
    property double nbaFreethrowCir: 12
    property double nbaRimDia: 1.5
    property double boardtoRim: 0.5
    property double heightofBoard: 6
    property double nbaBaseLinetoBoard: 4
    property double sideLinetoCornerThree: 3
    property double cornerThreeLength: 14
    property double nbaThreefromBaseLine: 27.9
    property double sideLineHash: 28
    property double baseLineHash: 3
    property double hashLengthSideLine: 2
    property double hashLengthBaseLine: 0.6
    property double freeThrowHashDistance: 3
    property double freeThrowHashLength: 0.6
    property double baseLinetoRestrictedArea: 4
    property double topSideLinetoRestrictedArea: 21
    property double bottomSideLinetoRestrictedArea: 29
    property double rimCenter: rim.x + rim.width / 2
    property double restrictedAreaRadiusY: 0.8

    Rectangle{
        id: freeThrow
        z: 2
        border.color: "black"
        border.width: 2
        color: "transparent"
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width: parent.width * (ftWidth/nbaCourtWidth)
        height: parent.height * (ftHeigth/nbaCourtHeight)
    }
    Rectangle{
        id: freeThrowArc
        z:1
        border.color: "black"
        border.width: 2
        anchors{
            horizontalCenter: freeThrow.right
            verticalCenter: freeThrow.verticalCenter
        }

        width: parent.width * (nbaFreethrowCir/nbaCourtWidth)
        height: width
        radius: width/2
    }

    Rectangle{
        id: board
        z: 3
        border.color: "orange"
        anchors.verticalCenter: parent.verticalCenter
        x: parent.width * (nbaBaseLinetoBoard/nbaCourtWidth)
        width: 2
        height: parent.height * (heightofBoard/nbaCourtHeight)

        Rectangle{
            id: boardToRimLine
            color: "orange"
            anchors.verticalCenter: board.verticalCenter
            width: halfCourt.width * (boardtoRim/nbaCourtWidth)
            height: 8
        }
        Rectangle{
            id: rim
            border.color: "orange"
            width: halfCourt.width * (nbaRimDia/nbaCourtWidth)
            height: width
            radius: width/2
            anchors.verticalCenter: board.verticalCenter
            x: (board.x + halfCourt.width) * (boardtoRim/nbaCourtWidth)
        }
    }
    Shape{
        id: restrictedArea
        ShapePath{
            strokeWidth: 2
            strokeColor: "black"
            startX: halfCourt.width * (baseLinetoRestrictedArea/nbaCourtWidth); startY: halfCourt.height * (topSideLinetoRestrictedArea/nbaCourtHeight)
            PathArc{
                x: halfCourt.width * (baseLinetoRestrictedArea/nbaCourtWidth); y: halfCourt.height * (bottomSideLinetoRestrictedArea/nbaCourtHeight)
                radiusX: rimCenter + halfCourt.height * (baseLinetoRestrictedArea/nbaCourtWidth); radiusY: radiusX * restrictedAreaRadiusY
            }
        }
    }
    Item{
        id: threePointLine
        anchors.fill: parent
        Rectangle{
            id: topCornerThree
            border.color: "black"
            anchors.left: parent.left
            y: halfCourt.height * (sideLinetoCornerThree/nbaCourtHeight)
            width: halfCourt.width * (cornerThreeLength/nbaCourtWidth)
            height: 2
        }
        Rectangle{
            id: bottomCornerThree
            border.color: "black"
            anchors.left: parent.left
            y: halfCourt.height - (halfCourt.height * (sideLinetoCornerThree/nbaCourtHeight))
            width: halfCourt.width * (cornerThreeLength/nbaCourtWidth)
            height: 2
        }
        Shape{
            id: threePointArc
            anchors.fill: parent
            ShapePath{
                id:arc
                strokeColor: "black"
                strokeWidth: 2
                startX: topCornerThree.x + topCornerThree.width; startY: topCornerThree.y + topCornerThree.height / 2 //get the middle of the corner line
                PathArc{
                    x: bottomCornerThree.x + bottomCornerThree.width; y: bottomCornerThree.y + topCornerThree.height / 2 //get the middle of the corner line
                    property double nbaArcCalc: nbaThreefromBaseLine - cornerThreeLength
                    radiusX:halfCourt.width * (nbaArcCalc/nbaCourtWidth) ; radiusY: (bottomCornerThree.y - topCornerThree.y) * 0.4
                    useLargeArc: false
                }
            }
        }
    }
    Item{
        id: hashLines
        anchors.fill: parent
        Shape{
            anchors.fill: parent
            ShapePath{
                id:topSideLineHash
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * (sideLineHash/nbaCourtWidth); startY: halfCourt.y
                PathLine{x: halfCourt.width * (sideLineHash/nbaCourtWidth); y: halfCourt.height * (hashLengthSideLine/nbaCourtHeight)}
            }
            ShapePath{
                id:bottomSideLineHash
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * (sideLineHash/nbaCourtWidth); startY: halfCourt.height
                PathLine{x: halfCourt.width * (sideLineHash/nbaCourtWidth); y: halfCourt.height - (halfCourt.height * (hashLengthSideLine/nbaCourtHeight))}
            }
            ShapePath{
                id:topBaseLineHash
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.x; startY: halfCourt.height * ((ftHeigth - baseLineHash)/nbaCourtHeight)
                PathLine{x: halfCourt.width * (hashLengthBaseLine/nbaCourtWidth); y:halfCourt.height * ((ftHeigth - baseLineHash)/nbaCourtHeight) }
            }
            ShapePath{
                id:bottomBaseLineHash
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.x; startY: halfCourt.height - (halfCourt.height * ((ftHeigth - baseLineHash)/nbaCourtHeight))
                PathLine{x: halfCourt.width * (hashLengthBaseLine/nbaCourtWidth); y:halfCourt.height - (halfCourt.height * ((ftHeigth-baseLineHash)/nbaCourtHeight)) }
            }
            /*
              The plus one in the free throw line hash
              is the one feet distance between first and second hash
            */

            ShapePath{
                id:topFreeThrowHash1
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + freeThrowHashDistance)/nbaCourtWidth); startY:freeThrow.y
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + freeThrowHashDistance)/nbaCourtWidth); y: freeThrow.y - halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
            ShapePath{
                id:topFreeThrowHashNextToHash1
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance + 1))/nbaCourtWidth); startY:freeThrow.y // plus 1 because theres another hash next to the first
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance + 1))/nbaCourtWidth); y: freeThrow.y - halfCourt.height * (freeThrowHashLength/nbaCourtHeight)}
            }
            ShapePath{
                id:topFreeThrowHash2
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance  * 2) + 1)/nbaCourtWidth); startY:freeThrow.y //multiple to 2 because its the third hash
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 2) + 1)/nbaCourtWidth); y: freeThrow.y - halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
            ShapePath{
                id:topFreeThrowHash3
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 3) + 1)/nbaCourtWidth); startY:freeThrow.y //multiple to 3 because its the third hash
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 3) + 1)/nbaCourtWidth); y: freeThrow.y - halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
            ShapePath{
                id:bottomFreeThrowHash1
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + freeThrowHashDistance)/nbaCourtWidth); startY:freeThrow.y + freeThrow.height
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + freeThrowHashDistance)/nbaCourtWidth); y: (freeThrow.y + freeThrow.height) + halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
            ShapePath{
                id:bottomFreeThrowHashNextToHash1
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance + 1))/nbaCourtWidth); startY:freeThrow.y + freeThrow.height // plus 1 because theres another hash next to the first
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance + 1))/nbaCourtWidth); y: (freeThrow.y + freeThrow.height) + halfCourt.height * (freeThrowHashLength/nbaCourtHeight)}
            }
            ShapePath{
                id:bottomFreeThrowHash2
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 2) + 1)/nbaCourtWidth); startY:freeThrow.y + freeThrow.height //multiple to 2 because its the third hash
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 2) + 1)/nbaCourtWidth); y: (freeThrow.y + freeThrow.height) + halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
            ShapePath{
                id:bottomFreeThrowHash3
                strokeColor: "black"
                strokeWidth: 2
                startX: halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 3) + 1)/nbaCourtWidth); startY:freeThrow.y + freeThrow.height //multiple to 3 because its the third hash
                PathLine{x:halfCourt.width * ((nbaBaseLinetoBoard + (freeThrowHashDistance * 3) + 1)/nbaCourtWidth); y: (freeThrow.y + freeThrow.height) + halfCourt.height * (freeThrowHashLength/nbaCourtHeight) }
            }
        }
    }
}
