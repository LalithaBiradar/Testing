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
import QtQuick.Controls 1.2
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

import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

import test 1.0
import "../Style"




Item{
    id:mainDisplayPg
//    property alias fitnessPage2: fitnessPage2
    property string previlageStatus
    property variant arrayList
    property int someNumber: 1000
    property int ttt

    property int gaugevalue
    property int cwGuageVal
    property int ipGuageVal:0
    property string errormsg1
    property string errormsg2

    property string dcomp_sts
    property string bypass_sts

    property string myString
    property variant stringList: myString.split('#')
    property string myString1
    property variant stringList1: myString1.split(',')

    property string statsdatapg



    signal qmlSignal(string msg)
    signal swipeviewpg(string msg)
    //property alias speedometer1: speedometer1
    width: 1920
    height: 1080
    property alias setZeroBtn: setZeroBtn

    enabled: UIStyle.idleforfg   //this action disable the touch on opening screen

    //------------------below function is called directly from cpp--------------------
    function myQmlFunction(msg) {
      console.log("Got message:", msg[0]);
        var dialSpd = parseInt(msg[0],10)
        console.log("Got message:", dialSpd);

      //  UIStyle.prd_code1 = msg[0]
        UIStyle.cwGuageVal = dialSpd
        valueSourcecwspd.kph = dialSpd
        console.log("Got message:", UIStyle.cwGuageVal);

      //  timer1.start();

      return "some return value"

    }



    Connections{
        target: savetextfield
        onPrevilage_status:{
            previlageStatus = text
            console.log("The status from cpp is:"+previlageStatus)
            for(var i = 0; i < previlageStatus.length; i++) {
            if(previlageStatus.charAt(i) != "2"){

            }

            }
        }
    }

    Connections
    {
        target: handle_loadcellcalls
        onHandleDcompsts:{
            dcomp_sts = cnt
            bypass_sts = cnt2

            UIStyle.dycomp_factor = cnt1
           // dyCompSwitch.checked = dcomp_sts

            console.log("DCOMP connection done"+dcomp_sts+UIStyle.dycomp_factor)
            console.log("dcomp sts"+dcomp_sts)
             console.log("bypass sts"+bypass_sts)
            if(dcomp_sts == "1")
            {
          //      dycompImage.visible=true
          //      dycompImagepg2.visible = true
          //      dasd6.visible = true
          //      rectangle_dycompfact.visible = true


            }
            else if(dcomp_sts == "0")
            {
         //       dycompImage.visible=false
         //       dycompImagepg2.visible = false
         //       dasd6.visible = false
         //       rectangle_dycompfact.visible = false
            }

            if(bypass_sts == "2")
            {
        //        bypassImage.visible=true
        //        bypassImagepg2.visible = true
                //dasd6.visible = true

            }
            else if(bypass_sts == "3")
            {
         //        bypassImage.visible=false
        //        bypassImagepg2.visible = false

            }

        }




    }


    //--------------------to change vaue from cpp -------------------------
        Connections
        {
            target: handle_loadcellcalls
            onHandleGuage_val:{
//                cwGuageVal = cnt

//                console.log("connection done"+cwGuageVal)
            }


            onHandleIPGuage_val:{
        //        ipGuageVal = cnt
            }

            onHandleConv_sts:{
      //          convOn.active = cnt
      //          convOnpg2.active = cnt

      //          convOn.text = "CONV OFF";convOn.textcolor = "white";
      //          convOnpg2.text = "CONV OFF";convOnpg2.textcolor = "white";

               // dyWeightpg1.color="pink";



            }
            onHandleerror_sts:{


                if(cnt==29)
                {
                    errormsg1 = "ERROR-29 -> METAL DETECTED IN CURRENT PASSING PRODUCT"
                    errid1.visible=true
                    loginDialog.open()
         //           err2id1.visible=true
         //           errDialog2.open()
                }

                if(cnt==290)
                {
                    errormsg1 = "ERROR-01 -> REDUCE SPEED OF CONVEYOR"
                    errid1.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()
                }



                if(cnt==1)
                {
                    errormsg1 = "ERROR-01 -> REDUCE THE SPEED OF CONVEYOR"
                    errid1.visible=true
                    loginDialog.open()
       //             err2id1.visible=true
       //             errDialog2.open()
                }

                if(cnt==10)
                {
                    errormsg1 = "ERROR-01 -> REDUCE SPEED OF CONVEYOR"
                    errid1.visible=false
                    loginDialog.close()
       //             err2id1.visible=false
       //             errDialog2.close()
                }

                if(cnt==2)
                {
                    errormsg1 = "ERROR-02 -> REDUCE INPUT SPEED OF THE PRODUCT"
                    errid1.visible=true
                    loginDialog.open()
       //             err2id1.visible=true
       //             errDialog2.open()
                }

                if(cnt==21)
                {
                    errid1.visible=false
                    loginDialog.close()
       //             err2id1.visible=false
       //             errDialog2.close()
                }

                if(cnt==7)
                {
                    errormsg1 = "ERR-07 -> SENSOR-1 NOT SENSED \nOR SENSOR-2 DOUBLE SENSED"
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
       //             errDialog2.open()

                }
                if(cnt==70)
                {
                    errid1.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()

                }



                if(cnt==12)
                {
                    errormsg1 = "ERR-12 -> OVERWEIGHT ERROR"
                    errid1.visible=true
                    loginDialog.open()
     //               err2id1.visible=true
      //              errDialog2.open()

                }
                if(cnt==120)
                {
                    //errormsg1 = "ERR-12 -> OVERWEIGHT ERROR"
                    errid1.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()

                }

                if(cnt==14)
                {
                    errormsg1 = "ERR-14 -> AIR PRESSURE NOT WITHIN RANGE"
                    errid2.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }
                if(cnt==140)
                {
                    errid2.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()

                }

                if(cnt==15)
                {
                    errormsg1 = "ERR-15 -> ESTOP PRESSED"
                    errid2.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }
                if(cnt==150)
                {
                    errormsg1 = "ERR-15 -> ESTOP PRESSED"
                    errid2.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()

                }

                if(cnt==16)
                {
                    errormsg1 = "ERR-16 -> SENSOR2 FAILED"
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }

                if(cnt==17)
                {
                    errormsg1 = "ERR-17 -> REJECTION CONFIRMATION FAILED"
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }
                if(cnt==19)
                {
                    errormsg1 = "ERR-19 -> CONTINUOUS REJECTION"
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }

                if(cnt==20)
                {
                    errormsg1 = "ERR-20 -> CABINET DOOR OPEN"
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }

                if(cnt==0)
                {
                    //errormsg1 = "ERR-20 -> CABINET DOOR OPEN"
                    console.log("I GOT RESET")
                    errid1.visible=false
                    loginDialog.close()
      //              err2id1.visible=false
      //              errDialog2.close()
      //              err2id2.visible=false


                }

                if(cnt==50)
                {
                    errormsg1 = "WARNING -> PLEASE PERFORM SETZERO "
                    errid1.visible=true
                    loginDialog.open()
       //             err2id1.visible=true
       //             errDialog2.open()

                }
                if(cnt==300)
                {
                    errormsg1 = "WARNING -> PLEASE CREATE NEW BATCH OR\n DUPLICATE BATCH FOUND... "
                    errid1.visible=true
                    loginDialog.open()
      //              err2id1.visible=true
      //              errDialog2.open()

                }


      //          if(loginDialog.visible == true | errDialog2.visible == true){
                if(loginDialog.visible == true ){

                  fitnessPage1.enabled = false
              //    fitnessPage2.enabled = false
                  savetextfield.disableScreen("LD")
                }
           //     if(loginDialog.visible == false | errDialog2.visible == false){
                if(loginDialog.visible == false){
                  fitnessPage1.enabled = true
            //        fitnessPage2.enabled = true
                    savetextfield.disableScreen("LE")
                }


            }

            onHandleSetzero_sts:{

                 console.log("cnt="+cnt);
                if(cnt==1)
                {
                    errormsg1 = "WARNING -> SETZERO IN PROCESS"
                    setzid1.visible=true
                    setz2id1.visible=true
                    setzeroDialog.open()
       //             setzeroDialog2.open()

                }


                if(cnt==3)
                {
                    //errormsg1 = "WARNING -> PLEASE PERFORM SETZERO "
                    //setzid1.visible=true

                    setZeroBtn.active=false
                    setZeroBtn.textcolor = "white"
    //                setZeroBtnpg2.active=false
    //                setZeroBtnpg2.textcolor = "white"
                    setzeroDialog.close()
    //                setzeroDialog2.close()


                }


            }


            onDynamicwt_sts:{
                if(cnt==1)
                {
//                    dyWeightpg1.color="yellow";
                    dyWeight.color="yellow";

                }
                if(cnt==2)
                {
 //                   dyWeightpg1.color="green";
                    dyWeight.color="green";

                }
                if(cnt==3)
                {
//                    dyWeightpg1.color="red";
                    dyWeight.color="red";

                }
                if(cnt==4)
                {
//                    dyWeightpg1.color="blue";
                    dyWeight.color="blue";

                }



            }






        }

    //--------------------------------------------------------------------------

//--------------------------------------------------------------------------------
//   onHeightChanged: {savetextfield.powerOnLoadFromLib("F:\\ dummy.txt");fitnessPage2.storeFileValues()}
    SwipeView {

        id: svFitnessContainer
        width: 1920
        height: 961
        currentIndex: 0

        contentItem: ListView {
                        model: svFitnessContainer.contentModel
                        interactive: svFitnessContainer.interactive
                        currentIndex: svFitnessContainer.currentIndex

                        spacing: svFitnessContainer.spacing
                        orientation: svFitnessContainer.orientation
                        snapMode: ListView.SnapOneItem
                        boundsBehavior: Flickable.StopAtBounds

                        highlightRangeMode: ListView.StrictlyEnforceRange
                        preferredHighlightBegin: 0
                        preferredHighlightEnd: 0
                        highlightMoveDuration: 250
                        //                    min:10

                        maximumFlickVelocity: 10 * (svFitnessContainer.orientation ===
                        Qt.Horizontal ? width : height)
                    }


        Item {
            id: fitnessPage1
            width: 1920
            rotation: 0
            state: "true"

Connections{
    target: savetextfield
   onDisablescr1:{
        console.log("login action in fitnesspage")
       if(cnt == 1){
       fitnessPage1.enabled = false
 //      fitnessPage2.enabled = false
       }
       if(cnt == 2){
       fitnessPage1.enabled = true
  //     fitnessPage2.enabled = true
       }
       if(cnt == 3){
   //    svFitnessContainer.currentIndex = 0
       }
    }
}

//            ValueSource {
//                id: valueSourceipspd

//             }
//            ValueSource{
//                id: valueSourcecwspd

//            }



            D{id: d; vl: ["i1", "i2", 3, 4]}

//            Item {
//                id: container
//                x: 0
//                y: 0
//                width: 1920
//                height: 961

//                 CircularGauge {
//                     id: speedometer
//                     x: 24
//                     y: 453
//                     width: 478
//                     height: 455
//                     //value: valueSourceipspd.kph
//                     maximumValue: 350



//                // We set the width to the height, because the height will always be
//                // the more limited factor. Also, all circular controls letterbox
//                // their contents to ensure that they remain circular. However, we
//                // don't want to extra space on the left and right of our gauges,
//                // because they're laid out horizontally, and that would create
//                // large horizontal gaps between gauges on wide screens.

//                     style: DashboardGaugeStyle{
//                         id:dashGauge
//                         guageInputText: "PPM\nINPUT\nSPEED"
//                     }
//                     value: ipGuageVal
//                 }

//                CircularGauge {
//                    id: speedometer1
//                    x: 1400
//                    y: 450
//                    width: 478


//                    height: 455
//                    maximumValue: 400
//                    style: DashboardGaugeStyle {
//                        guageInputText: "PPM\nCW\nSPEED"
//                    }

//                    value: cwGuageVal


//                }


//            }



            Flickable {
                id: flickable1

                property real scrollMarginVertical: 20
                x: 27
                y: 0
                height: 600

                contentWidth: content.width
                contentHeight: content.height
                interactive: contentHeight > height
                flickableDirection: Flickable.VerticalFlick
                children: ScrollBar {}

                MouseArea  {
                    id: content

                    width: flickable1.width
                    height: textEditors.height + 24

                    onClicked: focus = true

                    Column {
                        id: textEditors
                        spacing: 15
                        x: 12; y: 12
                        width: 1024


                    }

                }

            }

//                                Image {
//                                    id:dycompImage
//                                    x:100
//                                    y:20
//                                    visible: false
//                                    width: 80
//                                    height: 80
//                             //       anchors.verticalCenter: parent.verticalCenter
//                             //       source: "images/DynamicComp_icon.png"
//                                    source: "images/dycompfact.png"
//                                    fillMode: Image.PreserveAspectCrop
//                                }

//                                Image {
//                                    id:bypassImage
//                                    x:250
//                                    y:20
//                                    visible: false
//                                    width: 80
//                                    height: 80
//                             //       anchors.verticalCenter: parent.verticalCenter
//                                    source: "images/cwbypass.png"
//                                    fillMode: Image.PreserveAspectCrop
//                                }


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
                                onClicked: {handle_loadcellcalls.err_reset();loginDialog.close();errDialog2.close();fitnessPage1.enabled = true;/*fitnessPage2.enabled = true;*/savetextfield.disableScreen("LE")}//;circularView.blurScreena("Origin")}
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

//---------------------------------------------------------------------

            Dialog {
                id: setzeroDialog
                visible: false
                title:  "SETZERO WINDOW"
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
                        text: "SETZERO WINDOW"
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
//                            Button{
//                                //     text: "OK"
//                                Label{
//                                    anchors.centerIn: parent
//                                    text: "RESET"
//                                    font.pixelSize: 20
//                                }
//                            //    isDefault: true
//                                focus: true
//                                width: 150
//                                height: 80
//                                onClicked: {loginDialog.close()}//;circularView.blurScreena("Origin")}
//                            }
                    }
                    Column {
                        id: setzerocolumn
                        spacing: 20
                        Row{
                            spacing: 20
                            Label{id:setzid1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
                          //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                        }
                    }

                }
                //-----------------------------------------------------------------------------------------------------------

            }


//--------------------------------------------------------------



//            HexButton{
//                id: exitBtn
//                x: 1774
//                y: 68
//                width: 138
//                height: 53
//                color: "red"
//                text: "SHUT DOWN"
//                fontsize: 20
//                onClicked: Qt.quit()

//            }





            Label{
                x:750
                y: 5
                text: "WEIGHT VERIFICATION DISPLAY"
                font.pixelSize: 50
                color: "white"
            }

            Rectangle{
                id: rectangle
                x: 609
                y: 100
                //        x: 296
                //        y: 110
                width: 827
                height: 330
                opacity: 0.5
                rotation: 0
                //dy.weight
                // "transparent"
                border.width: 2
                radius: 20
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#0dcd83"
                    }

                    GradientStop {
                        position: 0.993
                        color: "#71d61f"
                    }
                }
                border.color: "#d58546"



             }

         //   Label{id:dyWeightpg1; x: 4; y: 10;font.pointSize: 100;text: UIStyle.netWt; anchors.rightMargin: 228; anchors.bottomMargin: 321;color:UIStyle.colorQtblk; anchors.bottom: parent.bottom;anchors.right: parent.right;}


            Label{id:dyWeightpg1; x: 714; y: 121; width: 546; height: 266;color: "#0000ff";text: UIStyle.netWt;font.pointSize: 220; /*padding: 0;*/ font.family: "Times New Roman"; antialiasing: false; fontSizeMode: Text.HorizontalFit; opacity: 1; font.weight: Font.Thin; verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter; rotation: 0; }

//HexButton {
//        id: convOn
//        x: 664
//        y: 592
//        width: 220
//        height: 204
//        color: "peru"
//        text: "CONV OFF"
//        fontsize: 20
////    onClicked:{


////     //   mainDisplayPg.ppmVal = 60

////        savetextfield.cycle("0000.1")
////        console.log("Clicked 1")
////         // console.log(d.vl[0]);
////        if(convOn.active == true){valueSourceipspd.kph = 60;valueSourcecwspd.kph = 80;/*arrayList =  d.doVl([6,7,8]);console.log("value get:"+arrayList[0]);*/ convOn.text = "CONV ON";convOn.textcolor = "black"}else{valueSourceipspd.kph = 0;convOn.text = "CONV OFF";convOn.textcolor = "white"}
////    }

//    onClicked:{

//        console.log("Clicked 1")
//        if(convOn.active == true){ convOn.text = "CONV ON";convOn.textcolor = "black";staticBtn.textcolor = "white";handle_loadcellcalls.conv_onoff();
//            staticBtn.active=false
//            setZeroBtn.active=false
//            setZeroBtn.textcolor = "white"
//            convOnpg2.active = true
//            convOnpg2.text = "CONV ON";convOnpg2.textcolor = "black";

//            staticBtnpg2.active=false
//            setZeroBtnpg2.active=false
//            setZeroBtnpg2.textcolor = "white"

//            savetextfield.disableScreen("LD")


//        }
//        else{convOn.text = "CONV OFF";convOn.textcolor = "white";handle_loadcellcalls.conv_onoff();
//            staticBtn.active=false;setZeroBtn.active=false
//            convOnpg2.active = false
//            convOnpg2.text = "CONV OFF";convOnpg2.textcolor = "white";
//            staticBtnpg2.active=false;setZeroBtnpg2.active=false

//            savetextfield.disableScreen("LE")

//        }



//    }


//}



HexButton {
    id: staticBtn
    x: 1009
    y: 591
    width: 220
    height: 204
    fontsize: 20
    color: "steelblue"

    text: "VERIFY\n WEIGHT"
        onClicked:{
 //           if(convOn.active!=true){
            staticBtn.text = "STATIC WT";staticBtn.textcolor = "black";handle_loadcellcalls.staticstart()
                setZeroBtn.active=false
                setZeroBtn.textcolor = "white"
                staticBtnpg2.active=true
                savetextfield.disableScreen("RT")

//            }
//            else
//            {
//                staticBtn.active=false
//                staticBtnpg2.active=false
//
//            }
        }
}
HexButton {
    id: setZeroBtn
    x: 836
    y: 686
    width: 220
    height: 204
    color: "teal"
    text: "SET ZERO"
    fontsize: 20
    transformOrigin: Item.Top
    antialiasing: false
    scale: 1
                    onClicked:{


                        console.log("Clicked 2");
//                        if(convOn.active!=true){
                        savetextfield.disableScreen("RT")
                        setZeroBtn.text = "SET ZERO";setZeroBtn.textcolor = "black";handle_loadcellcalls.setzerostart();
                        staticBtn.active=false
                            setZeroBtnpg2.active=true


 //                       }
//                        else
//                        {
//                            setZeroBtn.active=false
//                            setZeroBtnpg2.active=false

//                        }
                    }
                    onPressAndHold:
                        console.log("Long Pressed 2")
}
//HexButton {
//    id:statsPgBtn
//    x: 836
//    y: 490
//    width: 220
//    height: 204
//    color: "olive"
//    text: "STATS\nPAGE"
//    fontsize: 20

//    onClicked:{
//                 savetextfield.disableScreen("RT")
//                if((UIStyle.prdName.indexOf("1") >= 0)){
//                /*handle_loadcellcalls.stats_page();*/fitnessPage1.loadUserStatus();statsPage.open(); /*pageSw(Qt.resolvedUrl("qrc:/qml/Weather/StatsPage.qml"))*/
//            }
//            else{
//                statsPgBtn.color = "olive"
//                authFailDialog.open();setZeroBtn.enabled = false;staticBtn.enabled = false;convOn.enabled = false
//            }

//        }
//        //      handle_loadcellcalls.stats_page();pageSw(Qt.resolvedUrl("qrc:/qml/Weather/StatsPage.qml"))


//}
Connections{
    target: handle_loadcellcalls
    onHandlestats_data:{
  //     var temp = new Array(0);
        UIStyle.fileParam = ""
        UIStyle.fileParam = statsdata;
 //       temp.push(statsdatapg)
 //       console.log("received stats data:"+statsdata)
        console.log("received stats array data:"+UIStyle.fileParam)
 //        statsViewmodel.append({StatsParam:statsdatapg})
    }

}

function loadUserStatus(){
    handle_loadcellcalls.read_stats_page();
    statsViewmodel.clear({StatsParam:""})
    statsViewmodel.clear({StsParamVal:""})

    statsViewmodelpg2.clear({StatsParam:""})
    statsViewmodelpg2.clear({StsParamVal:""})

    for(var i = 0;i<UIStyle.fileParam.length;i++){
        myString = UIStyle.fileParam[i]
        UIStyle.prd_code1 = stringList[0]
        UIStyle.prd_code2 = stringList[1]
        statsViewmodel.append({StatsParam:UIStyle.prd_code1,StsParamVal:UIStyle.prd_code2})
        statsViewmodelpg2.append({StatsParam:UIStyle.prd_code1,StsParamVal:UIStyle.prd_code2})
 //       statsViewmodel.append({StatsParam:UIStyle.prd_code1})
    }
UIStyle.fileParam = ""

}

//Dialog {
//        id: statsPage
//        x: 10
//        y: 20
//        width: 1100
//        height: 700
//        visible: false
////        closePolicy: Popup.CloseOnEscape
//        background: Rectangle{
//            color: "aquamarine"
//            radius: 5
//            border.color: "mediumturquoise"
//        }

//        header: Rectangle{
//            width:1100
//            height: 40
//            color: "mediumturquoise"
//            border.color: "aquamarine"
//            radius: 5
//            Text{
//                anchors.centerIn: parent
//                text: "Statistical Data Window"
//                font.pixelSize: 30
//                color: "black"
//            }
//        }
//   contentItem: FocusScope{
//        Row {
//            id: blckUnblckcolumn
//            width: 1100
//            height: 600
//            spacing: 20
//            Column{
//                spacing: 50
//                anchors.top: parent.top
//                anchors.topMargin: 30
//                GroupBox{
//                    id:statsGrp
// //                   title: "Present User List with Status"
//                    width: 1100
//                    height: 600
////                    style: Style {
////                        property Component panel: Rectangle {
////                            Text {
////                                anchors.horizontalCenter: parent.horizontalCenter
////                                anchors.bottom: parent.top

////                                text: control.title
////                                color: control.enabled ? "Black" : "gray"
////                                renderType: Text.NativeRendering
////                                font.italic: !control.enabled
////                                //     font.weight: Font.Bold
////                                font.pointSize: 18
////                            }
////                        }
////                    }

//                    TableView {
//                        id: usrBlckUnblckListView

//                        anchors.fill: parent

//                        frameVisible: true
//                        backgroundVisible: true
//                        alternatingRowColors: true
//                        sortIndicatorVisible: true
//                        clip: true
//                        highlightOnFocus: true

//                        //ScrollBar

// //                       enabled: false

//                        TableViewColumn {
//                            id:stsParam
//                            role: "StatsParam"
//                            title: "Stats Parameter"
//                  //          width: usrBlckUnblckListView.width / 2
//                            width: 500
//                            resizable: true
//                            movable: true

//                            delegate: Component {
//                                id: usrBlckUnblckListViewdelegate

//                                Text {
//                                    //         anchors.verticalCenter: parent.verticalCenter
//                                    color: "Black"
//                                    elide: styleData.elideMode
//                                    text: styleData.value
//                                    font.family: "Arial"
//                                    font.pixelSize: 30
//                                }
//                            }

//                        }
//                        TableViewColumn {
//                            id:stsParamVal
//                            role: "StsParamVal"
//                            title: "Stats Parameter Value"
//                            width: 500
//                            resizable: true
//                            movable: true


//                            delegate: Component {
//                                id: statusdelegate

//                                Text {
//                                    color: "Black"
//                                    elide: styleData.elideMode
//                                    text: styleData.value
//                                    font.family: "Arial"
//                                    font.pixelSize: 30
//                                }
//                            }

//                        }

//                        model: ListModel {
//                            id: statsViewmodel
//                            ListElement { StatsParam: ""
//                                StsParamVal:""
//                            }
////                            ListElement { StatsParam:""

////                            }
////                            ListElement { StsParamVal:""

////                            }
//                        }


//                        rowDelegate: Rectangle {
//                            property bool selected : styleData.selected
//                            width: parent.width-2
//                            height: 90
//                            color: styleData.selected? "lightgray" : "steelblue"
//                            Rectangle {
//                                width: parent.width
//                                height: 1
//                                anchors.bottom: parent.bottom
//                                visible: parent.selected
//                                color: "steelblue"
//                            }
//                        }
//                        headerDelegate: Rectangle {
//                            width: parent.width
//                            height: 60
//                            color: "Brown"
//                            Text {
//                                anchors.fill: parent
//                                text: styleData.value
//                                color: "Yellow"
//                                font.family: "Arial"
//                                font.pixelSize: 40
//                            }
//                        }

//                    }
//                }

//            }

//   }

//}
//}



//Dialog {
//        id: authFailDialog
//        width: warmMsg1.contentWidth + 200
//        height: 300
//        x:10
//        y:100
//        visible: false
////          standardButtons: StandardButton.Ok
////          title:  "Login Failed!!!"
//         closePolicy: Popup.CloseOnEscape
//         background: Rectangle{
//                    color: "aquamarine"
//                    radius: 5
//                    border.color: "mediumturquoise"
//                }

//                header: Rectangle{
//                    width:150
//                    height: 40
//                    color: "mediumturquoise"
//                    border.color: "aquamarine"
//                    radius: 5
//                    Text{
//                        anchors.centerIn: parent
//                        text: "Authorization Failed!!!"
//                        font.pixelSize: 20
//                        color: "black"
//                    }
//                }
//   contentItem: FocusScope{
//        Column {
//            id: loginFailColumn
//            spacing: 20
//            Row{
//                spacing: 20
//                Label{id:warmMsg1;font.pixelSize:UIStyle.fontSizeXXL;text:"You are not Authorized to use this function!!";color:UIStyle.colorCandyPink}
//            }
//        }
//        Column{
//            spacing: 50
//            anchors.bottom: parent.bottom
//            anchors.right: parent.right
//            anchors.rightMargin: 20
//            anchors.bottomMargin: 20
//             Button{
//                 Label{
//                     anchors.centerIn: parent
//                     text: "OK"
//                     font.pixelSize: 20
//                 }
//      //          isDefault: true
//                focus: true
//                 width: 150
//                height: 80
//                onClicked:{savetextfield.disableScreen("RT");authFailDialog.close();setZeroBtn.enabled = true;staticBtn.enabled = true;convOn.enabled = true}
//            }
//         }

//    }

//}



    }

