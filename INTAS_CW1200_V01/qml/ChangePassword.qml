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
    id: changpassButton
    width: 220      //150
    height: 80      // Math.round(width * 0.866)
    property bool active: false
    property alias color: dummyOff.color
    property alias color1: dummyOn.color
    property alias text: dummytext.text
    property alias textcolor: dummytext.color
    property alias fontsize: dummytext.font.pointSize
     property bool expirefg: false
    signal clicked()
    signal pressAndHold()
    signal passStatuschngPass(string sts)

  //  signal passName(string text)

    property string adminName: ""        // userName.text
//    property alias adminPass: password.text
    property alias oldPass: oldPassword.text
    property alias newPass: newPassword.text
    property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: ""
 //   property alias loginLblGrpName: loginLblGrpNm.text
 //   property alias loginLblName: loginLblNm.text
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
    property string user_expiry_days: ""

    property int newPassEmpty
    property int cnfPassEmpty
    property int oldPassEmpty
    property int entryCnt

    property int changepassDial_x :-300
    property int changepassDial_y :80

    property alias userFailTxt: pwdWrong.text

    property string current_date: ""
    property variant cur_date: current_date.split('/')
    property variant user_expiry_date: ""
    property variant user_expiry_yy: ""

    //    property variant usr_exp_date: user_expiry_date.split('/')

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
        text: "CHANGE\nPASSWORD"
        color: "white"
        font.pointSize: 25
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(changpassButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(changpassButton.width * 0.866 * dummyOff.scale)
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
         //           changpassButton.clicked()
                    changpassButton.active = !changpassButton.active
                    pulseAnim.running = true
                    if(changpassButton.active == true){

                        // loadLoginNames()
                        changpassButton.enabled = false
                        changpassButton.passStatuschngPass("1")
                        savetextfield.disableScreen("RT")
                        UIStyle.scrEnabled = "1"
                        expiryLbl.text = ""
                        setExpiryDays()
                         chngPassDialog.open()
                        oldPass = "";newPass = "";cnfPass = ""
                         console.log("change pass dialogue open!!!")
                         dummytext.text = "CHANGE\nPASSWORD"
                    }
                    else{
                        //logoutOkDialog.open()
                        dummytext.text = "CHANGE\nPASSWORD"
                        console.log("change pass dialogue open!!!")
                    }
//                    if(changpassButton.active == false){
//                        pulseAnim.running = true
//                        oldPass = "";newPass = "";cnfPass = ""
//                        changpassButton.enabled = false
//                        chngPassDialog.open()
//                        console.log("login dialogue open!!!")

//                    }

//                    else if(changpassButton.active == true){
//                        logoutOkDialog.open()
//                        if(scrEnable == true){
//                            savetextfield.disableScreen1("1")
//                        }
//                        console.log("logout dialogue open!!!")
//                    }


                }
                onPressAndHold:
                    changpassButton.pressAndHold()

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
        onStopped: { changpassButton.clicked() }
    }
    Connections{
        target: savetextfield
       onClDialogue:{
            //console.log("close dialogue after timer end")
           if(text == "1"){
            chngPassDialog.close()
            chngUsrFailDialog.close()
            chngUsrOkDialog.close()
            changpassButton.active = false;changpassButton.enabled = true;passStatuschngPass("0")
           }

        }
    }
//    function loadLoginNames(){
//        savetextfield.loadFromLoginNames("F:\\ LoginFileNames.txt");
//        model.clear({text:""})
//       for(var i = 0;i<UIStyle.fileList.length;i++){
//            UIStyle.prd_code1 = UIStyle.fileList[i]
//            model.append({text:UIStyle.prd_code1})
//        }
//    }
   function setExpiryDays(){
       current_date = UIStyle.current_date
       user_expiry_date = parseInt(cur_date[1])
       user_expiry_date = user_expiry_date + 1       
       user_expiry_yy = parseInt(cur_date[2])
       if(user_expiry_date <= "9")
       {
            user_expiry_date = "0"+user_expiry_date;
       }
       else if(user_expiry_date > "12")
       {
           user_expiry_date = "01";
           user_expiry_yy = user_expiry_yy + 1;

       }

       if(user_expiry_yy % 4 == 0)
       {
           if( user_expiry_date === "02" )
           {
               console.log("The user checking leap Feb month  is")
              if(cur_date[0]>= "29")
              {
                  console.log("The user checking leap Feb Day is")
                 cur_date[0] = "29"
              }
           }

       }
      else if( user_expiry_date === "02" )
        {
            console.log("The user Feb month  is")
           if(cur_date[0]>= "29")
           {
               console.log("The user Feb Day is")
              cur_date[0] = "28"
           }
        }

       user_expiry_date = cur_date[0]+"/"+user_expiry_date+"/"+user_expiry_yy;//cur_date[2]
       console.log("The user expiry days is:" +user_expiry_date)
       expiryLbl.text = user_expiry_date
       console.log("The adminNameGroup is:" +adminNameGroup)
   }

    function chkPwdComplexity(pwdTemp){
        for (var i=0;i<pwdTemp.length;i++)
            {
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
            id: chngUsrFailDialog
            visible: false
            height: 300
            width:pwdWrong.contentWidth + 200
            closePolicy: Popup.CloseOnEscape
  //          standardButtons: StandardButton.Ok
  //          title:  "Password Change Window!!!"
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
                    text: "Password Change Window"
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
                    Label{id:pwdWrong;font.pixelSize:UIStyle.fontSizeXXL;text:":Something went wrong!!!!";color:UIStyle.colorQtblk}
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
                    onClicked:{savetextfield.disableScreen("RT");chngUsrFailDialog.close();chngPassDialog.open()}
                }
             }

         }


