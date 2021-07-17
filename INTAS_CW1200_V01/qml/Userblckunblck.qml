//import QtQuick 2.0
//import QtQuick.VirtualKeyboard 2.1
//import QtQuick.Dialogs 1.2

//import QtQuick.Controls 2.1
//import QtQuick.Controls 1.1
//import QtQuick.Controls.Styles 1.1

//import QtQuick.Controls.Styles 1.1
//import QtQuick.Controls.Private 1.0
//import QtQuick.Controls.Styles 1.4

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
    id: usrBlckUnblckButton
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

//    property string userName: ""
//    property string userStatus: ""
    property string adminName: ""
    property string userStatus: ""
    property string expiryStatus: ""

    // property alias adminPass: password.text
  //  property alias oldPass: oldPassword.text
    property alias newPass: newPassword.text
    property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
    property string logouttime: ""
    //property alias loginLblGrpName: loginLblGrpNm.text
  //  property alias loginLblName: loginLblNm.text
 //   property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"
    property string myString
    property variant stringList: myString.split(',')

    property string splChrs : "!#%&'()*+,-./:;<=>?@[]^_`{|}~"
     property string numChrs : "0123456789"
     property string upperChrs : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     property string lowerChrs : "abcdefghijklmnopqrstuvwxyz"

     property string splChrsfg : "0"
     property string numChrsfg : "0"
     property string upperChrsfg : "0"
     property string lowerChrsfg : "0"
     property string pwdValidatefg : "0"

     property alias userFailTxt: pwdWrong.text
    property int currentIndex_logout

    property string calendar_date: ""
    property variant min_date: calendar_date.split('/')
    property string cal_min_date: ""
    property string max_date: ""
    property string user_expiry_days: ""

    property string expiry_date: ""

    property string current_date: ""
    property variant cur_date: current_date.split('/')
    property string user_expiry_date: ""
    property variant usr_exp_date: user_expiry_date.split('/')
    property string daychkfg : "0"
    property string monthchkfg : "0"
    property string yearchkfg : "0"

    enabled: UIStyle.idleforfg

 //    property alias statusText: statusdelegateText.text



    Connections
    {
        target: handle_loadcellcalls
        onHandle_logouttime:{

            UIStyle.logout_time = cnt
            console.log("logout time"+UIStyle.logout_time)
          currentIndex_logout =  logoutBox.find(UIStyle.logout_time,flags = Qt.MatchExactly)
            console.log("current index is"+currentIndex_logout)



        }

    }




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
        text: "USER BLOCK\nUNBLOCK"
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
            width: 220// Math.round(height / 1.732)
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
                    usrBlckUnblckButton.active = !usrBlckUnblckButton.active
                    pulseAnim.running = true
                    if(usrBlckUnblckButton.active == true){
                        usrBlckUnblckButton.passStatus("1")
                        savetextfield.disableScreen("RT")
                        usrBlckUnblckButton.enabled = false
              //          unblckBtn.visible = false
              //          blckBtn.visible = false
                        unblckBtn.enabled = false
                        blckBtn.enabled = false
                        removeBtn.enabled = false
                        currentIndex_logout =  logoutBox.find(UIStyle.logout_time,flags = Qt.MatchExactly)
                        loadUserStatus()
                        UIStyle.scrEnabled = "1"

                        blckUnblckDialog.open()
                    console.log("block unblock dialogue open!!!")
                        dummytext.text = "USER BLOCK\nUNBLOCK"
                    }
                    else{
                        dummytext.text = "USER BLOCK\nUNBLOCK"
                    }
                }
                onPressAndHold:
                    usrBlckUnblckButton.pressAndHold()

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
        onStopped: { usrBlckUnblckButton.clicked() }
    }
    function loadUserStatus(){
        usrBlckUnblckmodel.clear({Username:""})
        usrBlckUnblckmodel.clear({Status:""})
        usrBlckUnblckmodel.clear({ExpiryDate:""})

        chngdUsrGrpmodel.clear({Username:""})
        chngdUsrGrpmodel.clear({Status:""})
        chngdUsrGrpmodel.clear({ChExpiryDate:""})

        savetextfield.loadUserStatusFile()
//       for(var i = 0;i<UIStyle.fileList.length;i++){
//            myString = UIStyle.fileList[i]
//            UIStyle.prd_code1 = stringList[0]
//            UIStyle.prd_code2 = stringList[1]

//            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

//        }

    }
    function clearAll(){
        usrBlckUnblckmodel.clear({Username:""})
        usrBlckUnblckmodel.clear({Status:""})
        usrBlckUnblckmodel.clear({ExpiryDate:""})
        chngdUsrGrpmodel.clear({Username:""})
        chngdUsrGrpmodel.clear({Status:""})
        chngdUsrGrpmodel.clear({ChExpiryDate:""})


    }


    Connections{
        target: savetextfield
   //     onHandleSaveFileList:{
        onHandleUserStatusFile:{
            console.log("the user status are:"+text)
            UIStyle.fileList = text
            UIStyle.prd_code1 = UIStyle.fileList[0]
            UIStyle.prd_code2 = UIStyle.fileList[1]
            expiry_date = UIStyle.fileList[2]


       //     usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})
            if(UIStyle.fileList[2] !== "Expired"){

            chkexpiry()
            if(daychkfg == "1"){
                expiry_date = "Expired"
                UIStyle.prd_code2 = "Blocked"
            }
            else{
                daychkfg = "0"
               expiry_date = UIStyle.fileList[2]
            }

            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2,ExpiryDate:expiry_date})
            }
            else{
                UIStyle.prd_code2 = "Blocked"
                expiry_date = UIStyle.fileList[2]
              usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2,ExpiryDate:expiry_date})
            }

        }
        onClDialogue:{
             console.log("close dialogue after timer end")
            if(text == "1"){
             blckUnblckDialog.close()
                chngPassDialog.close()
                calendarDialog.close()
                existUsrOkDialog.close()
                chngUsrOkDialog.close()
                pwdFailDialog.close()
                chngUsrFailDialog.close()
                usrBlckUnblckListView.selection.clear();usrBlckUnblckButton.active = false;usrBlckUnblckButton.enabled = true;passStatus("0")
            }

         }

    }
