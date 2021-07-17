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

import "../Style"

Item {
 //   Item{
    id: dycompButton
    width: 220      //150
    height: 80      // Math.round(width * 0.866)
    property bool active: false
    property alias color: dummyOff.color
    property alias color1: dummyOn.color
    property alias text: dummytext.text
    property alias textcolor: dummytext.color
    property alias fontsize: dummytext.font.pointSize
    signal clicked()
    signal pressAndHold()
    signal passName(string text)
    signal passStatus(string sts)

    property string userName: ""
    property string userStatus: ""

    // property alias adminPass: password.text
  //  property alias oldPass: oldPassword.text
  //  property alias newPass: newPassword.text
  //  property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: ""
    //property alias loginLblGrpName: loginLblGrpNm.text
  //  property alias loginLblName: loginLblNm.text
 //   property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"
    property string myString
    property variant stringList: myString.split(',')

    Rectangle { // ugly hack for aliasing button color. Must be a better way?
        id: dummyOff
        width: 3; height:3
        opacity: 0
        color: "steelblue"
    }
    Rectangle { // ugly hack for aliasing button color. Must be a better way?
        id: dummyOn
        width: 3; height:3
        opacity: 0
        color: "red"
    }
    Text {
        id: dummytext
        text: "GENERATE DY.COMP\nFACTOR"
        color: "white"
        font.pointSize: 25
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(usrBlckUnblckButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(usrBlckUnblckButton.width * 0.866 * dummyOff.scale)
            width: 400// Math.round(height / 1.732)
         //   color: dummy.color
            color: active ? dummyOn.color : dummyOff.color      // "red" : "green"
          //  rotation: index * 120
            anchors.centerIn: parent
            antialiasing: true
            Text {
                text: (index == 2)? dummytext.text : ""
           //     rotation: 120
                anchors.centerIn: parent
                color: dummytext.color
                font.pointSize: dummytext.font.pointSize
                style: Text.Raised
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
         //           usrBlckUnblckButton.clicked()
                    dycompButton.active = !dycompButton.active
                    pulseAnim.running = true
                    if(dycompButton.active == true){
 //                       dycompButton.passStatus("1")
  //                      dycompButton.enabled = false
  //                      loadUserStatus()
  //                      blckUnblckDialog.open()
                    console.log("dy compensation button pressed!!!")
                        dummytext.text = "GENERATE DY.COMP\nFACTOR"
                    }
                    else{
                        dummytext.text = "GENERATE DY.COMP\nFACTOR"
                    }
                }
                onPressAndHold:
                    dycompButton.pressAndHold()

            }
        }
    }
    SequentialAnimation {
        id: pulseAnim
        running: false
        loops: 1
        PropertyAnimation { target: dummyOff; property: "scale"; from: 1.0; to: 1.1; duration: 100; }
        PropertyAnimation { target: dummyOff; property: "scale"; from: 1.1; to: 1.0; duration: 100; }
        PropertyAnimation { target: dummyOn; property: "scale"; from: 1.0; to: 1.1; duration: 100; }
        PropertyAnimation { target: dummyOn; property: "scale"; from: 1.1; to: 1.0; duration: 100; }

        // The stopped() signal is emitted when animation ends. It is only triggered for top-level,
        // standalone animations. It will not be triggered for animations in a Behavior or Transition,
        // or animations that are part of an animation group.
        onStopped: { dycompButton.clicked() }
    }
//    function loadUserStatus(){
//        usrBlckUnblckmodel.clear({Username:""})
//        usrBlckUnblckmodel.clear({Status:""})
//        chngdUsrGrpmodel.clear({Username:""})
//        chngdUsrGrpmodel.clear({Status:""})
//        savetextfield.loadUserStatusFile()
////       for(var i = 0;i<UIStyle.fileList.length;i++){
////            myString = UIStyle.fileList[i]
////            UIStyle.prd_code1 = stringList[0]
////            UIStyle.prd_code2 = stringList[1]

////            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

////        }

//    }
    Connections{
        target: savetextfield
//        onHandleSaveFileList:{
//            console.log("the userlist is:"+text)
//            UIStyle.fileList = text
//            UIStyle.prd_code1 = UIStyle.fileList[0]
//            UIStyle.prd_code2 = UIStyle.fileList[1]

//            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

//        }
    }