//        Item {
//            id: fitnessPage2
//      //      objectName: "page2"
//            x: 0
//          width: 1920
//          height: 1080


//          Image {
//              id:dycompImagepg2
//              x:100
//              y:20
//              visible: false
//              width: 80
//              height: 80
//       //       anchors.verticalCenter: parent.verticalCenter
//       //       source: "images/DynamicComp_icon.png"
//              source: "images/dycompfact.png"
//              fillMode: Image.PreserveAspectCrop
//          }
//          Image {
//              id:bypassImagepg2
//              x:250
//              y:20
//              visible: false
//              width: 80
//              height: 80
//       //       anchors.verticalCenter: parent.verticalCenter
//              source: "images/cwbypass.png"
//              fillMode: Image.PreserveAspectCrop
//          }



//            function storeFileValues(){

//                prdCode.text = UIStyle.fileParam[0];
//                prdName.text = UIStyle.fileParam[1];
//                batchNum.text = UIStyle.fileParam[2];
//                targetWt.text = UIStyle.fileParam[3] + " g";
//                tareWt.text = UIStyle.fileParam[4] + " g";
//                prdLength.text = UIStyle.fileParam[5] + " mm";
//                upperLmt.text = UIStyle.fileParam[6] + " g";
//                lowerLmt.text = UIStyle.fileParam[7] + " g";
//                speed.text = UIStyle.fileParam[8] + " ppm";
//                oprDly.text = UIStyle.fileParam[9];
//                hldDly.text = UIStyle.fileParam[10];
//                rejCnt.text = UIStyle.fileParam[11];
//                oprDly_md.text = UIStyle.fileParam[12];