//    function chkexpiry(){
//        console.log("the current date is:"+UIStyle.current_date)
//         console.log("the expiry date is:"+UIStyle.fileList[2])
//       current_date = UIStyle.current_date
//       user_expiry_date = UIStyle.fileList[2]

//         if(cur_date[2]>=usr_exp_date[2]){
//             console.log("year checking")
//             yearchkfg = "1"
//             if(cur_date[1]>=usr_exp_date[1]){
//                 console.log("month checking")
//                 monthchkfg = "1"
//                 if(cur_date[0]>=usr_exp_date[0]){
//                     console.log("day checking")
//                     daychkfg = "1"
//                 }
//                 else{
//                    daychkfg = "0"
//                 }
//             }
//             else{
//                 monthchkfg = "0"
//             }
//         }
//         else{
//           yearchkfg = "0"
//         }

//    }


    function chkexpiry(){
        daychkfg = "0";monthchkfg = "0";yearchkfg = "0"
        console.log("the current date is:"+UIStyle.current_date)
         console.log("the expiry date is:"+UIStyle.expiry_Days)
       current_date = UIStyle.current_date
       user_expiry_date = UIStyle.fileList[2]//UIStyle.expiry_Days

        if(user_expiry_date != "Live")
        {
            if(cur_date[2]<=usr_exp_date[2]){
                console.log("year checking")
                yearchkfg = "1"
                if(cur_date[1]<=usr_exp_date[1]){
                    console.log("month checking")
                    monthchkfg = "1"
                    if(cur_date[0]>=usr_exp_date[0]){
                        console.log("day checking")
                       // daychkfg = "1"
                        daychkfg = "0"

                     if(cur_date[1]===usr_exp_date[1])
                     {
                         if(cur_date[0]<usr_exp_date[0])
                         {
                           console.log("1st cond day checking")
                           daychkfg = "0"
                         }
                        else
                         {

                           daychkfg = "1"
                         }
                       }
                     }
                    else{
                        if(cur_date[1]===usr_exp_date[1])
                         {

                            if(cur_date[0]<usr_exp_date[0])
                             {
                                console.log("2nd cond day checking")
                                daychkfg = "0"
                             }
                            else
                             {
                                daychkfg = "1"
                             }
                         }
                        else
                         {
                           //daychkfg = "1"
                            daychkfg = "0"
                         }


                    }
                }
                else{
                    monthchkfg = "0"
                    daychkfg = "1"
                }
            }
            else{
                yearchkfg = "0"
                daychkfg = "1"
            }

        }


    }



