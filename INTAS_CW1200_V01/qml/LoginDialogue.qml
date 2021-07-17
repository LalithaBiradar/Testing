
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
    id: loginButton
    width: 220      //150
    height: 80      // Math.round(width * 0.866)
    property bool active: false
    property bool scrEnable: false
    property alias color: dummyOff.color
    property alias color1: dummyOn.color
    property alias text: dummytext.text
    property alias textcolor: dummytext.color
    property alias fontsize: dummytext.font.pointSize
    signal clicked()
    signal pressAndHold()
    signal passName(string text)
    signal passStatus(string text)
//    signal connect()

    property alias adminName: userName.text
    property alias adminPass: password.text
    property alias oldPass: oldPassword.text
    property alias newPass: newPassword.text
    property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
  //  property string adminNameGroup: "test"
    property alias loginLblGrpName: loginLblGrpNm.text
    property alias loginLblName: loginLblNm.text
 //   property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"

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

    property alias userFailTxt: pwdWrong.text

    property string current_date: ""
    property variant cur_date: current_date.split('/')
    property string user_expiry_date: ""
    property variant usr_exp_date: user_expiry_date.split('/')
    property string daychkfg : "0"
    property string monthchkfg : "0"
    property string yearchkfg : "0"

    property string passadminName: ""


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
        text: "Login"
        color: "white"
        font.pointSize: 30
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(loginButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(loginButton.width * 0.866 * dummyOff.scale)
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
                    if(loginButton.active == false){
                        pulseAnim.running = true
                        adminName = "";adminPass = "";
                        loginButton.enabled = false
                        savetextfield.disableScreen("RT")
                        loginLblGrpName = ""
                        loginLblName = ""
                        UIStyle.oldUserName = "";
                        UIStyle.oldPass = "";
                        UIStyle.expiry_Days = "";
                        loginDialog.open()
            //            adminName = "Administrator"
            //           adminPass = "tepl"
                        console.log("login dialogue open!!!")

                    }

                    else if(loginButton.active == true){
                        savetextfield.disableScreen("RT")
                        logoutOkDialog.open()
                        UIStyle.scrEnabled = "1"
                        if(scrEnable == true){
               //             savetextfield.disableScreen1("1")
                        }
                        console.log("logout dialogue open!!!")
                    }
                }
                onPressAndHold:
                    loginButton.pressAndHold()

            }
        }
    }
    SequentialAnimation {
        id: pulseAnim
        running: false
        loops: 1
        PropertyAnimation { target: dummyOff; property: "scale"; from: 1.0; to: 1.2; duration: 100; }
        PropertyAnimation { target: dummyOff; property: "scale"; from: 1.2; to: 1.0; duration: 100; }
        PropertyAnimation { target: dummyOn; property: "scale"; from: 1.0; to: 1.2; duration: 100; }
        PropertyAnimation { target: dummyOn; property: "scale"; from: 1.2; to: 1.0; duration: 100; }
        PropertyAnimation { target: dummytext; property: "scale"; from: 1.0; to: 1.2; duration: 100; }
        PropertyAnimation { target: dummytext; property: "scale"; from: 1.2; to: 1.0; duration: 100; }

        // The stopped() signal is emitted when animation ends. It is only triggered for top-level,
        // standalone animations. It will not be triggered for animations in a Behavior or Transition,
        // or animations that are part of an animation group.
        onStopped: { loginButton.clicked() }
    }


    Connections{
        target: savetextfield
        onDisablescr:{
                    console.log("fitnesspage open")
            scrEnable = true
        }

        onPrevilage_status:{
//            previlageStatus = text
            UIStyle.prdName = text
            console.log("The status from cpp is:"+UIStyle.prdName)

        }
        onClDialogue:{
             //console.log("close dialogue after timer end")
            if(text == "1"){
                loginDialog.close()
                loginOkDialog.close()
                logoutOkDialog.close()
                loginFailDialog.close()
                chngPassDialog.close()
                chngUsrFailDialog.close()
                chngUsrOkDialog.close()
                userExpiredDialog.close()
                userBlockedDialog.close()
                loginButton.enabled = true;loginDialog.close();transparentDialogue.close(); loginButton.active = false;

            }

         }
    }


    function chkexpiry(){
        daychkfg = "0";monthchkfg = "0";yearchkfg = "0"
        console.log("the current date is:"+UIStyle.current_date)
         console.log("the expiry date is:"+UIStyle.expiry_Days)
       current_date = UIStyle.current_date
       user_expiry_date = UIStyle.expiry_Days

        if(user_expiry_date != "Live")
        {
            if(cur_date[2]<=usr_exp_date[2]){
                console.log("year checking")
                yearchkfg = "1"
                if(cur_date[1]<=usr_exp_date[1]){
                    console.log("month checking")
                    monthchkfg = "1"
                    if(cur_date[0]>=usr_exp_date[0]){
                        //console.log("day checking")
                        // daychkfg = "1"
                          daychkfg = "0"

                     if(cur_date[1]===usr_exp_date[1])
                     {
                        if(cur_date[0]<usr_exp_date[0])
                         {
                            console.log("day checking")
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
                                console.log("day checking")
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


    Dialog {
            id: logoutOkDialog
            width: warmMsg8.contentWidth + 200
            height: 400
            x:10
            y:100
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
                           text: "LOGOUT WINDOW!"
                           font.pixelSize: 40
                           color: "black"
                       }
                       Image {
                             id: logoutIcon
                             anchors.left: parent.left
                             width: 150
                             height: 100
                             source: "/images/logout.jpeg"
                       }

                   }
         contentItem: FocusScope{
            Column {
                id: logoutOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{
                        id:warmMsg8;
                        font.pixelSize:UIStyle.fontSizeXXL;
                        text: loginLblGrpName + " : " + loginLblName +" press OK to LOG OUT";/*" is logged out.";*/
                        color:UIStyle.colorQtblk
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
                    Label{
                        anchors.centerIn: parent
                        text: "Cancel"
                        font.pixelSize: 20
                    }
                   isDefault: true
                   focus: true
                    width: 150
                   height: 80
            //       onClicked:{savetextfield.disableScreen("RT");loginButton.enabled = true;logoutOkDialog.close();UIStyle.scrEnabled = "0"}
                   onClicked:{/*savetextfield.disableScreen("RT");*/loginButton.enabled = true;logoutOkDialog.close();UIStyle.scrEnabled = "0"}
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
                    onClicked:{UIStyle.idleforfg = false;savetextfield.disableScreen("RT");loginButton.enabled = true;savetextfield.logout(loginLblName); loginButton.active = false;dummytext.text = "Login";logoutOkDialog.close();
                        loginButton.passName(""); loginLblGrpName = "";loginLblName = "";loginButton.passStatus("0");UIStyle.scrEnabled = "1";savetextfield.disableScreen1("1")}
                }

             }

        }

    }

    Dialog {
            id: loginFailDialog
            width: warmMsg1.contentWidth + 200
            height: 300
            x:10
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
                            text: "Login Failed!!!"
                            font.pixelSize: 40
                            color: "black"
                        }
                        Image {
                              id: successIcon
                              anchors.left: parent.left
                              width: 150
                              height: 100
                              source: "/images/invalid_login.jpeg"
                        }
                    }
       contentItem: FocusScope{
            Column {
                id: loginFailColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg1;font.pixelSize:UIStyle.fontSizeXXL;text:"Wrong Username or Password!!";color:UIStyle.colorCandyPink}
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
//                    onClicked:{savetextfield.disableScreen("RT");loginButton.active = false;loginFailDialog.close();loginDialog.open()}
                    onClicked:{savetextfield.disableScreen("RT");UIStyle.oldUserName = "";UIStyle.oldPass = " "; loginButton.active = false;loginFailDialog.close();loginDialog.open()}

                }
             }

        }

    }
    Dialog {
            id: otpfailDialog
            visible: false
            height: 300
            x:10
            y:100
            width: warmMsgOtp.contentWidth + 200
   //         title:  "Password Change Window!!!"
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
                           text: "OTP Fail Window!!!"
                           font.pixelSize: 40
                           color: "black"
                       }
//                       Image {
//                             id: chngUsrIcon
//                             anchors.left: parent.left
//                             width: 150
//                             height: 100
//                             source: "/images/ok_icon.jpeg"
//                       }
                   }
        contentItem: FocusScope{
            Column {
                id: otpUsrColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsgOtp;font.pixelSize:UIStyle.fontSizeXXL;text:"Failed to change OTP. Try Again!!!!";color:UIStyle.colorQtblk}
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
                    onClicked:{savetextfield.disableScreen("RT");loginButton.enabled = true;otpfailDialog.close();loginButton.active = false; dummytext.text = "Login"}
                }
             }

         }
    }

    Dialog {
            id: chngUsrOkDialog
            visible: false
            height: 300
            x:10
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
                       height: 100
                       color: "mediumturquoise"
                       border.color: "aquamarine"
                       radius: 5
                       Text{
                           anchors.centerIn: parent
                           text: "Password Change Window!!!"
                           font.pixelSize: 40
                           color: "black"
                       }
                       Image {
                             id: chngUsrIcon
                             anchors.left: parent.left
                             width: 150
                             height: 100
                             source: "/images/ok_icon.jpeg"
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
                    onClicked:{savetextfield.disableScreen("RT");loginButton.enabled = true;chngUsrOkDialog.close();loginButton.active = false; dummytext.text = "Login"}
                }
             }

         }
    }

    function chkPwdComplexity(pwdTemp){
        for (var i=0;i<pwdTemp.length;i++)
            {
                if ((splChrs.match(pwdTemp[i])) && (splChrsfg !="1")){
                    splChrsfg = "1"
                    console.log("spl chars ok")
                }
                 if ((numChrs.match(pwdTemp[i])) && (numChrsfg != "1")){
                     numChrsfg = "1"
                    console.log("Num chars ok")
                 }
                 if ((upperChrs.match(pwdTemp[i])) && (upperChrsfg != "1")){
                     upperChrsfg = "1"
                    console.log("Upper chars ok")
                 }
                 if ((lowerChrs.match(pwdTemp[i])) && (lowerChrsfg != "1")){
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
            id: chngPassDialog
            width: inputPanelChngPass.width + 200
            height: inputPanelChngPass.height + 100
            x:10
            y:100
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
                       Image {
                             id: chngPassIcon
                             anchors.left: parent.left
                             width: 150
                             height: 100
                             source: "/images/change_password.jpeg"
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
//                    ComboBox {
//                        width: 300;height: 60
//                        model: ListModel {
//                            id: model
//                            ListElement { text: "" }
//                        }

//                        style: ComboBoxStyle {
//                            id: comboBoxStyle
//                            background: Rectangle {
//                                id: rect
//                                border.color: "green"
//                                color: "white"
//                            }
//                            label: Text {
//                                verticalAlignment: Text.AlignVCenter
//                                horizontalAlignment: Text.AlignHCenter
//                                color: "black"
//                                text: control.currentText
//                                font.pointSize: 18
//                            }
//                            __dropDownStyle: MenuStyle {
//                                frame: Rectangle {
//                                    color: "white"
//                                    border.width: 1
//                                    radius: 5
//                                    border.color: "gray"
//                                }

//                                itemDelegate.label: Text {
//                                    color: styleData.selected ? "red" : "black"
//                                    text: styleData.text
//                                    font.pointSize: 18
//                                }
//                            }
//                        }
//                        onCurrentIndexChanged: adminName = model.get(currentIndex).text
//                    }
                }
                Row{
                    spacing: 60
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"OLD PASSWORD ";color:UIStyle.colorQtGray1}
                   TextField{id:oldPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:cnfPassword.focus = true;width: 300;height: 60;onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0}else{/*newPassEmpty = 1*/}}
                       onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900;if(focus){if(cnfPassEmpty == 1){wrnOldpass.text = "(Field is Empty!!)"};if(aceptInput == true){newPassEmpty = 0;wrnOldpass.text = ""}else{newPassEmpty = 1}; toolTipdialogueC.visible = true}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {savetextfield.disableScreen("RT")}}
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
//                Row{
//                    spacing: 20
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
                         onClicked:{
                             savetextfield.disableScreen("RT");chngPassDialog.close();
                             console.log("the entered old password is:" + oldPass + '\n'+ "the entered new password is:" + newPass);
                                                      savetextfield.next(adminName);
                             if(((oldPass.indexOf(UIStyle.oldPass) === 0) && (newPass.indexOf(cnfPass) === 0) && (newPass === cnfPass)) && ((oldPass.indexOf(newPass) !== 0) || (newPass.indexOf(oldPass) !== 0)))
                             {
                                if(newPass == cnfPass){chkPwdComplexity(newPass);console.log("the... UUUUUUUUU:"+cnfPass)};
                                 if(pwdValidatefg == "1"){
                                 console.log("I M HERE the entered old password is:"+cnfPass);
                                 savetextfield.submittFileParamOTP(adminName,newPass);
                               if(UIStyle.fileNameExist.indexOf("Exist") !== 0)
                               {   chngUsrOkDialog.open();
                                   savetextfield.removeOTP(adminName);
                                   savetextfield.submittFileParam(adminName,newPass)
                               }
                               else{
                                   userFailTxt = "You can't use this password";
                                   chngUsrFailDialog.open();
                                   UIStyle.fileNameExist = ""
                               }
                               }else{UIStyle.oldPass = "";newPass = "";cnfPass = "";userFailTxt = "Check Password Complexity"; chngUsrFailDialog.open()}

                             }
                             else{
                                 console.log("oldPass :"+oldPass);console.log("UIStyle.oldPass :"+UIStyle.oldPass);otpfailDialog.open();
                                 if(oldPass.indexOf(UIStyle.oldPass) !== 0)
                                 {userFailTxt = "Old Password Incorrect       ";console.log("Old password Incorrect");chngUsrFailDialog.open()}else if(cnfPass.indexOf(newPass) !== 0){userFailTxt = "Check New & confirm password";
                                     chngUsrFailDialog.open()}
                                 UIStyle.oldPass = "";newPass = "";cnfPass = "";
                             }
                         }

                       }     /////
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
                         onClicked: {savetextfield.disableScreen("RT");loginButton.enabled = true;chngPassDialog.close();loginButton.active = false;dummytext.text = "Login"}
                    }

 //                }


             }

         }

    }

    Dialog {
            id: chngUsrFailDialog
            visible: false
            height: 300
            x:10
            y:100
            width:pwdWrong.contentWidth + 400
  //          standardButtons: StandardButton.Ok
  //          title:  "Password Change Window!!!"
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
                           text: "Password Fail Window!!!"
                           font.pixelSize: 40
                           color: "black"
                       }
                       Image {
                             id: chngUserfailIcon
                             anchors.left: parent.left
                             width: 150
                             height:100
                             source: "/images/chng_usr_fail.jpeg"
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
                    onClicked:{savetextfield.disableScreen("RT");loginButton.enabled = true;chngUsrFailDialog.close();otpfailDialog.close();chngPassDialog.open()}
                }
             }

         }

    }

    Dialog {
        id: loginDialog
        visible: false
    //    title:  "User Login Window"
        closePolicy: Popup.CloseOnEscape

        x:10
        y:100
        background: Rectangle{
            color: "aquamarine"
            radius: 5
            border.color: "mediumturquoise"
        }

        header: Rectangle{
            width:inputPanel.width
            height: 100
            color: "mediumturquoise"
            border.color: "aquamarine"
            radius: 5
            Text{
                anchors.centerIn: parent
                text: "User Login Window"
                font.pixelSize: 40
                color: "black"
            }

              Image {
                    id: loginIcon
                    anchors.left: parent.left
                    width: 150
                    height:100
                    source: "/images/login_icon.jpeg"
                }

        }
        width: inputPanel.width + 100
        height:inputPanel.height + 100
        contentItem: FocusScope{
            Column{
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 5
                Row{
                    spacing: 20
                    Button{
                        id:loginCancelBtn
                        Label{
                            anchors.centerIn: parent
                            text: "CANCEL"
                            font.pixelSize: 20
                        }
                        isDefault: true
                        focus: true
                        width: 150
                        height: 80
                        onClicked: {loginButton.enabled = true;loginDialog.close();transparentDialogue.close(); loginButton.active = false;dummytext.text = "Login"}

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
//                        onClicked: {loginDialog.close();savetextfield.nextOTP(adminName,adminPass);if((UIStyle.oldPass == "Blocked") &&(adminName !="Administrator")){savetextfield.statusFile(adminName,"Expired","Expired");userBlockedDialog.open()}else{
//                            if(((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){console.log("first step matched");/*login.visible = false;logout.visible = true;timerOnOff = true;*/savetextfield.findUserStatus(adminName);if((UIStyle.oldPass != "Blocked") && (UIStyle.oldPass != "Expired")){savetextfield.findGroupNameUserName(adminName);chkexpiry();if(daychkfg == "1"){console.log("checking status file");savetextfield.statusFile(adminName,"Expired","Expired");passadminName = adminName; userExpiredDialog.open();UIStyle.idleforfg = true}
//                                    else{loginOkDialog.open();UIStyle.scrEnabled = "0"}}else if(UIStyle.oldPass == "Expired"){passadminName = adminName;userExpiredDialog.open();UIStyle.idleforfg = true}else{userBlockedDialog.open()}  }
//                            else{ savetextfield.next(adminName);console.log("entered in next")
//                                if(((adminName == loginName) && (adminPass == userNamePass)) |((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){
//                                   if(((adminName == "Administrator") && (adminPass == "tepl"))){
//                                        UIStyle.oldPass = "ADMIN";loginLblGrpName = "ADMIN";loginLblName = "Administrator";UIStyle.prdName = "123456789";
//                                        /*timerOnOff = true;*/loginOkDialog.open();/*circularView.blurScreena("Origin");*/loginDialog.close()}
//                                    else{oldPass = "";newPass = "";cnfPass = "";/*loadLoginNames();*/UIStyle.prdName = "";chngPassDialog.open()}}else{adminName ="";adminPass = "";UIStyle.oldUserName = "";loginFailDialog.open()}}}}

                        onClicked: {savetextfield.disableScreen("RT");loginDialog.close();if((adminName.length != 0) || (adminPass.length != 0)){savetextfield.nextOTP(adminName,adminPass);if((UIStyle.oldPass.indexOf("Blocked") === 0) &&(adminName.indexOf("Administrator") !==0)){savetextfield.statusFile(adminName,"Blocked","Expired");userBlockedDialog.open()}else{
                            if(((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){console.log("first step matched");/*login.visible = false;logout.visible = true;timerOnOff = true;*/savetextfield.findUserStatus(adminName);if((UIStyle.oldPass != "Blocked") && (UIStyle.oldPass != "Expired")){savetextfield.findGroupNameUserName(adminName);chkexpiry();
                                    if(daychkfg == "1"){console.log("checking status file");savetextfield.statusFile(adminName,"Expired","Expired");passadminName = adminName; userExpiredDialog.open();UIStyle.idleforfg = true}
                                    else{loginOkDialog.open();UIStyle.scrEnabled = "0"}}else if(UIStyle.oldPass == "Expired"){passadminName = adminName;userExpiredDialog.open();UIStyle.idleforfg = true}else{userBlockedDialog.open()}  }
                            else{ savetextfield.next(adminName);console.log("entered in next")
                                if(((adminName == loginName) && (adminPass == userNamePass)) |((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){
                                   if(((adminName == "Administrator") && (adminPass == "tepl"))){
                                        UIStyle.oldPass = "ADMIN";loginLblGrpName = "ADMIN";loginLblName = "Administrator";UIStyle.prdName = "0";
                                        /*timerOnOff = true;*/loginOkDialog.open();/*circularView.blurScreena("Origin");*/loginDialog.close()}
                                    else{oldPass = "";newPass = "";cnfPass = "";/*loadLoginNames();*/UIStyle.prdName = "";chngPassDialog.open()}}else{adminName ="";adminPass = "";UIStyle.oldUserName = "";loginFailDialog.open()}}}}else{loginFailDialog.open()}}
                    }
                }
            }
            Column {
                id: column
                spacing: 30
                Row{
                    spacing: 40
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USER NAME";color:UIStyle.colorQtGray1}
                    TextField{id:userName; previewText: ""; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 50;loginDialog.height = 950}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 600;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged:{savetextfield.disableScreen("RT")}}

                }
                Row{
                    spacing: 45
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"PASSWORD";color:UIStyle.colorQtGray1}
                    TextField{id:password;previewText: ""; onFocusChanged: {inputPanel.visible = true;inputPanel.y = 50;loginDialog.height = 950}echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 600;height: 60;onTextChanged:{savetextfield.disableScreen("RT")}}
                }
                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPanel
                        visible: false
                        z: 89
                        width: 1500
                        y: Qt.inputMethod.visible ?  300 :parent.height
                    }
                }
            }
        }
        //-----------------------------------------------------------------------------------------------------------

    }
    function loadLoginNames(){
   //     savetextfield.loadFromLoginNames("F:\\ LoginGroupNames.txt");
        savetextfield.loadFromLoginNames("LoginGroupNames.txt");
        model.clear({text:""})
       for(var i = 0;i<UIStyle.fileList.length;i++){
            UIStyle.prd_code1 = UIStyle.fileList[i]
            model.append({text:UIStyle.prd_code1})
        }
    }
    Dialog {
            id: userExpiredDialog
            visible: false
            height: 300
            x:100
            y:10
            width: expireMsg.contentWidth + 100
            closePolicy: Popup.CloseOnEscape
   //         standardButtons: StandardButton.Ok
   //         title:  "Add User Window!!!"
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:expireMsg.contentHeight + 100
                height: 100
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "User Expiry Window"
                    font.pixelSize: 40
                    color: "black"
                }
                Image {
                      id: usrExpiryIcon
                      anchors.left: parent.left
                      width: 150
                      height:100
                      source: "/images/usr_blk.jpeg"
                  }
            }
         contentItem: FocusScope{
            Column {
                id: userExpireColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:expireMsg;scale: visible ? 1.0 : 0.1;font.pixelSize:30;text:adminName + " :IS EXPIRED.PLEASE CHANGE THE PASSWORD!!";color:"red"
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
                    spacing: 80

                    ChangePassword{
                        id:chngpassExp
                        width: 100
                        height: 40
                        onClicked: {changepassDial_x = -600;changepassDial_y = -150;chngPassDialog.height = 1000;expirefg = true; console.log("passing name is:"+passadminName);adminName = passadminName;}
                        onPassStatuschngPass: {
                            if((sts == "2") | (sts == "0"))
                            {
                                loginButton.enabled = true;
                                userExpiredDialog.close()}
                        }
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
                        onClicked:{loginButton.enabled = true;savetextfield.disableScreen("RT");userExpiredDialog.close(); adminPass = "";adminName = "";UIStyle.oldPass = "";loginButton.active = false;dummytext.text = "Login"}
                    }
                }
             }

         }

    }

    Dialog {
            id: userBlockedDialog
            visible: false
            height: 300
            x:10
            y:200
            width: blkMsg.contentWidth + 50
            closePolicy: Popup.CloseOnEscape
   //         standardButtons: StandardButton.Ok
   //         title:  "Add User Window!!!"
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:inputPanel.width
                height: 100
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "User Block Window"
                    font.pixelSize: 40
                    color: "black"
                }
                Image {
                      id: usrBlkIcon
                      anchors.left: parent.left
                      width: 150
                      height:100
                      source: "/images/usr_blk.jpeg"
                  }
            }
         contentItem: FocusScope{
            Column {
                id: userBlockedColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:blkMsg;scale: visible ? 1.0 : 0.1;font.pixelSize:30;text:adminName + " :IS BLOCKED. PLEASE CONTACT YOUR ADMINISTRATOR!!";color:"red"
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
                    onClicked:{loginButton.enabled = true; userBlockedDialog.close(); adminPass = "";adminName = "";UIStyle.oldPass = "";loginButton.active = false;dummytext.text = "Login"}
                }
             }

         }

    }

    Dialog {
            id: transparentDialogue

            visible: false
            height: 950
            width:1900
            x:200
            y: 10

        closePolicy: Popup.CloseOnEscape

//---------------------------------------------------------------------------------------------------------------------
        background: Rectangle{
            color: "transparent"
            radius: 5
            border.color: "black"
        }


    }


    Dialog {
            id: loginOkDialog
            width: warmMsg.contentWidth + 200
            visible: false
            height: 400
            x:10
            y:100
            title:  "Login Success!!!"
        closePolicy: Popup.CloseOnEscape

//---------------------------------------------------------------------------------------------------------------------
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
                text: "Login Success!!!"
                font.pixelSize: 40
                color: "black"
            }
            Image {
                  id: loginOkIcon
                  anchors.left: parent.left
                  width: 150
                  height: 100
                  source: "/images/ok_icon.jpeg"
            }
        }

    contentItem: FocusScope{
            Column {
                id: loginOkColumn
                spacing: 50
                Row{
                    spacing: 50
                    Label{id:warmMsg;font.pixelSize:UIStyle.fontSizeXXL;text: UIStyle.oldPass + " : " + adminName +" is logged in";color:UIStyle.colorQtblk}
                }
//                Row{
//                    spacing: 50
//                     Rectangle{
//                        width: 150
//                        height:110

//                        Image {
//                            id: successIcon
//                            anchors.fill: parent
//                            source: "/images/login_icon.jpeg"

//                        }
//                    }
//                }
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
//                    onClicked:{UIStyle.scrEnabled = "2";UIStyle.idleforfg = true; if(scrEnable == true){savetextfield.disableScreen1("2")}dummytext.text = "Logout";loginButton.active = true;
//                        loginButton.enabled = true; loginOkDialog.close();loginButton.passStatus("1");console.log("lohinlable name is:"+loginLblGrpName); if(loginLblGrpName == "ADMIN"){loginButton.passName(loginLblGrpName + "\n" + loginLblName);}else{ savetextfield.findGroupNameUserName(adminName);loginLblGrpName = UIStyle.oldPass; loginLblName = adminName;loginButton.passName(loginLblGrpName+ "\n" + loginLblName);savetextfield.overWriteFile(loginLblGrpName,loginLblName);}
//                        if((loginLblName != "Administrator") &&(loginLblGrpName != "Admin")){savetextfield.statusFile(loginLblName,"Active",UIStyle.expiry_Days);loginButton.passStatus("2")}else{savetextfield.statusFile(loginLblName,"Active","Live");};
//                        if(UIStyle.scrEnabled == "2"){};UIStyle.scrEnabled = "0"}

                    onClicked:{UIStyle.scrEnabled = "2";UIStyle.idleforfg = true; if(scrEnable == true){savetextfield.disableScreen1("2")}dummytext.text = "Logout";loginButton.active = true;
                        loginButton.enabled = true; loginOkDialog.close();/*loginButton.passStatus("1");*/console.log("lohinlable name is:"+loginLblGrpName); if(loginLblGrpName.indexOf("ADMIN") === 0){loginButton.passName(loginLblGrpName + "\n" + loginLblName)}else{ savetextfield.findGroupNameUserName(adminName);loginLblGrpName = UIStyle.oldPass; loginLblName = adminName;loginButton.passName(loginLblGrpName+ "\n" + loginLblName);savetextfield.overWriteFile(loginLblGrpName,loginLblName)}
                        if((loginLblName.indexOf("Administrator") !== 0) &&(loginLblGrpName.indexOf("Admin") !== 0 )){savetextfield.statusFile(loginLblName,"Active",UIStyle.expiry_Days);loginButton.passStatus("2")}else {loginButton.passStatus("1"); savetextfield.statusFile(loginLblName,"Active","Live")}
                        if(UIStyle.scrEnabled == "2"){};UIStyle.scrEnabled = "0"}

                }
             }

   }

//---------------------------------------------------------------------------------------------------------------------

    }



    Label{id:loginLblGrpNm;x:50;y:60;visible: false; font.pixelSize:UIStyle.fontSizeXXL;text:loginLblGrpName;color: UIStyle.colorQtBrown1}
    Label{id:loginLblNm;x:100;y:60;visible: false; font.pixelSize:UIStyle.fontSizeXXL;text:loginLblName;color: UIStyle.colorQtBrown1}

}


