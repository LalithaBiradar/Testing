import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.2

import QtQuick 2.7
import QtQuick.Controls 2.0 as QQ2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2


import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0


import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.2

import "../Style"

Item {
    id:keypad
    width: 400
    height: 300
    InputPanel {
        id: inputPanel1

        z: 89
        width: 300
        y: Qt.inputMethod.visible ?  0 :parent.height
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
    //    SpaceKey.enabled: false
    //    anchors.leftMargin: 450
    }
}




