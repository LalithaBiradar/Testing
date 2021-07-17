import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Controls 2.0 as QQ2
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.0

import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.VirtualKeyboard 2.1

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtQuick 2.1 as QQ2

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
//import "../Style"
//import "notifications.js" as NotificationData
Item {

    id:systeminfo

    Label {
         id: title_id
         x: 483
         y: 214
         width: 380
         height: 39
         color: "yellow"
         text: qsTr("SYSTEM INFO")
         font.bold: true
         font.pointSize: 28
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignHCenter
     }




     Rectangle {
         id: titleRect
         x: 434
         y: 194
         width: 465
         height: 64
         color: "#00000000"
         border.width: 3
         border.color: "#6b0bb9"
     }




     Rectangle {
         id: operatingsyst_rect
         x: 434
         y:  372  //416
         width: 465
         height: 119
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3

         Label {
             id: operatingsys_lbl
             x: 20  //24
             y: 30
             width: 187
             height: 60
             color: "white"
             text: qsTr("OPERATING  :  Linux\nSYSTEM ")
            // verticalAlignment: Text.AlignVCenter
            // horizontalAlignment: Text.AlignHCenter
            // font.bold: true
             font.pointSize: 20
         }


     }

     Rectangle {
         id: memory1_rect
         x: 434
         y:  489  //532
         width: 465
         height: 119
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3

         Label {
             id: memory1_lbl
             x:  20 //28
             y: 39
             width: 219
             height: 60
             color: "white"
             text: qsTr("MEMORY SIZE  :  15GB")
          //   verticalAlignment: Text.AlignVCenter
         //    horizontalAlignment: Text.AlignHCenter
             font.bold: false
             font.pointSize: 20
         }


     }

     Rectangle {
         id: processorRect
         x: 434
         y: 260   //299
         width: 465
         height: 119
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3

         Label {
             id: processor_lbl
             x: 20
             y: 30
             width: 187
             height: 60
             color: "white"
             text: qsTr("PROCESSOR :  ARM")
             font.bold: false
             font.pointSize: 20
             // verticalAlignment: Text.AlignVCenter
             //  horizontalAlignment: Text.AlignHCenter
         }


     }

     Rectangle {
         id: ram_rect
         x: 434
         y:  605  //649
         width: 465
         height: 119
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3

         Label {
             id: ram_lbl
             x: 23 //29
             y: 30
             width: 276
             height: 60
             color: "white"
             text: qsTr("RAM      :    2GB")
             // verticalAlignment: Text.AlignVCenter
             //  horizontalAlignment: Text.AlignHCenter
             font.bold: false
             font.pointSize: 20
         }


     }

     Label {
         id: title_id1
         x: 965
         y: 214
         width: 380
         height: 39
         color: "#ffff00"
         text: qsTr("SOFTWARE INFO")
         horizontalAlignment: Text.AlignHCenter
         font.bold: true
         font.pointSize: 28
         verticalAlignment: Text.AlignVCenter
     }

     Text{
         id: swver
         x: 958
         y: 291
         width: 352
         height: 83
         //text: "NAME : CWGX\nVERSION : V03.01.27.04.2021"
         text: "NAME : CWGX\nVERSION : V03.01.09.07.2021"
         font.pointSize: 20
         color: "white"

     }

     Rectangle {
         id: titleRect1
         x: 912
         y: 194
         width: 465
         height: 64
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3
     }

     Rectangle {
         id: titleRect2
         x: 912
         y: 259
         width: 465
         height: 115
         color: "#00000000"
         border.color: "#6b0bb9"
         border.width: 3
     }



}