//            }

//            //-------------------------------------------------------------

//                        Dialog {
//                            id: errDialog2
//                            visible: false
//                            title:  "ERROR WINDOW"
//                            closePolicy: Popup.CloseOnEscape


//                            x: 360
//                            y: 260
//                            background: Rectangle{
//                                color: "red"
//                                radius: 5
//                                border.color: "mediumturquoise"
//                            }

//                            header: Rectangle{
//                                width:1300//inputPanel.width
//                                height: 60
//                                color: "mediumturquoise"
//                                border.color: "aquamarine"
//                                radius: 5
//                                Text{
//                                    anchors.centerIn: parent
//                                    text: "ERROR WINDOW"
//                                    font.pixelSize: 30
//                                    color: "black"
//                                }
//                            }
//                            width: 1300//inputPanel.width + 100
//                            height:500//inputPanel.height + 100
//                            contentItem: FocusScope{
//                                Column{
//                                    anchors.bottom: parent.bottom
//                                    anchors.right: parent.right
//                                    anchors.rightMargin: 20
//                                    anchors.bottomMargin: 20
//                                   // Row{
//                                   //     spacing: 20
//                                        Button{
//                                            //     text: "OK"
//                                            Label{
//                                                anchors.centerIn: parent
//                                                text: "RESET"
//                                                font.pixelSize: 20
//                                            }
//                                        //    isDefault: true
//                                            focus: true
//                                            width: 150
//                                            height: 80
//                                            onClicked: {handle_loadcellcalls.err_reset();errDialog2.close();loginDialog.close();fitnessPage1.enabled = true;fitnessPage2.enabled = true;savetextfield.disableScreen("LE")}//;circularView.blurScreena("Origin")}
//                                        }
//            //                            Button{
//            //                                Label{
//            //                                    anchors.centerIn: parent
//            //                                    text: "OK"
//            //                                    font.pixelSize: 20
//            //                                }
//            //                                isDefault: true
//            //                                focus: true
//            //                                width: 150
//            //                                height: 80
//            //                                onClicked: {loginDialog.close()}
//            //                            }
//                                   // }
//                                }
//                                Column {
//                                    id: err2column
//                                    spacing: 20
//                                    Row{
//                                        spacing: 20
//                                        Label{id:err2id1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
//                                      //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
//                                    }
//                                    Row{
//                                        spacing: 25
//                                        Label{id:err2id2;visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
//                                      //  TextField{id:password;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 50;loginDialog.height = 700}echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 300;height: 60;}
//                                    }
//                                }

