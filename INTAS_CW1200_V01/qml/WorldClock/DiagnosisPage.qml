/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

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
import QtQuick.Window 2.1
import QtQuick.Extras 1.4

//import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.1






//import QtQuick 2.7


//import QtQuick.Controls 2.0 as QQ2
//import QtQuick.Window 2.2
//import QtQuick.Layouts 1.3
//import Qt.labs.settings 1.0
//import QtQuick.Controls 2.2


//import QtQuick.Controls 1.2
//import QtQuick.Controls.Private 1.0
//import QtQuick.Controls.Styles 1.4
////import QtGraphicalEffects 1.0


//import QtQuick 2.6
//import QtQuick.Controls 2.1
//import QtQuick.LocalStorage 2.0
//import QtQuick.Dialogs 1.2
import "../Style"
Item {
    id: diagnosis

//    property int hours
//    property int minutes
//    property int seconds
//    property real shift: timeShift
//    property bool night: false
//    property bool internationalTime: true //Unset for local time

    property string calibmsg1
    property string previlageStatus
    property bool acess: true
    property alias okampBtnText: okampBtn.text


    enabled: UIStyle.idleforfg



    Connections{
        target: savetextfield
       onDisablescr1:{
            console.log("login action in diagnosis")
           if(cnt == 1){
           diagnosis.enabled = false

           }
           if(cnt == 2){
           diagnosis.enabled = true

           }
        }
//       onPrevilage_status:{
//           previlageStatus = text
//           console.log("The status from cpp is:"+previlageStatus)
//           for(var i = 0; i < previlageStatus.length; i++) {
//           if(previlageStatus.charAt(i) != "3"){
//       //        calb_button.enabled = false
//               acess = false
//           }
//           else{
//      //         calb_button.enabled = true
//               acess = true
//           }

//           }
//       }
    }

//    function getWatchFaceImage(imageName) {
//        return "images/" + imageName
//    }

//    function timeChanged() {
//        var date = new Date
//        hours = internationalTime ? date.getUTCHours() + Math.floor(
//                                        diagnosis.shift) : date.getHours()
//        night = (hours < 7 || hours > 19)
//        minutes = internationalTime ?
//         date.getUTCMinutes() + ((diagnosis.shift % 1) * 60) : date.getMinutes()
//        seconds = date.getUTCSeconds()
//    }

    Connections{
        target: handle_loadcellcalls

        onHandlediagnos_sts:{

            if(cnt==1)
            {
                sensor1Indicator.active = true
            }
            if(cnt==2)
            {
                sensor2Indicator1.active = true

            }
            if(cnt==3)
            {
                sensor3Indicator.active = true

            }
            if(cnt==4)
            {
                airprsIndicator.active = true

            }
            if(cnt==5)
            {
                estopIndicator.active = true

            }
            if(cnt==6)
            {
                rvsensorIndicator.active = true

            }

            if(cnt==10)
            {
                sensor1Indicator.active = false
            }
            if(cnt==20)
            {
                sensor2Indicator1.active = false

            }
            if(cnt==30)
            {
                sensor3Indicator.active = false

            }
            if(cnt==40)
            {
                airprsIndicator.active = false

            }
            if(cnt==50)
            {
                estopIndicator.active = false


            }
            if(cnt==60)
            {
                rvsensorIndicator.active = false

            }



            if(cnt==11)
            {
                 uwIndicator.active = true
            }
            if(cnt==110)
            {
                uwIndicator.active = false
            }

            if(cnt==12)
            {
                 okIndicator1.active = true
            }
            if(cnt==120)
            {
                 okIndicator1.active = false
            }

            if(cnt==13)
            {
                 owlmpIndicator2.active = true
            }
            if(cnt==130)
            {
                 owlmpIndicator2.active = false
            }







        }


    }


    Dialog {
            id: authFailDialog
            width: warmMsg1.contentWidth + 200
            height: 300
            x:21
            y:191
            visible: false
    //          standardButtons: StandardButton.Ok
    //          title:  "Login Failed!!!"
             closePolicy: Popup.CloseOnEscape
             background: Rectangle{
                        color: "aquamarine"
                        radius: 5
                        border.color: "mediumturquoise"
                    }

                    header: Rectangle{
                        width:150
                        height: 40
                        color: "mediumturquoise"
                        border.color: "aquamarine"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "Authorization Failed!!!"
                            font.pixelSize: 20
                            color: "black"
                        }
                    }
       contentItem: FocusScope{
            Column {
                id: loginFailColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are not Authorized to use this function!!";color:UIStyle.colorCandyPink}
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
                 Button{
                     Label{
                         anchors.centerIn: parent
                         text: "OK"
                         font.pixelSize: 20
                     }
          //          isDefault: true
                     focus: true
                     width: 150
                     height: 80
                     onClicked:{authFailDialog.close()}
                 }
            }

       }

    }


    //-------------------------------------------------------------
    Dialog {
            id: acessDialog
            width: acessMsg.contentWidth + 200
            height: 200
            x:294
            y:491
            visible: false
  //          title:  "Logout Success!!!"
  //          closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                       color: "peru"
                       radius: 5
                       border.color: "mediumturquoise"
                   }

                   header: Rectangle{
                       width:150
                       height: 60
                       color: "mediumturquoise"
                       border.color: "aquamarine"
                       radius: 5
                       Text{
                           anchors.centerIn: parent
                           text: "ACCESS !!!"
                           font.pixelSize: 30
                           color: "black"
                       }
                   }
         contentItem: FocusScope{
            Column {
                id: previlageColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:acessMsg;font.pixelSize:UIStyle.fontSizeXXL;text:"Access is too low to use this action !!" ;color:UIStyle.colorQtblk}
                }
            }

         }

    }

    StatusIndicator {
        id: sensor1Indicator
        x: 341
        y: 186
        width: 100
        height: 100
        active: false
        color: active ? "green" : "red"
    }

