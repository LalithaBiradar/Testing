
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
    id: addNewUserButton
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
    property string adminPass: ""
   // property alias oldPass: oldPassword.text
   // property alias newPass: newPassword.text
    //property alias cnfPass: cnfPassword.text
    property alias addNewUserPass: addNewUsrPassword.text
    property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: ""
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

    property int newPassEmpty
    property int cnfPassEmpty
    property int oldPassEmpty
    property int entryCnt

    property string calendar_date: ""
    property variant min_date: calendar_date.split('/')
    property string cal_min_date: ""
    property variant max_date
    property string user_expiry_days: ""



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
        text: "ADD NEW\nUSER"
        color: "white"
        font.pointSize: 25
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(addNewUserButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(addNewUserButton.width * 0.866 * dummyOff.scale)
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
                         addNewUserButton.active = !addNewUserButton.active
                         pulseAnim.running = true
                    if(addNewUserButton.active == true){
                        addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = ""
                        addNewUserButton.passStatus("1")
                        savetextfield.disableScreen("RT")
                        toolTipdialogue.visible = false
                        UIStyle.scrEnabled = "1"
                        userEntryOkBtn.enabled = true
                        expiryLbl.text = ""

                        addNewUsrDialog.open()
                        console.log("add new user dialogue open!!!")
                        dummytext.text = "ADD NEW\nUSER"

                    }
                    else{
                        dummytext.text = "ADD NEW\nUSER"
                    }
                }
                onPressAndHold:
                    addNewUserButton.pressAndHold()

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
        onStopped: { addNewUserButton.clicked() }
    }

    Connections{
        target: savetextfield
       onClDialogue:{
            console.log("close dialogue after timer end")
           if(text == "1"){
            addNewUsrDialog.close()
            existUsrOkDialog.close()
            addUsrOkDialog.close()
            messageDialog.close()
            calendarDialog.close()
            pwdFailDialog.close()
            addNewUserButton.active = false;passStatus("0")
           }

        }
    }

    function chkPwdComplexity(pwdTemp){
        console.log("password checking:"+pwdTemp)
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
            id: existUsrOkDialog
            visible: false
            height: 300
            width: warmMsg5.contentWidth + 200
  //          standardButtons: StandardButton.Ok
  //          title:  "Add User Window!!!"
            closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:warmMsg5.contentWidth + 200
                height: 60
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "Add User Window"
                    font.pixelSize: 30
                    color: "black"
                }
            }
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
                    onClicked:{savetextfield.disableScreen("RT");existUsrOkDialog.close();addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}
                }
             }

         }


    //        onAccepted: {addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}
    }

    Dialog {
            id: addUsrOkDialog
            visible: false
            height: 300
            width: warmMsg6.contentWidth + 200
  //          standardButtons: StandardButton.Ok
  //          title:  "Add User Window!!!"
            closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:warmMsg6.contentWidth + 200
                height: 100
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "Add User Window"
                    font.pixelSize: 40
                    color: "black"
                }

            }
        contentItem: FocusScope{
            Column {
                id: addUsrOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg6;
                        font.pixelSize:UIStyle.fontSizeXXL;
                        text:"User added successfully!!!!";
                        color:UIStyle.colorQtblk}
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
                    onClicked:{savetextfield.disableScreen("RT");
                        addUsrOkDialog.close();
                        userEntryOkBtn.enabled = true;
                        addNewUserPass = "";
                        addNewCnfmPass = "";
                        adminName = "";
                        newUserName.text = "";
                        expiryLbl.text = "";
                        addNewUserButton.active=false;addNewUserButton.passStatus("0")}//HAHA addNewUsrDialog.open()}
                }
             }

         }

    }




    Dialog {
            id: addNewUsrDialog

//            title:  "New User Entry Window"
             width: inputPaneladdnewusr.width + 250
             height: inputPaneladdnewusr.height + 100
             x:-300
             y:40
             closePolicy: Popup.CloseOnEscape
             background: Rectangle{
                 color: "aquamarine"
                 radius: 5
                 border.color: "mediumturquoise"
             }

             header: Rectangle{
                 width:inputPaneladdnewusr.width
                 height: 100
                 color: "mediumturquoise"
                 border.color: "aquamarine"
                 radius: 5
                 Text{
                     anchors.centerIn: parent
                     text: "New User Entry Window"
                     font.pixelSize: 40
                     color: "black"
                 }
                 Image {
                       id: addNewUsrIcon
                       anchors.left: parent.left
                       width: 150
                       height: 100
                       source: "/images/new_usr.jpeg"
                 }
             }

        contentItem: FocusScope{
            Column {
                id: addNewUsrcolumn
                spacing: 20
                Row{
                    spacing: 80
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"GROUP NAME";color:UIStyle.colorQtGray1}
                    ComboBox {
                        width: 300;height: 60
                  //      currentIndex:0
                        model: ListModel {
                            id: addNewUsrmodel
                            ListElement { text: "Admin"}
                            ListElement { text: "Operator"}
                            ListElement { text: "Supervisor"}
                            ListElement { text: "Manager"}
                            ListElement { text: "Engineer"}
                        }


                        style: ComboBoxStyle {
                                                            id: comboBoxStyle
                                                            background: Rectangle {
                                                                id: rect
                                                                border.color: "green"
                                                                color: "white"
                                                            }
                                                            label: Text {
                                                                           verticalAlignment: Text.AlignVCenter
                                                                           horizontalAlignment: Text.AlignHCenter
                                                                            color: "black"
                                                                            text: control.currentText
                                                                            font.pointSize: 18
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
                                                                               font.pointSize: 18
                                                                           }
                                                                       }
                                                }


                        onCurrentIndexChanged:{savetextfield.disableScreen("RT");adminNameGroup = addNewUsrmodel.get(currentIndex).text;if(adminNameGroup == "Admin"){expiryText.visible = false;calendarbtn.visible = false;userEntryOkBtn.enabled = true;console.log("TTTTTadminNameGroup:"+adminNameGroup)}else{expiryText.visible = true;expiryLbl.text = "";calendarbtn.visible = true;userEntryOkBtn.enabled = false} console.log("adminNameGroup:"+adminNameGroup)}


                   }


                }
                Row{
                    spacing: 120
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USERNAME";color:UIStyle.colorQtGray1}
                   TextField{id:newUserName; previewText: "";enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 600;height: 60;onFocusChanged: {inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 20;addNewUsrDialog.height = 970}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {adminName = newUserName.text;savetextfield.disableScreen("RT") }}
                }
                Row{
                    spacing: 120
                    Label{id:passTooltip;
		     font.pixelSize:UIStyle.fontSizeXXL
		     text:"PASSWORD";
		     color:UIStyle.colorQtGray1 }
                   TextField{id:addNewUsrPassword; previewText: "";echoMode: TextInput.Password;enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:addNewCnfPassword.focus = true;width: 600;height: 60;
                       onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0;wrnpass.text = ""}else{/*newPassEmpty = 1*/}}
                       onFocusChanged: {inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 20;addNewUsrDialog.height = 970; if(focus){console.log("New password focussed");if(cnfPassEmpty == 1){wrncnfpass.text = "(Field is Empty!!)";console.log("Confirm Password is empty")};
                               if(aceptInput == true){oldPassEmpty = 0;wrnpass.text = ""}else{console.log("New password is empty"); newPassEmpty = 1}; toolTipdialogue.visible = true;addNewUsrDialog.width = inputPaneladdnewusr.width + 250}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {adminPass = addNewUserPass;savetextfield.disableScreen("RT")} }
                    Label{id:wrnpass;font.pixelSize:UIStyle.fontSizeXXL;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 95
                    Rectangle{
                        id:toolTipdialogue
                        visible: false
                        border.color: "Red"
                        border.width: 2
                        width: toolTiplbl.contentWidth;height: 100// UIStyle.prdParamHeight
                        Label{id:toolTiplbl;anchors.centerIn: parent; font.pixelSize:UIStyle.fontSizeXXL;text:"*Use atleast 6 characters. It must contain Uppercase,Lowercase,\nSpecial character and Digit.";color:UIStyle.colorCandyPink}

                    }
                }
                Row{
                    spacing: 20
                    Label{id:cnfpassl;font.pixelSize:UIStyle.fontSizeXXL;text:" CONFIRM PASSWORD";color:UIStyle.colorQtGray1}
                    TextField{id:addNewCnfPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 600;height: 60;onAceptInputChanged:{ if(aceptInput == true){console.log("cnf pass enetered"); wrncnfpass.text = "";cnfPassEmpty = 0}
                            else{/*cnfPassEmpty = 1*/}}onFocusChanged:{inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 20;addNewUsrDialog.height = 970;if(focus){console.log("Cnf password is focussed");
                                if(newPassEmpty == 1){wrnpass.text = "(Field is Empty!!)"; console.log("New Password is empty")}; if(addNewCnfPassword.text.length > 0){cnfPassEmpty = 0;wrncnfpass.text = "";console.log("Cnf password is entered")}else{cnfPassEmpty = 1;console.log("Here Cnf password is empty")}}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
                    Label{id:wrncnfpass;font.pixelSize:UIStyle.fontSizeXXL;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 20
                    Label{id:warnmsg5;visible: false;font.pixelSize:UIStyle.fontSizeXXL;text:"User is already Exist!!!!";color:UIStyle.colorQtGray1}
                    Label{id:warnmsg6;visible: false;font.pixelSize:UIStyle.fontSizeXXL;text:"User added successfully!!!!";color:UIStyle.colorQtGray1}
                }
                Row{
                    spacing: 25
                Label{id:expiryText; text: "Expire on:";font.pixelSize: 30;color: "red"}
                Label{id:expiryLbl;text:"";font.pixelSize: 30;color: "red"}
                }
                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPaneladdnewusr
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
 //             Row{
 //                 spacing: 30

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
               //     text: "OK"
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
                    onClicked:{savetextfield.disableScreen("RT");addNewUsrDialog.close();console.log("admingroup name is:"+adminNameGroup);if((numChrs.indexOf(adminName.charAt(0)) >= 0) |(splChrs.indexOf(adminName.charAt(0)) >= 0)){messageDialog.open();}else{savetextfield.next(adminName);if(addNewUserPass == addNewCnfmPass){chkPwdComplexity(addNewUserPass)}else{pwdFailDialog.open()};
                        if(pwdValidatefg == "1"){ if(((addNewUserPass == UIStyle.oldPass) && (addNewUserPass == addNewCnfmPass) && (adminName == UIStyle.oldUserName)) | (adminName == UIStyle.oldUserName)){existUsrOkDialog.open()}else{savetextfield.submittFileParam(adminName,adminPass);
                                if(adminNameGroup == "Admin"){/*savetextfield.createLoginNames(adminNameGroup,adminName,"Live")*/savetextfield.addNewUser(adminNameGroup,adminName,"Live")}else{/*savetextfield.createLoginNames(adminNameGroup,adminName,user_expiry_days)*/savetextfield.addNewUser(adminNameGroup,adminName,user_expiry_days)}addUsrOkDialog.open()}}
                        else{pwdFailDialog.open()}} }
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
                    onClicked: {savetextfield.disableScreen("RT");UIStyle.scrEnabled = "0";addNewUsrDialog.close();addNewUserButton.active = false;addNewUserButton.passStatus("0")}
                 }

  //            }
             }

         }

    }
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
                id: messageDialogColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg8;font.pixelSize:UIStyle.fontSizeXXL;text: "Warning ->Use character at starting!!\nDon't use number or special character at first.";color:UIStyle.colorQtblk}
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
                   onClicked:{savetextfield.disableScreen("RT");messageDialog.close(); UIStyle.scrEnabled = "0";adminName = "";newUserName.text = ""; addNewUsrDialog.open()}
               }


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
                               //         color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                                        color: styleData.selected ? "green" : (styleData.visibleMonth && styleData.valid ? "444" : "#green");

                                    }
                                    GradientStop {
                                        position: 1.00
                                 //       color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                        color: styleData.selected ? "green" : (styleData.visibleMonth && styleData.valid ? "111" : "#green");

                                    }
                                    GradientStop {
                                        position: 1.00
                                 //       color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                        color: styleData.selected ? "green" : (styleData.visibleMonth && styleData.valid ? "111" : "#green");

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
//                        expiryLbl.text = (calendarTable.selectedDate.getDate()+"/"+(calendarTable.selectedDate.getMonth() + 1)+"/"+calendarTable.selectedDate.getFullYear());
//                        user_expiry_days = expiryLbl.text

                        if(calendarTable.selectedDate.getDate() <= "9")
                        {
                            expiryLbl.text = "0"+calendarTable.selectedDate.getDate();
                        }
                        else
                        {
                            expiryLbl.text = calendarTable.selectedDate.getDate();
                        }

                        if(calendarTable.selectedDate.getMonth() <= "8")
                        {
                            expiryLbl.text = expiryLbl.text+"/0"+(calendarTable.selectedDate.getMonth()+1);
                        }
                        else
                        {
                            expiryLbl.text = expiryLbl.text+"/"+(calendarTable.selectedDate.getMonth()+1);
                        }
                        expiryLbl.text = expiryLbl.text+"/"+calendarTable.selectedDate.getFullYear();
                         user_expiry_days = expiryLbl.text;

                        console.log("TTTTTT-"+user_expiry_days);
                        calendarDialog.close()
                       if(expiryLbl.text !==""){userEntryOkBtn.enabled = true}else{userEntryOkBtn.enabled = false}
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
            id: pwdFailDialog
            visible: false
             width: pwdFail.contentWidth + 200
            height: 400
//            standardButtons: StandardButton.Ok
//            title:  "Password Fail Window!!!"
            closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:pwdFail.width
                height: 100
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "Password Fail Window"
                    font.pixelSize: 40
                    color: "black"
                }
            }
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
                    onClicked:{pwdFailDialog.close();addNewUsrDialog.open();pwdValidatefg = "0"}
                }
             }

         }


    }


}


