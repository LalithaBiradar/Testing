import QtQuick 2.0

import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Rectangle {
    height: 400
    width: 480
	
    HexButton {
        x:50; y:150
        color: "peru"
        text: "Button 1"
        onClicked:
            console.log("Clicked 1")
    }
	
    HexButton {
        x:168; y:217
        color: "teal"
        text: "Button 2"
        fontsize: 12
        textcolor: "yellow"
        onClicked:
            console.log("Clicked 2")
        onPressAndHold:
            console.log("Long Pressed 2")
    }
	
    HexButton {
        x: 287; y:150
        text: "Button 3"
    }
	
    HexButton {
        x: 168; y: 82
        color: "olive"
        text: "Button 4"
    }
}
