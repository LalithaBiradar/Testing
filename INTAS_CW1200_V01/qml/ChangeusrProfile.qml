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

import "Style"

Item {
 //   Item{
    id: changeUsrProfileButton
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

    property string adminName: ""
   // property alias adminPass: password.text
  //  property alias oldPass: oldPassword.text
  //  property alias newPass: newPassword.text
  //  property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: ""
    property string adminNameGroupSel: ""
    //property alias loginLblGrpName: loginLblGrpNm.text
  //  property alias loginLblName: loginLblNm.text
 //   property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"
    property string myString
    property variant stringList: myString.split(',')

    property bool userNameSel: false
    property bool groupNameSel: false
    property bool functPresent: false
    property string functionNm: ""
    property string groupNm: ""

    enabled: UIStyle.idleforfg

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
        text: "USER\nPROFILE"
        color: "white"
        font.pointSize: 25
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(changeUsrProfileButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(changeUsrProfileButton.width * 0.866 * dummyOff.scale)
            width: 200// Math.round(height / 1.732)
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
                    //           changeUsrProfileButton.clicked()
                    changeUsrProfileButton.active = !changeUsrProfileButton.active
                    pulseAnim.running = true
                    if(changeUsrProfileButton.active == true){
                        changeUsrProfileButton.passStatus("1")
                        changeUsrProfileButton.enabled = false
                        savetextfield.disableScreen("RT")
                        loadUserList();
                        UIStyle.scrEnabled = "1"
                        chngProfilebtn.enabled = false
                        chngUsrProfileDialog.open()
                        console.log("change user profile dialogue open!!!")
                        dummytext.text = "USER\nPROFILE"
                    }
                    else{
                        dummytext.text = "USER\nPROFILE"
                    }
                }
                onPressAndHold:
                    changeUsrProfileButton.pressAndHold()

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
        onStopped: { changeUsrProfileButton.clicked() }
    }


//    function loadUserList(){

//        savetextfield.loadUserProfileFile()
//        chngUsrProfilemodel.clear({Username:""})
//        chngUsrProfilemodel.clear({GroupName:""})
//        recAddedUsrGrpmodel.clear({Username:""})
//        recAddedUsrGrpmodel.clear({GroupName:""})
//       for(var i = 0;i<UIStyle.fileList.length;i++){
//            myString = UIStyle.fileList[i]
//            UIStyle.prd_code1 = stringList[0]
//            UIStyle.prd_code2 = stringList[1]

//            chngUsrProfilemodel.append({Username:UIStyle.prd_code1,GroupName:UIStyle.prd_code2})

//        }