//                            }
//                            //-----------------------------------------------------------------------------------------------------------

//                        }

//            //---------------------------------------------------------------------

//                        Dialog {
//                            id: setzeroDialog2
//                            visible: false
//                            title:  "SETZERO WINDOW"
//                            closePolicy: Popup.CloseOnEscape


//                            x: 360
//                            y: 260
//                            background: Rectangle{
//                                color: "red"
//                                radius: 5
//                                border.color: "mediumturquoise"
//                            }

//                            header: Rectangle{
//                                width:1300//inputPanel.width
//                                height: 60
//                                color: "mediumturquoise"
//                                border.color: "aquamarine"
//                                radius: 5
//                                Text{
//                                    anchors.centerIn: parent
//                                    text: "SETZERO WINDOW"
//                                    font.pixelSize: 30
//                                    color: "black"
//                                }
//                            }
//                            width: 1300//inputPanel.width + 100
//                            height:500//inputPanel.height + 100
//                            contentItem: FocusScope{
//                                Column{
//                                    anchors.bottom: parent.bottom
//                                    anchors.right: parent.right
//                                    anchors.rightMargin: 20
//                                    anchors.bottomMargin: 20
//                                   // Row{
//                                   //     spacing: 20
//            //                            Button{
//            //                                //     text: "OK"
//            //                                Label{
//            //                                    anchors.centerIn: parent
//            //                                    text: "RESET"
//            //                                    font.pixelSize: 20
//            //                                }
//            //                            //    isDefault: true
//            //                                focus: true
//            //                                width: 150
//            //                                height: 80
//            //                                onClicked: {loginDialog.close()}//;circularView.blurScreena("Origin")}
//            //                            }
//                                }
//                                Column {
//                                    id: setzerocolumn2
//                                    spacing: 20
//                                    Row{
//                                        spacing: 20
//                                        Label{id:setz2id1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:errormsg1;color:UIStyle.colorQtWhite1}
//                                      //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
//                                    }
//                                }

//                            }
//                            //-----------------------------------------------------------------------------------------------------------

//                        }


//            //--------------------------------------------------------------



////            Rectangle {
////                anchors.horizontalCenter: parent.horizontalCenter
////                width: parent.width
////                height: titleRow.height
////                color: "#ffaa7f"
////                clip: false
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0
////                        color: "#76edfc"
////                    }

////                    GradientStop {
////                        position: 1
////                        color: "#000000"
////                    }
////                }

////                anchors.horizontalCenterOffset: 0


////                Row {
////                    id: titleRow
////                    spacing: 10
////                    anchors.centerIn: parent

////                    Image {
////                        id: image
////                        anchors.verticalCenter: parent.verticalCenter
////                        source: "images/display22.png"
////                        fillMode: Image.PreserveAspectCrop
////                    }
////                    Text {
////                        color: "#ffffff"
////                        anchors.verticalCenter: parent.verticalCenter
////                        text: qsTr("COMBO DISPLAY")
////                        font.pixelSize: UIStyle.fontSizeM
////                        font.letterSpacing: 2
////                    }
////                 //   Component.onCompleted:{savetextfield.powerOnLoadFromLib("F:\\ dummy.txt"); fitnessPage2.storeFileValues()}
////                }
////              //  Component.onCompleted: {savetextfield.powerOnLoadFromLib("F:\\ dummy.txt");fitnessPage2.storeFileValues()}
////            }

////            Rectangle {
////               // id: rectangle1
////               // objectName: "rect"
////                y: -2
////                anchors.horizontalCenter: parent.horizontalCenter
////                width: parent.width
////                height: 60
////                //"#ffaa7f"
////                clip: false
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0
////                        color: "#76edfc"
////                    }

////                    GradientStop {
////                        position: 1
////                        color: "#000000"
////                    }
////                }

////                anchors.horizontalCenterOffset: 0

////                Row {
////                    id: titleRow
////                    spacing: 10
////                    anchors.centerIn: parent

////                    Image {
////                        width: 50
////                        height: 58
////                        anchors.verticalCenter: parent.verticalCenter
////                        source: "images/display22.png"
////                        fillMode: Image.PreserveAspectCrop
////                    }
////                    Text {
////                        y: 10
////                        height: 58
////                        color: "#ffffff"
////                        anchors.verticalCenter: parent.verticalCenter
////                        text: qsTr("COMBO DISPLAY")
////                        font.pixelSize: UIStyle.fontSizeXXL
////                        font.letterSpacing: 2
////                    }
////                }

////            }

//            Label{
//                x:750
//                y: 5
//                text: "COMBO DISPLAY"
//                font.pixelSize: 50
//                color: "white"
//            }


