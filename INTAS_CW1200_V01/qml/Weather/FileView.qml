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
import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls 2.0 as QQ2
import QtQuick.Controls.Material 2.2
import QtQml.Models 2.2
import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../Style"

    Rectangle {
    id: fileView
   // width: 800; height: 480
    signal message(string msg)
    property bool active: false
    property string footerText: "File Selected :"
    property string headerText: "File Name :"
    property alias footerColor: label.color
     //! [orientation]
    readonly property bool inPortrait: fileView.width < fileView.height
    //! [orientation]

    ToolBar {
        id: overlayHeader
        z: 1
        width: fileView.width
        Label {
            id: label
            width: 335
            height: 41
            anchors.centerIn: parent
            text: "Product File Details"
            anchors.verticalCenterOffset: 1
            anchors.horizontalCenterOffset: 0
            font.family: "Times New Roman"
            font.pixelSize: 37
            color: "black"
        }
    }

    Drawer {
        id: drawer
          x:0
          y:82
          width: 239
          height: 440
          clip: true

        modal: inPortrait
        interactive: inPortrait
        visible: !inPortrait

        ListView {
            id: listView
            anchors.bottomMargin: -79

            anchors.fill: parent
            model: ListModel{
                id:fileModel
                ListElement{ListFileName: qsTr("FileName");selected:false}

            }

        header: Dialog {
                id: header
                z: 2
                width: parent.width
                contentHeight: header.height/3

                Flickable {
                    id: flickable1
                    clip: true
  //                  anchors.fill: parent
                    contentHeight: header.height/3


                   /* ColumnLayout{
                    spacing: 10
                    anchors.fill: parent
                        Rectangle {
                            id:remove

                            width: header.width/1.5      // parent.width/1.5
                            height: header.width/4     //parent.width/4
                            color: removeFile.pressed ? "gray" : "lightgray"
                            Text {
                                anchors.centerIn: parent
                                text:"Delete"
                            }
                            MouseArea{
                                id:removeFile
                                anchors.fill: parent
                                onPressed: {savetextfield.removeFromLib(UIStyle.fileLibName);fileView.removeLibFiles()}
                            }
                        }


                        Rectangle {
                            id:load
                            visible: active
                            width: header.width/1.5      // parent.width/1.5
                            height: header.width/4       //parent.width/4
                            color: loadFile.pressed ? "gray" : "lightgray"
                                Text {
                                    anchors.centerIn: load
                                    text:"Load & Close"
                                }
                                MouseArea{
                                    id:loadFile
                                    anchors.fill: parent
                                     onClicked:  {savetextfield.loadFromLib(UIStyle.fileName);fileView.visible = false;listView.visible = false;drawer.visible = false;fileView.message("Load")}
                                }

                        }
                        Rectangle {
                            id:closePage
                            width: header.width/1.5  //parent.width/1.5
                             height: header.width/4      // parent.width/4
                            color: closePageFile.pressed ? "gray" : "lightgray"
                            Text {
                                anchors.centerIn: closePage
                                text:"Close"
                            }
                            MouseArea{
                                id:closePageFile
                                anchors.fill: parent
                                onClicked:  {fileView.message("closed!");fileView.visible = false;listView.visible = false;drawer.visible = false}
                            }

                        }

                }*/

                    ScrollIndicator.vertical: ScrollIndicator {
//                        parent: header.contentItem
//                        anchors.top: flickable1.top
//                        anchors.bottom: flickable1.bottom
//                        anchors.right: parent.right
//                        anchors.rightMargin: -header.rightPadding + 1
                    }

          }


            }

            footer: ItemDelegate {

                id: footer

                Text {
                    id: footerTextColour
                    text: footerText
                    color: footerColor
                }
                width: parent.width

               MenuSeparator {
                    parent: footer
                    width: parent.width
                    anchors.verticalCenter: parent.top
                }

            }

                delegate: ItemDelegate {
                id:listFiles
                text:ListFileName
                width: parent.width

                background: Rectangle{
                    id:fileBackColour
                    color: selected ? "red" :"white"
                    border.width: 1
                    border.color: UIStyle.colorCadetBlue
                }
                MouseArea{
                    anchors.fill: fileBackColour
                    onPressed: {active = true; load.visible = active; UIStyle.fileLibName = listFiles.text;UIStyle.fileName = "F:\\ " + listFiles.text;savetextfield.loadParamFromListFileName(UIStyle.fileName);fileView.storeFileValues();footerColor = "black";footerText = "File Selected :" + listFiles.text;headerText = "File Name :" + listFiles.text;fileView.changeSelection();fileModel.setProperty(index,"selected",!selected)}
               //     onReleased: {fileBackColour.color = "Gray"}
                }

            }
        }

    }

    Flickable {
        id: flickable
        height: 520
        anchors.rightMargin: 0
        anchors.bottomMargin: 48
        anchors.leftMargin: 0
        anchors.topMargin: 52
        anchors.fill: parent
        bottomMargin: 150
        clip: true
        topMargin: 50

        Rectangle {
            id:remove
            x: 699
            y: 395
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 55
            width: 100          //header.width/1.5      // parent.width/1.5
            height: 50          //header.width/4     //parent.width/4
            color: removeFile.pressed ? "gray" : "lightgray"
            Text {
                anchors.centerIn: parent
                text:"Delete"
            }
            MouseArea{
                id:removeFile
                anchors.rightMargin: 1
                anchors.bottomMargin: 0
                anchors.leftMargin: -1
                anchors.topMargin: -1
                anchors.fill: parent
                onPressed: {savetextfield.removeFromLib(UIStyle.fileLibName);fileView.removeLibFiles()}
            }
        }
        Rectangle {
            id:load
            x: 698
            y: 239
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 211
            visible: active
            width: 100
            height: 50
            color: loadFile.pressed ? "gray" : "lightgray"
                Text {
                    anchors.centerIn: load
                    text:"Load & Close"
                }
                MouseArea{
                    id:loadFile
                    anchors.fill: parent
                     onClicked:  {savetextfield.loadFromLib(UIStyle.fileName);fileView.visible = false;listView.visible = false;drawer.visible = false;fileView.message("closed!")}
                }

        }

        Rectangle {
            id:closePage
            x: 698
            y: 36
            width: 100
            height: 50
            color: "#adf041"
            radius: 5
            border.color: "#fee198"
            border.width: 2
            Text {
                color: "#2910f8"
                anchors.centerIn: closePage
                text:"Close"
                smooth: true
                antialiasing: false
                font.capitalization: Font.AllUppercase
                font.weight: Font.Light
                style: Text.Raised
                styleColor: "#103bca"
                font.pointSize: 16
                textFormat: Text.RichText
                fontSizeMode: Text.Fit
            }
            MouseArea{
                id:closePageFile
                antialiasing: true
                hoverEnabled: true
                anchors.rightMargin: 0
                anchors.bottomMargin: 1
                anchors.leftMargin: 0
                anchors.topMargin: -1
                anchors.fill: parent
                onClicked:  {fileView.message("closed!");fileView.visible = false;listView.visible = false;drawer.visible = false}
            }

        }

 //       contentHeight: parent.height - bottomMargin

        /*Column {
            id: column
            spacing: 20
//                              width: fitnessPage2.width

            Row{
                spacing: 20
                Rectangle {
                    id:remove

                    width: header.width/1.5      // parent.width/1.5
                    height: header.width/4     //parent.width/4
                    color: removeFile.pressed ? "gray" : "lightgray"
                    Text {
                        anchors.centerIn: parent
                        text:"Delete"
                    }
                    MouseArea{
                        id:removeFile
                        anchors.fill: parent
                        onPressed: {savetextfield.removeFromLib(UIStyle.fileLibName);fileView.removeLibFiles()}
                    }
                }
            }

            Row{
                spacing: 20
                Rectangle {
                    id:load
                    visible: active
                    width: header.width/1.5      // parent.width/1.5
                    height: header.width/4       //parent.width/4
                    color: loadFile.pressed ? "gray" : "lightgray"
                        Text {
                            anchors.centerIn: load
                            text:"Load & Close"
                        }
                        MouseArea{
                            id:loadFile
                            anchors.fill: parent
                             onClicked:  {savetextfield.loadFromLib(UIStyle.fileName);fileView.visible = false;listView.visible = false;drawer.visible = false;fileView.message("Load")}
                        }

                }
            }
            Row{
                spacing: 20
                Rectangle {
                    id:closePage
                    width: header.width/1.5  //parent.width/1.5
                     height: header.width/4      // parent.width/4
                    color: closePageFile.pressed ? "gray" : "lightgray"
                    Text {
                        anchors.centerIn: closePage
                        text:"Close"
                    }
                    MouseArea{
                        id:closePageFile
                        anchors.fill: parent
                        onClicked:  {fileView.message("closed!");fileView.visible = false;listView.visible = false;drawer.visible = false}
                    }

                }
            }

        }*/

        ListView {
            id: listViewFileParam
            height: 511
            snapMode: ListView.SnapToItem
            cacheBuffer: 306
            contentHeight: 478
            anchors.rightMargin: 438
            anchors.bottomMargin: 4
            anchors.leftMargin: 240
            anchors.topMargin: -68
            anchors.fill: parent
            model: ListModel{
                id:prdParam
                ListElement{fileParamNameF: "PRODUCT CODE : ";fileParamValueF:""}
                ListElement{fileParamNameF: "PRODUCT NAME : ";fileParamValueF:""}
                ListElement{fileParamNameF: "BATCH NUMBER : ";fileParamValueF:""}
                ListElement{fileParamNameF: "TARGET WEIGHT : ";fileParamValueF:""}
                ListElement{fileParamNameF: "TARE WAEIGHT : ";fileParamValueF:""}
                ListElement{fileParamNameF: "PRODUCT LENGTH : ";fileParamValueF:""}
                ListElement{fileParamNameF: "UPPER LIMIT : ";fileParamValueF:""}
                ListElement{fileParamNameF: "LOWER LIMIT : ";fileParamValueF:""}
                ListElement{fileParamNameF: "SPEED : ";fileParamValueF:""}
                ListElement{fileParamNameF: "OPERATE DELAY : ";fileParamValueF:""}
                ListElement{fileParamNameF: "HOLD DELAY : ";fileParamValueF:""}

            }

           header: Pane{

                id: fileHeader
                width: parent.width

                Text {
                    id: fileHeaderText
                    anchors.centerIn: parent
                    text: headerText
                    font.pixelSize: UIStyle.fontSizeM
                }

            }

                delegate: ItemDelegate {
                id:listFilesParam
                text:fileParamNameF + fileParamValueF
                width: parent.width
                }

                ScrollIndicator.vertical: ScrollIndicator {
//                    parent: header.contentItem
//                    anchors.top: flickable.top
//                    anchors.bottom: flickable.bottom
//                    anchors.right: parent.right
//                    anchors.rightMargin: -header.rightPadding + 1
                }

        }

    }
//------------------for loading the files in Library-----------------------------
    Component.onCompleted: {


        savetextfield.loadFromListFileNames("F:\\ LibraryFiles.txt")
               for(var i = 0;i<UIStyle.fileList.length;i++){

                    UIStyle.prd_code1 = UIStyle.fileList[i]
               listView.model.append({ ListFileName: UIStyle.prd_code1})
                }
    }
//-------------------------------------------------------------------------------
//------------------for loading the parameters in the respective file------------
    function storeFileValues(){


        for(var i = 0;i<UIStyle.fileParam.length;i++){

             UIStyle.prd_code1 = UIStyle.fileParam[i]
             prdParam.set(i,{"fileParamValueF":UIStyle.prd_code1})
         }

    }
//-------------------------------------------------------------------------------
//------------------Remove the selected file-------------------------------------
    function removeLibFiles(){

        if(UIStyle.fileNameExist != "Current File"){

                for (var j =0; j<fileModel.count; ++j)
                  {
                      if (fileModel.get(j).selected){
                          fileModel.remove(j);
                 //         j=0; //read from the start! Because index has changed after removing
                      }
                  }
                footerColor = "green"
                footerText = UIStyle.fileLibName + " File removed" + "\n" + "from Library!!"
                for(var i = 0;i<UIStyle.fileParam.length;i++){

                     UIStyle.prd_code1 = ""
                     prdParam.set(i,{"fileParamValueF":UIStyle.prd_code1})
                 }

          }
        else{
            footerColor = "red"
           footerText = "You can not delete"+"\n"+ "current File!!"
        }

               console.log("executed this function")

    }
//-------------------------------------------------------------------------------
//------------------toggling the selection file----------------------------------
    function changeSelection(){
        for (var j =0; j<fileModel.count; ++j)
           {
               if (fileModel.get(j).selected){
                   fileModel.setProperty(j,"selected",false);

              //     j=0; //read from the start! Because index has changed after removing
               }
           }

    }
//-------------------------------------------------------------------------------

}