//    }

    function loadUserList(){
        chngUsrProfilemodel.clear({Username:""})
        chngUsrProfilemodel.clear({GroupName:""})
        recAddedUsrGrpmodel.clear({Username:""})
        recAddedUsrGrpmodel.clear({GroupName:""})
        savetextfield.loadUserProfileFile()
//       for(var i = 0;i<UIStyle.fileList.length;i++){
//            myString = UIStyle.fileList[i]
//            UIStyle.prd_code1 = stringList[0]
//            UIStyle.prd_code2 = stringList[1]

//            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

//        }

    }
    Connections{
        target: savetextfield
        onHandleUserProfileList:{
            console.log("the userlist is:"+text)
            UIStyle.fileList = text
            UIStyle.prd_code1 = UIStyle.fileList[0]
            UIStyle.prd_code2 = UIStyle.fileList[1]
                if(UIStyle.prd_code1 != "Administrator"){
                     chngUsrProfilemodel.append({Username:UIStyle.prd_code1,GroupName:UIStyle.prd_code2})

                 }
        }
        onClDialogue:{
             console.log("close dialogue after timer end")
            if(text == "1"){
             chngUsrProfileDialog.close()
             passStatus("0")
             changeUsrProfileButton.active = false;changeUsrProfileButton.enabled = true;
            }

         }
    }

    function findFunction(name,grpName){
        console.log("count is:" +recAddedUsrGrpmodel.count)
        if(recAddedUsrGrpmodel.count == 0){
          functPresent = false;
        }

        for(var i = 0; i < recAddedUsrGrpmodel.count; i++) {
            functionNm = recAddedUsrGrpmodel.get(i).Username;
            groupNm = recAddedUsrGrpmodel.get(i).GroupName;
            if((name === functionNm) && (grpName === groupNm)) {
                console.log("Found it at index : ", i+1);
                functPresent = true

                break;
            }
            else{
                functPresent = false
                console.log("hahahahahaha");
            }
        }

    }

    Dialog {
        id: chngUsrProfileDialog
        width: 1920
        height: chngusrprflgrp.height * 2.7
        x:-500
        y:70
        closePolicy: Popup.CloseOnEscape
        background: Rectangle{
            color: "aquamarine"
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
                text: "Change User Profile Window"
                font.pixelSize: 30
                color: "black"
            }
        }

        contentItem: FocusScope{
            Row {
                id: chngUsrProfilecolumn
                spacing: 20
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    GroupBox{
                        id:chngusrprflgrp
                        title: "Present User List with Group Name"
                        width: 700
                        height: 350
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
                            id: usrListView

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
                                role: "Username"
                                title: "User Name"
                                width: usrListView.width / 2
                                resizable: false
                                movable: false

                                delegate: Component {
                                    id: usrListViewdelegate

                                    Text {
                                        color: "Black"
                                        elide: styleData.elideMode
                                        text: styleData.value
                                        font.family: "Arial"
                                        font.pixelSize: 30
                                    }
                                }

                            }
                            TableViewColumn {
                                role: "GroupName"
                                title: "Group Name"
                                width: usrListView.width / 2
                                resizable: false
                                movable: false

                                delegate: Component {
                                    id: groupNamedelegate

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

                            //                             frameVisible: false
                            //                             backgroundVisible: true
                            //                             alternatingRowColors: false

//---------------------------------VERTICAL SCROLLBAR CUSTOMIZATION-------------------------------------------
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
//-------------------------------------------------------------------------------------------------------

                            model: ListModel {
                                id: chngUsrProfilemodel
                                ListElement { Username: ""
                                    GroupName:""
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

                       //     onCurrentRowChanged: {adminName = chngUsrProfilemodel.get(__currentRow).Username}
                            onClicked: {
                                savetextfield.disableScreen("RT");
                                adminName = chngUsrProfilemodel.get(__currentRow).Username;
                                adminNameGroupSel = chngUsrProfilemodel.get(__currentRow).GroupName;
                                if(adminNameGroupSel != "Admin")
                                {userNameSel = true}
                                else{
                                    userNameSel = false;
                                     chngProfilebtn.enabled = false;
                                }
                                /*if((userNameSel == true) && (groupNameSel == true)){userNameSel = false;groupNameSel = false; chngProfilebtn.enabled = true}else{chngProfilebtn.enabled = false}*/}

                        }
                    }

                    GroupBox{
                        title: "Available User Groups"
                        width: 700
                        height: 350
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
                            id: view
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
                                role: "name"
                                title: "Group Name"
                                width: view.width / 2
                                resizable: false
                                movable: false

                                delegate: Component {
                                    id: name1delegate

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

                            //                            frameVisible: false
                            //                            backgroundVisible: true
                            //                            alternatingRowColors: false

//---------------------------------VERTICAL SCROLLBAR CUSTOMIZATION-------------------------------------------
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
//-------------------------------------------------------------------------------------------------------

                            model: ListModel {
                                id: avlUsrGrpmodel
                                ListElement { name: "Operator"; }
                                ListElement { name: "Supervisor"; }
                                ListElement { name: "Manager"; }
                                ListElement { name: "Engineer"; }
                                ListElement { name: "Administrator"; }

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

                   //         onCurrentRowChanged:{adminNameGroup = avlUsrGrpmodel.get(__currentRow).name}
                            onClicked:{savetextfield.disableScreen("RT");adminNameGroup = avlUsrGrpmodel.get(__currentRow).name;groupNameSel = true;if((userNameSel == true) && (groupNameSel == true)){chngProfilebtn.enabled = true}else{chngProfilebtn.enabled = false}}

                        }
                    }

                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 400
                  //  anchors.centerIn: parent

//                    GroupBox{
//                        title: "Selected User Expiry Days"
//                        width: 300
//                        height: 200
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

//                        TextField{id:usrExpiryDays;previewText: "";width: 200;height: 60}
//                    }
//                    GroupBox{
//                        title: "User New Expiry Days"
//                        width: 300
//                        height: 200
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
//                        TextField{id:usrNewExpiryDays;previewText: "";enterKeyAction: EnterKeyAction.Next;width: 200;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
//                    }

                    Button{id:chngProfilebtn;
                        width: 300;
                        height: 60;
                        Label{text: "CHANGE PROFILE";
                            anchors.centerIn: chngProfilebtn;anchors.left: chngProfilebtn.left;font.pointSize: 25}
                        onClicked:{savetextfield.disableScreen("RT");userNameSel = false;groupNameSel = false;chngProfilebtn.enabled = false;savetextfield.overWriteFileAdmin(adminNameGroup,adminName);/*loadUpdatedUserList();*/findFunction(adminName,adminNameGroup);if(functPresent == false){ recAddedUsrGrpmodel.append({Username:adminName,GroupName:adminNameGroup});usrListView.selection.clear();view.selection.clear();}}}
//                    Button{id:setProfilebtn;width: 200;height: 50;Label{text: "---->";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Unblocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Unblocked"})}}
                    Button{
                        //     text: "OK"
                        Label{
                            anchors.centerIn: parent
                            text: "Close"
                            font.pixelSize: 20
                        }
                        isDefault: true
                        focus: true
                        width: 150
                        height: 80
                        onClicked:{savetextfield.disableScreen("RT");usrListView.selection.clear();view.selection.clear();recAddedUsrGrpList.selection.clear();UIStyle.scrEnabled = "0"; chngUsrProfileDialog.close();changeUsrProfileButton.active = false;changeUsrProfileButton.enabled = true;changeUsrProfileButton.passStatus("0")}
                    }



                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

//                    GroupBox{
//                        title: "Selected User Group"
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

//                        ListView{
//                            width: 200
//                            height : 100
//                            id:selUsrGrpList
//                            model: ListModel {
//                                id: selUsrGrpmodel
//                                ListElement { text: "" }

//                            }


//                        }
//                    }

                    GroupBox{
                        title: "Recently Added User with Group Name"

                        width: 700
                        height: 350
                        style: Style {
                            property Component panel: Rectangle {
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.top
                                    text: control.title
                                    color: control.enabled ? "Black" : "gray"
                                    renderType: Text.NativeRendering
                                    font.italic: !control.enabled
                                    font.pointSize: 18
                                }
                            }
                        }


                        TableView {
                            id: recAddedUsrGrpList
                            anchors.fill: parent

                            frameVisible: false
                            backgroundVisible: false
                            alternatingRowColors: false
                            sortIndicatorVisible: true
                            clip: true
                            highlightOnFocus: false
                            //enabled: false

                            TableViewColumn {
                                role: "Username"
                                title: "User Name"
                                width: recAddedUsrGrpList.width / 2
                                resizable: false
                                movable: false


                                delegate: Component {
                                    id: usernamedelegate

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
                                role: "GroupName"
                                title: "Group Name"
                                width: recAddedUsrGrpList.width / 2
                                resizable: false
                                movable: false


                                delegate: Component {
                                    id: selgroupNamedelegate

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
                                id: recAddedUsrGrpmodel
                                ListElement { Username: ""
                                    GroupName:""
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


        //                    onCurrentRowChanged: {console.log(recAddedUsrGrpmodel.get(__currentRow).Username)}

                        }


                    }

                }

            }
            Row{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20

//                Button{
//                    //     text: "OK"
//                    Label{
//                        anchors.centerIn: parent
//                        text: "Cancel"
//                        font.pixelSize: 20
//                    }
//                    isDefault: true
//                    focus: true
//                    width: 150
//                    height: 80
//                    onClicked:{ chngUsrProfileDialog.close();changeUsrProfileButton.active = false;changeUsrProfileButton.passStatus("0")}
//                }


            }

        }

    }
}