////            Rectangle{
////                x:0
////                y:40
////                width: parent.width
////                height: 565
////                // 350
////                color: UIStyle.colorQtGray8
////                antialiasing: false
////            }

//            HexButton {
//                    id: convOnpg2
//                    x: 664
//                    y: 592
//                    width: 220
//                    height: 204
//                    color: "peru"
//                    text: "CONV OFF"
//                    fontsize: 20        //"Button 1"




//                    onClicked:{
//                    console.log("Clicked 1")
//                    if(convOnpg2.active == true)
//                    {convOnpg2.text = "CONV ON";convOnpg2.textcolor = "black";staticBtn.textcolor = "white";handle_loadcellcalls.conv_onoff();

//                        staticBtnpg2.active=false
//                        setZeroBtnpg2.active=false
//                        setZeroBtnpg2.textcolor = "white"
//                        convOn.active = true
//                        convOn.text = "CONV ON";convOn.textcolor = "black";
//                        setZeroBtn.active=false
//                        setZeroBtn.textcolor = "white"
//                        savetextfield.disableScreen("LD")


//                    }
//                    else{convOnpg2.text = "CONV OFF";convOnpg2.textcolor = "white";handle_loadcellcalls.conv_onoff();

//                        staticBtnpg2.active=false;setZeroBtnpg2.active=false
//                        convOn.active = false
//                        convOn.text = "CONV OFF";convOn.textcolor = "white";
//                        setZeroBtn.active=false
//                        setZeroBtn.textcolor = "white"

//                        savetextfield.disableScreen("LE")
//                    }
//                }
//            }
//            HexButton {
//                id: staticBtnpg2
//                x: 1009
//                y: 591
//                width: 220
//                height: 204

//                text: "STATIC WT"
//                fontsize: 20
//                onClicked:{
//                    if(convOnpg2.active!=true){staticBtnpg2.text = "STATIC WT";staticBtnpg2.textcolor = "black";handle_loadcellcalls.staticstart();
//                        setZeroBtnpg2.active=false
//                        setZeroBtnpg2.textcolor = "white"
//                        staticBtn.active=true
//                        savetextfield.disableScreen("RT")


//                    }
//                    else
//                    {
//                        staticBtnpg2.active=false
//                        staticBtn.active=false

//                    }




//                    }
//            }
//            HexButton {
//                id: setZeroBtnpg2
//                x: 836
//                y: 686
//                width: 220
//                height: 204
//                color: "teal"
//                text: "SET ZERO"
//                fontsize: 20
//                //     fontsize: 12
//                           //     textcolor: "yellow"
//                                onClicked:{
//                                    console.log("Clicked 2")
//                                    savetextfield.disableScreen("RT")
//                                    if(convOnpg2.active!=true){setZeroBtnpg2.text = "SET ZERO";setZeroBtnpg2.textcolor = "black";handle_loadcellcalls.setzerostart();

//                                        staticBtnpg2.active=false
//                                        staticBtn.active=false
//                                        setZeroBtnpg2.active=true
//                                        setZeroBtn.active=true

//                                    }
//                                     else
//                                        {
//                                            setZeroBtnpg2.active=false
//                                            setZeroBtn.active=false

//                                        }


//                                }
//                                onPressAndHold:
//                                    console.log("Long Pressed 2")
//            }
//            HexButton {
//                id:statsbtnPg2
//                x: 836
//                y: 490
//                width: 220
//                height: 204
//                color: "olive"
//                text: "STATS\nPAGE"
//                fontsize: 20
//                onClicked:{
//                            savetextfield.disableScreen("RT")
//                            if((UIStyle.prdName.indexOf("1") >= 0)){
//                            fitnessPage1.loadUserStatus();statsPage1.open();/*savetextfield.disableScreen("LE");handle_loadcellcalls.stats_page();pageSw(Qt.resolvedUrl("qrc:/qml/Weather/StatsPage.qml"))*/
//                        }
//                        else{
//                            statsbtnPg2.color = "olive"
//                            authFailDialogpg2.open();setZeroBtnpg2.enabled = false;staticBtnpg2.enabled = false;convOnpg2.enabled = false
//                        }

//                    }

//           }

//            Dialog {
//                    id: authFailDialogpg2
//                    width: warmMsgpg2.contentWidth + 200
//                    height: 300
//                    x:10
//                    y:100
//                    visible: false
//            //          standardButtons: StandardButton.Ok
//            //          title:  "Login Failed!!!"
//                     closePolicy: Popup.CloseOnEscape
//                     background: Rectangle{
//                                color: "aquamarine"
//                                radius: 5
//                                border.color: "mediumturquoise"
//                            }

//                            header: Rectangle{
//                                width:150
//                                height: 40
//                                color: "mediumturquoise"
//                                border.color: "aquamarine"
//                                radius: 5
//                                Text{
//                                    anchors.centerIn: parent
//                                    text: "Authorization Failed!!!"
//                                    font.pixelSize: 20
//                                    color: "black"
//                                }
//                            }
//               contentItem: FocusScope{
//                    Column {
//                        id: loginFailColumnpg2
//                        spacing: 20
//                        Row{
//                            spacing: 20
//                            Label{id:warmMsgpg2;font.pixelSize:UIStyle.fontSizeXXL;text:"You are not Authorized to use this function!!";color:UIStyle.colorCandyPink}
//                        }
//                    }
//                    Column{
//                        spacing: 50
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right
//                        anchors.rightMargin: 20
//                        anchors.bottomMargin: 20
//                         Button{
//                             Label{
//                                 anchors.centerIn: parent
//                                 text: "OK"
//                                 font.pixelSize: 20
//                             }
//                  //          isDefault: true
//                            focus: true
//                             width: 150
//                            height: 80
//                            onClicked:{savetextfield.disableScreen("RT");authFailDialogpg2.close();setZeroBtnpg2.enabled = true;staticBtnpg2.enabled = true;convOnpg2.enabled = true}
//                        }
//                     }

//                }

//            }

//            Dialog {
//                    id: statsPage1
//                    x: 10
//                    y: 20
//                    width: 1100
//                    height: 700
//                    visible: false
//            //        closePolicy: Popup.CloseOnEscape
//                    background: Rectangle{
//                        color: "aquamarine"
//                        radius: 5
//                        border.color: "mediumturquoise"
//                    }

//                    header: Rectangle{
//                        width:1100
//                        height: 40
//                        color: "mediumturquoise"
//                        border.color: "aquamarine"
//                        radius: 5
//                        Text{
//                            anchors.centerIn: parent
//                            text: "Statistical Data Window"
//                            font.pixelSize: 30
//                            color: "black"
//                        }
//                    }
//               contentItem: FocusScope{
//                    Row {
//                        id: blckUnblckcolumnpg2
//                        width: 1100
//                        height: 600
//                        spacing: 20
//                        Column{
//                            spacing: 50
//                            anchors.top: parent.top
//                            anchors.topMargin: 30
//                            GroupBox{
//                                id:statsGrppg2
//             //                   title: "Present User List with Status"
//                                width: 1100
//                                height: 600
//            //                    style: Style {
//            //                        property Component panel: Rectangle {
//            //                            Text {
//            //                                anchors.horizontalCenter: parent.horizontalCenter
//            //                                anchors.bottom: parent.top

//            //                                text: control.title
//            //                                color: control.enabled ? "Black" : "gray"
//            //                                renderType: Text.NativeRendering
//            //                                font.italic: !control.enabled
//            //                                //     font.weight: Font.Bold
//            //                                font.pointSize: 18
//            //                            }
//            //                        }
//            //                    }

//                                TableView {
//                                    id: usrBlckUnblckListViewpg2

//                                    anchors.fill: parent

//                                    frameVisible: true
//                                    backgroundVisible: true
//                                    alternatingRowColors: true
//                                    sortIndicatorVisible: true
//                                    clip: true
//                                    highlightOnFocus: true

//                                    //ScrollBar

//             //                       enabled: false

//                                    TableViewColumn {
//                                        id:stsParampg2
//                                        role: "StatsParam"
//                                        title: "Stats Parameter"
//                              //          width: usrBlckUnblckListView.width / 2
//                                        width: 500
//                                        resizable: true
//                                        movable: true

//                                        delegate: Component {
//                                            id: usrBlckUnblckListViewdelegatepg2

//                                            Text {
//                                                //         anchors.verticalCenter: parent.verticalCenter
//                                                color: "Black"
//                                                elide: styleData.elideMode
//                                                text: styleData.value
//                                                font.family: "Arial"
//                                                font.pixelSize: 30
//                                            }
//                                        }

//                                    }
//                                    TableViewColumn {
//                                        id:stsParamValpg2
//                                        role: "StsParamVal"
//                                        title: "Stats Parameter Value"
//                                        width: 500
//                                        resizable: true
//                                        movable: true


//                                        delegate: Component {
//                                            id: statusdelegatepg2

