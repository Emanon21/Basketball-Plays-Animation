import QtQuick

Item {
    id: ball
    z:1

    Rectangle{
        id: ballShape
        width: 0.02 * window.width
        height: width
        radius: width/2
        color: "orange"
        border.color: "black"
    }
}