//    Dialog {
//        id: blckUnblckDialog
//        width: 1850
//        height: blkunblkgrp.height * 1.8
//        x:-1100
//        y:80
//  //      title:  "Block Unblock User Window"
//        closePolicy: Popup.CloseOnEscape
//        background: Rectangle{
//                   color: "aquamarine"
//                   radius: 5
//                   border.color: "mediumturquoise"
//               }

//               header: Rectangle{
//                   width:150
//                   height: 40
//                   color: "mediumturquoise"
//                   border.color: "aquamarine"
//                   radius: 5
//                   Text{
//                       anchors.centerIn: parent
//                       text: "Block Unblock User Window"
//                       font.pixelSize: 20
//                       color: "black"
//                   }
//               }
//        contentItem: FocusScope{
//            Row {
//                id: blckUnblckcolumn
//                spacing: 20
//                Column{
//                    spacing: 50
//                    anchors.top: parent.top
//                    anchors.topMargin: 30
//                    GroupBox{
//                        id:blkunblkgrp
//                        title: "Present User List with Status"
//                        width: 700
//                        height: 350
//                        style: Style {
//                            property Component panel: Rectangle {
//                                Text {
//                                    anchors.horizontalCenter: parent.horizontalCenter
//                                    anchors.bottom: parent.top

//                                    text: control.title
//                                    color: control.enabled ? "Black" : "gray"
//                                    renderType: Text.NativeRendering
//                                    font.italic: !control.enabled
//                                    //     font.weight: Font.Bold
//                                    font.pointSize: 18
//                                }
//                            }
//                        }

//                        TableView {
//                           id: usrBlckUnblckListView
//                            anchors.fill: parent
//                            frameVisible: false
//                            backgroundVisible: false
//                            alternatingRowColors: false
//                            sortIndicatorVisible: true
//                            clip: true
//                            highlightOnFocus: false

//                            TableViewColumn {
//                                role: "Username"
//                                title: "User Name"
//                                width: usrBlckUnblckListView.width / 2
//                                resizable: false
//                                movable: false

//                                delegate: Component {
//                                    id: usrBlckUnblckListViewdelegate

//                                    Text {
//                                        //         anchors.verticalCenter: parent.verticalCenter
//                                        color: "Black"
//                                        elide: styleData.elideMode
//                                        text: styleData.value
//                                        font.family: "Arial"
//                                        font.pixelSize: 30
//                                    }
//                                }

//                            }
//                            TableViewColumn {
//                                role: "Status"
//                                title: "Status"
//                                width: usrBlckUnblckListView.width / 2
//                                resizable: false
//                                movable: false

//                                delegate: Component {
//                                    id: statusdelegate

//                                    Text {
//                                        //         anchors.verticalCenter: parent.verticalCenter
//                                        color: "Black"
//                                        elide: styleData.elideMode
//                                        text: styleData.value
//                                        font.family: "Arial"
//                                        font.pixelSize: 30
//                                    }
//                                }

//                            }

//                            model: ListModel {
//                                id: usrBlckUnblckmodel
//                                ListElement { Username: ""
//                                    Status:""
//                                }
//                            }

//                            rowDelegate: Rectangle {
//                                property bool selected : styleData.selected
//                                width: parent.width-2
//                                height: 90
//                                color: styleData.selected? "lightgray" : "steelblue"
//                                Rectangle {
//                                    width: parent.width
//                                    height: 1
//                                    anchors.bottom: parent.bottom
//                                    visible: parent.selected
//                                    color: "steelblue"
//                                }
//                            }
//                            headerDelegate: Rectangle {
//                                width: parent.width
//                                height: 60
//                                color: "Brown"
//                                Text {
//                                    anchors.fill: parent
//                                    text: styleData.value
//                                    color: "Yellow"
//                                    font.family: "Arial"
//                                    font.pixelSize: 40
//                                }
//                            }

//                            onCurrentRowChanged: {userName = usrBlckUnblckmodel.get(__currentRow).Username;userStatus = usrBlckUnblckmodel.get(__currentRow).Status;console.log("USer status"+userStatus)}

//                        }
//                    }

//                }
//                Column{