//                                            Text {
//                                                color: "Black"
//                                                elide: styleData.elideMode
//                                                text: styleData.value
//                                                font.family: "Arial"
//                                                font.pixelSize: 30
//                                            }
//                                        }

//                                    }

//                                    model: ListModel {
//                                        id: statsViewmodelpg2
//                                        ListElement { StatsParam: ""
//                                            StsParamVal:""
//                                        }
//            //                            ListElement { StatsParam:""

//            //                            }
//            //                            ListElement { StsParamVal:""

//            //                            }
//                                    }


//                                    rowDelegate: Rectangle {
//                                        property bool selected : styleData.selected
//                                        width: parent.width-2
//                                        height: 90
//                                        color: styleData.selected? "lightgray" : "steelblue"
//                                        Rectangle {
//                                            width: parent.width
//                                            height: 1
//                                            anchors.bottom: parent.bottom
//                                            visible: parent.selected
//                                            color: "steelblue"
//                                        }
//                                    }
//                                    headerDelegate: Rectangle {
//                                        width: parent.width
//                                        height: 60
//                                        color: "Brown"
//                                        Text {
//                                            anchors.fill: parent
//                                            text: styleData.value
//                                            color: "Yellow"
//                                            font.family: "Arial"
//                                            font.pixelSize: 40
//                                        }
//                                    }



//                                }
//                            }

//                        }


//               }



//            }
//            }

////            HexButton {
////                x: 1685
////                y: 526
////                width: 220
////                height: 206
////                color: "#808000"
////                text: "BATCH\nREPORT"
////                fontsize: 20
////                onClicked:{
////                    {handle_loadcellcalls.slot_view_batch_report()}
////                }

////            }
////            HexButton {
////                x: 1515
////                y: 626
////                width: 220
////                height: 206
////                color: "#808000"
////                text: "AUDIT\nREPORT"
////                fontsize: 20
////                onClicked:{
////                    {handle_loadcellcalls.slot_view_audit_report()}
////                }

////            }
////            HexButton {
////                x: 1685
////                y: 726
////                width: 220
////                height: 206
////                color: "#808000"
////                text: "ALARAM\nREPORT"
////                fontsize: 20
////                onClicked:{
////                    {handle_loadcellcalls.slot_view_alaram_report()}
////                }

////            }

//            Row {
//                x: 11
//                y: 8
//                spacing:20
//            Column {
//                // The "Row" type lays out its child items in a horizontal line
//                spacing: 10 // Places 20px of space between items
//                x:UIStyle.xDistance
//                y:UIStyle.yDistance

//                Item {
//                    id: button
//                    width: 80
//                    height: 50
//                    anchors.horizontalCenter: parent.horizontalCenter
// //                   property alias text: innerText.text
//                    signal clicked

////                    Text {
////                        id: innerText
////                        anchors.centerIn: parent
////                        color: "black"
////                        font.bold: true
////                        text: "pressed"
////                    }

//                    //Mouse area to react on click events
//                }



//                Button {
//                    text: "BATCH DETAILS"
//                    font.pointSize: 20
//                    font.family: "Times New Roman"
//                    checkable: false
//                    highlighted: true
//                    autoExclusive: true
//                    spacing: 0
//                    //    color: "teal"

//                    anchors.horizontalCenter: parent.horizontalCenter
//                    width: fitnessPage2.width/7
//                    height: 100
//                    onClicked: contentDialog.open()

//                    Dialog {
//                        id: contentDialog
//                        x: (fitnessPage2.width - width) / 10
//                        y: (fitnessPage2.height - height) / 3

//                        width: Math.min(fitnessPage2.width, fitnessPage2.height) / 3 * 2
//                        contentHeight: logo.height * 8
//                        parent: QQ2.ApplicationWindow.overlay

//                        modal: true
//                        title: "Product File Parameter"
//                        font.pointSize: 20
//                        standardButtons: Dialog.Close

//                        Flickable {
//                            id: flickable
//                            clip: true
//                            contentHeight: contentDialog.height     //column.height
//                            anchors.fill: parent
//                            Column {
//                                id: column
//                                spacing: 20
//  //                              width: fitnessPage2.width

//                                Row{
//                                    spacing: 20
//                                    Image {
//                                        id: logo
//                                        width: contentDialog.width
//                                         anchors.horizontalCenter: contentDialog.horizontalCenter
//                                         source: "images/product_data_page_small1.png"
//                                      //   fillMode: Image.PreserveAspectCrop
//                                        fillMode: Image.PreserveAspectFit
//                                    }

//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize:UIStyle.fontSizeXS;text:"PRODUCT CODE  #";color:UIStyle.colorQtGray1}
//                                 Label{id:prdCode;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:"PRODUCT NAME      #";color: UIStyle.colorQtGray1}
//                                 Label{id:prdName;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:"BATCH NUMBER      #";color: UIStyle.colorQtGray1}
//                                 Label{id:batchNum;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }

//                            }

//                            ScrollIndicator.vertical: ScrollIndicator {
//                                parent: contentDialog.contentItem
//                                anchors.top: flickable.top
//                                anchors.bottom: flickable.bottom
//                                anchors.right: parent.right
//                                anchors.rightMargin: -contentDialog.rightPadding + 1
//                            }
//                        }
//                    }
//                }

//                Button {
//                     text: "Dynamic Weight\nParameter"
//                     font.pointSize: 20
//                     font.family: "Times New Roman"
//                //    color: "teal"
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    width: fitnessPage2.width/7
//                    height: 100
//                    onClicked: contentDialogDynWeightParam.open()

//                    Dialog {
//                        id: contentDialogDynWeightParam
//                        x: (fitnessPage2.width - width) / 10
//                        y: (fitnessPage2.height - height) / 3

//                        width: Math.min(fitnessPage2.width, fitnessPage2.height) / 3 * 2
//                        contentHeight: logDynWtParam.height * 8
//                        parent: QQ2.ApplicationWindow.overlay

//              //          modal: true
//                        title: " Dynamic Weight Parameter"
//                        font.pointSize: 20
//                        standardButtons: Dialog.Close

//                        Flickable {
//                            id: flickableDynWtParam
//                            anchors.rightMargin: -384
//                            anchors.bottomMargin: -56
//                            anchors.leftMargin: 1
//                            anchors.topMargin: 0
//                            clip: true
//                            anchors.fill: parent
//                            contentHeight: contentDialogDynWeightParam.height     //column.height

//                            Column {
//                                id: columnDynWtParam
//                                spacing: 20
//  //                              width: fitnessPage2.width

//                                Row{
//                                    spacing: 20
//                                    Image {
//                                        id: logDynWtParam
//                                        width: contentDialogDynWeightParam.width
//                                         anchors.horizontalCenter: contentDialogDynWeightParam.horizontalCenter
//                                         source: "images/product_data_page_small1.png"
//                                      //   fillMode: Image.PreserveAspectCrop
//                                        fillMode: Image.PreserveAspectFit
//                                    }

//                                }
//                                Row{
//                                    spacing: 20
//                                   Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.targ_wt;color:UIStyle.colorQtGray1}
//                                   Label{id:targetWt;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.tare_wt;color: UIStyle.colorQtGray1}
//                                 Label{id:tareWt;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}//Label{text:"g";color:UIStyle.colorQtGray1;x:48;y:4}}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.up_lmt;color: UIStyle.colorQtGray1}
//                                 Label{id:upperLmt;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.lo_lmt;color: UIStyle.colorQtGray1}
//                                 Label{id:lowerLmt;font.pixelSize: UIStyle.fontSizeXS;color: UIStyle.colorQtGray1}
//                                }

//                            }

//                            ScrollIndicator.vertical: ScrollIndicator {
//                                parent: contentDialogDynWeightParam.contentItem
//                                anchors.top: flickableDynWtParam.top
//                                anchors.bottom: flickableDynWtParam.bottom
//                                anchors.right: parent.right
//                                anchors.rightMargin: -contentDialogDynWeightParam.rightPadding + 1
//                            }
//                        }
//                    }
//                }
//                Button {
//                     text: "Dynamic Rejection\nParameter"
//                     font.pointSize: 20
//                     font.family: "Times New Roman"
//                //    color: "teal"
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    width: fitnessPage2.width/7
//                    height: 100
//                    onClicked: contentDialogDynRejParam.open()

//                    Dialog {
//                        id: contentDialogDynRejParam
//                        x: (fitnessPage2.width - width) / 10
//                        y: (fitnessPage2.height - height) / 3

//                        width: Math.min(fitnessPage2.width, fitnessPage2.height) / 3 * 2
//                        contentHeight: logDynRejParam.height * 8
//                        parent: QQ2.ApplicationWindow.overlay

//              //          modal: true
//                        title: " Dynamic Rejection Parameter"
//                        font.pointSize: 20
//                        standardButtons: Dialog.Close

