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

//import QtQuick 2.7
//import QtQuick.Controls 2.0 as QQ2

//import Qt.labs.settings 1.0
//import QtQuick.Controls 2.2


//import QtQuick.Controls 1.2
//import QtQuick.Controls.Private 1.0
//import QtQuick.Controls.Styles 1.4

//import QtQuick 2.3

//import QtQuick 2.6
//import QtQuick.Controls 2.1
//import QtQuick.LocalStorage 2.0
//import QtQuick.Dialogs 1.2
//import QtQuick.Layouts 1.1
//import QtQuick.Window 2.0
//import QtQuick.Window 2.2
//import QtQuick.VirtualKeyboard 2.1
//import QtQuick 2.5
//import QtQuick.Controls 1.2




//import QtQuick 2.7
//import QtQuick.Controls 2.0 as QQC2
//import Qt.labs.settings 1.0
import "../Style"

Item {

 property string rtcmsg1
   // QQC2.SwipeView {
  //      id: svSettingsContainer

      //  anchors.fill: parent

     // Item {
            id: settingsPage1
            width: 1920
            height: 1080
            enabled: UIStyle.idleforfg

            property variant rtclist: []

            Label{
                x:750
                y: 5
                text: "SET RTC"
                font.pixelSize: 50
                color: "white"
            }
            Connections{
                target: savetextfield
               onDisablescr1:{
                    console.log("login action in fitnesspage")
                   if(cnt == 1){
                   settingsPage1.enabled = false

                   }
                   if(cnt == 2){
                   settingsPage1.enabled = true
                    button.color = "peru"

                   }
                }
            }

            Connections{
                target: handle_loadcellcalls
               onHandleRtcmessage:{
                    console.log("login action in fitnesspage")
                   if(cnt == 1){

                            console.log("WRONG RTC")
                       rtcmsg1 = "WARNING 1: FILL ALL THE FIELDS.\nENTER PROPER DATE/TIME FORMAT."
                       rtcid1.visible=true
                       loginDialog.open()

                   }
                   if(cnt == 2){

                            console.log("WRONG RTC")
                       rtcmsg1 = "WARNING 2: ENTER PROPER DATE/TIME FORMAT."
                       rtcid1.visible=true
                       loginDialog.open()

                   }

                }
            }


            function ldValues(){
                var temp = new Array(0);
                temp.push(dd.text);
                temp.push(mm.text);
                temp.push(yy.text);
                temp.push(hh.text);
                temp.push(min.text);
                temp.push(sec.text);
                rtclist = temp;

              //  console.log("the param1:"+UIStyle.fileParam); //for debugging

            }



            Column {
                anchors.verticalCenterOffset: -236
                anchors.horizontalCenterOffset: -485
                anchors.centerIn: parent
                spacing: 25

//                Row {
//                    spacing: 50
//                    Image {
//                        anchors.verticalCenter: parent.verticalCenter
//                        source: "images/bluetooth.png"
//                    }
//                    QQC2.Switch {
//                        id: bluetoothSwitch
//                        anchors.verticalCenter: parent.verticalCenter
//                        checked: settings.bluetooth
//                    }
//                }
//                Row {
//                    spacing: 50
//                    Image {
//                        anchors.verticalCenter: parent.verticalCenter
//                        source: "images/wifi.png"
//                    }
//                    QQC2.Switch {
//                        id: wirelessSwitch
//                        anchors.verticalCenter: parent.verticalCenter
//                        checked: settings.wireless
//                    }
//                }
            }

            InputPanel {
                id: inputPanel

                z: 89
                width: 1300
                visible: false

                y: Qt.inputMethod.visible ?  300 :parent.height
                anchors.bottom:  parent.Center
                anchors.bottomMargin: 150
                anchors.left: parent.left
                anchors.leftMargin: 20


            }


//            TextEdit {
//                id: textEdit
//                x: 115
//                y: 143
//                width: 1691
//                height: 187
//                text: qsTr("PAGE UNDER DEVELOPMENT")
//                font.pixelSize: 125
//                horizontalAlignment: Text.AlignHCenter
//            }

            TextField{id:dd; x: 613; y: 215; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: /*hldDly.focus = true;*/inputPanel.visible = false;inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
            TextField{id:mm; x: 817; y: 215; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: /*hldDly.focus = true;*/inputPanel.visible = false;inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
            TextField{id:yy; x: 1044; y: 215; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: /*hldDly.focus = true;*/inputPanel.visible = false;inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}

            Label {
                id: label
                x: 629
                y: 146
                width: 107
                height: 49
                text: qsTr("DATE (DD)")
                font.pointSize: 25
                font.family: "Times New Roman"
            }


            Label {
                id: label1
                x: 817
                y: 146
                width: 100
                height: 49
                text: qsTr("MONTH (MM)")
                font.family: "Times New Roman"
                font.pointSize: 25
            }
            Label {
                id: label2
                x: 1050
                y: 146
                width: 100
                height: 49
                text: qsTr("YEAR (YY)")
                font.family: "Times New Roman"
                font.pointSize: 25
            }

            TextField {
                id: hh
                x: 613
                y: 395
                width: 150
                height: 50
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator {
                    regExp: /^[0-9]{2,2}$/
                }
                previewText: ""
                onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}
                enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanel.visible = false;
            }

            TextField {
                id: min
                x: 817
                y: 395
                width: 150
                height: 50
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator {
                    regExp: /^[0-9]{2,2}$/
                }
                previewText: ""
                onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}
                enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanel.visible = false;

            }

            TextField {
                id: sec
                x: 1044
                y: 395
                width: 150
                height: 50
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator {
                    regExp: /^[0-9]{2,2}$/
                }
                previewText: ""
                onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}
                enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanel.visible = false;

            }

            Label {
                id: label3
                x: 629
                y: 324
                width: 107
                height: 49
                text: qsTr("HOUR (HH)")
                font.family: "Times New Roman"
                font.pointSize: 25
            }

            Label {
                id: label4
                x: 817
                y: 324
                width: 107
                height: 49
                text: qsTr("MIN (MM)")
                font.family: "Times New Roman"
                font.pointSize: 25
            }

            Label {
                id: label5
                x: 1044
                y: 324
                width: 107
                height: 49
                text: qsTr("SEC (SS)")
                font.family: "Times New Roman"
                font.pointSize: 25
            }

            RTCButton {
                id: button
                x: 1427
                y: 240
                width: 150
                height: 60
                color: "peru"
                text: "SET RTC"
                fontsize: 20
                onClicked: {

                    ldValues();
                    handle_loadcellcalls.rtc_data(rtclist,6);

                }
            }

            //-------------------------------------------------


                        Dialog {
                            id: loginDialog
                            visible: false
                            title:  "RTC WINDOW"
                            closePolicy: Popup.CloseOnEscape


                            x: 300
                            y: 300
                            background: Rectangle{
                                color: "red"
                                radius: 5
                                border.color: "mediumturquoise"
                            }

                            header: Rectangle{
                                width:1300//inputPanel.width
                                height: 60
                                color: "mediumturquoise"
                                border.color: "aquamarine"
                                radius: 5
                                Text{
                                    anchors.centerIn: parent
                                    text: "RTC WINDOW" //"CALIBRATION WINDOW"
                                    font.pixelSize: 30
                                    color: "black"
                                }
                            }
                            width: 1300//inputPanel.width + 100
                            height:500//inputPanel.height + 100
                            contentItem: FocusScope{
                                Column{
                                    anchors.bottom: parent.bottom
                                    anchors.right: parent.right
                                    anchors.rightMargin: 20
                                    anchors.bottomMargin: 20
                                   // Row{
                                   //     spacing: 20
                                        Button{
                                            //     text: "OK"
                                            Label{
                                                anchors.centerIn: parent
                                                text: "RESET"
                                                font.pixelSize: 20
                                            }
                                        //    isDefault: true
                                            focus: true
                                            width: 150
                                            height: 80
                                            onClicked: {rtcid1.visible=false;loginDialog.close()}//
                                        }
                                   // }
                                }
                                Column {
                                    id: errcolumn
                                    spacing: 20
                                    Row{
                                        spacing: 20
                                        Label{id:rtcid1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:rtcmsg1;color:UIStyle.colorQtWhite1}
                                    }
                                }

                            }
                            //-----------------------------------------------------------------------------------------------------------

                        }


//            Button {
//                id: button
//                x: 1427
//                y: 240
//                width: 165
//                height: 69
//                //text: qsTr("SET RTC")
//                Label{anchors.centerIn: parent;text:"SET RTC";font.pointSize: 25;font.family: "Times New Roman"}

//                onClicked: {

//                    ldValues();
//                    handle_loadcellcalls.rtc_data(rtclist,6);

//                }
//            }


  //      }







//        Item {
//            id: settingsPage2

//            Column {
//                anchors.centerIn: parent
//                spacing: 2

//                Column {
//                    Image {
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        source: "images/brightness.png"
//                    }
//                    QQC2.Slider {
//                        id: brightnessSlider
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        from: 0
//                        to: 5
//                        stepSize: 1
//                        value: settings.brightness
//                    }
//                }
//                Column {
//                    spacing: 2
//                    Image {
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        source: "images/contrast.png"
//                    }
//                    QQC2.Slider {
//                        id: contrastSlider
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        from: 0
//                        to: 10
//                        stepSize: 1
//                        value: settings.contrast
//                    }
//                }
//            }
//        }
  //  }

Component.onCompleted: savetextfield.disableScreen("1")

}
