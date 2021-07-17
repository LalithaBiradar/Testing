/*import QtQuick 2.7
import QtQuick.Controls 2.0 as QQC2
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


import "../Style"

Item {


    QQC2.SwipeView {
        id: svFunSetContainer

        anchors.fill: parent

        Rectangle {
            Settings{
                id:settings
                property alias wireless: wirelessSwitch.checked
            }
            id: funSetPage1
             width: 800; height: 480

                 signal sendValue(string text)

                 Rectangle {
                     anchors.horizontalCenter: parent.horizontalCenter
                     width: parent.width
                     height: titleRow.height

                     color: UIStyle.colorQtGray9

                     Row {
                         id: titleRow
                         spacing: UIStyle.bRadius           // 10
                         anchors.centerIn: parent

                    //     Image {
                   //          anchors.verticalCenter: parent.verticalCenter
                    //         source: "images/function_setup_small1.png"
                    //         fillMode: Image.PreserveAspectCrop
                    //     }
                         Text {
                             anchors.verticalCenter: parent.verticalCenter
                             text: UIStyle.funIconName
                             font.pixelSize: UIStyle.fontSizeM
                             font.letterSpacing: 2
                             color: UIStyle.colorQtGray2
                         }
                     }

                 }
                 Column {
                     anchors.centerIn: parent
                     spacing: 25

                     Row {
                         spacing: 50
                     //    Image {
                     //        anchors.verticalCenter: parent.verticalCenter
                     //        source: "images/bluetooth.png"
                     //    }
                         QQC2.Switch {
                             id: bluetoothSwitch
                             anchors.verticalCenter: parent.verticalCenter
                             checked: settings.bluetooth
                         }
                     }
                     Row {
                         spacing: 50
                         Image {
                             anchors.verticalCenter: parent.verticalCenter
                             source: "images/wifi.png"
                         }
                         QQC2.Switch {
                             id: wirelessSwitch
                             anchors.verticalCenter: parent.verticalCenter
                             checked: settings.wireless
                         }
                     }
                 }



        }
        Rectangle {
            id: prdDataPage2
             width: 800; height: 480
             Rectangle {
                 anchors.horizontalCenter: parent.horizontalCenter
                 width: parent.width
                 height: titleRowPrdPg2.height

                 color: UIStyle.colorQtGray9

                 Row {
                     id: titleRowPrdPg2
                     spacing: 10
                     anchors.centerIn: parent

                     Image {
                         anchors.verticalCenter: parent.verticalCenter
                         source: "images/function_setup_small1.png"
                         fillMode: Image.PreserveAspectCrop
                     }
                     Text {
                         anchors.verticalCenter: parent.verticalCenter
                         text: UIStyle.funIconName
                         font.pixelSize: UIStyle.fontSizeM
                         font.letterSpacing: 2
                         color: UIStyle.colorQtGray2
                     }
                 }

             }



    }
         }
    QQC2.PageIndicator {
        count: svPrdDataContainer.count
        currentIndex: svPrdDataContainer.currentIndex

        anchors.bottom: svPrdDataContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

}*/
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
import QtQuick.Controls 2.0 as QQC2
import Qt.labs.settings 1.0


import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

import QtQuick.Controls 1.2
import QtQuick.Controls 2.2


import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.0

import "../Style"
import "../Navigation"