//                    width: 300
//                    spacing: 30
//                    anchors.top: parent.top
//                    anchors.topMargin: 200
//                    Button{id:blckBtn;width: 200;height: 70;Label{text: "BLOCK";anchors.centerIn: blckBtn;anchors.left: blckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(userName,"Blocked");chngdUsrGrpmodel.append({Username:userName,Status:"Blocked"})}}
//                    Button{id:unblckBtn;width: 200;height: 70;Label{text: "UNBLOCK";anchors.centerIn: unblckBtn;anchors.left: unblckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(userName,"Active");chngdUsrGrpmodel.append({Username:userName,Status:"Unblocked"})}}
//                    Button{
//                        Label{
//                            anchors.centerIn: parent
//                            text: "Cancel"
//                            font.pixelSize: 30
//                        }
//                        isDefault: true
//                        focus: true
//                        width: 200
//                        height: 70
//                        onClicked:{blckUnblckDialog.close();dycompButton.active = false;dycompButton.enabled = true;dycompButton.passStatus("0")}
//                    }
//                }
//                Column{
//                    spacing: 50
//                    anchors.top: parent.top
//                    anchors.topMargin: 30

//                    GroupBox{
//                        title: "Changed User with Status"
//                        width: 700
//                        height: 350
//                        style: Style {
//                            property Component panel: Rectangle {
//                                Text {
//                                    anchors.horizontalCenter: parent.horizontalCenter
//                                    anchors.bottom: parent.top

//                                    text: control.title
//                                    color: control.enabled ? "Black" : "gray"
//                                    renderType: Text.NativeRendering
//                                    font.italic: !control.enabled
//                                    //     font.weight: Font.Bold
//                                    font.pointSize: 18
//                                }
//                            }
//                        }


//                        TableView {
//                            id: chngdUsrGrpList

//                            anchors.fill: parent
//                            //      width: 600
//                            //      height: 400
//                            frameVisible: false
//                            backgroundVisible: false
//                            alternatingRowColors: false
//                            sortIndicatorVisible: true
//                            clip: true
//                            highlightOnFocus: false

//                            TableViewColumn {
//                                role: "Username"
//                                title: "User Name"
//                                width: chngdUsrGrpList.width / 2
//                                resizable: false
//                                movable: false
//                                delegate: Component {
//                               //     id: statusdelegate
//                                    Text {
//                                        //         anchors.verticalCenter: parent.verticalCenter
//                                        color: "Black"
//                                        elide: styleData.elideMode
//                                        text: styleData.value
//                                        font.family: "Arial"
//                                        font.pixelSize: 30
//                                    }
//                                }
//                            }
//                            TableViewColumn {
//                                role: "Status"
//                                title: "Status"
//                                width: chngdUsrGrpList.width / 2
//                                resizable: false
//                                movable: false
//                                delegate: Component {
//                             //       id: statusdelegate

//                                    Text {
//                                        //         anchors.verticalCenter: parent.verticalCenter
//                                        color: "Black"
//                                        elide: styleData.elideMode
//                                        text: styleData.value
//                                        font.family: "Arial"
//                                        font.pixelSize: 30
//                                    }
//                                }

//                            }

//                            model: ListModel {
//                                id: chngdUsrGrpmodel
//                                ListElement { Username: ""
//                                    Status:""
//                                }
//                            }

//                            rowDelegate: Rectangle {
//                                property bool selected : styleData.selected
//                                width: parent.width-2
//                                height: 90
//                                color: styleData.selected? "lightgray" : "steelblue"
//                                Rectangle {
//                                    width: parent.width
//                                    height: 1
//                                    anchors.bottom: parent.bottom
//                                    visible: parent.selected
//                                    color: "steelblue"
//                                }
//                            }
//                            headerDelegate: Rectangle {
//                                width: parent.width
//                                height: 60
//                                color: "Brown"
//                                Text {
//                                    anchors.fill: parent
//                                    text: styleData.value
//                                    color: "Yellow"
//                                    font.family: "Arial"
//                                    font.pixelSize: 30
//                                }
//                            }

//                            onCurrentRowChanged: {console.log(chngdUsrGrpmodel.get(__currentRow).Username)}

//                        }

//                    }

//                }

//            }
//            Row{
//                spacing: 50
//                anchors.bottom: parent.bottom
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//                anchors.bottomMargin: 20

//            }

//        }

//    }


}