//            onAccepted: {chngPassDialog.open()}

    }
    Dialog {
            id: chngPassDialog
            //width: inputPanelChngPass.width
            //height: inputPanelChngPass.height

            width: inputPanelChngPass.width + 100
            height: inputPanelChngPass.height + 300
            x:changepassDial_x      // -300
            y:changepassDial_y      //80
     //       title:  "Change User Password Window"
     //       standardButtons: StandardButton.Cancel | StandardButton.Ok
            closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                color: "aquamarine"
                radius: 5
                border.color: "mediumturquoise"
            }

            header: Rectangle{
                width:inputPanelChngPass.width
                height: 50
                color: "mediumturquoise"
                border.color: "aquamarine"
                radius: 5
                Text{
                    anchors.centerIn: parent
                    text: "Change User Password Window"
                    font.pixelSize: 30
                    color: "black"
                }
            }
        contentItem: FocusScope{
            Column{
              //  spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 5
                Row{
                    spacing: 30
                    InputPanel {
                        id: inputPanelChngPass
                        visible: false
                        z: 89
                        width: 1100
                        y: Qt.inputMethod.visible ?  300 :parent.height

                    }
                }
                Row{
                    spacing: 20
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
                         onClicked:
                         {
                             savetextfield.disableScreen("RT");
                             chngPassDialog.close();console.log("the entered old password is:" + oldPass + '\n'+ "the entered new password is:" + newPass);
                             if(newPass == cnfPass){chkPwdComplexity(newPass);console.log("the... UUUUUUUUU:"+cnfPass)};
                             if(pwdValidatefg == "1"){
                                 savetextfield.next(adminName);
                                 console.log("theeeee UUUUUUUUU:"+cnfPass);
                                 if(((oldPass === UIStyle.oldPass) && (newPass === cnfPass)) && (oldPass != newPass))
                                 {savetextfield.lastTwoSave(adminName,newPass);if(UIStyle.fileNameExist != "Exist"){ savetextfield.submittFileParamOTP(adminName,newPass);console.log("the UUUUUUUUU:"+cnfPass);
                                         if(UIStyle.fileNameExist != "Exist")
                                         {
                                             chngUsrOkDialog.open();
                                             savetextfield.changepwd(adminName);//savetextfield.remove(adminName);
                                             savetextfield.submittFileParam(adminName,newPass)
                                             if(expirefg){
                                                 expirefg = false;
                                                 savetextfield.statusFile(adminName,"UserExp",user_expiry_days);

                                             }
                                         }
                                         else{
                                             userFailTxt = "You can't use this password";
                                             chngUsrFailDialog.open();UIStyle.fileNameExist = "";
                                         }

                                     }
                                     else{userFailTxt = "You can't use this password";chngUsrFailDialog.open();UIStyle.fileNameExist = ""}
                                 }
                                 else{UIStyle.oldPass = "";newPass = "";cnfPass = "";if(oldPass != UIStyle.oldPass){userFailTxt = "Old Password Incorrect"; chngUsrFailDialog.open()}else if(cnfPass != newPass){userFailTxt = "Check New & confirm password"; chngUsrFailDialog.open()}}
                             }
                             else{
                                 UIStyle.oldPass = "";
                                 newPass = "";cnfPass = "";
                                 userFailTxt = "Check Password Complexity";
                                 chngUsrFailDialog.open()}}
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
                         onClicked: {savetextfield.disableScreen("RT");UIStyle.scrEnabled = "0";chngPassDialog.close();changpassButton.active = false;changpassButton.enabled = true;changpassButton.passStatuschngPass("2")}
                    }

                 }


             }
          Column {
                id: chngPasscolumn
                spacing: 30
                Row{
                    spacing: 90
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USER NAME     ";color:UIStyle.colorQtGray1}
                    Rectangle{width: 600;height: 60;color: "white";border.color: "aquamarine";radius: 5;Label{id:usernmlbl;anchors.centerIn: parent;font.pixelSize: 30; text:adminName}}

                }
                Row{
                    spacing: 60
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"OLD PASSWORD ";color:UIStyle.colorQtGray1}
                   TextField{id:oldPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:cnfPassword.focus = true;width: 600;height: 60;onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0}else{/*newPassEmpty = 1*/}} onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 30;chngPassDialog.height = 950;if(focus){if(cnfPassEmpty == 1){wrncnfpass.text = "(Field is Empty!!)"};if(aceptInput == true){newPassEmpty = 0}else{newPassEmpty = 1}; toolTipdialogueC.visible = true;/*chngPassDialog.width = toolTipdialogueC.width+200*/}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
                   Label{id:wrnOldpass;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
               //    TextField{id:userName; text: "";visible: false}
               //    TextField{id:groupName; text: "";visible: false}
                }

                Row{
                    spacing: 50
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:" NEW PASSWORD";color:UIStyle.colorQtGray1}
                   TextField{id:newPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 30;chngPassDialog.height = 950}width: 600;height: 60}
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
                   TextField{id:cnfPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 30;chngPassDialog.height = 950}width: 600;height:60}
                   Label{id:wrnCnfpassC;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 10
                Label{text: "Expire on:";font.pixelSize: 30;color: "red"}
                Label{id:expiryLbl;text:"";font.pixelSize: 30;color: "red"}
                }