//                        Flickable {
//                            id: flickableDynRejParam
//                            x: 0
//                            anchors.rightMargin: 1
//                            anchors.leftMargin: 1
//                            anchors.topMargin: 0
//                            anchors.bottomMargin: -56
//                            clip: true
//                            anchors.fill: parent
//                            contentHeight: contentDialogDynRejParam.height     //column.height

//                            Column {
//                                id: columnDynRejParam
//                                x: 1
//                                y: 0
//                                spacing: 20
//  //                              width: fitnessPage2.width

//                                Row{
//                                    spacing: 20
//                                    Image {
//                                        id: logDynRejParam
//                                        width: 1920
//                                        height: 67
//                                        anchors.horizontalCenter: contentDialogDynRejParam.horizontalCenter
//                                         source: "images/product_data_page_small1.png"
//                                      //   fillMode: Image.PreserveAspectCrop
//                                        fillMode: Image.PreserveAspectFit
//                                    }

//                                }
//                                Row{
//                                    spacing: 20
//                                   Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.prd_len;color: UIStyle.colorQtGray1}
//                                   Label{id:prdLength;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.speed;color: UIStyle.colorQtGray1}
//                                 Label{id:speed;font.pixelSize: UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize:UIStyle.fontSizeXS;text:UIStyle.opr_dly;color:UIStyle.colorQtGray1}
//                                 Label{id:oprDly;font.pixelSize:UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize:UIStyle.fontSizeXS;text:UIStyle.hld_dly;color:UIStyle.colorQtGray1}
//                                 Label{id:hldDly;font.pixelSize:UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize:UIStyle.fontSizeXS;text:"REJECT COUNT      #";color:UIStyle.colorQtGray1}
//                                 Label{id:rejCnt;font.pixelSize:UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }
//                                Row{
//                                    spacing: 20
//                                 Label{font.pixelSize:UIStyle.fontSizeXS;text:"OPERATE DLY(MD)    #";color:UIStyle.colorQtGray1}
//                                 Label{id:oprDly_md;font.pixelSize:UIStyle.fontSizeXS;color:UIStyle.colorQtGray1}
//                                }

//                            }

//                            ScrollIndicator.vertical: ScrollIndicator {
//                                parent: contentDialogDynRejParam.contentItem
//                                anchors.top: flickableDynRejParam.top
//                                anchors.bottom: flickableDynRejParam.bottom
//                                anchors.right: parent.right
//                                anchors.rightMargin: -contentDialogDynRejParam.rightPadding + 1
//                            }
//                        }
//                    }
//                }


//                 }

//            Column {
//                spacing: 10
//                x:UIStyle.xDistance
//                y:UIStyle.yDistance

//            }
//        }


////            Rectangle{//cnts rectangle
////                id:cntsRectangle
////                x: 8
////                y: 302
////                width: parent.width/2.9
////                height:parent.height/6.1
////                border.width: 2
////                radius: 10
////                opacity: 0.5
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0
////                        color: "#0dcd83"
////                    }

////                    GradientStop {
////                        position: 0.993
////                        color: "#71d61f"
////                    }
////                }
////                   border.color: "#d58546"
////             }

////            Rectangle{
////                id: dynwrPg2rectangle
////                x: 354
////                y: 73
////                width: parent.width/2.8
////                height:parent.height/5
////                opacity: 0.5
////                rotation: 0
////                border.width: 2
////                radius: 10
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0
////                        color: "#ffffff"
////                    }

////                    GradientStop {
////                        position: 0.993
////                        color: "#71d61f"
////                    }
////                }
////                border.color: "#d58546"

////             }

////            Rectangle{
////                id: dynwrPg2rectangle
////                x: 686
////                y: 152
////                width: 681
////                height: 263
////                color: "#0000ff"
////                opacity: 0.5
////                rotation: 0
////                border.width: 2
////                radius: 10
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0.993
////                        color: "#facc53"
////                    }

////                    GradientStop {
////                        position: 1
////                        color: "#71d61f"
////                    }
////                }
////                border.color: "#57f529"

////             }

//            Rectangle{
//                id: dynwrPg2rectangle
//                x: 609
//                y: 100
//                //        x: 296
//                //        y: 110
//                width: 827
//                height: 330
//                opacity: 0.5
//                rotation: 0
//                //dy.weight
//                // "transparent"
//                border.width: 2
//                radius: 20
//                gradient: Gradient {
//                    GradientStop {
//                        position: 0
//                        color: "#0dcd83"
//                    }

//                    GradientStop {
//                        position: 0.993
//                        color: "#71d61f"
//                    }
//                }
//                border.color: "#d58546"



//             }


//          //  Label{id:dyWeight; x: 414; y: 83;font.pixelSize: 100;color:UIStyle.colorQtWhite1;text: UIStyle.netWt ;font.family: "Times New Roman";}
//            Label{id:dyWeight; x: 714; y: 121; width: 546; height: 266; color: "#0000ff";text: UIStyle.netWt ; font.pointSize: 220; /*padding: 0;*/ font.family: "Times New Roman"; antialiasing: false; fontSizeMode: Text.HorizontalFit; opacity: 1; font.weight: Font.Thin; verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter; rotation: 0;}

//  //          Label{ x: 13; y: 314;text: "UNDERWIGHT COUNTS #"; font.pixelSize: 18; font.family: "Times New Roman"; renderType: Text.NativeRendering; horizontalAlignment: Text.AlignLeft;color:UIStyle.colorQtWhite1;}
//  //          Label{ x: 13; y: 344;text: "ACCEPT COUNTS     #"; font.pixelSize: 18; font.family: "Times New Roman";color:UIStyle.colorQtWhite1;}
//   //         Label{ x: 13; y: 375;text: "OVERWEIGHT COUNTS #"; font.pixelSize: 18;color:UIStyle.colorQtWhite1;}


////            Rectangle {
////                id: rectangle_acpcnts
////                x: 72
////                y: 599
////                width: 392
////                height: 101
////                color: "#facc53"
////                radius: 1
////                border.color: "#20f243"
////                border.width: 2

////                Label {
////                    id: label4
////                    x: 35
////                    y: 8
////                    width: 254
////                    height: 39
////                    color: "#0000ff"
////                    text: qsTr("ACCEPT COUNTS")
////                    font.family: "Times New Roman"
////                    font.pixelSize: 30
////                }
////            }

////            Rectangle {
////                id: rectangle_uwcnts
////                x: 72
////                y: 458
////                width: 392
////                height: 101
////                color: "#facc53"
////                radius: 4
////                border.width: 2
////                border.color: "#20f243"

////                Label {
////                    id: label3
////                    x: 17
////                    y: 8
////                    width: 353
////                    height: 45
////                    color: "#0000ff"
////                    text: qsTr("UNDERWEIGHT COUNTS")
////                    font.family: "Times New Roman"
////                    font.pixelSize: 30
////                }
////            }

////            Rectangle {
////                id: rectangle_owcnts
////                x: 72
////                y:738
////                width: 392
////                height: 101
////                color: "#facc53"
////                radius: 1
////                border.width: 2
////                border.color: "#20f243"

////                Label {
////                    id: label5
////                    x: 17
////                    y: 8
////                    width: 341
////                    height: 38
////                    color: "#0000ff"
////                    text: qsTr("OVERWEIGHT COUNTS")
////                    font.family: "Times New Roman"
////                    font.pixelSize: 30
////                }
////            }



////            Label{ id: dasd; x: 183; y: 650; width: 120; height: 34; clip: false;text:UIStyle.acp_counts ; font.pointSize: 30; font.family: "Times New Roman"; renderType: Text.NativeRendering; textFormat: Text.RichText; opacity: 1; }


////            Rectangle{      //system parameter
////                id:sysParamRectangle
////                x: 664
////                y: 309
////                width: parent.width/2.9
////                height:parent.height/6.1
////                border.width: 2
////                radius: 10
////                opacity: 0.5
////                gradient: Gradient {
////                    GradientStop {
////                        position: 0
////                        color: "#ffffff"
////                    }
////                    GradientStop {
////                        position: 0.993
////                        color: "#71d61f"
////                    }
////                }
////                   border.color: "#d58546"


////             }

////            Label{ x: 672; y: 314;font.pixelSize:UIStyle.fontSizeXS;text:UIStyle.dy_comp;color:UIStyle.colorQtWhite1;}
////            Label{id:dyCompOff; x: 849; y: 314;font.pixelSize:UIStyle.fontSizeXS;text:"OFF"; color:UIStyle.colorQtYellow1;}
////            Label{ x: 672; y: 342;font.pixelSize:UIStyle.fontSizeXS;text:UIStyle.dy_comp_fact;color:UIStyle.colorQtWhite1;}
////            Label{ x: 672; y: 372;font.pixelSize:UIStyle.fontSizeXS;text:UIStyle.feed_back;color:UIStyle.colorQtWhite1;}
////            Label{id:feedbackOff; x: 849; y: 372;font.pixelSize:UIStyle.fontSizeXS;text:"OFF";color:UIStyle.colorQtYellow1;}