Item {
    id:sendSig
 //   signal submitTextField2(string text)
    property string dcomp_sts
    property string errormsg1
    property string machine_sts
    enabled: UIStyle.idleforfg
    property string  prodmsg1:prodid1.text

    Settings {
        id: settings
        property alias cwbypass : cwbypassSwitch.checked

        property alias dyComp: dyCompSwitch.checked
        property alias mode: modeSwitch.checked

    }





    QQC2.SwipeView {
        id: svSettingsContainer
        anchors.rightMargin: 8
        anchors.bottomMargin: 0
        anchors.leftMargin: -8
        anchors.topMargin: 0
        anchors.fill: parent


        Rectangle {
            id: settingsPage1

            Connections
            {
                target: savetextfield
                onHandleDcompsts:{
                    dcomp_sts = cnt
                    dyCompSwitch.checked = dcomp_sts
                    if(dcomp_sts == "1"){
                    lbDycomp.text = "Dy.COMPENSATION ON"
                    }
                    else{
                      lbDycomp.text = "Dy.COMPENSATION OFF"
                    }

                    console.log("DCOMP connection done"+dcomp_sts)
                }

                onHandleMachine_sts:{
                    machine_sts = cnt
                    console.log(machine_sts+"MACHINE STATUS")


                    if(cnt == 0)
                    {
                       modeSwitch.checked = false
                       lbMode.text = "MODE : Setting"

                    }
                    if(cnt == 1)
                    {
                       modeSwitch.checked = true
                       lbMode.text = "MODE : PRODUCTION"

                    }



                    if(cnt == 2)
                    {
                       modeSwitch.checked = false
                       lbMode.text = "MODE : Setting"
                        prodmsg1 = "WARNING -> PLEASE CREATE NEW BATCH OR\n DUPLICATE BATCH FOUND... "
                        prodid1.visible=true
                        prodDialog.open()
             //           savetextfield.machine_sts(0)

                    }
                    if(cnt == 3)
                    {
                       modeSwitch.checked = true
                       lbMode.text = "MODE : PRODUCTION"
                        prodmsg1 = "WARNING -> END BATCH. TO CHANGE THE MACHINE MODE "
                        prodid1.visible=true
                        prodDialog.open()


                    }

                }
                onDisablescr1:{
                     console.log("logout action in Funsetup")
                    if(cnt == 1){
                    sendSig.enabled = false

                    }
                    if(cnt == 2){
                    sendSig.enabled = true

                    }

                 }

            }

            Connections
            {
                target: handle_loadcellcalls
                onHandleDcompsts:{

                    UIStyle.batch_num1 = cnt  //dcomp status
                    UIStyle.prd_name1 = cnt2   //cwbypass status
                    UIStyle.dycomp_factor = cnt1
                   // dyCompSwitch.checked = dcomp_sts
                    console.log("DCOMP connection done"+dcomp_sts+UIStyle.dycomp_factor)
                    if(UIStyle.prd_name1 == "2"){
                        cwbypassSwitch.checked = true
                        lbDatalogger.text = "CHECKWEIGHER BYPASS ON"
                    }
                    else{
                        cwbypassSwitch.checked = false
                        lbDatalogger.text = "CHECKWEIGHER BYPASS OFF"
                    }
                    if(UIStyle.batch_num1 == "1"){
                        dyCompSwitch.checked = true
                        lbDycomp.text = "Dy.COMPENSATION ON"
                    }
                    else{
                        dyCompSwitch.checked = false
                        lbDycomp.text = "Dy.COMPENSATION OFF"
                    }

                    if(cnt3 == "4")
                    {
                        modeSwitch.checked = true
                        lbMode.text = "MODE : PRODUCTION"



                    }
                    else if(cnt3 == "5")
                    {
                         modeSwitch.checked = false
                        lbMode.text = "MODE : Setting"



                    }


                }

                onHandlestzerosts:{

                    if(cnt==50)
                    {
                        errormsg1 = "WARNING -> PLEASE PERFORM SETZERO "
                        errid1.visible=true
                        loginDialog.open()

                    }

                }


            }


            //-------------------------------------------------------------------------------

                             Dialog {
                                 id: prodDialog
                                 visible: false
                                 title:  "PRODUCT DATA WINDOW"
                                 closePolicy: Popup.CloseOnEscape


                                 x: 310
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
                                         text: "PRODUCT DATA WINDOW"
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
                                                 onClicked: {prodDialog.close()}//;circularView.blurScreena("Origin")}
                                             }
                                     }
                                     Column {
                                         id: errcolumn1
                                         spacing: 20
                                         Row{
                                             spacing: 20
                                             Label{id:prodid1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:prodmsg1;color:UIStyle.colorQtWhite1}
                                           //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                                         }
                                     }

                                 }
                                 //-----------------------------------------------------------------------------------------------------------

                             }



            //-------------------------------------------------------------

                        Dialog {
                            id: loginDialog
                            visible: false
                            title:  "ERROR WINDOW"
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
                                    text: "ERROR WINDOW"
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
                                            onClicked: {savetextfield.disableScreen("RT");loginDialog.close();}//;circularView.blurScreena("Origin")}
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
                                        Label{id:errid1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
                                    }
                                    Row{
                                        spacing: 25
                                        Label{id:errid2;visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
                                    }
                                }

                            }
                            //-----------------------------------------------------------------------------------------------------------

                        }


       //    color: "steelblue"

            Rectangle {
                width: parent.width
                height: 60          //titleRowPrdPg2.height

                color: "peru"

                Row {
                    id: titleRowPrdPg2
                    x: 848
                    y: 0
                    spacing: 10

//                    Image {
//                        anchors.verticalCenter: parent.verticalCenter
//                        source: "images/function_setup_small1.png"
//                        fillMode: Image.PreserveAspectCrop
//                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.topMargin: 40
                        text: UIStyle.funIconName
                        font.pixelSize: 30         //UIStyle.fontSizeM
                        font.letterSpacing: 2
                        color: UIStyle.colorQtGray2
                        font.bold: true
                    }
                }

            }



 //           Column {