//                Row{
//                    spacing: 10
//                    InputPanel {
//                        id: inputPanelChngPass
//                        visible: false
//                        z: 89
//                        width: 1100
//                        y: Qt.inputMethod.visible ?  300 :parent.height

//                    }
//                }
            }
//            Column{
//                spacing: 50
//                anchors.bottom: parent.bottom
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//                anchors.bottomMargin: 20
//                Row{
//                    spacing: 20
//                    Button{
//                      Label{
//                            anchors.centerIn: parent
//                            text: "OK"
//                            font.pixelSize: 20
//                        }
//                         isDefault: true
//                            focus: true
//                            width: 150
//                         height: 80
////                         onClicked:{chngPassDialog.close();console.log("the entered old password is:" + oldPass + '\n'+ "the entered new password is:" + newPass);
////                             if(newPass == cnfPass){chkPwdComplexity(newPass)};
////                             if(pwdValidatefg == "1"){savetextfield.next(adminName);if((oldPass === UIStyle.oldPass) && (newPass == cnfPass) && (oldPass != newPass)){savetextfield.submittFileParamOTP(adminName,newPass);chngUsrOkDialog.open();savetextfield.remove(adminName);savetextfield.removeFromOTP(adminName);savetextfield.submittFileParam(adminName,newPass)}
////                             else{UIStyle.oldPass = "";newPass = "";cnfPass = "";chngUsrFailDialog.open()}}else{chngUsrFailDialog.open()} }
//                         onClicked:{chngPassDialog.close();console.log("the entered old password is:" + oldPass + '\n'+ "the entered new password is:" + newPass);if(newPass == cnfPass){chkPwdComplexity(newPass)};if(pwdValidatefg == "1"){
//                                                      savetextfield.next(adminName);if((oldPass === UIStyle.oldPass) && (newPass == cnfPass) && (oldPass != newPass)){savetextfield.submittFileParamOTP(adminName,newPass);
//                                                          if(UIStyle.fileNameExist != "Exist"){chngUsrOkDialog.open();savetextfield.remove(adminName);savetextfield.submittFileParam(adminName,newPass)}
//                                                          else{userFailTxt = "You can't use this password";chngUsrFailDialog.open();UIStyle.fileNameExist = ""}}
//                                                      else{UIStyle.oldPass = "";newPass = "";cnfPass = "";if(oldPass != UIStyle.oldPass){userFailTxt = "Old Password Incorrect"; chngUsrFailDialog.open()}else if(cnfPass != newPass){userFailTxt = "Check New & confirm password"; chngUsrFailDialog.open()}}}else{UIStyle.oldPass = "";newPass = "";cnfPass = "";userFailTxt = "Check Password Complexicity"; chngUsrFailDialog.open()}}
//                    }
//                    Button{
//                       Label{
//                            anchors.centerIn: parent
//                            text: "Cancel"
//                            font.pixelSize: 20
//                        }
//                         isDefault: true
//                            focus: true
//                            width: 150
//                         height: 80
//                         onClicked: {UIStyle.scrEnabled = "0";chngPassDialog.close();changpassButton.active = false;changpassButton.enabled = true;changpassButton.passStatus("0")}
//                    }

//                 }


//             }

         }

    }

    Dialog {
            id: chngUsrOkDialog
            visible: false
            height: 300
            width: warmMsg7.contentWidth + 200
    //        standardButtons: StandardButton.Ok
    //        title:  "Password Change Window!!!"
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
                           text: "Password Change Window"
                           font.pixelSize: 30
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
                    onClicked:{
                        savetextfield.disableScreen("RT");
                        UIStyle.scrEnabled = "0";
                        savetextfield.findGroupNameUserName(adminName);
                        savetextfield.createLoginNames(UIStyle.oldPass,adminName,expiryLbl.text);
                        //savetextfield.statusFile(adminName,"Active",expiryLbl.text);
                        chngUsrOkDialog.close();
                        changpassButton.active = false;
                        changpassButton.enabled = true;
                        changpassButton.passStatuschngPass("2");expiryLbl.text = ""}
                }
             }

         }

    }


}