function setindex(){
    currentIndex_logout =  logoutBox.find(UIStyle.logout_time,flags = Qt.MatchExactly)
    console.log("new index is:"+currentIndex_logout)

}

    Dialog {
        id: blckUnblckDialog
        width: 1850
        height: blkunblkgrp.height * 1.8
        x:-950
        y:80
  //      title:  "Block Unblock User Window"
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
                       text: "Block Unblock User Window"
                       font.pixelSize: 40
                       color: "black"
                   }
               }
        contentItem: FocusScope{
            Row {
                id: blckUnblckcolumn
                spacing: 20
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    GroupBox{
                        id:blkunblkgrp
                        title: "Present User List with Status"
                        width: 700
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
                            frameVisible: false
                            backgroundVisible: false
                            alternatingRowColors: false
                            sortIndicatorVisible: true
                            clip: true
                            highlightOnFocus: false

                            TableViewColumn {
                                role: "Username"
                                title: "User Name"
                                width: usrBlckUnblckListView.width / 3
                                resizable: false
                                movable: false

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
                                title: "Status"
                                width: usrBlckUnblckListView.width / 3
                                resizable: false
                                movable: false

                                delegate: Component {
                                    id: statusdelegate

                                    Text {
                                        id:statusdelegateText
                                        //         anchors.verticalCenter: parent.verticalCenter
                                        color: "Black"
                                        elide: styleData.elideMode
                                        text: styleData.value
                                     //   text: usrBlckUnblckListView.model.get(styleData.row).Status
                                        font.family: "Arial"
                                        font.pixelSize: 30
                                    }
                                }


                            }
//--------------------------------------------------------------------------
                            TableViewColumn {
                                role: "ExpiryDate"
                                title: "Expiry Date"
                                width: usrBlckUnblckListView.width / 3
                                resizable: false
                                movable: false

                                delegate: Component {
                                    id: expiryDatedelegate

                                    Text {
                                        id:expiryDatedelegateText
                                        //         anchors.verticalCenter: parent.verticalCenter
                                        color: "Black"
                                        elide: styleData.elideMode
                                        text: styleData.value
                                     //   text: usrBlckUnblckListView.model.get(styleData.row).Status
                                        font.family: "Arial"
                                        font.pixelSize: 30
                                    }
                                }


                            }

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
                                id: usrBlckUnblckmodel
                                ListElement { Username: ""
                                    Status:""
                                    ExpiryDate:""
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
                         //       onSelectedChanged: {blckBtn.enabled = false;unblckBtn.enabled = false}


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

                     //       onCurrentRowChanged: {console.log("row changed"); adminName = usrBlckUnblckmodel.get(__currentRow).Username;userStatus = usrBlckUnblckmodel.get(__currentRow).Status
                     //                                   if((userStatus == "Active") && (adminName.length != 0)){blckBtn.visible = true; unblckBtn.visible = false}else if((userStatus == "Blocked") && (adminName.length != 0)){blckBtn.visible = false;unblckBtn.visible = true}}
                     //       onClicked: {console.log("press and hold");adminName = usrBlckUnblckmodel.get(__currentRow).Username;userStatus = usrBlckUnblckmodel.get(__currentRow).Status
                     //           if((userStatus == "Active") && (adminName.length != 0)){blckBtn.enabled = true; unblckBtn.enabled = false}else if((userStatus == "Blocked") && (adminName.length != 0)){blckBtn.enabled = false;unblckBtn.enabled = true}}
                            onClicked:   {
                                savetextfield.disableScreen("RT");
                                console.log("press and hold");
                                adminName = usrBlckUnblckmodel.get(__currentRow).Username;
                                userStatus = usrBlckUnblckmodel.get(__currentRow).Status;
                                console.log("UserName is:"+adminName);
                                expiryStatus = usrBlckUnblckmodel.get(__currentRow).ExpiryDate;
                                if(((userStatus == "Active") &&(expiryStatus != "Live")) && ((adminName.length != 0) && (adminName != "Administrator")))
                                {blckBtn.enabled = true; unblckBtn.enabled = false;removeBtn.enabled = true}
                                else if((userStatus == "Blocked") && ((adminName.length != 0) && (adminName != "Administrator")))
                                {blckBtn.enabled = false;unblckBtn.enabled = true;removeBtn.enabled = true}
                                else if(userStatus == "Inactive")
                                {blckBtn.enabled = false;unblckBtn.enabled = false;removeBtn.enabled = true}
                                else if(((userStatus == "Active") &&(expiryStatus == "Live")) && ((adminName.length != 0) && (adminName != "Administrator")))
                                {blckBtn.enabled = true; unblckBtn.enabled = false;removeBtn.enabled = true}
                                else{blckBtn.enabled = false;removeBtn.enabled = false}}
                        }
                    }

                }
                Column{

                    width: 300
                    spacing: 30
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    Label{width: 100; height: 70; color: "black";text:"LOGOUT TIME\n(Min.)"; font.pixelSize: 35}
                  //  TextField{id:logouttime; x: 430; y: 370; width: 155;previewText: "";fontPixelSize: 16; onFocusChanged: {inputPanelpg2.visible = true;inputPanelpg2.y = 460}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:{ logouttime.focus = false;inputPanelpg2.visible = false;}inputMethodHints: Qt.ImhDigitsOnly;height: 50; validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{savetextfield.disableScreen("RT")}}
                    ComboBox {
                        id:logoutBox
                        width: 300;height: 60
                        currentIndex : currentIndex_logout

                        model: ListModel {
                            id: addlogouttimemodel
            //                ListElement { text: "Administrator"}
                            ListElement { text: ""}
                            ListElement { text: "5"}
                            ListElement { text: "10"}
                            ListElement { text: "15"}
                            ListElement { text: "20"}
                        }


                        style: ComboBoxStyle {
                                                            id: comboBoxStyle
                                                            background: Rectangle {
                                                                id: rect
                                                                border.color: "green"
                                                                color: "gray"
                                                            }
                                                            label: Text {
                                                                id:logoutText
                                                                           verticalAlignment: Text.AlignVCenter
                                                                           horizontalAlignment: Text.AlignHCenter
                                                                            color: "black"
                                                                            text: control.currentText
                                                                            font.pointSize: 22
                                                                            onTextChanged: {logouttime = logoutText.text;savetextfield.disableScreen("RT");if(logouttime != ""){console.log("empty in logout time"); UIStyle.logout_time = logouttime;savetextfield.storeLogout_time(UIStyle.logout_time);console.log("time:"+logouttime)}else{UIStyle.logout_time = "5";savetextfield.storeLogout_time(UIStyle.logout_time); setindex();}}
                                                                        }
                                                            __dropDownStyle: MenuStyle {
                                                                           frame: Rectangle {
                                                                               color: "white"
                                                                               border.width: 1
                                                                               radius: 5
                                                                               border.color: "gray"
                                                                           }

                                                                           itemDelegate.label: Text {
                                                                               color: styleData.selected ? "red" : "black"
                                                                               text: styleData.text
                                                                               font.pointSize: 22
                                                                           }
                                                                       }
                                                }


                      //  onCurrentIndexChanged:{ logouttime = addlogouttimemodel.get(currentIndex).text;savetextfield.disableScreen("RT");UIStyle.logout_time = logouttime}
                     //   on__StyleChanged:   { logouttime = addlogouttimemodel.get(currentIndex).text;savetextfield.disableScreen("RT");UIStyle.logout_time = logouttime;savetextfield.storeLogout_time(UIStyle.logout_time);console.log("logout time:"+logouttime)}

                   }
                    Button{id:blckBtn;
		    width: 200;
		    height: 70;
		    Label{text: "BLOCK";
		    anchors.centerIn: blckBtn;anchors.left: blckBtn.left;font.pointSize: 25}onClicked:{savetextfield.disableScreen("RT");savetextfield.statusFile(adminName,"Blocked","Expired");usrBlckUnblckListView.selection.clear();blckUnblckDialog.close();loadUserStatus();unblckBtn.enabled = false;blckBtn.enabled = false; removeBtn.enabled = false;blckUnblckDialog.open(); chngdUsrGrpmodel.append({Username:adminName,Status:"Blocked",ChExpiryDate:"Expired"}) }}
                    Button{id:unblckBtn;
		    width: 200;
		    height: 70;
		    Label{text: "UNBLOCK";
		    anchors.centerIn: unblckBtn;anchors.left: unblckBtn.left;font.pointSize: 25}onClicked:{savetextfield.disableScreen("RT");blckUnblckDialog.close();newPassword.text = "";cnfPassword.text = ""; userEntryOkBtn.enabled = false;chngPassDialog.open();/*savetextfield.statusFile(userName,"Active");chngdUsrGrpmodel.append({Username:userName,Status:"Unblocked"})*/}}
                   Button{id:removeBtn;
		   width: 300;
		   height: 70;
		   Label{text: "REMOVE USER";
		   anchors.centerIn: removeBtn;anchors.left: removeBtn.left;font.pointSize: 25}onClicked:{savetextfield.disableScreen("RT");savetextfield.remove(adminName);savetextfield.removeFromOTP(adminName);usrBlckUnblckListView.selection.clear();blckUnblckDialog.close();loadUserStatus();unblckBtn.enabled = false;blckBtn.enabled = false; removeBtn.enabled = false;blckUnblckDialog.open()}}
                    Button{
                        Label{
                            anchors.centerIn: parent
                            text: "Close"
                            font.pixelSize: 30
                        }
                        isDefault: true
                        focus: true
                        width: 200
                        height: 70
                        onClicked:{savetextfield.disableScreen("RT");usrBlckUnblckListView.selection.clear();UIStyle.scrEnabled = "0";blckUnblckDialog.close();usrBlckUnblckButton.active = false;usrBlckUnblckButton.enabled = true;usrBlckUnblckButton.passStatus("0")}
                    }
                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

                    GroupBox{
                        title: "Changed User with Status"
                        width: 700
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
                            id: chngdUsrGrpList

                            anchors.fill: parent
                            //      width: 600
                            //      height: 400
                            frameVisible: false
                            backgroundVisible: false
                            alternatingRowColors: false
                            sortIndicatorVisible: true
                            clip: true
                            highlightOnFocus: false
                            enabled: false

                            TableViewColumn {
                                role: "Username"
                                title: "User Name"
                                width: chngdUsrGrpList.width / 3
                                resizable: false
                                movable: false
                                delegate: Component {
                               //     id: statusdelegate
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
                                title: "Status"
                                width: chngdUsrGrpList.width / 3
                                resizable: false
                                movable: false
                                delegate: Component {
                             //       id: statusdelegate

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
//----------------------------------------------------------------------------------------------------------
                            TableViewColumn {
                                role: "ChExpiryDate"
                                title: "Expiry Date"
                                width: chngdUsrGrpList.width / 3
                                resizable: false
                                movable: false
                                delegate: Component {

                                    Text {
                                        color: "Black"
                                        elide: styleData.elideMode
                                        text: styleData.value
                                        font.family: "Arial"
                                        font.pixelSize: 30
                                    }
                                }

                            }
//--------------------------------------------------------------------------------------------------------------
                            model: ListModel {
                                id: chngdUsrGrpmodel

                                ListElement { Username: ""
                                    Status:""
                                    ChExpiryDate:""
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
                                    font.pixelSize: 30
                                }
                            }

                            onCurrentRowChanged: {savetextfield.disableScreen("RT");console.log(chngdUsrGrpmodel.get(__currentRow).Username)}

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
//                                    Label{
//                                        anchors.centerIn: parent
//                                        text: "Cancel"
//                                        font.pixelSize: 20
//                                    }
//                                    isDefault: true
//                                    focus: true
//                                    width: 150
//                                    height: 80
//                                    onClicked:{blckUnblckDialog.close(); usrBlckUnblckButton.active = false;usrBlckUnblckButton.enabled = true;UIStyle.scrEnabled = "0";usrBlckUnblckButton.passStatus("0");usrBlckUnblckmodel.clear({Username:""})
//                                        usrBlckUnblckmodel.clear({Status:""})
//                                        chngdUsrGrpmodel.clear({Username:""})
//                                        chngdUsrGrpmodel.clear({Status:""})}
//                                }
            }

        }

    }

    Dialog {
            id: chngPassDialog
            width: inputPanelChngPass.width + 200
            height: inputPanelChngPass.height + 100
            x:-800
            y: 10
            title:  "Change User Password Window"
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
                           text: "Change User Password Window"
                           font.pixelSize: 40
                           color: "black"
                       }
                   }
        contentItem: FocusScope{

            Column {
                id: chngPasscolumn
                spacing: 20
                Row{
                    spacing: 90
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USER NAME     ";color:UIStyle.colorQtGray1;}
                //    Label{id:usernmlbl;Rectangle{}}
                    Rectangle{width: 300;height: 60;color: "white";border.color: "aquamarine";radius: 5;Label{id:usernmlbl;anchors.centerIn: parent;font.pixelSize: 20; text:adminName}}

                }
                Row{
                    spacing: 60
           //         Label{font.pixelSize:UIStyle.fontSizeXXL;text:"OLD PASSWORD ";color:UIStyle.colorQtGray1}
           //        TextField{id:oldPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:cnfPassword.focus = true;width: 300;height: 60;onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0;wrnpass.text = ""}else{/*newPassEmpty = 1*/}} onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900;if(focus){if(cnfPassEmpty == 1){wrnOldpass.text = "(Field is Empty!!)"};if(aceptInput == true){newPassEmpty = 0;wrnOldpass.text = ""}else{newPassEmpty = 1}; toolTipdialogueC.visible = true;/*chngPassDialog.width = toolTipdialogueC.width+200*/}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
                   Label{id:wrnOldpass;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }

                Row{
                    spacing: 50
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:" NEW PASSWORD";color:UIStyle.colorQtGray1}
                   TextField{id:newPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900}width: 300;height: 60;onTextChanged: {savetextfield.disableScreen("RT")}}
                   Label{id:wrnNewpass;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 50
                    Rectangle{
                        id:toolTipdialogueC
                        visible: false
                        border.color: "Red"
                        border.width: 2
                        width: toolTiplblC.contentWidth;height: UIStyle.prdParamHeight
                        Label{id:toolTiplblC;anchors.centerIn: parent; font.pixelSize:UIStyle.fontSizeM;text:"*Use atleast 6 characters. It must contain Uppercase,Lowercase,Special character and Digit.";color:UIStyle.colorCandyPink}

                    }
                }
                Row{
                    spacing: 20
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:" CONFIRM PASSWORD";color:UIStyle.colorQtGray1}
                   TextField{id:cnfPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900}width: 300;height:60;onTextChanged: {savetextfield.disableScreen("RT")}}
                   Label{id:wrnCnfpassC;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 25
                Label{text: "Expire on:";font.pixelSize: 30;color: "red"}
                Label{id:expiryLbl;text:"";font.pixelSize: 30;color: "red"}
                }
                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPanelChngPass
                        visible: false
                        z: 89
                        width: 1200
                        y: Qt.inputMethod.visible ?  300 :parent.height

                    }
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
          //      Row{
          //          spacing: 20
                    Button{
                        id:calendarbtn
                      Label{
                            anchors.centerIn: parent
                            text: "Expiry Days"
                            font.pixelSize: 20
                        }
                       isDefault: true
                       focus: true
                        width: 150
                       height: 80

    //                   onClicked: {UIStyle.scrEnabled = "0";addNewUsrDialog.close();addNewUserButton.active = false;addNewUserButton.passStatus("0")}
                       onClicked: {savetextfield.disableScreen("RT");calendarDialog.open();console.log("the rtc is:"+calendar_date);console.log("first:"+min_date[0]);cal_min_date = parseInt(min_date[1]) - 1;console.log("second:"+cal_min_date); max_date = parseInt(min_date[2]); max_date = max_date + 1; console.log("third:"+max_date)}
                    }

                    Button{
                        id:userEntryOkBtn
                        Label{
                            anchors.centerIn: parent
                            text: "OK"
                            font.pixelSize: 20
                        }
                         isDefault: true
                            focus: true
                            width: 150
                         height: 80
                         enabled: false
                         onClicked:{savetextfield.disableScreen("RT");chngPassDialog.close();if(newPass == cnfPass){chkPwdComplexity(newPass)};if(pwdValidatefg == "1"){
                                                      savetextfield.next(adminName);if((newPass == cnfPass) && (UIStyle.oldPass != newPass)){savetextfield.submittFileParamOTP(adminName,newPass);
                                                          if(UIStyle.fileNameExist != "Exist"){ chngUsrOkDialog.open();savetextfield.remove(adminName);savetextfield.submittFileParam(adminName,newPass);savetextfield.createLoginNames("Group",adminName,user_expiry_days);savetextfield.statusFile(adminName,"Inactive",user_expiry_days);expiryLbl.text = ""}
                                                          else{userFailTxt = "You can't use this password";chngUsrFailDialog.open();UIStyle.fileNameExist = ""}}
                                                      else{UIStyle.oldPass = "";newPass = "";cnfPass = "";if(UIStyle.oldPass == newPass){userFailTxt = "Use another Password"; chngUsrFailDialog.open()}
                                     else if(cnfPass != newPass)
				     {
				     userFailTxt = "Check New & confirm password";
				      chngUsrFailDialog.open()}}}
				      else{UIStyle.oldPass = "";newPass = "";cnfPass = "";
				      userFailTxt = "Check Password Complexity"; 
				      chngUsrFailDialog.open()}}

//                             chngPassDialog.close();savetextfield.remove(adminName);savetextfield.removeFromOTP(adminName);chkPwdComplexity(newPass);
//                                                     if(pwdValidatefg == "1"){savetextfield.next(adminName); if(((newPass == UIStyle.oldPass) && (newPass == cnfPass) && (adminName == UIStyle.oldUserName)) | (adminName == UIStyle.oldUserName)){existUsrOkDialog.open()}else{savetextfield.submittFileParam(adminName,newPass);savetextfield.createLoginNames(adminNameGroup,adminName,newPass)/*;model.append({listLoginNames:adminName})*/;chngUsrOkDialog.open()}}
//                                                     else{pwdFailDialog.open()}

                       }
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
                         onClicked: {savetextfield.disableScreen("RT");chngPassDialog.close();UIStyle.scrEnabled = "0";usrBlckUnblckButton.enabled = true;usrBlckUnblckButton.active = false;usrBlckUnblckListView.selection.clear();usrBlckUnblckButton.passStatus("0");expiryLbl.text = ""}
                    }

            //     }


             }

         }

    }

    Dialog {
        id: calendarDialog
        visible: false
        width: calendarTable.width + 200
//        width: 500
        height: calendarTable.height + 200
        x:100
        y:200
        //            standardButtons: StandardButton.Ok
        //            title:  "Password Fail Window!!!"
        closePolicy: Popup.CloseOnEscape
        background: Rectangle{
            color: "aquamarine"
            radius: 5
            border.color: "mediumturquoise"
        }

        header: Rectangle{
//            width:calendarTable.width
            width: 500
            height: 50
            color: "mediumturquoise"
            border.color: "aquamarine"
            radius: 5
            Text{
                anchors.centerIn: parent
                text: "CALENDAR"
                font.pixelSize: 30
                color: "black"
            }
        }
        contentItem: FocusScope{
            Column {
                id: calendarColumn
                spacing: 20
                Row{
                    spacing: 20
                    //                    Label{id:pwdFail;font.pixelSize:UIStyle.fontSizeXXL;text:":Password went wrong!!!!";color:UIStyle.colorQtblk}


                    Calendar{
                        id:calendarTable
                        visible: true
                        width: 600
                        height: 500
                        minimumDate: new Date(min_date[2], cal_min_date, min_date[0])
                        maximumDate: new Date(max_date, cal_min_date, min_date[0])

                        style: CalendarStyle {
                            gridVisible: false
                            dayDelegate: Rectangle {
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.00
                                        color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");

                                    }
                                    GradientStop {
                                        position: 1.00
                                        color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");

                                    }
                                    GradientStop {
                                        position: 1.00
                                        color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");

                                    }
                                }

                                Label {
                                    text: styleData.date.getDate()
                                    anchors.centerIn: parent
                                    color: styleData.valid ? "white" : "yellow"
                                    font.pixelSize: 20
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "#555"
                                    anchors.bottom: parent.bottom
                                }

                                Rectangle {
                                    width: 1
                                    height: parent.height
                                    color: "#555"
                                    anchors.right: parent.right
                                }
                            }

                            dayOfWeekDelegate: Component{
                                Rectangle {
                                    //     color: gridVisible ? "#fcfcfc" : "transparent"
                                    color: gridVisible ? "stealblue" : "yellow"
                                    implicitHeight: Math.round(TextSingleton.implicitHeight * 2.25)
                                    Label {
                                        text: control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
                                        anchors.centerIn: parent
                                        font.pixelSize: 30
                                    }
                                }
                            }

                            navigationBar: Component{
                                Rectangle {
                                    height:70           // Math.round(TextSingleton.implicitHeight * 2.73)
                                    //       color: "#f9f9f9"
                                    color: "peru"

                                    Rectangle {
                                        color: Qt.rgba(1,1,1,0.6)
                                        height: 1
                                        width: parent.width
                                    }

                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        height: 1
                                        width: parent.width
                                        //      color: "#ddd"
                                        color: "blue"
                                    }
                                    HoverButton {
                                        id: previousMonth
                                        width: parent.height*2
                                        height: width
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        source:  "/images/reverse_1.png"
                                        onClicked: control.showPreviousMonth()
                                    }

                                    Label {
                                        id: dateText
                                        text: styleData.title
                                        elide: Text.ElideRight
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 30      //TextSingleton.implicitHeight * 1.25
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: previousMonth.right
                                        anchors.leftMargin: 2
                                        anchors.right: nextMonth.left
                                        anchors.rightMargin: 2
                                        color: "brown"

                                    }
                                    HoverButton {
                                        id: nextMonth
                                        width: parent.height*2
                                        height: width
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        source: "/images/forward_1.png"
                                        onClicked: control.showNextMonth()
                                    }
                                }

                            }

                        }

//                        onClicked:{ console.log("The current date is:"+selectedDate)

//                            console.log("The current date is:"+Qt.locale().standaloneDayName(calendarTable.selectedDate.getDay())+ calendarTable.selectedDate.toLocaleDateString(Qt.locale(), " yyyy","mm"))
//                            console.log("The current date is:"+calendarTable.selectedDate.toLocaleDateString(Qt.locale(), " yyyy","mm"))
//                        }
                    }

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
                    onClicked:{savetextfield.disableScreen("RT");
                        console.log("The date is:"+(calendarTable.selectedDate.getDate()+"/"+(calendarTable.selectedDate.getMonth() + 1)+"/"+calendarTable.selectedDate.getFullYear()))
                        /*expiryLbl.text = calendarTable.selectedDate.toLocaleDateString(Qt.locale(), "yyyy","mm");*/

                        if(calendarTable.selectedDate.getDate() <= "9")
                        {
                            expiryLbl.text = "0"+calendarTable.selectedDate.getDate();
                        }
                        else
                        {
                            expiryLbl.text = calendarTable.selectedDate.getDate();
                        }

                        if(calendarTable.selectedDate.getMonth() <= "9")
                        {
                            expiryLbl.text = expiryLbl.text+"/0"+(calendarTable.selectedDate.getMonth()+1);
                        }
                        else
                        {
                            expiryLbl.text = expiryLbl.text+"/"+(calendarTable.selectedDate.getMonth()+1);
                        }
                         expiryLbl.text = expiryLbl.text+"/"+calendarTable.selectedDate.getFullYear();

//                        expiryLbl.text = (calendarTable.selectedDate.getDate()+"/"+(calendarTable.selectedDate.getMonth() + 1)+"/"+calendarTable.selectedDate.getFullYear());
                        user_expiry_days = expiryLbl.text
                        calendarDialog.close()
                       if(expiryLbl.text !=""){userEntryOkBtn.enabled = true}else{userEntryOkBtn.enabled = false}
                    }
                }


            }

            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
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
                    onClicked:{savetextfield.disableScreen("RT");calendarDialog.close()

                    }
                }

            }

        }
    }

    Dialog {
            id: existUsrOkDialog
            visible: false
            height: 300
            width: warmMsg5.contentWidth + 200
  //          standardButtons: StandardButton.Ok
            title:  "Add User Window!!!"
         contentItem: FocusScope{
            Column {
                id: existUsrOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg5;font.pixelSize:UIStyle.fontSizeM;text:"User already exist!!!!";color:UIStyle.colorQtblk}
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
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
                    onClicked:{savetextfield.disableScreen("RT");existUsrOkDialog.close()}
                }
             }

         }

    }