//                x: 553
//                y: 357
//                width: 658
//                height: 397
                //   anchors.centerIn: parent

//                spacing: 25

//                Row {
 //                   spacing: 200
//                    Image {
//                        id:feedbackIcon
//                        x: 20
//                        y: 422
//                        source: "images/feedback_icon.png"
//                        Label{id:lbFeedback; x: 76; y: 12; width: 253; height: 40;text:"FEEDBACK OFF"; font.pixelSize: 35;color:UIStyle.colorQtblk}
//                    }
//                    QQC2.Switch {
//                        id: feedbackSwitch
//                        x: 624
//                        y: 453
//                        checked: settings.feedback
//                  //      onClicked: {if(feedbackSwitch.checked==true){lbFeedback.text = "FEEDBACK ON"}else{lbFeedback.text ="FEEDBACK OFF"}}
//                        onClicked: {if((UIStyle.prdName.indexOf("6") >= 0)){console.log("feedbackSwitch pressed");if(feedbackSwitch.checked==true){lbFeedback.text = "FEEDBACK ON"}else{lbFeedback.text ="FEEDBACK OFF"}}else{feedbackSwitch.checked = false;authFailDialogpg2.open()}}
//                    }


//                    }

//                Row {
//                    spacing: 200
                    Image {
                        id:dataLoggerIcon
                        x: 20
                        y: 279
                        source: "images/cwbypass.png"
                        width: 75
                        height:75
                        Label{id:lbDatalogger; x: 77; y: 17; width: 476; height: 39;text:"CHECKWEIGHER BYPASS OFF"; font.pixelSize: 35;color:UIStyle.colorQtblk}

                    }
                    QQC2.Switch {
                        id: cwbypassSwitch
                        x: 624
                        y: 303
                        checked:  settings.cwbypass


               //         onClicked: {if(cwbypassSwitch.checked==true){lbDatalogger.text = "CHECKWEIGHER BYPASS ON"}else{lbDatalogger.text ="CHECKWEIGHER BYPASS OFF"}}
                        onClicked: {savetextfield.disableScreen("RT");if((UIStyle.prdName.indexOf("7") >= 0)){console.log("cwbypassSwitch pressed");if(cwbypassSwitch.checked==true){lbDatalogger.text = "CHECKWEIGHER BYPASS ON";handle_loadcellcalls.cwbypass_on_off(1)/*;UIStyle.prd_name1 = "1" */}else{lbDatalogger.text ="CHECKWEIGHER BYPASS OFF";handle_loadcellcalls.cwbypass_on_off(0)/*;UIStyle.prd_name1 = "0"*/}}else{cwbypassSwitch.checked = false;authFailDialogpg2.open()}}
                    }

