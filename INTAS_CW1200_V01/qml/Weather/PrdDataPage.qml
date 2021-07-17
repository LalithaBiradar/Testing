
//import QtQuick.Extras 1.4
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.VirtualKeyboard 2.1
import QtQml 2.0
import QtQuick.Controls 2.0 as QQ2
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
//    property var targetwt_digit: RegExpValidator  {regExp: /(\d{1,4})([.,])\d{1,1}?$/}

    property var limit_digit: RegExpValidator  {regExp: /^[0-9]{2,2}([\.\,][0-9]{1,1})?$/}
    property string  prodmsg1:prodid1.text

    property bool emptyChkfg: false
    property bool modeSel: false

    property string modeText:"MACHINE\nMODE:"
    property string numChrs : "0123456789"

    property bool numChrsfg: false

  //  property string digitchng : "13579"



    SwipeView {
        id: svPrdDataContainer
//        width: 1024
//        height: 528
        anchors.fill: parent
        currentIndex: 0
//        anchors.rightMargin: 0
//        anchors.bottomMargin: 0
//        anchors.leftMargin: 0
//        anchors.topMargin: 1
//        anchors.fill: parent

        Item {
            id: prdDataPage1
             width: 1920
             height: 1080
             enabled: true

             property int cmplData
             property int incmplData
             property int dataPos
              signal sendValue(string text)
             property int vardigit1:4




             Connections{
                 target: savetextfield
                onDisablescr1:{
                     console.log("login action in prdDataPage")
                    if(cnt == 1){
                    prdDataPage1.enabled = false
                    }
                    if(cnt == 2){
                    prdDataPage1.enabled = true
                    }
                    if(cnt == 3){
                        vardigit3 = targetwt_digit// =  RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
                        vardigit2 = limit_digit
                        console.log("DIGIT RESLN")
                    }

                    if(cnt==5)
                    {

                        prodmsg1 = "WARNING -> PLEASE CREATE NEW BATCH OR\n DUPLICATE BATCH FOUND... "
                        prodid1.visible=true
                        prodDialog.open()
                        console.log("DUPLICATE BATCH")

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
                        prodid1pg2.visible = true
                        prodDialog.open()
                        prodDialogpg2.open()
                        speed.text = cnt1
                    }

                    if(cnt==122)
                    {

                        speed.text = cnt1
                    }
                    if(cnt==123)
                    {

                        speed.text = cnt1
                    }

                    if(cnt==124)
                    {

                        targetWt.text = cnt1
                    }

                    if(cnt==125)
                    {

                        tareWt.text = cnt1
                    }
                    if(cnt==126)
                    {
                        targetWt.text = cnt1
                    }
                    if(cnt==127)
                    {
                        tareWt.text = cnt1
                    }
                    if(cnt==128)
                    {
                        upperLmt.text = cnt1
                    }
                    if(cnt==129)
                    {
                        lowerLmt.text = cnt1
                    }
                    if(cnt==130)
                    {

                        oprDly.text = cnt1
                    }
                    if(cnt==131)
                    {

                        prdLength.text = cnt1
                    }


                }
             }

             Connections{
                 target: handle_loadcellcalls
                onHandleResln_digit:{
                     console.log("Model Selection resolution")
                    if(cnt == 1){
                  //  prdDataPage1.enabled = false

                        vardigit3 = targetwt_digit// =  RegExpValidator  {regExp: /^[0-9]{4,4}([\.\,][0-9]{1,1})?$/}
                        vardigit2 = limit_digit
                        console.log("DIGIT RESLN")
                    }
                    if(cnt == 2){
                    prdDataPage1.enabled = true
                    }
                 }
             }

             Connections
             {
                 target: handle_loadcellcalls
                 onHandleDcompsts:{
//                     dcomp_sts = cnt
//                     bypass_sts = cnt2

//                     UIStyle.dycomp_factor = cnt1
                    // dyCompSwitch.checked = dcomp_sts


                     if(cnt3 == "4")
                     {
                         lbcwMode.text = modeText + " PRODUCTION"
                         lbcwModepg2.text = modeText + " PRODUCTION"
                         modeSel = true



                         console.log("machine sts"+cnt3)

                     }
                     else if(cnt3 == "5")
                     {
                         lbcwMode.text = modeText + " SETTING"
                         lbcwModepg2.text = modeText + " SETTING"
                         modeSel = false

                         console.log("machine sts"+cnt3)

                     }



                 }




             }
             Label{
                 x:750
                 y: 5
                 text: "SAVE RECIPE"
                 font.pixelSize: 50
                 color: "white"
             }

             Rectangle{
                 id:machine_sts_rect
                 x: 310
                 y: 0
                 width: lbcwMode.contentWidth + 20
                 height: 70
                 color: "chartreuse"
                         Label{
                             id:lbcwMode
                        //     x:5
                        //     y: 5
                             anchors.left: parent.left
                             anchors.leftMargin: 10
                        //     anchors.centerIn: parent
                             text: modeText                  //"MACHINE\nMODE :"
                             font.pixelSize: 30
                             color: "red"
                         }
             }

//             function digitResoln(){
//                 for (var i=0;i<pwdTemp.length;i++)
//                     {

//                 }

//             }


             function ldValues (){
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

                 for(var i =0;i < UIStyle.fileParam.length;i++){
                     if((UIStyle.fileParam[i] === " ") | (UIStyle.fileParam[i] === "")){
                        emptyChkfg = true

                     }

                 }
                  if(numChrs.indexOf(batchNum.text.charAt(0)) >= 0){
                     console.log("Number present at first location")
                     numChrsfg = false;//true
                 }

                 console.log("SAVE PARAMETER button action save prd file:"+UIStyle.fileParam); //for debugging

                if(emptyChkfg != true){
                    if(numChrsfg != true){

                      savetextfield.saveParamInFile("currentFile.txt",UIStyle.fileParam,UIStyle.fileParam.length);
                    }
                    else{
                        numChrsfg = false
                        batchNum.text = ""
                        batchNum.focus = true
                        UIStyle.fileNameExist = "Warning ->Use character at starting!!\nDon't use number at first.";
                        saveParamInFile.active = false;saveParamInFilepg2.active = false;messageDialog.open();
                        messageDialogpg2.open()

                    }
                }
                else{emptyChkfg = false;console.log("warning from 2nd page")
                        UIStyle.fileNameExist = "Warning ->One of the parameter is empty!!\nPlease fill all the parameteres.";
                        saveParamInFile.active = false;saveParamInFilepg2.active = false;messageDialog.open();
                        messageDialogpg2.open()}
                        UIStyle.fileName = "";
                        fileName.text = "";
                        UIStyle.fileParam = "";

             }
             Dialog {
                 id: fileExist
                 title: "Validation"

                 Label {
                     text: UIStyle.fileNameExist
                 }
             }


                     Label{ x: 23; y: 70; width: 249; height: 34; color: "#aaff00";text:"1.PRODUCT CODE"; font.pixelSize: 35}
                     Label{ x: 23; y: 170; width: 249; height: 34; color: "#aaff00";text:"2.PRODUCT NAME"; font.pixelSize: 35}
                     Label{ x: 23; y: 270; width: 249; height: 34; color: "#aaff00";text:"3.BATCH NUMBER"; font.pixelSize: 35}
                     Label{ x: 23; y: 370; width: 249; height: 34; color: "#aaff00";text:"4.TARGET WEIGHT"; font.pixelSize: 35}
                     Label{ x: 993; y: 70; width: 249; height: 34; color: "#aaff00";text:"5.TARE WEIGHT"; font.pixelSize: 35}
                     Label{ x: 994; y: 170; width: 329; height: 40; color: "#aaff00";text:"6.PRODUCT LENGTH"; font.pixelSize: 35}
                     Label{ x: 996; y: 270; width: 249; height: 34; color: "#aaff00";text:"7.UPPER LIMIT"; font.family: "Times New Roman"; font.pixelSize: 35}
                     Label{ x: 998; y: 371; width: 249; height: 34; color: "#aaff00";text:"8.LOWER LIMIT"; font.family: "Times New Roman"; font.pixelSize: 35}

//                     Label{ x: 722; y: 470; width: 249; height: 34; color: "#aaff00";text:"13.OPERATE DLY(MD)"; font.family: "Times New Roman"; font.pixelSize: 35}
//                     Label{ x: 1364; y: 70; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"9.SPEED";}
//                     Label{ x: 1362; y: 170; width: 249; color: "#aaff00";font.pixelSize: 35;text:"10.OPERATE DLY(CW)";}
//                     Label{ x: 1363; y: 270; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"11.HOLD DELAY"; font.family: "Times New Roman"}
//                     Label{ x: 1361; y: 370; width: 249; height: 34; color: "#aaff00"; text: "12.REJECT COUNT";font.pixelSize: 35}



                      // TextField{id:prdCodef;x: 376; y: 70; width: 503;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{prdCodef.focus = false;inputPanel.visible = false; }height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                     //  TextField{id:prdName; x: 381; y: 170; width: 498;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ prdName.focus = false;inputPanel.visible = false;}height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                     Rectangle
                     {
                         id:prodCodeRect
                         x: 376; y: 80; width: 503; height:  75
                        // x: 376; y: 76; width: 503; height:  75
                         color : "white"

                      TextInput{id:prdCodef; anchors.fill:parent; /*x: 376; y: 70; width: 503;*/ font.pixelSize: 30; wrapMode: TextInput.Wrap;onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460} /*height:  75 ;*/ color: "black";validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,25}$/}onTextChanged: {savetextfield.disableScreen("RT")}}

                     }
                      Rectangle
                      {
                         id: prdNameRect
                         x: 381; y: 170; width: 498;
                          height:  75
                          color : "white"

                      TextInput{id:prdName;/*x: 381; y: 170; width: 498;*/anchors.fill:parent ;font.pixelSize: 30; wrapMode: TextInput.Wrap ;onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460} /*height:  75 50*/ validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,25}$/} onTextChanged: {savetextfield.disableScreen("RT")}}

                      }
                       TextField{id:targetWt; x: 385; y: 370; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{/*targetWt.text = digitAdjust1(targetWt.text);*/targetWt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit3;onTextChanged:{savetextfield.disableScreen("RT")}}
                       TextField{id:batchNum; x: 381; y: 270; width: 498;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {batchNum.focus = false;inputPanel.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}

                       TextField{id:tareWt; x: 1380; y: 70; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next; onEnterKeyClicked:{/*tareWt.text = digitAdjust1(tareWt.text);*/ tareWt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit3;onTextChanged:{savetextfield.disableScreen("RT")}}
                       TextField{id:prdLength; x: 1380; y: 170; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 480}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ prdLength.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
                       TextField{id:upperLmt; x: 1380; y: 270; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {/*upperLmt.text = digitAdjust1(upperLmt.text);*/upperLmt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;onTextChanged:{savetextfield.disableScreen("RT")}}
                       TextField{id:lowerLmt; x: 1380; y: 370; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction:EnterKeyAction.Next;onEnterKeyClicked:{/*lowerLmt.text = digitAdjust1(lowerLmt.text);*/ lowerLmt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: vardigit2;onTextChanged:{savetextfield.disableScreen("RT")}}

//                       TextField{id:oprDly_md; x: 1123; y: 470; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly_md.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//                       TextField{id:speed; x: 1746; y: 70; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {speed.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{}}
//                       TextField{id:oprDly; x: 1747; y: 170; width: 155;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//                       TextField{id:hldDly; x: 1746; y: 270; width: 155;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ hldDly.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//                       TextField{id:rejCnt; x: 1746; y: 370; width: 150;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{rejCnt.focus = false;inputPanel.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}


  //               }

  //               }

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
                                      onClicked:{messageDialog.close();messageDialogpg2.close(); UIStyle.scrEnabled = "0";UIStyle.fileNameExist = ""}
                                  }


                                }

                           }

                       }

                 HexButton {
                         id: load
                         x: 1524
                         y: 666
                         width: 220
                         height: 204
                         color: "peru"
                         text: "LOAD \nRECIPE"
                         fontsize: 20

                         onClicked:{

                           fileLoadbtn.enabled = false;deletebtn.enabled = false; inputPanel.visible = false; prdDataPage1.loadLibraryFiles();libFileDialog.open();load.color = "peru"
                     }
                 }
                 HexButton {
                         id: saveParamInFile
                         x: 1524
                         y: 464
                         width: 220
                         height: 204
                         color: "olive"
                         text: "SAVE \nRECIPE"
                         fontsize: 20
                         onClicked:{
                          //  prdDataPage1.ldValues();savetextfield.saveParamInFile(UIStyle.fileParam,UIStyle.fileParam.length)
                             prdDataPage1.ldValues();prdDataPage2.ldreporthdrParam();/*UIStyle.fileNameCompare = fileName.text;savetextfield.createNsaveToLib(UIStyle.fileName,UIStyle.fileParam,UIStyle.fileParam.length);prdDataPage1.storeFileValues();*/
                             if(UIStyle.fileNameExist == "Recipe SAVE successfully"){saveParamInFile.color = "olive"; messageDialog.open()}else{messageDialog.open()}


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
                     fileParamsmodel.append({FileParamName: "",FileParamVal: ""})

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
                 //    savetextfield.saveParamInFile(UIStyle.fileParam,UIStyle.fileParam.length);
                 //    savetextfield.saveParamInFile("F:\\ currentFile.txt",UIStyle.fileParam,UIStyle.fileParam.length);
                     savetextfield.saveParamInFile("currentFile.txt",UIStyle.fileParam,UIStyle.fileParam.length);
                     UIStyle.fileName = "";
                     fileName.text = "";
                     UIStyle.fileParam = "";
                    // messageDialog.close();
                   //  messageDialog.open();
                 }
                 function powerOnstoreFileValues(){

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
                     compName.text = UIStyle.fileParam[13]//13
                     line1Add.text = UIStyle.fileParam[14]//14
                     line2Add.text = UIStyle.fileParam[15]//15
                     machineId.text = UIStyle.fileParam[16]//16
                 //    savetextfield.saveParamInFile(UIStyle.fileParam,UIStyle.fileParam.length);
                 //    savetextfield.saveParamInFile("F:\\ currentFile.txt",UIStyle.fileParam,UIStyle.fileParam.length);
                     UIStyle.fileName = "";
                     fileName.text = "";
                     UIStyle.fileParam = "";
                    // messageDialog.close();
                   //  messageDialog.open();
                 }

                 function loadLibraryFiles(){
              //    savetextfield.loadFromListFileNames("F:\\ LibraryFiles.txt")
                     UIStyle.prd_code1 = "";
                     UIStyle.fileList = "";
                     savetextfield.loadFromListFileNames("LibraryFiles.txt")

                     libFilemodel.clear({Filename:""})
                         for(var i = 0;i<UIStyle.fileList.length ;i++){

                              UIStyle.prd_code1 = UIStyle.fileList[i]
                         libFilemodel.append({ Filename: UIStyle.prd_code1})
                          }
                         libFilemodel.append({ Filename: ""})
                 }


                 function initializeFileParamName(){
                     UIStyle.fileParamName[0] = "PRODUCT CODE:"
                     UIStyle.fileParamName[1] = "PRODUCT NAME:"
                     UIStyle.fileParamName[2] = "BATCH NUMBER:"
                     UIStyle.fileParamName[3] = "TARGET WEIGHT:"
                     UIStyle.fileParamName[4] = "TARE WEIGHT:"
                     UIStyle.fileParamName[5] = "PRODUCT LENGTH:"
                     UIStyle.fileParamName[6] = "UPPER LIMIT:"
                     UIStyle.fileParamName[7] = "LOWER LIMIT:"
                     UIStyle.fileParamName[8] = "SPEED:"
                     UIStyle.fileParamName[9] = "OPERATE DELAY:"
                     UIStyle.fileParamName[10] = "HOLD DELAY:"
                     UIStyle.fileParamName[11] = "REJECT COUNT:"
                     UIStyle.fileParamName[12] = "OPERATE DLY(MD):"


                 }


                 Dialog {
                         id: libFileDialog
                 //        standardButtons: StandardButton.Cancel | StandardButton.Ok
                //         title:  "Library Window"
                         visible: false
                         width: 1820
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
                                 text: "Library Window"
                                 font.pixelSize: 30
                                 color: "black"
                             }
                         }
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
                                     width: 600
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
                                         role: "Filename"
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

                                    //      onCurrentRowChanged: {fileLoadbtn.visible = true;deletebtn.visible = true;deleteFile.visible = false;UIStyle.fileNameExist = "";UIStyle.fileLibName = libFilemodel.get(__currentRow).Filename;UIStyle.fileName = "F:\\ " + libFilemodel.get(__currentRow).Filename;savetextfield.loadParamFromListFileName(UIStyle.fileName);prdDataPage1.storeFileParamValues();/*selFileName.text = "File Selected :" + UIStyle.fileLibName*//*adminName = libFilemodel.get(__currentRow).Filename*/}
                                          onClicked: {if(modeSel == false){ fileLoadbtn.enabled = true;deletebtn.enabled = true;}else{informationDialog.open()} deleteFile.visible = false;UIStyle.fileNameExist = "";UIStyle.fileLibName = libFilemodel.get(__currentRow).Filename;/*UIStyle.fileName = "F:\\ " + libFilemodel.get(__currentRow).Filename;*/UIStyle.fileName = libFilemodel.get(__currentRow).Filename;
                                              savetextfield.loadParamFromListFileName(UIStyle.fileName);prdDataPage1.storeFileParamValues();}


                                     }
                                  }

                             }
                             Column{
                                 spacing: 50
                                 anchors.top: parent.top
                                 anchors.topMargin: 30

                                 Button{id:fileLoadbtn;width: 300;height: 80;Label{text: "LOAD & CLOSE";anchors.centerIn: fileLoadbtn;anchors.left: fileLoadbtn.left;font.pointSize: 25}onClicked:{savetextfield.loadFromLib(UIStyle.fileName);prdDataPage1.storeFileValues();libFileDialog.close();load.active = false;/*UIStyle.fileName = "F:\\ " + UIStyle.fileLibName;*/
                                         UIStyle.fileName = UIStyle.fileLibName;console.log("file name is:"+UIStyle.fileLibName);libFileListView.selection.clear();}}
                                 Button{id:closebtn;width: 300;height: 80;Label{text: "CLOSE";anchors.centerIn: closebtn;anchors.left: closebtn.left;font.pointSize: 25}onClicked:{libFileListView.selection.clear();libFileDialog.close();load.active = false;}}
                                 Button{id:deletebtn;width: 200;height: 80;Label{text: "DELETE";anchors.centerIn: deletebtn;anchors.left: deletebtn.left;font.pointSize: 25}onClicked:{savetextfield.removeFromLib(UIStyle.fileLibName); if(UIStyle.fileNameExist != "Current File"){ libFileDialog.close();prdDataPage1.loadLibraryFiles();libFileDialog.open();/*loadLibraryFiles();*/load.active = false;}else{UIStyle.fileNameExist = "You can't delete\nRunning File"; deleteFile.visible = true}}}
                                 Label{id:deleteFile;visible: false; font.pixelSize:UIStyle.fontSizeXS;color:UIStyle.colorCandyPink;text: UIStyle.fileNameExist}
                             }
                             Column{
                                 spacing: 10
                                 anchors.top: parent.top
                                 anchors.topMargin: 30


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
                       //          enabled: false

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
                         id: informationDialog
                         width: infoMsg.contentWidth + 200
                         height: 400
                         x:400
                         y:300
                         visible: false
               //          title:  "Logout Success!!!"
                         closePolicy: Popup.CloseOnEscape
                         background: Rectangle{
                                    color: "peru"
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
                                        text: "WARNING !!!"
                                        font.pixelSize: 40
                                        color: "black"
                                    }
                                }
                      contentItem: FocusScope{
                         Column {
                             id: infoMsgColumn
                             spacing: 20
                             Row{
                                 spacing: 20
                                 Label{id:infoMsg;font.pixelSize:UIStyle.fontSizeXXL;text:"Current batch is in Production mode\nYou can't Load batch.";color:UIStyle.colorQtblk}
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
                                 onClicked:{informationDialog.close()}
                             }
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
                                     onClicked: {prodDialog.close(),prodDialogpg2.close()}//;circularView.blurScreena("Origin")}
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



             //-----------------------------Digit Adjustment call--------------------------
                          function digitAdjust1(pwdTemp){
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
             Dialog {
                     id: saveFileNameDialog
                     visible: false
                     standardButtons: StandardButton.Cancel | StandardButton.Ok
                     title:  "Save File Name"
                     Column {
                         id: column
                         spacing: 20
                         Row{
                             spacing: 20
                            TextField{id:fileName; previewText: "One line field";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {UIStyle.fileName = "F:\\ " + fileName.text + ".txt";console.log("the name of file is:" +UIStyle.fileName)}}
                         }
                     }

                     onAccepted: {UIStyle.fileNameCompare = fileName.text;savetextfield.createNsaveToLib(UIStyle.fileName,UIStyle.fileParam,UIStyle.fileParam.length);savetextfield.createListFileNames(fileName.text + ".txt")}
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
                            TextField{id:ldFileName; previewText: "One line field";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {UIStyle.fileName = "F:\\ " + ldFileName.text + ".txt";console.log("the name of file is:" +UIStyle.fileName)}}
                         }

                      }

                     onAccepted: {savetextfield.loadFromLib(UIStyle.fileName); prdDataPage1.storeFileValues()}
             }

             Loader {
                 id: loader
                 width: 1920
                 height: 1080
                 visible: true
                 clip: false
                 antialiasing: false
                 anchors.rightMargin: 0
                 anchors.bottomMargin: 0
                 anchors.leftMargin: 0
                 anchors.topMargin: 0
                 anchors.fill: parent

                 Label {
                     id: label
                     x: 522
                     y: 354
                     width: 78
                     height: 90
                     text: qsTr("g")
                     font.pointSize: 25
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignHCenter
                 }

                 Label {
                     id: label1
                     x: 1550
                     y: 354
                     width: 78
                     height: 90
                     text: qsTr("g")
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignHCenter
                     font.pointSize: 25
                 }

                 Label {
                     id: label2
                     x: 1549
                     y: 246
                     width: 78
                     height: 90
                     text: qsTr("g")
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignHCenter
                     font.pointSize: 25
                 }

                 Label {
                     id: label3
                     x: 1548
                     y: 44
                     width: 78
                     height: 90
                     text: qsTr("g")
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignHCenter
                     font.pointSize: 25
                 }

                 Label {
                     id: label4
                     x: 1548
                     y: 152
                     width: 78
                     height: 90
                     text: qsTr("mm")
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: Text.AlignHCenter
                     font.pointSize: 25
                 }
             }


        }

        Item{
            id: prdDataPage2
             width: 1920
             height: 1080


             Rectangle{
                 id:machine_sts_rectpg2
                 x: 800
                 y: 0
                 width: lbcwModepg2.contentWidth + 20
                 height: 70
                 color: "chartreuse"
                         Label{
                             id:lbcwModepg2
                        //     x:5
                        //     y: 5
                             anchors.left: parent.left
                             anchors.leftMargin: 10
                        //     anchors.centerIn: parent
                             text: "MACHINE\nMODE :"
                             font.pixelSize: 30
                             color: "red"
                         }
             }

             Dialog {
                 id: prodDialogpg2
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
                                 onClicked: {prodDialogpg2.close();prodDialog.close()}//;circularView.blurScreena("Origin")}
                             }
                     }
                     Column {
                         id: errcolumnpg2
                         spacing: 20
                         Row{
                             spacing: 20
                             Label{id:prodid1pg2; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:prodmsg1;color:UIStyle.colorQtWhite1}
                           //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                         }
                     }

                 }
                 //-----------------------------------------------------------------------------------------------------------

             }

             Label{ x: 23; y: 70; width: 249; height: 34; color: "#aaff00";text:"9.OPERATE DLY(MD)"; font.family: "Times New Roman"; font.pixelSize: 35}
             Label{ x: 23; y: 170; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"10.SPEED";}
             Label {
                 id: speedLbl
                 x: 600
                 y: 150
                 width: 78
                 height: 90
                 text: qsTr("ppm")
                 verticalAlignment: Text.AlignVCenter
                 horizontalAlignment: Text.AlignHCenter
                 font.pointSize: 25
             }
             Label{ x: 23; y: 270; width: 249; color: "#aaff00";font.pixelSize: 35;text:"11.OPERATE DLY(CW)";}
             Label{ x: 23; y: 370; width: 249; height: 34; color: "#aaff00";font.pixelSize: 35;text:"12.HOLD DELAY"; font.family: "Times New Roman"}
             Label{ x: 23; y: 470; width: 249; height: 34; color: "#aaff00"; text: "13.REJECT COUNT";font.pixelSize: 35}

             Label{ x: 793; y: 70; width: 249; height: 34; color: "#aaff00"; text: "COMPANY NAME";font.pixelSize: 35}
             Label{ x: 793; y: 170; width: 249; height: 34; color: "#aaff00"; text: "LINE1 ADDRESS";font.pixelSize: 35}
             Label{ x: 793; y: 270; width: 249; height: 34; color: "#aaff00"; text: "LINE2 ADDRESS";font.pixelSize: 35}
             Label{ x: 793; y: 370; width: 249; height: 34; color: "#aaff00"; text: "MACHINE ID";font.pixelSize: 35}

             TextField{id:oprDly_md; x: 430; y: 70; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly_md.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
             TextField{id:speed; x: 430; y: 170; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {speed.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{1,3}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
             TextField{id:oprDly; x: 430; y: 270; width: 155;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked: {oprDly.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
             TextField{id:hldDly; x: 430; y: 370; width: 155;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ hldDly.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
             TextField{id:rejCnt; x: 430; y: 470; width: 150;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 60}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{rejCnt.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}

             TextField{id:compName;x: 1180; y: 70; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{compName.focus = false;inputPanelpg2.visible = false; }height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~.,;:\ ]{1,30}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
             TextField{id:line1Add; x: 1180; y: 170; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ line1Add.focus = false;inputPanelpg2.visible = false;}height: 50; /*color: "#0000ff";*/validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~.,;:\ ]{1,30}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
             TextField{id:line2Add; x: 1180; y: 270; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {line2Add.focus = false;inputPanelpg2.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~.,;:\ ]{1,30}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
             TextField{id:machineId; x: 1180; y: 370; width: 550;previewText: "";onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: {EnterKeyAction.Next}onEnterKeyClicked: {machineId.focus = false;inputPanelpg2.visible = false;}height: 50;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}

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
             HexButton {
                     id: saveParamInFilepg2
                     x: 1524
                     y: 464
                     width: 220
                     height: 204
                     color: "olive"
                     text: "SAVE \nRECIPE"
                     fontsize: 20
                     onClicked:{
                      //  prdDataPage1.ldValues();savetextfield.saveParamInFile(UIStyle.fileParam,UIStyle.fileParam.length)
                         prdDataPage1.ldValues();prdDataPage2.ldreporthdrParam();if(UIStyle.fileNameExist == "Recipe SAVE successfully"){saveParamInFilepg2.active = false; messageDialogpg2.open()}else{ messageDialogpg2.open()}


                 }
             }
             function ldreporthdrParam(){
                 var temp = new Array(0);
              temp.push(compName.text)
              temp.push(line1Add.text)
              temp.push(line2Add.text)
              temp.push(machineId.text)
              UIStyle.fileParam = temp;

                 for(var i =0;i < UIStyle.fileParam.length;i++){
                     if((UIStyle.fileParam[i] === " ") | (UIStyle.fileParam[i] === "")){
                        emptyChkfg = true

                     }

                 }

                 if(emptyChkfg != true){

                     savetextfield.saveParamInReporthdrFile(UIStyle.fileParam,UIStyle.fileParam.length);
                     UIStyle.fileParam = "";
                 }
                 else{
                      emptyChkfg = false
                     UIStyle.fileNameExist = "Warning ->One of the parameter is empty!!\nPlease fill all the parameteres.";
                     saveParamInFile.active = false;saveParamInFilepg2.active = false;messageDialog.open();
                     messageDialogpg2.open()
                   }
                     UIStyle.fileName = "";
                     fileName.text = "";
                     UIStyle.fileParam = "";


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
                            onClicked:{messageDialogpg2.close();messageDialog.close(); UIStyle.scrEnabled = "0";UIStyle.fileNameExist = ""}
                        }


                      }

                 }

             }


        }


  }

    PageIndicator {
        count: svPrdDataContainer.count
        currentIndex: svPrdDataContainer.currentIndex

        anchors.bottom: svPrdDataContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Component.onCompleted:{/*savetextfield.powerOnLoadFromLib("F:\\ currentFile.txt")*/savetextfield.powerOnLoadFromLib("currentFile.txt");handle_loadcellcalls.send_sts();if(UIStyle.fileNameExist == "Load Recipe"){messageDialog.open();saveParamInFile.enabled = false}else{saveParamInFile.enabled = true;prdDataPage1.powerOnstoreFileValues();savetextfield.disableScreen("1")}}

}