////            Label {
////                id: ow_cnts
////                x: 183
////                y: 798
////                width: 120
////                height: 34
////                text: UIStyle.ow_counts
////                textFormat: Text.RichText
////                clip: false
////                opacity: 1
////                renderType: Text.NativeRendering
////                font.family: "Times New Roman"
////                font.pointSize: 30
////            }

////            Label {
////                id: dasd2
////                x: 183
////                y: 518
////                width: 120
////                height: 34
////                text: UIStyle.uw_counts
////                textFormat: Text.RichText
////                clip: false
////                opacity: 1
////                renderType: Text.NativeRendering
////                font.family: "Times New Roman"
////                font.pointSize: 30
////            }
//            Rectangle {
//                id: rectangle_stddev
//                x: 1494
//                y: 83
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 4
//                border.color: "#20f243"
//                border.width: 2
//                Label {
//                    id: label6
//                    x: 17
//                    y: 8
//                    width: 353
//                    height: 45
//                    color: "#0000ff"
//                    text: "STD DEVIATION"
//        //            verticalAlignment: Text.AlignVCenter
//        //            horizontalAlignment: Text.AlignHCenter
//                    font.pixelSize: 30
//                    font.family: "Times New Roman"
//                }

//                Label {
//                    id: dasd4
//                    x: 1609
//                    y: 198
//                    width: 120
//                    height: 34
//                    text: UIStyle.std_deviation
//                    renderType: Text.NativeRendering
//                    font.pointSize: 30
//                    clip: false
//                    textFormat: Text.RichText
//                    font.family: "Times New Roman"
//                    opacity: 1
//                }
//            }

//            Label {
//                id: dasd3
//                x: 1609
//                y: 142
//                width: 120
//                height: 34
//                text: UIStyle.std_deviation
//                renderType: Text.NativeRendering
//                font.pointSize: 30
//                clip: false
//                textFormat: Text.RichText
//                font.family: "Times New Roman"
//                opacity: 1
//            }

//            Rectangle {
//                id: rectangle_stddev1
//                x: 1494
//                y: 221
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 4
//                border.color: "#20f243"
//                border.width: 2
//                Label {
//                    id: label7
//                    x: 17
//                    y: 8
//                    width: 353
//                    height: 45
//                    color: "#0000ff"
//                    text: "AVG - X WT"
//          //          verticalAlignment: Text.AlignVCenter
//                    font.pixelSize: 30
//          //          horizontalAlignment: Text.AlignHCenter
//                    font.family: "Times New Roman"
//                }
//            }

//            Label {
//                id: dasd5
//                x: 1609
//                y: 282
//                width: 120
//                height: 34
//                text: UIStyle.avgxWt
//   //             verticalAlignment: Text.AlignVCenter
//   //             horizontalAlignment: Text.AlignHCenter
//                renderType: Text.NativeRendering
//                font.pointSize: 30
//                clip: false
//                textFormat: Text.RichText
//                font.family: "Times New Roman"
//                opacity: 1
//            }

//            Rectangle {
//                id: rectangle_uwcnts
//                x: 1494
//                y: 542
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 4
//                border.width: 2
//                border.color: "#20f243"

//                Label {
//                    id: label3
//                    x: 17
//                    y: 8
//                    width: 353
//                    height: 45
//                    color: "#0000ff"
//                    text: qsTr("UNDERWEIGHT COUNTS")
//                    font.family: "Times New Roman"
//                    font.pixelSize: 30
//                }
//            }
//            Label {
//                id: dasd2
//                x: 1603
//                y: 602
//                width: 120
//                height: 34
//                text: UIStyle.uw_counts
//                textFormat: Text.RichText
//                clip: false
//                opacity: 1
//                renderType: Text.NativeRendering
//                font.family: "Times New Roman"
//                font.pointSize: 30
//            }
//            Rectangle {
//                id: rectangle_acpcnts
//                x: 1502
//                y: 677
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 1
//                border.color: "#20f243"
//                border.width: 2

//                Label {
//                    id: label4
//                    x: 17
//                    y: 8
//                    width: 254
//                    height: 39
//                    color: "#0000ff"
//                    text: qsTr("ACCEPT COUNTS")
//                    font.family: "Times New Roman"
//                    font.pixelSize: 30
//                }
//            }
//            Label{ id: dasd; x: 1609; y: 726; width: 120; height: 34; clip: false;text:UIStyle.acp_counts ; font.pointSize: 30; font.family: "Times New Roman"; renderType: Text.NativeRendering; textFormat: Text.RichText; opacity: 1; }

//            Rectangle {
//                id: rectangle_owcnts
//                x: 1502
//                y:818
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 1
//                border.width: 2
//                border.color: "#20f243"

//                Label {
//                    id: label5
//                    x: 17
//                    y: 8
//                    width: 341
//                    height: 38
//                    color: "#0000ff"
//                    text: qsTr("OVERWEIGHT COUNTS")
//                    font.family: "Times New Roman"
//                    font.pixelSize: 30
//                }
//            }
//            Label {
//                id: ow_cnts
//                x: 1609
//                y: 870
//                width: 120
//                height: 34
//                text: UIStyle.ow_counts
//                textFormat: Text.RichText
//                clip: false
//                opacity: 1
//                renderType: Text.NativeRendering
//                font.family: "Times New Roman"
//                font.pointSize: 30
//            }

//            Rectangle {
//                id: rectangle_dycompfact
//                x: 1494
//                y: 370
//                visible: false
//                width: 392
//                height: 101
//                color: "#facc53"
//                radius: 4
//                border.color: "#20f243"
//                Label {
//                    id: label9
//                    x: 17
//                    y: 8
//                    width: 353
//                    height: 45
//                    color: "#0000ff"
//                    text: qsTr("DY.COMP.FACTOR")
//                    font.family: "Times New Roman"
//                    font.pixelSize: 30
//                }
//                border.width: 2
//            }

//            Label {
//                id: dasd6
//                x: 1603
//                y: 430
//                visible: false
//                width: 120
//                height: 34
//                text: UIStyle.dycomp_factor
//                font.pointSize: 30
//                font.family: "Times New Roman"
//                clip: false
//                opacity: 1
//                textFormat: Text.RichText
//                renderType: Text.NativeRendering
//            }



////            Rectangle {
////                id: rectangle_dycomp_onoff
////                x: 1527
////                y: 632
////                width: 285
////                height: 71
////                color: "#facc53"
////                radius: 1
////                border.width: 2
////                border.color: "#20f243"



////                Text {
////                    id: dyCompStatus
////                    x: 90
////                    y: 39
////                    width: 42
////                    height: 24
////                    color: "#f11205"
////                    text: qsTr("OFF")
////                    font.pixelSize: 20
////                }

////                Label {
////                    id: label
////                    x: 8
////                    y: 9
////                    width: 239
////                    height: 24
////                    color: "#0000ff"
////                    text: qsTr("DYNAMIC COMPENSATION")
////                    font.pixelSize: 20
////                }
////            }

////            Rectangle {
////                id: rectangle_feedbk
////                x: 1527
////                y: 899
////                width: 285
////                height: 71
////                color: "#facc53"
////                radius: 1
////                border.width: 2
////                border.color: "#20f243"
////                Label {
////                    id: label2
////                    x: 82
////                    y: 8
////                    width: 97
////                    height: 24
////                    color: "#0000ff"
////                    text: qsTr("FEEDBACK")
////                    font.pixelSize: 20
////                }

////                Text {
////                    id: feedbackStatus
////                    x: 102
////                    y: 38
////                    width: 42
////                    height: 24
////                    color: "#f11205"
////                    text: qsTr("OFF")
////                    font.pixelSize: 20
////                }
////            }

////            Rectangle {
////                id: rectangle_dycomp_fact
////                x: 1527
////                y: 759
////                width: 285
////                height: 71
////                color: "#facc53"
////                radius: 1
////                border.width: 2
////                border.color: "#20f243"

////                Label {
////                    id: label1
////                    x: 1
////                    y: 8
////                    width: 258
////                    height: 24
////                    color: "#0000ff"
////                    text: qsTr("DY.COMPENSATION FACTOR")
//            //                    font.pixelSize: 20
//            //                }
//            //            }



//        }


        Component.onCompleted: {savetextfield.disableScreen("RT");/*if((convOn.active == true) | (convOnpg2.active == true)){savetextfield.disableScreen("LD")}*/ /*savetextfield.powerOnLoadFromLib("F:\\ currentFile.txt");*/savetextfield.powerOnLoadFromLib("currentFile.txt");/*fitnessPage2.storeFileValues();*/savetextfield.disableScreen("1");handle_loadcellcalls.send_sts();
            }

        }

    PageIndicator {
        count: svFitnessContainer.count
        currentIndex: svFitnessContainer.currentIndex
        anchors.bottom: svFitnessContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onCurrentIndexChanged: {console.log("swipe:"+currentIndex);stackView.swipeviewpg(currentIndex);savetextfield.disableScreen("RT")}
    }

}
