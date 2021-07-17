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
    id: clock

    property int hours
    property int minutes
    property int seconds
    property real shift: timeShift
    property bool night: false
    property bool internationalTime: true //Unset for local time

    property string calibmsg1
    property string previlageStatus
    property bool acess: true

    enabled: UIStyle.idleforfg


    Label{
        x:750
        y: 5
        text: "MACHINE SETUP"
        font.pixelSize: 50
        color: "white"
    }
    Connections{
        target: savetextfield
       onDisablescr1:{
            console.log("login action in fitnesspage")
           if(cnt == 1){
           clock.enabled = false

           }
           if(cnt == 2){
           clock.enabled = true

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

    function getWatchFaceImage(imageName) {
        return "images/" + imageName
    }

//    function timeChanged() {
//        var date = new Date
//        hours = internationalTime ? date.getUTCHours() + Math.floor(
//                                        clock.shift) : date.getHours()
//        night = (hours < 7 || hours > 19)
//        minutes = internationalTime ?
//         date.getUTCMinutes() + ((clock.shift % 1) * 60) : date.getMinutes()
//        seconds = date.getUTCSeconds()
//    }

    Connections{
        target: handle_loadcellcalls

        onHandleCalib_sts:{

            if(cnt==1)
            {
                calibmsg1 = "STEP 1 --> CONFIRM WEIGHING PLATFORM IS EMPTY\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==18)
            {
                calibmsg1 = "ERROR-18 -> CALIBRATION SWITCH IS OFF"
                calibid1.visible=true
                loginDialog.open()
            }
            if(cnt==180)
            {
                calibmsg1 = "ERROR-18 -> CALIBRATION SWITCH IS OFF"
                calibid1.visible=false
                loginDialog.close()
            }

            if(cnt==2)
            {
                calibmsg1 = "STEP 2 --> ******** WAIT ********\n ZEROING IN PROCESS"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==3)
            {
                calibmsg1 = "STEP 3 --> PUT STD WEIGHT OF 500g ON WEIGHING PLATFORM\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==6)
            {
                calibmsg1 = "STEP 3 --> PUT STD WEIGHT OF 1000g ON WEIGHING PLATFORM\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==8)
            {
                calibmsg1 = "STEP 3 --> PUT STD WEIGHT OF 2000g ON WEIGHING PLATFORM\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==9)
            {
                calibmsg1 = "STEP 3 --> PUT STD WEIGHT OF 5000g ON WEIGHING PLATFORM\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==10)
            {
                calibmsg1 = "STEP 3 --> PUT STD WEIGHT OF 100g ON WEIGHING PLATFORM\nPRESS ENTER TO CONTINUE"
                calibid1.visible=true
                loginDialog.open()

            }

            if(cnt==4)
            {
                calibmsg1 = "STEP 4 --> ******** WAIT ********\n CALIBRATION IN PROCESS"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==5)
            {
                calibmsg1 = "STEP 5 --> CALIBRATION PROCESS COMPLETED...\n REMOVE WEIGHT TO CONTINUE SETZERO"
                calibid1.visible=true
                loginDialog.open()

            }
            if(cnt==7)
            {
                calibmsg1 = "STEP 6 --> CALIBRATION ERROR\n PRESS ENTER TO ABORT CALIBRATION PROCESS"
                calibid1.visible=true
                loginDialog.open()

            }


        }


    }

//    Timer {
//        interval: 100
//        running: true
//        repeat: true
//        onTriggered: clock.timeChanged()
//    }

    HexButton {
        id: calb_button
        x: 800
        y: 100
 //       width: 479
        height: 205
        text: "CALIBRATION"
        color: "olive"
        fontsize: 42
        enabled: true
   //     text: qsTr("CALIBRATION")
   //     checkable: false
   //     font.weight: Font.DemiBold
    //    font.pointSize: 42
   //     font.family: "Times New Roman"
   //     highlighted: true

        onClicked:{if((UIStyle.prdName.indexOf("3") >= 0)){handle_loadcellcalls.calibration()}else{calb_button.active = false;authFailDialog.open()}}

        //onClicked:
    }

    HexButton {
        id: diagnosis_button
        x: 800
        y: 300
   //     width: 700
        height: 205
        color: "olive"
        text: "DIAGNOSIS"
        fontsize: 42
        enabled: true
  //      text: qsTr("DIAGNOSIS")
    //    checkable: false
    //    font.weight: Font.DemiBold
    //    font.pointSize: 42
    //    font.family: "Times New Roman"
    //    highlighted: true

        onClicked:{pageSw(Qt.resolvedUrl("qrc:/qml/WorldClock/DiagnosisPage.qml"))}

        //onClicked:
    }

    HexButton {
        id:batchendBtn
        x: 800
        y: 500
   //     width: 479
        height: 204
        color: "olive"
        text: "BATCH END"
        fontsize: 42
        enabled: true

        onClicked:{
                     savetextfield.disableScreen("RT")
                    if((UIStyle.prdName.indexOf("5") >= 0)){
                        confirmDialog.open()
//                        db.createTable_testmode()
//                        handle_loadcellcalls.send_sts()
                }
                else{
                    batchendBtn.active = false
                        authFailDialog.open()
                }
//                    db.createTable_testmode()
//                    handle_loadcellcalls.send_sts()
       }

    }

//    Button {
//        id: wtverifn_button
//        x: 713
//        y: 700
//        width: 479
//        height: 153
//        text: qsTr("WEIGHT VERIFICATION")
//        checkable: false
//        font.weight: Font.DemiBold
//        font.pointSize: 35
//        font.family: "Times New Roman"
//        highlighted: true

//        onClicked:{pageSw(Qt.resolvedUrl("qrc:/qml/WorldClock/WeightVerificationPage.qml"))}

//        //onClicked:
//    }


    Dialog {
            id: authFailDialog
            width: warmMsg1.contentWidth + 200
            height: 300
            x:10
            y:100
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


    Dialog {
            id: confirmDialog
            width: confirmwarmMsg1.contentWidth + 200
            height: 300
            x:10
            y:100
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
                        height: 100
                        color: "mediumturquoise"
                        border.color: "aquamarine"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "WARNING (1)!!!"
                            font.pixelSize: 40
                            color: "black"
                        }
                    }
       contentItem: FocusScope{
            Column {
                id:confirmDialogColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:confirmwarmMsg1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are ending the current batch\nAre you sure? ";color:UIStyle.colorCandyPink}
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
                Row{
                    spacing: 20
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
                        onClicked:{confirmDialog.close();confirmDialog2.open()}
                    }
                    Button{
                        Label{
                            anchors.centerIn: parent
                            text: "Cancel"
                            font.pixelSize: 20
                        }
                        //          isDefault: true
                        focus: true
                        width: 150
                        height: 80
                        onClicked:{confirmDialog.close()}
                    }
                }
             }

        }

    }

    Dialog {
            id: confirmDialog2
            width: confirmwarmMsg2.contentWidth + 200
            height: 500
            x:100
            y:100
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
                        height: 100
                        color: "mediumturquoise"
                        border.color: "aquamarine"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "WARNING (2)!!!"
                            font.pixelSize: 40
                            color: "black"
                        }
                    }
       contentItem: FocusScope{
            Column {
                id:confirmDialog2Column
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:confirmwarmMsg2;scale: visible ? 1.0 : 0.1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are doing batch end action\nPlease double confirm?\nYou are not able to run current batch again.";color:"red"
                        Behavior on scale {
                           NumberAnimation  { duration: 500 ; easing.type: Easing.InOutBounce  }
                          }
                    }
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
                Row{
                    spacing: 20
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
                        onClicked:{
                            confirmDialog2.close();
//                            widget.addBatchdetails();
//                            savetextfield.batch_end_auditlog();
//                            handle_loadcellcalls.send_sts();
//                            handle_loadcellcalls.read_stats_page();
//                            widget.gen_batchreport();
//                            Alaram.gen_alaramreport();
//                            Audit.gen_auditreport();
//                            db.createTable_testmode();

                            widget.addBatchdetails();
                            savetextfield.batch_end_auditlog();
                            handle_loadcellcalls.send_sts();
                            handle_loadcellcalls.read_stats_page();
                            db.createTable_testmode();
                            widget.gen_batchreport();
                            Alaram.gen_alaramreport();
                            Audit.gen_auditreport();

                        }
                    }

                    Button{
                        Label{
                            anchors.centerIn: parent
                            text: "Cancel"
                            font.pixelSize: 20
                        }
                        //          isDefault: true
                        focus: true
                        width: 150
                        height: 80
                        onClicked:{confirmDialog2.close()}
                    }
                }


             }

        }

    }


    //-------------------------------------------------------------
    Dialog {
            id: acessDialog
            width: acessMsg.contentWidth + 200
            height: 200
            x:300
            y:400
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

                Dialog {
                    id: loginDialog
                    visible: false
                    title:  "CALIBRATION WINDOW"
                    closePolicy: Popup.CloseOnEscape


                    x: 360
                    y: 260
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
                            text: "CALIBRATION WINDOW"
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
                                        text: "ENTER"
                                        font.pixelSize: 20
                                    }
                                //    isDefault: true
                                    focus: true
                                    width: 150
                                    height: 80
                                    onClicked: {handle_loadcellcalls.err_reset()}//;loginDialog.close()}//;circularView.blurScreena("Origin")}
                                }
    //                            Button{
    //                                Label{
    //                                    anchors.centerIn: parent
    //                                    text: "OK"
    //                                    font.pixelSize: 20
    //                                }
    //                                isDefault: true
    //                                focus: true
    //                                width: 150
    //                                height: 80
    //                                onClicked: {loginDialog.close()}
    //                            }
                           // }
                        }
                        Column {
                            id: errcolumn
                            spacing: 20
                            Row{
                                spacing: 20
                                Label{id:calibid1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:calibmsg1;color:UIStyle.colorQtWhite1}
                              //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                            }
//                            Row{
//                                spacing: 25
//                                Label{id:errid2;visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg2;color:UIStyle.colorQtWhite1}
//                              //  TextField{id:password;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 50;loginDialog.height = 700}echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 300;height: 60;}
//                            }
                        }

                    }
                    //-----------------------------------------------------------------------------------------------------------

                }



    //--------------------------------------------------------------
Component.onCompleted:savetextfield.disableScreen("1")

}