//                }

  //              Row {
  //                  spacing: 200
                    Image {
                        id:dyCompIcon
                        x: 20
                        y: 136
                        width: 75
                        height: 75
                        source: "images/dycompfact.png"
                        Label{id:lbDycomp; x: 74; y: 15; width: 398; height: 40;text:"Dy.COMPENSATION OFF"; font.pixelSize: 35;color:UIStyle.colorQtblk}

                    }

                    QQC2.Switch {
                        id: dyCompSwitch
                        x: 624
                        y: 159
                        checked: settings.dyComp
                        onClicked: {savetextfield.disableScreen("RT");if((UIStyle.prdName.indexOf("4") >= 0)){if(dyCompSwitch.checked==true){lbDycomp.text = "Dy.COMPENSATION ON";handle_loadcellcalls.dcomp_on_off(1)/*;UIStyle.batch_num1 = "1"*/}else{lbDycomp.text ="Dy.COMPENSATION OFF";handle_loadcellcalls.dcomp_on_off(0)/*;UIStyle.batch_num1 = "0"*/}}else{dyCompSwitch.checked = false;authFailDialogpg2.open()}}

                    }

                    Image {
                        id:modeIcon
                        x: 20
                        y: 422
                        width: 75
                        height: 75
             //           source: "images/dycompfact.png"
                        Label{id:lbMode; x: 74; y: 15; width: 398; height: 40;text:"MODE : Setting"; font.pixelSize: 35;color:UIStyle.colorQtblk}

                    }

                    QQC2.Switch {
                        id: modeSwitch
                        x: 624
                        y: 445
                        checked: settings.mode
                        onClicked: {savetextfield.disableScreen("RT");if((UIStyle.prdName.indexOf("6") >= 0)){if(modeSwitch.checked===true){confirmDialog2.open()/*lbMode.text = "MODE : Production";savetextfield.machine_sts(1)*/}else{confirmDialog.open()/*lbMode.text ="MODE : Setting";savetextfield.machine_sts(0)*/}}else{modeSwitch.checked = false;authFailDialogpg2.open()}}

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
                                    Label{id:confirmwarmMsg2;scale: visible ? 1.0 : 0.1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are changing MODE to PRODUCTION\nPlease double confirm?";color:"red"
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
                                        onClicked:{confirmDialog2.close();lbMode.text = "MODE : Production";savetextfield.machine_sts(1) }

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
                                        onClicked:{modeSwitch.checked = false;confirmDialog2.close()}
                                    }
                                }


                             }

                        }

                    }


                    Dialog {
                            id: confirmDialog
                            width: confirmwarmMsg1.contentWidth + 200
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
                                id:confirmDialogColumn
                                spacing: 20
                                Row{
                                    spacing: 20
                                    Label{id:confirmwarmMsg1;scale: visible ? 1.0 : 0.1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are changing MODE to SETTING\nPlease double confirm?";color:"red"
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
                                        onClicked:{confirmDialog.close();lbMode.text ="MODE : Setting";savetextfield.machine_sts(0) }

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
                                        onClicked:{modeSwitch.checked = true;confirmDialog.close()}
                                    }
                                }


                             }

                        }

                    }

MButton{
    id:dycompbtn
    x: 1000
    y:129
    width: 200
    height: 100
    color: "peru"
    onClicked: {savetextfield.disableScreen("RT");if((UIStyle.prdName.indexOf("4") >= 0)){console.log("dycomp btn pressed"); handle_loadcellcalls.gen_dcomp_fact()}else{dycompbtn.color = "peru";authFailDialogpg2.open()}}
}

Dialog {
        id: authFailDialogpg2
        width: warmMsgpg2.contentWidth + 200
        height: 300
        x:50
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
            id: loginFailColumnpg2
            spacing: 20
            Row{
                spacing: 20
                Label{id:warmMsgpg2;font.pixelSize:UIStyle.fontSizeXXL;text:"You are not Authorized to use this function!!";color:UIStyle.colorCandyPink}
            }
        }
        Column{
            spacing: 50
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottomMargin: 20
             Button{
                 id:okBtn
                 Label{
                     anchors.centerIn: okBtn
                     text: "OK"
                     font.pixelSize: 20
                 }
 //               isDefault: true
                focus: true
                 width: 150
                height: 80
                onClicked:{savetextfield.disableScreen("RT");authFailDialogpg2.close()}
            }
         }

    }

}




//                    }


//            }
        }

//        Rectangle {
//            id: settingsPage2

//            Column {
//                anchors.centerIn: parent
//                spacing: 2

//                Column {
//              //      Image {
//              //          anchors.horizontalCenter: parent.horizontalCenter
//              //          source: "images/brightness.png"
//               //     }
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
//                //    Image {
//                 //       anchors.horizontalCenter: parent.horizontalCenter
//                //        source: "images/contrast.png"
//                //    }
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
    }

    QQC2.PageIndicator {
        count: svSettingsContainer.count
        currentIndex: svSettingsContainer.currentIndex

        anchors.bottom: svSettingsContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Component.onCompleted:{savetextfield.disableScreen("RT");handle_loadcellcalls.send_sts(); console.log("previlage status is:"+UIStyle.prdName)}
}