//    Button {
//        id: button
//        x: 63
//        y: 681
//        width: 150
//        height: 100
//        text: qsTr("status on/off")
//        onClicked: {/*statusIndicator.active = true;*/sensor1Indicator.active = !sensor1Indicator.active}
//    }

    Label {
        id: sensor1_lbl
        x: 45
        y: 211
        width: 187
        height: 60
        text: qsTr("SENSOR - 1")
        color: "white"
        font.bold: false
        font.pointSize: 20
        fontSizeMode: Text.FixedSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: input_lbl
        x: 70
        y: 141
        width: 380
        height: 39
        color: "yellow"
        text: qsTr("INPUTS")
        font.bold: true
        font.pointSize: 28
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        id: rectangle
        x: 21
        y: 121
        width: 465
        height: 64
        color: "#00000000"
        border.width: 3
        border.color: "#6b0bb9"
    }

    Rectangle {
        id: rectangle1
        x: 21
        y: 183
        width: 465
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3
    }

    Rectangle {
        id: sensor2_rect
        x: 21
        y: 299
        width: 465
        height: 119
        color: "#00000000"
        border.width: 3
        border.color: "#6b0bb9"

        Label {
            id: sensor2_lbl
            x: 26
            y: 30
            width: 187
            height: 60
            color: "white"
            text: qsTr("SENSOR - 2")
            font.bold: false
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: sensor2Indicator1
            x: 320
            y: 11
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }
    }

