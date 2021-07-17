import QtQuick 2.0

Item {
    id: hexButton
    width: 150
    height: Math.round(width * 0.866)
    property alias color: dummy.color
    property alias text: dummytext.text
    property alias textcolor: dummytext.color
    property alias fontsize: dummytext.font.pointSize
    signal clicked()
    signal pressAndHold()

    Rectangle { // ugly hack for aliasing button color. Must be a better way?
        id: dummy
        width: 1; height:1
        opacity: 0
        color: "steelblue"
    }
    Text {
        id: dummytext
        text: "HexButton"
        color: "white"
        font.pointSize: 14
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex
            height: Math.round(hexButton.width * 0.866 * dummy.scale)
            width:  Math.round(height / 1.732)
            color: dummy.color
            rotation: index * 120
            anchors.centerIn: parent
            antialiasing: true
            Text {
                text: (index == 2)? dummytext.text : ""
                rotation: 120
                anchors.centerIn: parent
                color: dummytext.color
                font.pointSize: dummytext.font.pointSize
                style: Text.Raised
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
         //           hexButton.clicked()
                    pulseAnim.running = true
                }
                onPressAndHold:
                    hexButton.pressAndHold()

            }
        }
    }
    SequentialAnimation {
        id: pulseAnim
        running: false
        loops: 1
        PropertyAnimation { target: dummy; property: "scale"; from: 1.0; to: 1.1; duration: 100; }
        PropertyAnimation { target: dummy; property: "scale"; from: 1.1; to: 1.0; duration: 100; }

        // The stopped() signal is emitted when animation ends. It is only triggered for top-level,
        // standalone animations. It will not be triggered for animations in a Behavior or Transition,
        // or animations that are part of an animation group.
        onStopped: { hexButton.clicked(); }
    }

}