//    Dialog {
//            id: chngUsrOkDialog
//            visible: false
//            height: 300
//            width: warmMsg7.contentWidth + 200
//    //        standardButtons: StandardButton.Ok
//            title:  "Password Change Window!!!"
//        contentItem: FocusScope{
//            Column {
//                id: chngUsrOkColumn
//                spacing: 20
//                Row{
//                    spacing: 20
//                    Label{id:warmMsg7;font.pixelSize:UIStyle.fontSizeXXL;text:adminName + ":Password change Successfully!!!!";color:UIStyle.colorQtblk}
//                }
//            }

//            Column{
//                spacing: 50
//                anchors.bottom: parent.bottom
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//                anchors.bottomMargin: 20
//                 Button{
//                     Label{
//                         anchors.centerIn: parent
//                         text: "OK"
//                         font.pixelSize: 20
//                     }
//                    isDefault: true
//                    focus: true
//                     width: 150
//                    height: 80
//                    onClicked:{chngUsrOkDialog.close();}
//                }
//             }

//         }

//    }

    Dialog {
            id: chngUsrOkDialog
            visible: false
            height: 300
            x:-800
            y:100
            width: warmMsg7.contentWidth + 200
   //         title:  "Password Change Window!!!"
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
                           text: "Password Change Window!!!"
                           font.pixelSize: 20
                           color: "black"
                       }
                   }
        contentItem: FocusScope{
            Column {
                id: chngUsrOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg7;font.pixelSize:UIStyle.fontSizeXXL;text:adminName + ":Password change Successfully!!!!";color:UIStyle.colorQtblk}
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
                    onClicked:{savetextfield.disableScreen("RT");UIStyle.scrEnabled = "0";chngUsrOkDialog.close();usrBlckUnblckListView.selection.clear();loadUserStatus(); chngdUsrGrpmodel.append({Username:adminName,Status:"Inactive",ChExpiryDate:user_expiry_days});unblckBtn.enabled = false;blckBtn.enabled = false; removeBtn.enabled = false;blckUnblckDialog.open()}
                }
             }

         }
    }

    function chkPwdComplexity(pwdTemp){
        for (var i=0;i<pwdTemp.length;i++)
            {
            console.log("the character is:"+pwdTemp[i])
            //    if ((splChrs.match(pwdTemp[i])) && (splChrsfg !="1")){
                  if ((splChrs.indexOf(pwdTemp[i]) >= 0) && (splChrsfg !="1")){
                    splChrsfg = "1"
                    console.log("spl chars ok")
                }
          //       if ((numChrs.match(pwdTemp[i])) && (numChrsfg != "1")){
                 if ((numChrs.indexOf(pwdTemp[i]) >= 0) && (numChrsfg != "1")){
                     numChrsfg = "1"
                    console.log("Num chars ok")
                 }
          //       if ((upperChrs.match(pwdTemp[i])) && (upperChrsfg != "1")){
                 if ((upperChrs.indexOf(pwdTemp[i]) >= 0) && (upperChrsfg != "1")){
                     upperChrsfg = "1"
                    console.log("Upper chars ok")
                 }
          //       if ((lowerChrs.match(pwdTemp[i])) && (lowerChrsfg != "1")){
                 if ((lowerChrs.indexOf(pwdTemp[i]) >= 0) && (lowerChrsfg != "1")){
                     lowerChrsfg = "1"
                    console.log("Lower chars ok")
                 }
        }

        if((splChrsfg == "1") && (numChrsfg == "1") && (upperChrsfg == "1") && (lowerChrsfg == "1") && (pwdTemp.length >= 6)){
            splChrsfg = "0";numChrsfg = "0";upperChrsfg = "0";lowerChrsfg = "0";
            pwdValidatefg = "1"
                console.log("Password entry is valid")
        }
        else{
            pwdValidatefg = "0"
            console.log("Password entry is Invalid")
        }

    }

    Dialog {
            id: pwdFailDialog
            visible: false
             width: pwdFail.contentWidth + 200
            height: 300
//            standardButtons: StandardButton.Ok
            title:  "Password Fail Window!!!"
    contentItem: FocusScope{
            Column {
                id: pwdFailColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:pwdFail;font.pixelSize:UIStyle.fontSizeXXL;text:":Password went wrong!!!!";color:UIStyle.colorQtblk}
                }
            }

            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
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
                    onClicked:{savetextfield.disableScreen("RT");pwdFailDialog.close();chngPassDialog.open();userEntryOkBtn.enabled = false}
                }
             }

         }

    }
    Dialog {
            id: chngUsrFailDialog
            visible: false
            height: 300
            width:pwdWrong.contentWidth + 200
 //           title:  "Password Change Window!!!"
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
                           text: "Password Change Window!!!"
                           font.pixelSize: 20
                           color: "black"
                       }
                   }

        contentItem: FocusScope{
            Column {
                id: chngUsrFailColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:pwdWrong;font.pixelSize:UIStyle.fontSizeXXL;text:userFailTxt;color:UIStyle.colorQtblk}
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
                    onClicked:{savetextfield.disableScreen("RT");UIStyle.scrEnabled = "0";chngUsrFailDialog.close();chngPassDialog.open();userEntryOkBtn.enabled = false}
                }
             }

         }


    }



}


