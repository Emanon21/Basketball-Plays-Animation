import QtQuick
import QtQuick.Controls

Item {
    id: addPlayerButton
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    property double buttonSize: 0.10
    property int maxPlayersByTeam: 5
    property int offensePlayerCount: 0
    property int defensePlayerCount: 0
    property var offensePlayers: []
    property var defensePlayers: []
    property Item court

    function getNextOffensePlayer(){
        var names = ["PG", "SG", "SF", "PF", "C"]
        for(var i = 0; i < names.length; ++i){
            if(offensePlayers.indexOf(names[i]) === -1){
                return names[i]
            }
        }
    }

    function getNextDefensePlayer(){
        var names = ["PG", "SG", "SF", "PF", "C"]
        for(var i = 0; i < names.length; ++i){
            if(defensePlayers.indexOf(names[i]) === -1){
                return names[i]
            }
        }
    }


    Button{
        id: addOffensePlayerButton
        width: buttonSize * window.width
        height: buttonSize * window.height
        anchors.bottom: parent.bottom
        anchors.right: addDefensePlayerButton.left
        text: "Add Offense Player"
        onClicked: {
            var playerName = getNextOffensePlayer()
            if(offensePlayerCount < maxPlayersByTeam){
                offensePlayerCount += 1
                var newPlayer = playerComponent.createObject(court, {playerName: playerName, teamColor: "blue", teamType: "offense"})
                offensePlayers.push(playerName)
            }
            console.log("Offense Count: ", offensePlayerCount)
        }
    }
    Button{
        id: addDefensePlayerButton
        width: buttonSize * window.width
        height: buttonSize * window.height
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.right
        text: "Add Defense Player"
        onClicked: {
            var playerName = getNextDefensePlayer()
            if(defensePlayerCount < maxPlayersByTeam){
                defensePlayerCount += 1
                var newPlayer = playerComponent.createObject(court, {playerName: playerName, teamColor: "red", teamType: "defense"})
                defensePlayers.push(playerName)
            }
            console.log("Defense Count: ", defensePlayerCount)
        }
    }
    Button{
        id: deletePlayer
        width: buttonSize * window.width
        height: buttonSize * window.height
        anchors.bottom: parent.bottom
        anchors.left: addDefensePlayerButton.right
        text: "Delete Player"
        onClicked:{
            var children = court.children
            console.log("court children: ", children.length)
            for(var i = children.length - 1; i >= 0; --i){
                if(children[i].isClicked){
                    var removeName = children[i].playerName
                    if(children[i].teamType === "offense"){
                        offensePlayerCount -= 1
                        var indexOffense = offensePlayers.indexOf(removeName)
                        if(indexOffense !== -1){offensePlayers.splice(indexOffense, 1)}
                    }
                    else{
                        defensePlayerCount -= 1
                        var indexDefense = defensePlayers.indexOf(removeName)
                        if(indexDefense !== -1){defensePlayers.splice(indexDefense, 1)}

                    }
                    children[i].destroy()
                }
            }
        }
    }

    Component{
        id: playerComponent
        Player {}
    }
}
