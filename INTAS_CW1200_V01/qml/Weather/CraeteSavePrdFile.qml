
//import QtQuick 2.7
//import QtQuick.Controls 2.0 as QQ2

//import Qt.labs.settings 1.0
//import QtQuick.Controls 2.2

//import QtQuick.Controls 1.2
//import QtQuick.Controls.Private 1.0
//import QtQuick.Controls.Styles 1.4
//import QtQuick.Dialogs 1.2

//import QtQuick 2.3
//import QtQuick.Controls 1.2

//import QtQuick.Layouts 1.1
//import QtQuick.Window 2.0

//import QtQuick.VirtualKeyboard 2.1


import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.VirtualKeyboard 2.1
import QtQml 2.0
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Controls.Material 2.2
import QtQml.Models 2.2
import QtQuick 2.0
import QtQuick.Layouts 1.1


import QtQuick.Controls 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import QtQuick.Controls.Styles 1.1
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

//import "weather.js" as WeatherData
import "../Style"
import "../Fitness"

Item {
    id:mainPrdPg
    width: 1920
    height: 1080
    enabled: UIStyle.idleforfg

    property var vardigit3: RegExpValidator  {regExp: /^[0-9]{3,3}([\.\,][0-9]{2,2})?$/}
    property var vardigit2:RegExpValidator  {regExp: /^[0-9]{2,2}([\.\,][0-9]{2,2})?$/}
//    property var valid1: RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
    property var targetwt_digit: RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
    property var limit_digit: RegExpValidator  {regExp: /^[0-9]{2,2}([\.\,][0-9]{1,1})?$/}
    property string  prodmsg1:prodid1.text

    property bool emptyChkfg: false
SwipeView {
    id: svPrdDataContainer
    width: 1920
    height: 1000
    currentIndex: 0
         Item {
            id: prdDataPage1
             width: 1920; height: 1000

                property int cmplData
                property int incmplData
                property int dataPos

  //              property alias panelVisibility: inputPanel1.visible


                 signal sendValue(string text)

             Label{
                 x:750
                 y: 5
                 text: "CREATE RECIPE"
                 font.pixelSize: 50
                 color: "white"
             }

             Connections{
                 target: savetextfield
                onDisablescr1:{
                     console.log("login action create n save page")
                    if(cnt == 1){
                    prdDataPage1.enabled = false
                    }
                    if(cnt == 2){
                    prdDataPage1.enabled = true
                    }
                 }
             }

             Connections{
                 target: savetextfield
                onDisablescr1:{
                     console.log("login action in prdDataPage")
                    if(cnt == 1){
          //          prdDataPage1.enabled = false
                    }
                    if(cnt == 2){
           //         prdDataPage1.enabled = true
                    }
                    if(cnt == 3){
                        vardigit3 = targetwt_digit// =  RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
                        vardigit2 = limit_digit
                        console.log("DIGIT RESLN")
                    }

                    if(cnt==121)
                    {

                            prodmsg1 = "WARNING -> MAX PACK LENGTH #" + cnt1
                        prodid1.visible=true
                        prodDialog.open()
                        prdLength.text = cnt1
                    }

                    if(cnt==120)
                    {

                        prodmsg1 = "WARNING -> MAX ALLOWED PACKS/MIN #" + cnt1 + "PPM"
                        prodid1.visible=true
                        prodDialog.open()
                        speed.text = cnt1
                    }



                }
             }
             Dialog {
                 id: prodDialog
                 visible: false
                 title:  "PRODUCT DATA WINDOW"
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
                                 onClicked: {savetextfield.disableScreen("RT");prodDialog.close()}//;circularView.blurScreena("Origin")}
                             }
                     }
                     Column {
                         id: errcolumn
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

             function storeFileValues(){

                 prdCodef.text = UIStyle.fileParam[0];
                 prdName.text = UIStyle.fileParam[1];
                 batchNum.text = UIStyle.fileParam[2];
                 targetWt.text = UIStyle.fileParam[3];
                 tareWt.text = UIStyle.fileParam[4];
                 prdLength.text = UIStyle.fileParam[5];
                 upperLmt.text = UIStyle.fileParam[6];
                 lowerLmt.text = UIStyle.fileParam[7];
                 speed.text = UIStyle.fileParam[8];
                 oprDly.text = UIStyle.fileParam[9];
                 hldDly.text = UIStyle.fileParam[10];
                  rejCnt.text = UIStyle.fileParam[11];
                 oprDly_md.text = UIStyle.fileParam[12];
      //           savetextfield.saveParamInFile(UIStyle.fileParam,UIStyle.fileParam.length);
                 UIStyle.fileName = "";
                 fileName.text = "";
                 UIStyle.fileParam = "";
                 messageDialog.close();
             }

             function ldValues(){

             //   UIStyle.fileParam[0] ="";
                 var temp = new Array(0);
                 temp.push(prdCodef.text);
                 temp.push(prdName.text);
                 temp.push(batchNum.text);
                 temp.push(targetWt.text);
                 temp.push(tareWt.text);
                 temp.push(prdLength.text);
                 temp.push(upperLmt.text);
                 temp.push(lowerLmt.text);
                 temp.push(speed.text);
                 temp.push(oprDly.text);
                 temp.push(hldDly.text);
                  temp.push(rejCnt.text);
                 temp.push(oprDly_md.text);
                 UIStyle.fileParam = temp;

                 console.log("the param for saving in create and save:"+UIStyle.fileParam); //for debugging

                 for(var i =0;i < UIStyle.fileParam.length;i++){
                     if((UIStyle.fileParam[i] === " ") | (UIStyle.fileParam[i] === "")){
                        emptyChkfg = true

                     }

                 }
             }

             function initializeFileValues(){
                 prdCodef.text = "";
                 prdName.text = "";
                 batchNum.text = "";
                 targetWt.text = "";
                 tareWt.text = "";
                 prdLength.text = "";
                 upperLmt.text = "";
                 lowerLmt.text = "";
                 speed.text = "";
                 oprDly.text = "";
                 hldDly.text = "";
                 rejCnt.text = "";
                 oprDly_md.text = "";
                 UIStyle.fileName = "";
                 fileName.text = "";
                 UIStyle.fileParam = "";
              }
            function initializeFileParamName(){
                UIStyle.fileParamName[0] = "PRODUCT CODE:"
                UIStyle.fileParamName[1] = "PRODUCT NAME:"
                UIStyle.fileParamName[2] = "BATCH NUMBER:"
                UIStyle.fileParamName[3] = "TARGET WEIGHT:"
                UIStyle.fileParamName[4] = "TARE WEIGHT:"
                UIStyle.fileParamName[5] = "PRODUCT LENGTH:"
                UIStyle.fileParamName[6] = "SPEED:"
                UIStyle.fileParamName[7] = "UPPER LIMIT:"
                UIStyle.fileParamName[8] = "LOWER LIMIT:"
                UIStyle.fileParamName[9] = "OPERATE DELAY:"
                UIStyle.fileParamName[10] = "HOLD DELAY:"
                UIStyle.fileParamName[11] = "REJECT COUNT:"


            }
//            Connections{
//                target: handle_loadcellcalls
//               onHandleResln_digit:{
//                    console.log("Model Selection resolution")
//                   if(cnt == 1){
//                 //  prdDataPage1.enabled = false

//                       vardigit3 = targetwt_digit// =  RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
//                       vardigit2 = limit_digit
//                       console.log("DIGIT RESLN")
//                   }
//                   if(cnt == 2){
//               //    prdDataPage1.enabled = true
//                   }
//                }
//            }

//            Rectangle {
//                anchors.horizontalCenter: parent.horizontalCenter
//                width: parent.width
//                height: 60
//                gradient: Gradient {
//                    GradientStop {
//                             position: 0
//                             color: "#76edfc"
//                         }

//                         GradientStop {
//                             position: 1
//                             color: "#000000"
//                         }
//                     }


//                     Row {
//                         id: titleRow
//                         spacing: UIStyle.bRadius           // 10
//                         anchors.centerIn: parent

//                         Image {
//                             sourceSize.height: 50
//                             anchors.verticalCenter: parent.verticalCenter
//                             source: "images/prd_lib_small1.png"
//                             fillMode: Image.PreserveAspectCrop
//                         }
//                         Text {
//                             color: "#fbfbfb"
//                             anchors.verticalCenter: parent.verticalCenter
//                             text: UIStyle.prdLbIconName
//                             font.pixelSize: 40
//                             font.letterSpacing: 2
//                         }
//                     }
//                     Component.onCompleted:{inputPanel.visible = false;saveFileNameDialog.open(); paramEdit.enabled = false;saveNewFile.enabled = false;savetextfield.disableScreen("1")/*savetextfield.powerOnLoadFromLib("F:\\ dummy.txt"); prdDataPage1.storeFileValues()*/}

//                 }
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

             Item {
                 id:paramEdit

 //                Row {
 //                    spacing: UIStyle.bSize
 //                    x : prdDataPage1.width/UIStyle.bSize
 //                    y : prdDataPage1.height/UIStyle.bRadius
 //                Column {

 //                    id : prdLabelPos
 //                    spacing: 17
//                     Label{ color: "#070707";font.pixelSize: UIStyle.fontSizeXS;text: "1.PRODUCT CODE"}
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.prdName;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.batchNum;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.targWt;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.tareWt;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.prdLen;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.upLmt;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.loLmt;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: 16;text:UIStyle.spd;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: 16;text:UIStyle.oprDly;color: UIStyle.colorQtblk }
//                     Label{font.pixelSize: 16;text:UIStyle.hldDly;color: UIStyle.colorQtblk }
//                 Label{ x: 23; y: 70; color: "#aaff00";text:UIStyle.prdCode; font.pixelSize: 30}

//                 Label{ x: 23; y: 70; color: "#aaff00";text:"1.PRODUCT CODE"; font.pixelSize: 30}
//                     Label{ x: 18; y: 170; color: "#aaff00";text:"2.PRODUCT NAME"; font.pixelSize: 30}
//                     Label{ x: 23; y: 270; width: 249; height: 34; color: "#aaff00";text:"3.BATCH NUMBER"; wrapMode: Text.NoWrap; font.pixelSize: 30}
//                     Label{ x: 24; y: 370; color: "#aaff00";text:"4.TARGET WEIGHT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 70; color: "#aaff00";text:"5.TARE WEIGHT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 170; color: "#aaff00";text:"6.PRODUCT LENGTH"; font.pixelSize: 30}

//                     Label{ x: 657; y: 270; width: 249; height: 34; color: "#aaff00";text:"7.UPPER LIMIT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 370; width: 249; height: 34; color: "#aaff00";text:"8.LOWER LIMIT"; font.pixelSize: 30}

//                     Label{ x: 722; y: 470; width: 249; height: 34; color: "#aaff00";text:"13.OPERATE DLY(MD)"; font.family: "Times New Roman"; font.pixelSize: 35}

//                     Label{ x: 1214; y: 70; width: 249; color: "#aaff00";font.pixelSize: 30;text:"9.SPEED"}
//                     Label{ x: 1220; y: 170; width: 249; height: 34; color: "#aaff00";font.pixelSize: 30;text:"10.OPERATE DELAY";}
//                     Label{ x: 1214; y: 270; width: 249; height: 34; color: "#aaff00";font.pixelSize: 30;text:"11.HOLD DELAY";}
//                     Label{ x: 1214; y: 370; width: 249; height: 34; color: "#aaff00"; text: "12.REJECT COUNT";font.pixelSize: 30}

                 Label{ x: 23; y: 70; width: 249; height: 34; color: "#aaff00";text:"1.PRODUCT CODE"; font.pixelSize: 35}
                 Label{ x: 23; y: 170; width: 249; height: 34; color: "#aaff00";text:"2.PRODUCT NAME"; font.pixelSize: 35}
                 Label{ x: 23; y: 270; width: 249; height: 34; color: "#aaff00";text:"3.BATCH NUMBER"; font.pixelSize: 35}
                 Label{ x: 23; y: 370; width: 249; height: 34; color: "#aaff00";text:"4.TARGET WEIGHT"; font.pixelSize: 35}
                 Label{ x: 993; y: 70; width: 249; height: 34; color: "#aaff00";text:"5.TARE WEIGHT"; font.pixelSize: 35}
                 Label{ x: 994; y: 170; width: 329; height: 40; color: "#aaff00";text:"6.PRODUCT LENGTH"; font.pixelSize: 35}
                 Label{ x: 996; y: 270; width: 249; height: 34; color: "#aaff00";text:"7.UPPER LIMIT"; font.family: "Times New Roman"; font.pixelSize: 35}
                 Label{ x: 998; y: 371; width: 249; height: 34; color: "#aaff00";text:"8.LOWER LIMIT"; font.family: "Times New Roman"; font.pixelSize: 35}



//                     Label{ x: 23; y: 70; color: "#aaff00";text:"1.PRODUCT CODE"; font.pixelSize: 30}
//                     Label{ x: 18; y: 170; color: "#aaff00";text:"2.PRODUCT NAME"; font.pixelSize: 30}
//                     Label{ x: 23; y: 270; width: 249; height: 34; color: "#aaff00";text:"3.BATCH NUMBER"; wrapMode: Text.NoWrap; font.pixelSize: 30}
//                     Label{ x: 24; y: 370; color: "#aaff00";text:"4.TARGET WEIGHT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 70; color: "#aaff00";text:"5.TARE WEIGHT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 170; color: "#aaff00";text:"6.PRODUCT LENGTH"; font.pixelSize: 30}

//                     Label{ x: 657; y: 270; width: 249; height: 34; color: "#aaff00";text:"7.UPPER LIMIT"; font.pixelSize: 30}
//                     Label{ x: 657; y: 370; width: 249; height: 34; color: "#aaff00";text:"8.LOWER LIMIT"; font.pixelSize: 30}
//                     Label{ x: 1214; y: 70; width: 249; color: "#aaff00";font.pixelSize: 30;text:"9.SPEED";}
//                     Label{ x: 1220; y: 170; width: 249; height: 34; color: "#aaff00";font.pixelSize: 30;text:"10.OPERATE DELAY";}
//                     Label{ x: 1214; y: 270; width: 249; height: 34; color: "#aaff00";font.pixelSize: 30;text:"11.HOLD DELAY";}
//                     Label{ x: 1214; y: 370; width: 249; height: 34; color: "#aaff00"; text: "12.REJECT COUNT";font.pixelSize: 30}

 //                }

 //                Column {
 //                      spacing: 5

                 TextField{id:prdCodef;x: 376; y: 70; width: 503;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{prdCodef.focus = false;inputPanel.visible = false; }height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                 TextField{id:prdName; x: 381; y: 170; width: 498;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ prdName.focus = false;inputPanel.visible = false;}height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                 TextField{id:batchNum; x: 381; y: 270; width: 498;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {batchNum.focus = false;inputPanel.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                 TextField{id:targetWt; x: 385; y: 370; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{/*targetWt.text = digitAdjust1(targetWt.text);*/targetWt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit3;onTextChanged:{savetextfield.disableScreen("RT")}}
                 TextField{id:tareWt; x: 1380; y: 70; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next; onEnterKeyClicked:{/*tareWt.text = digitAdjust1(tareWt.text);*/ tareWt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit3;onTextChanged:{savetextfield.disableScreen("RT")}}
                 TextField{id:prdLength; x: 1380; y: 170; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 480}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ prdLength.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
                 TextField{id:upperLmt; x: 1380; y: 270; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {/*upperLmt.text = digitAdjust1(upperLmt.text);*/upperLmt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;onTextChanged:{savetextfield.disableScreen("RT")}}
                 TextField{id:lowerLmt; x: 1380; y: 370; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction:EnterKeyAction.Next;onEnterKeyClicked:{/*lowerLmt.text = digitAdjust1(lowerLmt.text);*/ lowerLmt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;onTextChanged:{savetextfield.disableScreen("RT")}}





//                       TextField{id:prdCodef ; x: 313; y: 70; width: 300;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{prdCodef.focus = false;inputPanel.visible = false;} /*prdCodef.focus = false;*/height: 50; color: "#0000ff";validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
//                       TextField{id:prdName; x: 313; y: 170; width: 300;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{prdName.focus = false;inputPanel.visible = false;} /*prdName.focus = false;*/height: 50; color: "#0000ff";validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
//                       TextField{id:batchNum; x: 313; y: 270; width: 300;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {batchNum.focus = false;inputPanel.visible = false;/*batchNum.focus = false*/}height: 50; fontPixelSize: 20;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
//                       TextField{id:targetWt; x: 313; y: 370; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{/*targetWt.text = digitAdjust1(targetWt.text);*/targetWt.focus = false;inputPanel.visible = false;/*targetWt.focus = false*/}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit3;/*RegExpValidator { regExp: /^[0-9]{3,3}([\.\,][0-9]{2,2})?$/}*/onTextChanged:{}}
//                       TextField{id:tareWt; x: 971; y: 70; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next; onEnterKeyClicked:{/*tareWt.text = digitAdjust1(tareWt.text);*/tareWt.focus = false;inputPanel.visible = false; /*tareWt.focus = false*/}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator:vardigit3; /*RegExpValidator { regExp: /^[0-9]{3,3}([\.\,][0-9]{2,2})?$/}*/onTextChanged:{}}
//                       TextField{id:prdLength; x: 971; y: 170; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ prdLength.focus = false;inputPanel.visible = false;}/* prdLength.focus = true;*/inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{}}
//                       TextField{id:upperLmt; x: 971; y: 270; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {/*upperLmt.text = digitAdjust1(upperLmt.text);*/upperLmt.focus = false;inputPanel.visible = false;/*upperLmt.focus = false*/}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;/*RegExpValidator { regExp: /^[0-9]{2,2}([\.\,][0-9]{2,2})?$/}*/onTextChanged:{}}
//                       TextField{id:lowerLmt; x: 971; y: 370; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction:EnterKeyAction.Next;onEnterKeyClicked:{/*lowerLmt.text = digitAdjust1(lowerLmt.text);*/lowerLmt.focus = false;inputPanel.visible = false;/* lowerLmt.focus = false*/}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;/*RegExpValidator { regExp: /^[0-9]{2,2}([\.\,][0-9]{2,2})?$/}*/onTextChanged:{}}

//                       TextField{id:oprDly_md; x: 1123; y: 470; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly_md.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}

//                       TextField{id:speed; x: 1559; y: 70; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {speed.focus = false;inputPanel.visible = false;}/* speed.focus = false;*/inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{}}
//                       TextField{id:oprDly; x: 1559; y: 171; width: 150;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{oprDly.focus = false;inputPanel.visible = false;}/* oprDly.focus = false;*/inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//                       TextField{id:hldDly; x: 1559; y: 270; width: 150;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{hldDly.focus = false;inputPanel.visible = false;} /*hldDly.focus = false;*/inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//                       TextField{id:rejCnt; x: 1559; y: 370; width: 150;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 500}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{rejCnt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}



                 Dialog {
                         id: messageDialog
                         width: warmMsg8.contentWidth + 200
                         height: 300
                         x:400
                         y:400
                         visible: false
               //          title:  "Logout Success!!!"
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
                                        text: "STATUS"
                                        font.pixelSize: 20
                                        color: "black"
                                    }
                                }
                      contentItem: FocusScope{
                         Column {
                             id: messageDialogColumn
                             spacing: 20
                             Row{
                                 spacing: 20
                                 Label{id:warmMsg8;font.pixelSize:UIStyle.fontSizeXXL;text: UIStyle.fileNameExist;color:UIStyle.colorQtblk}
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
                                isDefault: true
                                focus: true
                                 width: 150
                                height: 80
                                onClicked:{savetextfield.disableScreen("RT");messageDialog.close();messageDialogpg2.close(); UIStyle.scrEnabled = "0";UIStyle.fileNameExist = ""}
                            }


                          }

                     }

                 }



               //     signal passValue(string text);

                 }
//-----------------------------Digit Adjustment call--------------------------
             function digitAdjust(pwdTemp){
                 cmplData = 0
                 incmplData = 0
                 for (var i=0;i<pwdTemp.length;i++)
                     {
                         if ((".".match(pwdTemp[i]))){
                             dataPos = i+1
                         }
                         else{

                             incmplData = i
                         }

                 }
                 if((dataPos !=0) && (incmplData == dataPos)){
                    UIStyle.retData = pwdTemp
                 }
                 if((dataPos !=0) && (incmplData < dataPos)){
                     UIStyle.retData = pwdTemp + "0"
                 }
                 if(dataPos ==0){
                     UIStyle.retData = pwdTemp + ".0"
                 }
                    return UIStyle.retData
             }


//             HexButton {
//                     id:
//                     x: 1555
//                     y: 789
//                     width: 220
//                     height: 204
//                     color: "peru"
//                     text: " \nRECIPE"
//                     fontsize: 20
//                     onClicked:{
//                     prdDataPage1.loadLibraryFiles();libFileDialog.open()
//                 }
//             }
             HexButton {
                     id: saveNewFile
                     x: 1384
                     y: 687
                     width: 220
                     height: 204
                     color: "olive"
                     text: "SAVE  \nRECIPE"
                     fontsize: 20
                     onClicked:{savetextfield.disableScreen("RT");savetextfield.disableScreen("RT")
                          prdDataPage1.ldValues();UIStyle.fileNameCompare = fileName.text;
                       if(emptyChkfg != true){savetextfield.createNsaveToLib(UIStyle.fileName,UIStyle.fileParam,UIStyle.fileParam.length);savetextfield.createListFileNames(fileName.text + ".txt");
                         if(UIStyle.fileNameExist == "Recipe SAVE successfully"){saveNewFile.color = "olive";saveNewFile.active = false;messageDialog.open();prdDataPage1.enabled = false}
                      }else{emptyChkfg = false; UIStyle.fileNameExist = "One of the parameter is empty!!\nPlease fill all the parameteres.";saveNewFile.active = false;saveNewFilePg2.active = false;messageDialog.open();messageDialogpg2.open()}}
             }
             HexButton {
                     id: createFile
                     x: 1555
                     y: 585
                     width: 220
                     height: 204
                     color: "steelblue"
                     text: "CREATE \nRECIPE"
                     fontsize: 20
                     onClicked:{savetextfield.disableScreen("RT");
                       /* inputPanel.visible = false;paramEdit.enabled = false;saveNewFile.enabled = false;*/prdDataPage1.initializeFileValues();saveFileNameDialog.open()
                 }
             }

            function loadLibraryFiles(){
           //  savetextfield.loadFromListFileNames("F:\\ LibraryFiles.txt")
                savetextfield.loadFromListFileNames("LibraryFiles.txt")
                libFilemodel.clear({Filename:""})
                    for(var i = 0;i<UIStyle.fileList.length;i++){

                         UIStyle.prd_code1 = UIStyle.fileList[i]
                    libFilemodel.append({ Filename: UIStyle.prd_code1})
                     }


            }

            function storeFileParamValues(){

                fileParamsmodel.clear({FileParamVal:""})
                fileParamsmodel.clear({FileParamName:""})
                initializeFileParamName()
                for(var i = 0;i<UIStyle.fileParam.length;i++){

                     UIStyle.prd_code1 = UIStyle.fileParam[i]
                    UIStyle.prd_code2 = UIStyle.fileParamName[i]
                  //   prdParam.set(i,{"fileParamValueF":UIStyle.prd_code1})

                    fileParamsmodel.append({FileParamName: UIStyle.prd_code2,FileParamVal: UIStyle.prd_code1})

                 }

            }
            Dialog {
                    id: dfErrDialog
                    width: warmdfMsg.contentWidth + 200
                    height: 300
                    x:400
                    y:400
                    visible: false
          //          title:  "Logout Success!!!"
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
                                   text: "Warning!!!"
                                   font.pixelSize: 40
                                   color: "black"
                               }
                           }
                 contentItem: FocusScope{
                    Column {
                        id: warmdfMsgColumn
                        spacing: 20
                        Row{
                            spacing: 20
                            Label{id:warmdfMsg;font.pixelSize:UIStyle.fontSizeXXL;text: "DUPLICATE BATCH. PLEASE USE DIFFERENT  FILE NAME.";color:"red"}
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
                           isDefault: true
                           focus: true
                            width: 150
                           height: 80
                           onClicked:{savetextfield.disableScreen("RT");dfErrDialog.close();fileName.text = "";UIStyle.scrEnabled = "0";UIStyle.fileNameExist = "";saveFileNameDialog .open()}
                       }


                     }

                }

            }

             Dialog {
                     id: libFileDialog
                     standardButtons: StandardButton.Cancel | StandardButton.Ok
                     title:  "Library Window"
                     width: 1820
           //            x:23
           //            y:500

                     Row {
                         id: libFilecolumn
                         spacing: 20
                         Column{
                             spacing: 10
                             anchors.top: parent.top
                             anchors.topMargin: 30

                             GroupBox{
                                 width: 700
                                 height: 900

                                 style: Style {
                                                             property Component panel: Rectangle {
                                                                 Text {
                                                                     anchors.horizontalCenter: parent.horizontalCenter
                                                                     anchors.bottom: parent.top

                                                                     text: control.title
                                                                     color: control.enabled ? "Black" : "gray"
                                                                     renderType: Text.NativeRendering
                                                                     font.italic: !control.enabled
                                                                //     font.weight: Font.Bold
                                                                     font.pointSize: 18
                                                                 }
                                                             }
                                                         }


                             title: "Library File List"
                                 TableView {
                                     id: libFileListView


                                     anchors.fill: parent
                                     //      width: 600
                                     //      height: 400
                                     frameVisible: false
                                     backgroundVisible: false
                                      alternatingRowColors: false
                                       sortIndicatorVisible: true
                                        clip: true
                                       highlightOnFocus: false


                                     TableViewColumn {
                                     role: ""
                                     title: "File Names"
                                     width: libFileListView.width / 2
                                     resizable: false
                                     movable: false

                                     delegate: Component {
                                                                            id: libfiledelegate

                                                                            Text {
                                                                       //         anchors.verticalCenter: parent.verticalCenter
                                                                                color: "Black"
                                                                                elide: styleData.elideMode
                                                                                text: styleData.value
                                                                                font.family: "Arial"
                                                                                font.pixelSize: 30
                                                                            }
                                                            }

                                  }
//                                 TableViewColumn {
//                                     role: "GroupName"
//                                     title: "Group Name"
//                                     width: usrListView.width / 2
//                                     resizable: false
//                                     movable: false
//                                 }

//                                      frameVisible: false
//                                      backgroundVisible: true
//                                      alternatingRowColors: false

                                      model: ListModel {
                                      id: libFilemodel
                                         ListElement { Filename: ""
                                                   //GroupName:""
                                         }
                                 }

                                      rowDelegate: Rectangle {
                                                                     property bool selected : styleData.selected
                                                                     width: parent.width-2
                                                                     height: 20
                                                                     color: styleData.selected? "lightgray" : "steelblue"
                                                                     Rectangle {
                                                                         width: parent.width
                                                                         height: 1
                                                                         anchors.bottom: parent.bottom
                                                                         visible: parent.selected
                                                                         color: "steelblue"
                                                                     }
                                                                 }
                                      headerDelegate: Rectangle {
                                                                     width: parent.width
                                                                     height: 60
                                                                     color: "Brown"
                                                                     Text {
                                                                         anchors.fill: parent
                                                                         text: styleData.value
                                                                         color: "Yellow"
                                                                         font.family: "Arial"
                                                                         font.pixelSize: 40
                                                                     }
                                                                 }

                                      onCurrentRowChanged: {savetextfield.disableScreen("RT");fileLoadbtn.visible = true;deletebtn.visible = true; UIStyle.fileLibName = libFilemodel.get(__currentRow).Filename;UIStyle.fileName = "F:\\ " + libFilemodel.get(__currentRow).Filename;savetextfield.loadParamFromListFileName(UIStyle.fileName);prdDataPage1.storeFileParamValues();selFileName.text = "File Selected :" + UIStyle.fileLibName/*adminName = libFilemodel.get(__currentRow).Filename*/}

                                 }
                              }

                         }
                         Column{
                             spacing: 10
                             width: 300
                             height: 900
                             GroupBox{
                                 title: "Selected Library File Name Is"

                                 Label{id:selFileName;text: "";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight}

                             }
                             Button{id:fileLoadbtn;visible: false; text: "LOAD & CLOSE";width: 200;height: 80;onClicked:{savetextfield.disableScreen("RT");savetextfield.loadFromLib(UIStyle.fileName);prdDataPage1.storeFileValues();libFileDialog.close();load.active = false;}}
                             Button{id:closebtn;text: "CLOSE";width: 200;height: 80;onClicked:{savetextfield.disableScreen("RT");libFileDialog.close();load.active = false;}}
                             Button{id:deletebtn;visible: false; text: "DELETE";width: 200;height: 80;onClicked:{savetextfield.disableScreen("RT");savetextfield.removeFromLib(UIStyle.fileLibName);libFileDialog.close();prdDataPage1.loadLibraryFiles();libFileDialog.open();/*loadLibraryFiles();*/load.active = false;}}

                         }
                         Column{
                             spacing: 10

                    GroupBox{
                       title: "File Details"

                       width: 700
                       height: 900

                       style: Style {
                                                   property Component panel: Rectangle {
                                                       Text {
                                                           anchors.horizontalCenter: parent.horizontalCenter
                                                           anchors.bottom: parent.top

                                                           text: control.title
                                                           color: control.enabled ? "Black" : "gray"
                                                           renderType: Text.NativeRendering
                                                           font.italic: !control.enabled
                                                      //     font.weight: Font.Bold
                                                           font.pointSize: 18
                                                       }
                                                   }
                                               }


                       TableView {
                           id: fileParamList

                           anchors.fill: parent
                           //      width: 600
                           //      height: 400
                           frameVisible: false
                           backgroundVisible: false
                            alternatingRowColors: false
                             sortIndicatorVisible: true
                              clip: true
                             highlightOnFocus: false

                           TableViewColumn {
                               role: "FileParamName"
                               title: "File Parameter"
                               width: fileParamList.width / 2
                               resizable: false
                               movable: false

                               delegate: Component {
                                                                      id: filenamedelegate

                                                                      Text {
                                                                 //         anchors.verticalCenter: parent.verticalCenter
                                                                          color: "Black"
                                                                          elide: styleData.elideMode
                                                                          text: styleData.value
                                                                          font.family: "Arial"
                                                                          font.pixelSize: 30
                                                                      }
                                                      }

                           }
                           TableViewColumn {
                               role: "FileParamVal"
                               title: "Value"
                               width: fileParamList.width / 2
                               resizable: false
                               movable: false

                               delegate: Component {
                                                                      id: fileparamdelegate

                                                                      Text {
                                                                 //         anchors.verticalCenter: parent.verticalCenter
                                                                          color: "Black"
                                                                          elide: styleData.elideMode
                                                                          text: styleData.value
                                                                          font.family: "Arial"
                                                                          font.pixelSize: 30
                                                                      }
                                                      }


                           }

//                           frameVisible: false
//                           backgroundVisible: true
//                           alternatingRowColors: false


                           model: ListModel {
                              id: fileParamsmodel
                              ListElement{FileParamName: "";FileParamVal:""}

                           }

                           rowDelegate: Rectangle {
                                                          property bool selected : styleData.selected
                                                          width: parent.width-2
                                                          height: 90
                                                          color: styleData.selected? "lightgray" : "steelblue"
                                                          Rectangle {
                                                              width: parent.width
                                                              height: 1
                                                              anchors.bottom: parent.bottom
                                                              visible: parent.selected
                                                              color: "steelblue"
                                                          }
                                                      }
                           headerDelegate: Rectangle {
                                                          width: parent.width
                                                          height: 60
                                                          color: "Brown"
                                                          Text {
                                                              anchors.fill: parent
                                                              text: styleData.value
                                                              color: "Yellow"
                                                              font.family: "Arial"
                                                              font.pixelSize: 40
                                                          }
                                                      }


                       }

                    }

                }

             }
         }




                 Dialog {

                     id: saveFileNameDialog
                     width: inputPanel1.width + 100
                     height: inputPanel1.height + 100
                     visible: false
           //          standardButtons: StandardButton.Cancel | StandardButton.Ok
                     title:  "Create New Product File Name"
                      closePolicy: Popup.CloseOnEscape
                     background: Rectangle{
                                 color: "aquamarine"
                                 radius: 5
                                 border.color: "mediumturquoise"
                             }

                             header: Rectangle{
                                 width:inputPanel.width
                                 height: 60
                                 color: "mediumturquoise"
                                 border.color: "aquamarine"
                                 radius: 5
                                 Text{
                                     anchors.centerIn: parent
                                     text: "Create New Product File Name"
                                     font.pixelSize: 30
                                     color: "black"
                                 }
                             }

                contentItem: FocusScope{
                     Column {
                         id: column
                         spacing: 20
                         Row{
                             spacing: 20
                            Label{font.pixelSize:UIStyle.fontSizeXXL;text:"FILE NAME:";color:UIStyle.colorQtGray1}
                            TextField{id:fileName;previewText: "";fontPixelSize: 30;onFocusChanged: {inputPanel1.visible = true;inputPanel1.y = 20;saveFileNameDialog.height = 900}width: 600;height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: { /*UIStyle.fileName = "F:\\ " + fileName.text + ".txt";*/UIStyle.fileName = fileName.text + ".txt";savetextfield.disableScreen("RT")}}
                         }
                         Row{
                             spacing: 25
                             InputPanel {
                                 id: inputPanel1
                                 visible: false
                                 z: 89
                                 width: 1500
                                 //    y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
                                 y: Qt.inputMethod.visible ?  300 :parent.height
                                 //                        anchors.right: parent.right
                                 //                        anchors.rightMargin: 10
                                 //                        anchors.left: parent.left
                                 //                        anchors.leftMargin: 450
                                 //                 anchors.bottom: parent.bottom
                                 //                 anchors.bottomMargin: 100


                             }
                         }
                     }

                     Column{
                         anchors.bottom: parent.bottom
                         anchors.right: parent.right
                         anchors.rightMargin: 20
                         anchors.bottomMargin: 20
                         Row{
                             spacing: 20
                          Button{
                        //     text: "OK"
                              Label{
                                  anchors.centerIn: parent
                                  text: "OK"
                                  font.pixelSize: 20
                              }
                             isDefault: true
                             focus: true
                              width: 150
                             height: 80
                             onClicked: {savetextfield.disableScreen("RT");createFile.color = "steelblue";if(fileName.text == ""){}else{savetextfield.chkDuplicateFile(UIStyle.fileName);if(UIStyle.fileNameExist == "DF"){saveFileNameDialog.close();dfErrDialog.open()}else{paramEdit.enabled = true;paramEditpg2.enabled = true;saveNewFile.enabled = true;saveNewFilePg2.enabled = true;saveFileNameDialog.close();}}}
                          }
                          Button{
                        //     text: "OK"
                              Label{
                                  anchors.centerIn: parent
                                  text: "Cancel"
                                  font.pixelSize: 20
                              }
                             isDefault: true
                             focus: true
                              width: 150
                             height: 80
                             onClicked: {savetextfield.disableScreen("RT");createFile.color = "steelblue";saveFileNameDialog.close()}
                          }
                         }
                     }
                }


                 }


                 Dialog {
                     id: loadFileNameDialog
                     visible: false
                     standardButtons: StandardButton.Cancel | StandardButton.Ok
                     Column {
                         id: columnldFile
                         spacing: 20
                         Row{
                             spacing: 20
                             TextField{id:ldFileName;previewText: "One line field";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT");UIStyle.fileName = "F:\\ " + ldFileName.text + ".txt";console.log("the name of file is:" +UIStyle.fileName)}}

                         }

                     }
                     onAccepted: {savetextfield.disableScreen("RT");savetextfield.loadFromLib(UIStyle.fileName); prdDataPage1.storeFileValues()}
                 }

                 Loader {
                     id: loader
                     anchors.rightMargin: -8
                     anchors.bottomMargin: 0
                     anchors.leftMargin: 8
                     anchors.topMargin: 0
                     anchors.fill: parent

                     Label {
                         id: label
                         x: 530
                         y: 354
                         width: 78
                         height: 90
                         color: "black"
                         text: qsTr("g")
                         fontSizeMode: Text.Fit
                         font.pointSize: 25
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }

                     Label {
                         id: label1
                         x: 1544
                         y: 54
                         width: 78
                         height: 90
                         color: "black"
                         text: qsTr("g")
                         fontSizeMode: Text.Fit
                         verticalAlignment: Text.AlignVCenter
                         font.pointSize: 25
                         horizontalAlignment: Text.AlignHCenter
                     }

                     Label {
                         id: label2
                         x: 1544
                         y: 162
                         width: 78
                         height: 90
                         color: "black"
                         text: qsTr("mm")
                         fontSizeMode: Text.Fit
                         verticalAlignment: Text.AlignVCenter
                         font.pointSize: 25
                         horizontalAlignment: Text.AlignHCenter
                     }

//                     Label {
//                         id: label3
//                         x: 1701
//                         y: 58
//                         width: 78
//                         height: 90
//                         color: "#aaff00"
//                         text: qsTr("ppm")
//                         fontSizeMode: Text.Fit
//                         verticalAlignment: Text.AlignVCenter
//                         font.pointSize: 25
//                         horizontalAlignment: Text.AlignHCenter
//                     }

                     Label {
                         id: label4
                         x: 1544
                         y: 258
                         width: 78
                         height: 90
                         color: "black"
                         text: qsTr("g")
                         fontSizeMode: Text.Fit
                         verticalAlignment: Text.AlignVCenter
                         font.pointSize: 25
                         horizontalAlignment: Text.AlignHCenter
                     }

                     Label {
                         id: label5
                         x: 1544
                         y: 354
                         width: 78
                         height: 90
                         color: "black"
                         text: qsTr("g")
                         fontSizeMode: Text.Fit
                         verticalAlignment: Text.AlignVCenter
                         font.pointSize: 25
                         horizontalAlignment: Text.AlignHCenter
                     }
             }
             Connections {
                 target: loader.item
                 onMessage: {if(msg == "closed!"){} else{ prdDataPage1.storeFileValues()};loader.active = false}
             }


        }

         Item{
             id: prdDataPage2
              width: 1920
              height: 1080

              Item {
                  id:paramEditpg2

              Label{ x: 23; y: 70; width: 249; height: 34; color: "#aaff00";text:"9.OPERATE DLY(MD)"; font.family: "Times New Roman"; font.pixelSize: 35}
              Label{ x: 23; y: 170; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"10.SPEED";}
              Label {
                  id: speedLbl
                  x: 600
                  y: 150
                  width: 78
                  height: 90
                  text: qsTr("ppm")
                  color: "black"
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  font.pointSize: 25
              }
              Label{ x: 23; y: 270; width: 249; color: "#aaff00";font.pixelSize: 35;text:"11.OPERATE DLY(CW)";}
              Label{ x: 23; y: 370; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"12.HOLD DELAY"; font.family: "Times New Roman"}
              Label{ x: 23; y: 470; width: 249; height: 34; color: "#aaff00"; text: "13.REJECT COUNT";font.pixelSize: 35}

//              Label{ x: 793; y: 70; width: 249; height: 34; color: "#aaff00"; text: "COMPANY NAME";font.pixelSize: 35}
//              Label{ x: 793; y: 170; width: 249; height: 34; color: "#aaff00"; text: "LINE1 ADDRESS";font.pixelSize: 35}
//              Label{ x: 793; y: 270; width: 249; height: 34; color: "#aaff00"; text: "LINE2 ADDRESS";font.pixelSize: 35}
//              Label{ x: 793; y: 370; width: 249; height: 34; color: "#aaff00"; text: "MACHINE ID";font.pixelSize: 35}

              TextField{id:oprDly_md; x: 430; y: 70; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly_md.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
              TextField{id:speed; x: 430; y: 170; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {speed.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
              TextField{id:oprDly; x: 430; y: 270; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
              TextField{id:hldDly; x: 430; y: 370; width: 155;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ hldDly.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
              TextField{id:rejCnt; x: 430; y: 470; width: 150;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 60}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{rejCnt.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}

//              TextField{id:compName;x: 1180; y: 70; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{compName.focus = false;inputPanelpg2.visible = false; }height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,40}$/}onTextChanged: {}}
//              TextField{id:line1Add; x: 1180; y: 170; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ line1Add.focus = false;inputPanelpg2.visible = false;}height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,40}$/}onTextChanged: {}}
//              TextField{id:line2Add; x: 1180; y: 270; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {line2Add.focus = false;inputPanelpg2.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,40}$/}onTextChanged: {}}
//              TextField{id:machineId; x: 1180; y: 370; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {machineId.focus = false;inputPanelpg2.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}

              InputPanel {
                  id: inputPanelpg2

                  z: 89
                  width: 1300
                  visible: false

                  y: Qt.inputMethod.visible ?  300 :parent.height
                  anchors.bottom:  parent.Center
                  anchors.bottomMargin: 150
                  anchors.left: parent.left
                  anchors.leftMargin: 20


              }
            }
              HexButton {
                      id: saveNewFilePg2
                      x: 1384
                      y: 687
                      width: 220
                      height: 204
                      color: "olive"
                      text: "SAVE  \nRECIPE"
                      fontsize: 20
                      onClicked:{savetextfield.disableScreen("RT");
                           prdDataPage1.ldValues();UIStyle.fileNameCompare = fileName.text;
                         if(emptyChkfg != true){ savetextfield.createNsaveToLib(UIStyle.fileName,UIStyle.fileParam,UIStyle.fileParam.length);savetextfield.createListFileNames(fileName.text + ".txt");
                          if(UIStyle.fileNameExist == "Recipe SAVE successfully"){saveNewFile.color = "olive";saveNewFile.active = false;messageDialogpg2.open();prdDataPage2.enabled = false}
                      }else{emptyChkfg = false; UIStyle.fileNameExist = "One of the parameter is empty!!\nPlease fill all the parameteres.";saveNewFile.active = false;saveNewFilePg2.active = false;messageDialog.open();messageDialogpg2.open()}}
              }

              Dialog {
                      id: messageDialogpg2
                      width: warmMsgpg2.contentWidth + 200
                      height: 300
                      x:400
                      y:400
                      visible: false
            //          title:  "Logout Success!!!"
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
                                     text: "STATUS"
                                     font.pixelSize: 20
                                     color: "black"
                                 }
                             }
                   contentItem: FocusScope{
                      Column {
                          id: messageDialogpg2Column
                          spacing: 20
                          Row{
                              spacing: 20
                              Label{id:warmMsgpg2;font.pixelSize:UIStyle.fontSizeXXL;text: UIStyle.fileNameExist;color:UIStyle.colorQtblk}
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
                             isDefault: true
                             focus: true
                              width: 150
                             height: 80
                             onClicked:{savetextfield.disableScreen("RT");messageDialogpg2.close();messageDialog.close(); UIStyle.scrEnabled = "0";UIStyle.fileNameExist = ""}
                         }


                       }

                  }

              }


         }



//         Item {
//            id: prdDataPage2
//             width: 1920; height: 1000

//                property int cmplData
//                property int incmplData
//                property int dataPos
// //               property alias panelVisibility: inputPanel1.visible


//                 signal sendValue(string text)

////             function storeFileValues(){

////                 prdCodef.text = UIStyle.fileParam[0];
////                 prdName.text = UIStyle.fileParam[1];
////                 batchNum.text = UIStyle.fileParam[2];
////                 targetWt.text = UIStyle.fileParam[3];
////                 tareWt.text = UIStyle.fileParam[4];
////                 prdLength.text = UIStyle.fileParam[5];
////                 upperLmt.text = UIStyle.fileParam[6];
////                 lowerLmt.text = UIStyle.fileParam[7];
////                 speed.text = UIStyle.fileParam[8];
////                 oprDly.text = UIStyle.fileParam[9];
////                 hldDly.text = UIStyle.fileParam[10];
////                 UIStyle.fileName = "";
////                 fileName.text = "";
////                 UIStyle.fileParam = "";
////                 messageDialog.close();
////             }

////             function ldValues(){

////             //   UIStyle.fileParam[0] ="";
////                 var temp = new Array(0);
////                 temp.push(prdCodef.text);
////                 temp.push(prdName.text);
////                 temp.push(batchNum.text);
////                 temp.push(targetWt.text);
////                 temp.push(tareWt.text);
////                 temp.push(prdLength.text);
////                 temp.push(upperLmt.text);
////                 temp.push(lowerLmt.text);
////                 temp.push(speed.text);
////                 temp.push(oprDly.text);
////                 temp.push(hldDly.text);
////                 UIStyle.fileParam = temp;

////                 console.log("the param1:"+UIStyle.fileParam); //for debugging
////             }

////             function initializeFileValues(){
////                 prdCodef.text = "";
////                 prdName.text = "";
////                 batchNum.text = "";
////                 targetWt.text = "";
////                 tareWt.text = "";
////                 prdLength.text = "";
////                 upperLmt.text = "";
////                 lowerLmt.text = "";
////                 speed.text = "";
////                 oprDly.text = "";
////                 hldDly.text = "";
////                 UIStyle.fileName = "";
////                 fileName.text = "";
////                 UIStyle.fileParam = "";
////              }
////            function initializeFileParamName(){
////                UIStyle.fileParamName[0] = "PRODUCT CODE:"
////                UIStyle.fileParamName[1] = "PRODUCT NAME:"
////                UIStyle.fileParamName[2] = "BATCH NUMBER:"
////                UIStyle.fileParamName[3] = "TARGET WEIGHT:"
////                UIStyle.fileParamName[4] = "TARE WEIGHT:"
////                UIStyle.fileParamName[5] = "PRODUCT LENGTH:"
////                UIStyle.fileParamName[6] = "SPEED:"
////                UIStyle.fileParamName[7] = "UPPER LIMIT:"
////                UIStyle.fileParamName[8] = "LOWER LIMIT:"
////                UIStyle.fileParamName[9] = "OPERATE DELAY:"
////                UIStyle.fileParamName[10] = "HOLD DELAY:"


////            }

//            Rectangle {
//                anchors.horizontalCenter: parent.horizontalCenter
//                width: parent.width
//                height: titleRowpg2.height
//                gradient: Gradient {
//                         GradientStop {
//                             position: 0
//                             color: "#76edfc"
//                         }

//                         GradientStop {
//                             position: 1
//                             color: "#000000"
//                         }
//                     }


//                     Row {
//                         id: titleRowpg2
//                         spacing: UIStyle.bRadius           // 10
//                         anchors.centerIn: parent

//                         Image {
//                             anchors.verticalCenter: parent.verticalCenter
//                             source: "images/prd_lib_small1.png"
//                             fillMode: Image.PreserveAspectCrop
//                         }
//                         Text {
//                             color: "#fbfbfb"
//                             anchors.verticalCenter: parent.verticalCenter
//                             text: UIStyle.prdLbIconName
//                             font.pixelSize: UIStyle.fontSizeM
//                             font.letterSpacing: 2
//                         }
//                     }
//             //        Component.onCompleted:{inputPanel.visible = false;saveFileNameDialog.open(); paramEdit.enabled = false;saveNewFile.enabled = false/*savetextfield.powerOnLoadFromLib("F:\\ dummy.txt"); prdDataPage1.storeFileValues()*/}

//                 }
//                 InputPanel {
//                     id: inputPanelpg2

//                     z: 89
//                     width: 900
//                     visible: false

//                     y: Qt.inputMethod.visible ?  300 :parent.height
//                     anchors.bottom:  parent.Center
//                     anchors.bottomMargin: 150
//                     anchors.left: parent.left
//                     anchors.leftMargin: 20


//                 }

//             Item {
//                 id:paramEditpg2

// //                Row {
// //                    spacing: UIStyle.bSize
// //                    x : prdDataPage1.width/UIStyle.bSize
// //                    y : prdDataPage1.height/UIStyle.bRadius
// //                Column {

// //                    id : prdLabelPos
// //                    spacing: 17
////                     Label{ color: "#070707";font.pixelSize: UIStyle.fontSizeXS;text: "1.PRODUCT CODE"}
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.prdName;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.batchNum;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.targWt;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.tareWt;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.prdLen;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.upLmt;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: UIStyle.fontSizeXS;text:UIStyle.loLmt;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: 16;text:UIStyle.spd;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: 16;text:UIStyle.oprDly;color: UIStyle.colorQtblk }
////                     Label{font.pixelSize: 16;text:UIStyle.hldDly;color: UIStyle.colorQtblk }

// //                }

// //                Column {
// //                      spacing: 5

//                     Label{ x: 23; y: 55; color: "#aaff00";text:UIStyle.upLmt; font.pixelSize: 20;}
//                     Label{ x: 479; y: 55; color: "#aaff00";text:UIStyle.loLmt; font.pixelSize: 20;}
//                     Label{ x: 23; y: 115; color: "#aaff00";font.pixelSize: 20;text:UIStyle.spd;}
//                     Label{ x: 479; y: 115; color: "#aaff00";font.pixelSize: 20;text:UIStyle.oprDly;}
//                     Label{ x: 23; y: 176; color: "#aaff00";font.pixelSize: 20;text:UIStyle.hldDly;}
//                     Label{ x: 479; y: 176; color: "#aaff00"; text: "12.REJECT COUNT";font.pixelSize: 20;}
////                     TextField{id:upperLmt; x: 238; y: 50; width: 200;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {/*upperLmt.text = digitAdjust1(upperLmt.text);*/inputPanelpg2.visible = false;/*lowerLmt.focus = true*/}inputMethodHints: Qt.ImhDigitsOnly;height: 35;validator: RegExpValidator { regExp: /^[0-9]{2,2}([\.\,][0-9]{2,2})?$/}onTextChanged:{}}
////                     TextField{id:lowerLmt; x: 699; y: 50; width: 200;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction:EnterKeyAction.Next;onEnterKeyClicked:{/*lowerLmt.text = digitAdjust1(lowerLmt.text);*/inputPanelpg2.visible = false;/* speed.focus = true*/}inputMethodHints: Qt.ImhDigitsOnly;height: 35;validator: RegExpValidator { regExp: /^[0-9]{2,2}([\.\,][0-9]{2,2})?$/}onTextChanged:{}}
////                     TextField{id:speed; x: 238; y: 110; width: 200;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: inputPanelpg2.visible = false;/* oprDly.focus = true;*/inputMethodHints: Qt.ImhDigitsOnly;height: 35;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{}}
////                     TextField{id:oprDly; x: 699; y: 110; width: 200;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanelpg2.visible = false;/* hldDly.focus = true;*/inputMethodHints: Qt.ImhDigitsOnly;height: 35;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
////                     TextField{id:hldDly; x: 238; y: 171; width: 200;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanelpg2.visible = false; /*rejCnt.focus = true;*/inputMethodHints: Qt.ImhDigitsOnly;height: 35; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
////                     TextField{id:rejCnt; x: 699; y: 171; width: 200;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 220}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:inputPanelpg2.visible = false;inputMethodHints: Qt.ImhDigitsOnly;height: 35; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}

// //                }

// //                }


////-----------------------------Digit Adjustment call--------------------------
//             function digitAdjust(pwdTemp){
//                 cmplData = 0
//                 incmplData = 0
//                 for (var i=0;i<pwdTemp.length;i++)
//                     {
//                         if ((".".match(pwdTemp[i]))){
//                             dataPos = i+1
//                         }
//                         else{

//                             incmplData = i
//                         }

//                 }
//                 if((dataPos !=0) && (incmplData == dataPos)){
//                    UIStyle.retData = pwdTemp
//                 }
//                 if((dataPos !=0) && (incmplData < dataPos)){
//                     UIStyle.retData = pwdTemp + "0"
//                 }
//                 if(dataPos ==0){
//                     UIStyle.retData = pwdTemp + ".0"
//                 }
//                    return UIStyle.retData
//             }


//        }

//}
     }
    PageIndicator {
        count: svPrdDataContainer.count
        currentIndex: svPrdDataContainer.currentIndex

        anchors.bottom: svPrdDataContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Component.onCompleted:{inputPanel.visible = false;saveFileNameDialog.open(); paramEdit.enabled = false;paramEditpg2.enabled = false;saveNewFile.enabled = false;saveNewFilePg2.enabled = false;savetextfield.disableScreen("1")}
}