//    Rectangle {
//        id: rectangle3
//        x: 38
//        y: 362
//        width: 200
//        height: 200
//        color: "#00000000"
//    }

    Rectangle {
        id: sensor3_rect
        x: 21
        y: 416
        width: 465
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3

        Label {
            id: sensor3_lbl
            x: 24
            y: 30
            width: 187
            height: 60
            color: "white"
            text: qsTr("SENSOR - 3")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 20
        }

        StatusIndicator {
            id: sensor3Indicator
            x: 322
            y: 11
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }
    }

    Rectangle {
        id: estop_rect
        x: 21
        y: 532
        width: 465
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3

        Label {
            id: estop_lbl
            x: 28
            y: 39
            width: 219
            height: 60
            color: "white"
            text: qsTr("E-STOP SWITCH")
            font.bold: true
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: estopIndicator
            x: 327
            y: 15
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }
    }

    Rectangle {
        id: airpres_rect
        x: 21
        y: 649
        width: 465
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3

        Label {
            id: airpres_lbl
            x: 29
            y: 36
            width: 205
            height: 60
            color: "white"
            text: qsTr("AIR PRESSURE")
            font.bold: true
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: airprsIndicator
            x: 329
            y: 16
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }
    }

    Rectangle {
        id: uw_rect
        x: 485
        y: 182
        width: 589
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3

        Label {
            id: uw_lbl
            x: 17
            y: 30
            width: 187
            height: 60
            text: qsTr("UW LAMP")
            color: "white"
            font.bold: true
            font.pointSize: 24
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: uwIndicator
            x: 261
            y: 11
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }

        HexButtond{
            id:uwlampBtn
            x:384
            y:20
            width:120
            height: 80
            //    text: "OFF"
            text: active ? "ON" : "OFF"
            color: "chartreuse"
            onClicked:{

                if(uwlampBtn.active==true)
                {

                    handle_loadcellcalls.output_diagnosst(1)
                  //  uwIndicator.active = true

                    console.log("ACTIVE")
                }
                else
                {


                    handle_loadcellcalls.output_diagnosst(10)
                    console.log("INACTIVE")
                   // uwIndicator.active = false

                }


             }
        }

    }

    Rectangle {
        id: ok_rect
        x: 485
        y: 300
        width: 589
        height: 119
        color: "#00000000"
        border.width: 3
        border.color: "#6b0bb9"

        Label {
            id: ok_lbl
            x: 15
            y: 30
            width: 187
            height: 60
            text: qsTr("OK LAMP")
            color: "white"
            font.bold: true
            font.pointSize: 24
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: okIndicator1
            x: 261
            y: 11
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }

        HexButtond {
            id: okampBtn
            x: 386
            y: 20
            width: 120
            height: 80
            text: active ? "ON" : "OFF"
            color: "chartreuse"
            onClicked:{

                if(okampBtn.active==true)
                {

                    handle_loadcellcalls.output_diagnosst(2)
//                    okIndicator1.active = true

                    console.log("ACTIVE")
                }
                else
                {


                    handle_loadcellcalls.output_diagnosst(20)
                    console.log("INACTIVE")
//                    okIndicator1.active = false

                }


             }
        }
    }

    Rectangle {
        id: ow_rect
        x: 485
        y: 416
        width: 589
        height: 119
        color: "#00000000"
        border.width: 4
        border.color: "#6b0bb9"

        Label {
            id: ow_lbl
            x: 15
            y: 30
            width: 187
            height: 60
            text: qsTr("OW LAMP")
            color: "white"
            font.bold: true
            font.pointSize: 24
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        StatusIndicator {
            id: owlmpIndicator2
            x: 262
            y: 11
            width: 100
            height: 100
            active: false
            color: active ? "green" : "red"
        }

        HexButtond {
            id: owlampBtn
            x: 391
            y: 20
            height: 80
            text: active ? "ON" : "OFF"
            color: "chartreuse"
            onClicked:{

                if(owlampBtn.active==true)
                {

                    handle_loadcellcalls.output_diagnosst(3)
                    console.log("ACTIVE")
                }
                else
                {

                    handle_loadcellcalls.output_diagnosst(30)
                    console.log("INACTIVE")

                }


             }
        }
    }

//    Rectangle {
//        id: rej_rect
//        x: 485
//        y: 532
//        width: 589
//        height: 119
//        color: "#00000000"
//        border.width: 4
//        border.color: "#6b0bb9"

//        Label {
//            id: rej_lbl
//            x: 18
//            y: 30
//            width: 187
//            height: 60
//            text: qsTr("REJECTION")
//            color: "white"
//            font.bold: true
//            font.pointSize: 24
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignHCenter
//        }

//        StatusIndicator {
//            id: rejIndicator3
//            x: 263
//            y: 11
//            width: 100
//            height: 100
//            active: false
//            color: active ? "green" : "red"
//        }

//        HexButton {
    //            id: rejBtn
    //            x: 392
    //            y: 21
    //            height: 80
    //            text: active ? "ON" : "OFF"
    //            color: "chartreuse"
    //            onClicked:{

    //             }
    //        }
    //    }

    Rectangle {
        id: rectangle7
        x: 485
        y: 121
        width: 589
        height: 64
        color: "#00000000"
        border.width: 3
        border.color: "#6b0bb9"

        Label {
            id: label4
            x: 76
            y: 17
            width: 380
            height: 39
            text: qsTr("OUTPUTS")
            color: "yellow"
            font.bold: true
            font.pointSize: 28
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Rectangle {
        id: sensor4_rect
        x: 21
        y: 768
        width: 465
        height: 119
        color: "#00000000"
        border.color: "#6b0bb9"
        border.width: 3
        Label {
            id: sensor4_lbl
            x: 24
            y: 30
            width: 187
            height: 60
            color: "#ffffff"
            text: qsTr("RV SENSOR ")
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: rvsensorIndicator
            x: 322
            y: 11
            width: 100
            height: 100
            color: active ? "green" : "red"
            active: false
        }
    }





    //--------------------------------------------------------------
Component.onCompleted:savetextfield.disableScreen("1")

}
