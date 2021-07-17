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

import QtQuick 2.5
import QtQuick.Controls 1.2
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

//import QtGraphicalEffects 1.0


import "../Style"





//import QtQuick 2.7
//import QtQuick.Controls 2.0 as QQC2

Item {
    property string batchname:""
    property string batchstrtDtTm:""
    property string batchstpDtTm:""

    enabled: UIStyle.idleforfg

    Connections{
        target: db
        onHandleSQL_batch:{
            //cwGuageVal = cnt

            console.log("connection done with SQL"+sql_data1)
        //    usrBlckUnblckmodel.append({Username:sql_data1,Status:sql_data2})
            usrBlckUnblckmodel.append({Username:sql_data1,Status:sql_data2,BatchStpDtTm:sql_data3})

        }
    }
//    Connections{
//        target: W
//        onBatchLoading:{
//            if(cnt == 1){
//                console.log("batch loading.....")
//                batchLoadingDialog.open()
//            }
//            if(cnt == 0){
//                console.log("batch loading.....")
//                batchLoadingDialog.close()
//            }
//        }
//    }

    function loadBatches(){

  //      savetextfield.loadUserStatusFile()
        usrBlckUnblckmodel.clear({Username:""})
        usrBlckUnblckmodel.clear({Status:""})
         usrBlckUnblckmodel.clear({BatchStpDtTm:""})

        db.loadSQLBatches()

    //    chngdUsrGrpmodel.clear({Username:""})
    //    chngdUsrGrpmodel.clear({Status:""})
//       for(var i = 0;i<UIStyle.fileList.length;i++){
//            myString = UIStyle.fileList[i]
//            UIStyle.prd_code1 = stringList[0]
//            UIStyle.prd_code2 = stringList[1]

//            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

//        }

    }

    Dialog {
            id: batchLoadingDialog
            width: warmMsg8.contentWidth + 400
            height: 600
            x:10
            y:100
            visible: false
  //          title:  "Logout Success!!!"
            closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                       color: "red"
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
                           text: "BATCH LOADING WINDOW"
                           font.pixelSize: 40
                           color: "black"
                       }
//                       Image {
//                             id: logoutIcon
//                             anchors.left: parent.left
//                             width: 150
//                             height: 100
//                             source: "/images/logout.jpeg"
//                       }

                   }
         contentItem: FocusScope{
            Column {
                id: batchLoadingColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg8;font.pixelSize:UIStyle.fontSizeXXL;text: "BATCH LOADING IN PROGRESS......";color:UIStyle.colorQtblk}
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
                        text: "Cancel"
                        font.pixelSize: 20
                    }
                   isDefault: true
                   focus: true
                    width: 150
                   height: 80
                   onClicked:{}
               }
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
                    onClicked:{}
                }

             }

        }

    }

    Dialog {
            id: blckUnblckDialog
            x: 10
            y: 20
            width: 1850
            height: blkunblkgrp.height * 2
            visible: true
            closePolicy: Popup.CloseOnEscape
     //       standardButtons: StandardButton.Cancel | StandardButton.Ok
     //       title:  "Block Unblock User Window"
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:1800
                height: 40
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "Batch Report Window"
                    font.pixelSize: 30
                    color: "black"
                }
            }
       contentItem: FocusScope{
            Row {
                id: blckUnblckcolumn
                width: 1209
                height: 600
                spacing: 20
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    GroupBox{
                        id:blkunblkgrp
                        title: "Present User List with Status"
                        width: 1200
                        height: 600
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
                            id: usrBlckUnblckListView

                            anchors.fill: parent
                            //      width: 600
                            //      height: 400
                            frameVisible: true
                            backgroundVisible: true
                            alternatingRowColors: true
                            sortIndicatorVisible: true
                            clip: true
                            highlightOnFocus: true

                            TableViewColumn {
                                role: "Username"
                                title: "BATCH NAME"
                                width: usrBlckUnblckListView.width / 3
                                resizable: true
                                movable: true

                                delegate: Component {
                                    id: usrBlckUnblckListViewdelegate

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
                                role: "Status"
                                title: "START DATE TIME"
                                width: usrBlckUnblckListView.width / 3
                                resizable: true
                                movable: true

                                delegate: Component {
                                    id: statusdelegate

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
                                role: "BatchStpDtTm"
                                title: "STOP DATE TIME"
                                width: usrBlckUnblckListView.width / 3
                                resizable: true
                                movable: true

                                delegate: Component {
                                    id: batchstpDtTmdelegate

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

                            style:TableViewStyle {
                                rowDelegate: Rectangle{
                                    height: 50
                                }

                                frame:Rectangle {
                                    border{
                                        color: "white"
                                    }
                                }
                                handle: Rectangle {
                                    implicitWidth: 50
                                    implicitHeight: 50
                                    Rectangle {
                                        color: "steelblue"
                                        anchors.fill: parent
                                        anchors.topMargin: 6
                                        anchors.leftMargin: 4
                                        anchors.rightMargin: 4
                                        anchors.bottomMargin: 6
                                    }
                                }
                                scrollBarBackground: Item {
                                    implicitWidth: 50
                                    implicitHeight: 50

                                }
                            }


                            //                        frameVisible: true
                            //                        backgroundVisible: true
                            //                        alternatingRowColors: true

                            model: ListModel {
                                id: usrBlckUnblckmodel
                                ListElement { Username: ""
                                    Status:""
                                    BatchStpDtTm:""
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

                            onCurrentRowChanged: {batchname = usrBlckUnblckmodel.get(__currentRow).Username;batchstrtDtTm = usrBlckUnblckmodel.get(__currentRow).Status; batchstpDtTm = usrBlckUnblckmodel.get(__currentRow).BatchStpDtTm;  if(batchname.length != 0){batchrpt.visible = true;alaramrpt.visible = true;auditrpt.visible = true}}

                        }
                    }

                }
             //   Column{

                 //   width: 300
                //    spacing: 30
                 //   Button{id:blckBtn;width: 200;height: 50;Label{text: "BLOCK"; anchors.verticalCenterOffset: 1; anchors.horizontalCenterOffset: 1; anchors.leftMargin: 1;anchors.centerIn: blckBtn;anchors.left: blckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Blocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Blocked"})}}
                 //   Button{id:unblckBtn;width: 200;height: 50;Label{text: "UNBLOCK";anchors.centerIn: unblckBtn;anchors.left: unblckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Unblocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Unblocked"})}}




              //  }
//                Column{
//                    spacing: 50
//                    anchors.top: parent.top
//                    anchors.topMargin: 30

//           GroupBox{
//              title: "Changed User with Status"
//              width: 800
//              height: 450
//              style: Style {
//                                          property Component panel: Rectangle {
//                                              Text {
//                                                  anchors.horizontalCenter: parent.horizontalCenter
//                                                  anchors.bottom: parent.top

//                                                  text: control.title
//                                                  color: control.enabled ? "Black" : "gray"
//                                                  renderType: Text.NativeRendering
//                                                  font.italic: !control.enabled
//                                             //     font.weight: Font.Bold
//                                                  font.pointSize: 18
//                                              }
//                                          }
//                                      }


//              TableView {
//                  id: chngdUsrGrpList

//                  anchors.fill: parent
//                  //      width: 600
//                  //      height: 400
//                  frameVisible: true
//                  backgroundVisible: true
//                   alternatingRowColors: true
//                    sortIndicatorVisible: true
//                     clip: true
//                    highlightOnFocus: true

//                  TableViewColumn {
//                      role: "Username"
//                      title: "User Name"
//                      width: chngdUsrGrpList.width / 2
//                      resizable: true
//                      movable: true
//                  }
//                  TableViewColumn {
//                      role: "Status"
//                      title: "Status"
//                      width: chngdUsrGrpList.width / 2
//                      resizable: true
//                      movable: true

//                  }

////                  frameVisible: true
////                  backgroundVisible: true
////                  alternatingRowColors: true


//                  model: ListModel {
//                     id: chngdUsrGrpmodel
//                  ListElement { Username: ""
//                                Status:""
//                  }
//                  }

//                  rowDelegate: Rectangle {
//                                                 property bool selected : styleData.selected
//                                                 width: parent.width-2
//                                                 height: 90
//                                                 color: styleData.selected? "lightgray" : "steelblue"
//                                                 Rectangle {
//                                                     width: parent.width
//                                                     height: 1
//                                                     anchors.bottom: parent.bottom
//                                                     visible: parent.selected
//                                                     color: "steelblue"
//                                                 }
//                                             }
//                  headerDelegate: Rectangle {
//                                                 width: parent.width
//                                                 height: 60
//                                                 color: "Brown"
//                                                 Text {
//                                                     anchors.fill: parent
//                                                     text: styleData.value
//                                                     color: "Yellow"
//                                                     font.family: "Arial"
//                                                     font.pixelSize: 40
//                                                 }
//                                             }

//                  onCurrentRowChanged: {console.log(chngdUsrGrpmodel.get(__currentRow).Username)}

//              }




//           }

 //      }

    }
            Row{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
//                 Button{
//               //     text: "OK"
//                     Label{
//                         anchors.centerIn: parent
//                         text: "Cancel"
//                         font.pixelSize: 20
//                     }
//                    isDefault: true
//                    focus: true
//                    width: 150
//                    height: 80
//                    onClicked:{blckUnblckDialog.close();circularView.blurScreena("Origin")}
//                 }
            }

       }

       HexButton {
           id:loadbatch
           x: 1300
           y: 452
           width: 220
           height: 204
           color: "#808000"
           text: "LOAD\nBATCHES"
           fontsize: 20


           onClicked: {
               loadBatches()
           }
       }

       HexButton {

           id:batchrpt
           x: 1526
           y: 647
           width: 220
           height: 204
           color: "#808000"
           text: "BATCH\nREPORT"
           fontsize: 20
           visible: false
          onClicked:
              //W.sQL_Batch_Report(batchname,batchstrtDtTm,batchstpDtTm)//
                W.open_batchpdf(batchname,batchstrtDtTm,batchstpDtTm)
       }

       HexButton {
           id:auditrpt
           x: 1526
           y: 259
           width: 220
           height: 204
           color: "#808000"
           text: "AUDIT\nREPORT"
           fontsize: 20
           visible: false
           onClicked:
               //Audit.sQL_Audit_Report(batchname,batchstrtDtTm,batchstpDtTm)//
               Audit.open_auditpdf(batchname,batchstrtDtTm,batchstpDtTm)
       }

         HexButton {
             id:alaramrpt
             x: 1526
             y: 452
             width: 220
             height: 204
             color: "#808000"
             text: "ALARM\nREPORT"
             fontsize: 20
             visible: false
             onClicked:
                // Alaram.sQL_Alaram_Report(batchname,batchstrtDtTm,batchstpDtTm)//
                    Alaram.open_alarampdf(batchname,batchstrtDtTm,batchstpDtTm)
         }

}






}
