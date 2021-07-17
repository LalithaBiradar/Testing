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

//import QtGraphicalEffects 1.0


import "Style"

PathView {
    id: circularView
//    width: 1024
//    height: 600
    enabled: UIStyle.idleforfg

    signal launched(string page)
    signal blurScreena(string text)
//    signal submitTextField1(string text)

    readonly property int cX: width / 2
    readonly property int cY: height / 2
    readonly property int itemSize: size / 4
    readonly property int size: Math.min(width - 80, height)
    readonly property int radius: size / 2.3 - itemSize / 3.3
    property alias appTitle: appTitle
    property alias addwarnMessage: warnmsg5.text
    property alias warnMessage: warmMsg.text
    property alias warnMesClr: warmMsg.color
    property alias adminName: userName.text
    property alias adminPass: password.text
    property alias oldPass: oldPassword.text
    property alias newPass: newPassword.text
    property alias cnfPass: cnfPassword.text
    property alias addNewUserPass: addNewUsrPassword.text
    property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: "test"
    property alias loginLblGrpName: loginLblGrpNm.text
    property alias loginLblName: loginLblNm.text
    property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"
    property string myString
    property variant stringList: myString.split(',')


//    property var locale: Qt.locale()
//    property date currentTime: new Date()
//    property string timeString

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
    property string setzeromsg1

//        property int hours
//        property int minutes
//        property int seconds

//        property string shours

//       function timeChanged() {
//               var date = new Date;
//               hours = date.getHours()
//                minutes = date.getMinutes()
//               seconds = date.getSeconds();

//           timeString = new Date(). toLocaleTimeString();
//           shours =  timeString.charAt(0)

// //          print(hours,minutes,seconds,timeString,shours);
//           }

//       Timer {
//              interval: 1000; running: true; repeat: true;
//              onTriggered: circularView.timeChanged();
//              triggeredOnStart: true
//          }


    Dialog {
            id: authFailDialogpg2
            width: warmMsgpg2.contentWidth + 200
            height: 300
            x:50
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
                        height: 40
                        color: "mediumturquoise"
                        border.color: "aquamarine"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "Authorization Failed!!!"
                            font.pixelSize: 20
                            color: "black"
                        }
                    }
       contentItem: FocusScope{
            Column {
                id: loginFailColumnpg2
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsgpg2;font.pixelSize:UIStyle.fontSizeXXL;text:"You are not Authorized to use this function!!";color:UIStyle.colorCandyPink}
                }
            }
            Column{
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
                 Button{
                     id:okBtn
                     Label{
                         anchors.centerIn: okBtn
                         text: "OK"
                         font.pixelSize: 20
                     }
     //               isDefault: true
                    focus: true
                     width: 150
                    height: 80
                    onClicked:{authFailDialogpg2.close()}
                }
             }

        }

    }


    snapMode: PathView.SnapToItem

    model: ListModel {
        ListElement {
             title: qsTr("DISPLAY")
             title1: qsTr("DISPLAY")
      //      icon: "Fitness/images/display22.png"
      //      icon: "Fitness/images/display.png"
            icon: "Fitness/images/display1.png"
            page: "Fitness/FitnessPage.qml"
        }
        ListElement {
            title: qsTr("MACHINE SETUP")
            title1: qsTr("MACHINE\nSETUP")
         //   icon: "WorldClock/images/machine_setup22.png"
            icon: "WorldClock/images/machine_setup2.png"
            page: "WorldClock/WorldClockPage.qml"
        }
        ListElement {
            title: qsTr("FUNCTION SETUP")
            title1: qsTr("FUNCTION\nSETUP")
             icon: "Navigation/images/function_setup22.png"
         //    icon: "Navigation/images/function_setup.jpeg"
            page: "Navigation/FunSettingPage.qml"
        }
        ListElement {
             title: qsTr("PRODUCT SETUP")
             title1: qsTr("PRODUCT\nSETUP")
        //    icon: "Weather/images/prd_setup11.png"
        //    icon: "Weather/images/product_setup.png"
            icon: "Weather/images/product_setup1.png"
            page: "Weather/Testcheck.qml"
        }
        ListElement {
//            title: qsTr("MANUAL")
//            title1: qsTr("MANUAL")
            title: qsTr("SYSTEM\nINFO")
            title1: qsTr("SYSTEM\nINFO")

            icon: "Notifications/images/pdf1.png"
            page: "Notifications/NotificationsPage.qml"
        }
        ListElement {
            title: qsTr("BATCH REPORTS")
            title1: qsTr("BATCH\nREPORTS")
      //      icon: "Alarms/images/alarm_list22.png"
            icon: "Alarms/images/reports1.png"
            page: "Alarms/AlarmsPage.qml"
        }
        ListElement {
            title: qsTr("SET RTC")
            title1: qsTr("SET\nRTC")
        //    icon: "Settings/images/settings.png"
        //    icon: "Settings/images/rtc.png"
            icon: "Settings/images/rtc2.png"
            page: "Settings/SettingsPage.qml"
        }
    }


    delegate: QQC2.AbstractButton {
        id:actionButton
        width: circularView.itemSize
        height: circularView.itemSize

        text: model.title


        opacity: PathView.itemOpacity
        padding: 12

        contentItem:Image {
            id:modelImage
            source: model.icon
            fillMode: Image.Pad
            sourceSize.width: parent.availableWidth
            sourceSize.height: parent.availableHeight

            Text {
                id: nametext
                x:40
                y:150
                text: model.title1
                font.pointSize: 20
                font.italic: true
            }
        }

        background: Rectangle {
            radius: width / 2
            border.width: 3
            border.color: parent.PathView.isCurrentItem ? UIStyle.colorQtPrimGreen : UIStyle.colorQtGray4
        }

        onClicked: {
            //circleBtn.start()
            if(UIStyle.scrEnabled != "1"){
               console.log("the current index is:"+circularView.currentIndex)
                if (PathView.isCurrentItem){

                    if(page == "Settings/SettingsPage.qml"){
                    if((UIStyle.prdName.indexOf("1") >= 0)){
                circularView.launched(Qt.resolvedUrl(page));

                 }
                    else{authFailDialogpg2.open()}
                    }
                    else{circularView.launched(Qt.resolvedUrl(page))}
                    }

                else{
                 circularView.currentIndex = index
                }
            }
        }

        Component.onCompleted:{UIStyle.scrEnabled = "1"}
//        PropertyAnimation{
//            id:circleBtn
//            target: actionButton
//            property: "scale"
//            from: 0
//            to:1
//            duration: 500
//            easing.type: Easing.OutBack
//        }
    }

    path: Path {
        id:circlePath

        startX: circularView.cX
        startY: circularView.cY
        PathAttribute {
            name: "itemOpacity"
            value: 1.0
        }
        PathLine {
            x: circularView.cX + circularView.radius
            y: circularView.cY
        }
        PathAttribute {
            name: "itemOpacity"//    QQC2.SwipeView {
            //        id: svAlarmsContainer


            //            Item {
            //                Column {
            //                    spacing: 30
            //                    anchors.centerIn: parent

            //                    QQC2.Switch {
            //                        id: stateSwitch
            //                        checked: model.state
            //                        anchors.left: nameLabel.right
            //                    }

            //                    Text {
            //                        text: model.time
            //                        anchors.horizontalCenter: parent.horizontalCenter
            //                        verticalAlignment: Text.AlignVCenter
            //                        height: UIStyle.fontSizeXL
            //                        font.bold: stateSwitch.checked
            //                        font.pixelSize: stateSwitch.checked ? UIStyle.fontSizeXL : UIStyle.fontSizeL
            //                        font.letterSpacing: 4
            //                        color: UIStyle.colorQtGray1
            //                    }

            //                    Text {
            //                        id: nameLabel
            //                        text: model.name
            //                        anchors.horizontalCenter: parent.horizontalCenter
            //                        font.pixelSize: UIStyle.fontSizeS
            //                        font.italic: true
            //                        font.bold: true
            //                        font.letterSpacing: 1
            //                        color: UIStyle.colorQtGray2
            //                    }
            //                }


            //            }
            //        }
            //    }

            //    QQC2.PageIndicator {
            //        count: svAlarmsContainer.count
            //        currentIndex: svAlarmsContainer.currentIndex

            //        anchors.bottom: svAlarmsContainer.bottom
            //        anchors.horizontalCenter: parent.horizontalCenter
            //    }

            //    TextEdit {
            //        id: textEdit
            //        x: 88
            //        y: 406
            //        width: 1682
            //        height: 145
            //        text: qsTr("PAGE UNDER DEVELOPMENT")
            //        horizontalAlignment: Text.AlignHCenter
            //        font.pixelSize: 125
            //    }
            value: 0.7

        }
        PathArc {
            x: circularView.cX - circularView.radius
            y: circularView.cY
            radiusX: circularView.radius
            radiusY: circularView.radius
            useLargeArc: true
            direction: PathArc.Clockwise
        }
        PathAttribute {
            name: "itemOpacity"
            value: 0.5
        }
        PathArc {
            x: circularView.cX + circularView.radius
            y: circularView.cY

            radiusX: circularView.radius
            radiusY: circularView.radius
            useLargeArc: true
            direction: PathArc.Clockwise
        }
        PathAttribute {
            name: "itemOpacity"
            value: 0.3

        }

    }

    Text {
        id: appTitle
        property Item currentItem: circularView.currentItem
        visible: currentItem ? currentItem.PathView.itemOpacity === 1.0 : 0
    //    visible: true
        text: currentItem ? currentItem.text : ""


        anchors.centerIn: parent
        anchors.verticalCenterOffset: (circularView.itemSize + height) / 2
        font.bold: true
        font.pixelSize: circularView.itemSize / 4
        font.letterSpacing: 1
        color: UIStyle.colorQtGray1
    }




    Button{id:addNewUserbtn;Label{text: "ADD NEW\nUSER";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}
            visible: false; y:600;width: 300;height: 100;onClicked:{circularView.blurScreena("Blur");addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";toolTipdialogue.visible = false;addNewUsrDialog.open()}}
 //   Button{id:save;text: "Save";y:160;width: 100;height: 50;onClicked: savetextfield.saveToFile()}
 //   Button{id:previous;text: "previous";y:120;width: 100;height: 50;onClicked: {savetextfield.next(adminName)}}
 //   Button{id:submitt;text: "submitt";y:80;width: 100;height: 50;onClicked: savetextfield.submittFileParam(adminName,adminPass)}
//    Button{
//        id:login
//        width: 300
//        height: 100

//        y:100
//        //text:"LOGIN"
//        Label{text: "LOGIN";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}
////        Text {
////            id: logintext
////            text: qsTr("LOGIN")
////            anchors.centerIn: parent

////        }

//        onClicked:{/*savetextfield.arrayPass();*/adminName = "Administrator";adminPass = "tepl";circularView.blurScreena("Blur"); loginDialog.open()/*chkPwdComplexity()*/}

//    }
    Button{
        id:logout
        width: 300
        height: 100
         y:100
        visible: false
        //text:"LOGOUT"
        Label{text: "LOGOUT";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}
        onClicked:{logoutOkDialog.open();changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;logout.visible = false;login.visible = true;UIStyle.scrEnabled = "1";changePass.visible = false;addNewUserbtn.visible = false;/*loginLblGrpName = "";loginLblName = "";*/timerOnOff = false}
    }
    Button{
        id:changePass
        width: 300
        height: 100
        y:200
        visible: false
        //text:"CHANGE PASSWORD"
        Label{text: "CHANGE\nPASSWORD";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}
        onClicked:{circularView.blurScreena("Blur");if(UIStyle.scrEnabled == "0"){oldPass = "";newPass = "";cnfPass = "";loadLoginNames();chngPassDialog.open()}else{acessDeniedDialog.open()}}
    }
    Button{
        id:changeUsrProfile
        width: 300
        height: 100
        y:300
        visible: false
        //text:"USER PROFILE"
        Label{text: "USER\nPROFILE";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}

        onClicked:{circularView.blurScreena("Blur");usrExpiryDays.enabled = false;chngUsrProfileDialog.open();loadUserList();if(UIStyle.scrEnabled == "0"){}}
    }
    Button{
        id:usrPrevilage
        width: 300
        height: 100
        y:400
        visible: false
//        text:"USER PREVILAGE"
        Label{text: "USER\nPREVILAGE";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}

        onClicked:{circularView.blurScreena("Blur");chngUsrGrpPrevilageDialog.open()}
    }
    Button{
        id:usrBlckUnblck
        width: 300
        height: 100
        y:500
        visible: false
//        text:"USER BLOCK UNBLOCK"
        Label{text: "USER BLOCK\nUNBLOCK";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}

        onClicked:{circularView.blurScreena("Blur");loadUserStatus();blckUnblckDialog.open()}
    }



 //   TextField{id:prdCodef ; y:50;previewText: "";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight; validator: RegExpValidator { regExp: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/} onTextChanged: {if(aceptInput == false){console.log("fail")}else{console.log("ok")}}}
 //   TextField{id:prdCodef;y:50;previewText: "";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight; validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_+!:;.,*@#%&<>""''()={}~\ ]{1,16}$/} onTextChanged:{}  }
    function loadLoginNames(){
   //     savetextfield.loadFromLoginNames("F:\\ LoginFileNames.txt");
        savetextfield.loadFromLoginNames("LoginFileNames.txt");
        model.clear({text:""})
       for(var i = 0;i<UIStyle.fileList.length;i++){
            UIStyle.prd_code1 = UIStyle.fileList[i]
            model.append({text:UIStyle.prd_code1})
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

    function loadUserList(){

        savetextfield.loadUserProfileFile()
        chngUsrProfilemodel.clear({Username:""})
        chngUsrProfilemodel.clear({GroupName:""})
        recAddedUsrGrpmodel.clear({Username:""})
        recAddedUsrGrpmodel.clear({GroupName:""})
       for(var i = 0;i<UIStyle.fileList.length;i++){
            myString = UIStyle.fileList[i]
            UIStyle.prd_code1 = stringList[0]
            UIStyle.prd_code2 = stringList[1]

            chngUsrProfilemodel.append({Username:UIStyle.prd_code1,GroupName:UIStyle.prd_code2})

        }

    }
    function loadUpdatedUserList(){

        savetextfield.loadUserProfileFile()
        recAddedUsrGrpmodel.clear({Username:""})
        recAddedUsrGrpmodel.clear({GroupName:""})
       for(var i = 0;i<UIStyle.fileList.length;i++){
            myString = UIStyle.fileList[i]
            UIStyle.prd_code1 = stringList[0]
            UIStyle.prd_code2 = stringList[1]
           console.log(stringList[0])
           console.log(stringList[1])
           recAddedUsrGrpmodel.append({Username:UIStyle.prd_code1,GroupName:UIStyle.prd_code2})

        }

    }

    function loadUserStatus(){

        savetextfield.loadUserStatusFile()
        usrBlckUnblckmodel.clear({Username:""})
        usrBlckUnblckmodel.clear({Status:""})
        chngdUsrGrpmodel.clear({Username:""})
        chngdUsrGrpmodel.clear({Status:""})
       for(var i = 0;i<UIStyle.fileList.length;i++){
            myString = UIStyle.fileList[i]
            UIStyle.prd_code1 = stringList[0]
            UIStyle.prd_code2 = stringList[1]

            usrBlckUnblckmodel.append({Username:UIStyle.prd_code1,Status:UIStyle.prd_code2})

        }

    }


    Timer{
        interval: 300000;running: timerOnOff;repeat: true
        onTriggered:{ logout.visible = false;login.visible = true;UIStyle.scrEnabled = "1";timerOnOff = false;changePass.visible = false;addNewUserbtn.visible = false;usrBlckUnblck.visible = false;usrPrevilage.visible =false;changePass.visible = false; changeUsrProfile.visible = false;loginLblGrpName = "";loginLblName = "";console.log("timer end")}
        }

    Dialog {
            id: chngUsrGrpPrevilageDialog
            width: 1920
            height:avlUsrgrp.height * 2



    //        standardButtons: StandardButton.Cancel | StandardButton.Ok
            title:  "Change User Profile Window"

            contentItem: FocusScope{


            Row {
                id: chngUsrGrpPrevilagecolumn
                spacing: 10
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    GroupBox{
                        id:avlUsrgrp
                        title: "Available User Previlages"
                        width: 800
                        height: 450
//                        y:30
//                        anchors.top: parent.top
//                        anchors.topMargin: 30

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
                            id: previlageView
                            //width: 800
                            //height: 450
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
                                title: "Previlages"
                                width: previlageView.width / 2
                                resizable: false
                                movable: false

                                delegate: Component {
                                                                       id: namedelegate

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
                            model: ListModel {
                               id: avlUsrPrevilagemodel
                               ListElement { name: "Administrator"; }
                               ListElement { name: "Operator"; }
                               ListElement { name: "Supervisor"; }
                               ListElement { name: "Manager"; }
                               ListElement { name: "Engineer"; }
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

                            onCurrentRowChanged:{adminNameGroup = avlUsrPrevilagemodel.get(__currentRow).name}

                        }
                 }

                    GroupBox{
                    title: "Previlages"
                    width: 800
                    height: 450
         //           anchors.top: parent.top
          //          anchors.topMargin: 30
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
                        id: usrPrevilageListView

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
                            width: usrPrevilageListView.width / 2
                            resizable: false
                            movable: false

                            delegate: Component {
                                                                   id: previlageusernamedelegate

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
                            width: usrPrevilageListView.width / 2
                            resizable: false
                            movable: false

                            delegate: Component {
                                                                   id: previlagegroupnamedelegate

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

//                        frameVisible: false
//                        backgroundVisible: true
//                        alternatingRowColors: false

                        model: ListModel {
                           id: usrPrevilagemodel
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

                        onCurrentRowChanged: {adminName = usrPrevilagemodel.get(__currentRow).Username}

                    }
                     }



                }
                Column{
                    spacing: 100
//                    GroupBox{
//                        title: "Selected User Expiry Days"

//                        TextField{id:usrExpiryDays;previewText: "";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight}
//                    }
//                    GroupBox{
//                        title: "User New Expiry Days"
//            //        Label{font.pixelSize:UIStyle.fontSizeM;text:"User New Expiry Days";color:UIStyle.colorQtGray1}
//                      TextField{id:usrNewExpiryDays;previewText: "";enterKeyAction: EnterKeyAction.Next;width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
//                    }
                  //  Button{id:chngPrevilagebtn;text: "ADD";width: 120;height: 50;onClicked:{}}
                    Button{id:chngPrevilagebtn;width: 300;height: 60;Label{text: "ADD";anchors.centerIn: chngPrevilagebtn;anchors.left: chngPrevilagebtn.left;font.pointSize: 25}onClicked:{}}

//                    Button{id:setProfilebtn;text: "---->";width: 120;height: 50;onClicked:{}}

                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

                GroupBox{
                    title: "Selected User Group"
                    width: 800
                    height: 450
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

                    ListView{
                        width: 200
                        height : 100
                        id:selUsrGrpListP
                        model: ListModel {
                            id: selUsrGrpmodelP
                            ListElement { text: "" }

                        }


                    }
                }

           GroupBox{
              title: "Recently Added Group Previlages"
              width: 800
              height: 450
 //             anchors.top: parent.top
  //            anchors.topMargin: 30


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
                  id: recAddedUsrGrpPrevilagesList

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
                      width: recAddedUsrGrpPrevilagesList.width / 2
                      resizable: false
                      movable: false

                      delegate: Component {
                                                             id: recentprevilagedelegate

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
//                  TableViewColumn {
//                      role: "GroupName"
//                      title: "Group Name"
//                      width: recAddedUsrGrpPrevilagesList.width / 2
//                      resizable: false
//                      movable: false

//                  }

//                  frameVisible: false
//                  backgroundVisible: true
//                  alternatingRowColors: false


                  model: ListModel {
                     id: recAddedUsrGrpPrevilagemodel
                  ListElement { Username: ""
                           //     GroupName:""
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

                  onCurrentRowChanged: {console.log(recAddedUsrGrpPrevilagemodel.get(__currentRow).Username)}

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
                    onClicked:{chngUsrGrpPrevilageDialog.close();circularView.blurScreena("Origin")}
                }
             }

         }


  // onVisibleChanged:{entryCnt = entryCnt +1;console.log("outside entry count usrPrvilage is:"+entryCnt);if(UIStyle.retData=="Blur"){entryCnt = entryCnt +1;console.log("outside entry count usrPrvilage is:"+entryCnt);UIStyle.retData = "";}else {if(entryCnt == 4){entryCnt = 0;circularView.blurScreena("Origin")}}}
}



    Dialog {
            id: blckUnblckDialog
            width: 1850
            height: blkunblkgrp.height * 2
     //       standardButtons: StandardButton.Cancel | StandardButton.Ok
            title:  "Block Unblock User Window"
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
                    width: 800
                    height: 450
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
                        frameVisible: false
                        backgroundVisible: false
                         alternatingRowColors: false
                          sortIndicatorVisible: true
                           clip: true
                          highlightOnFocus: false

                        TableViewColumn {
                            role: "Username"
                            title: "User Name"
                            width: usrBlckUnblckListView.width / 2
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
                            width: usrBlckUnblckListView.width / 2
                            resizable: false
                            movable: false

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

//                        frameVisible: false
//                        backgroundVisible: true
//                        alternatingRowColors: false

                        model: ListModel {
                           id: usrBlckUnblckmodel
                            ListElement { Username: ""
                                          Status:""
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

                        onCurrentRowChanged: {adminName = usrBlckUnblckmodel.get(__currentRow).Username}

                    }
                     }

                }
                Column{

                    width: 300
                    spacing: 30
                    anchors.top: parent.top
                    anchors.topMargin: 200
                    Button{id:blckBtn;width: 200;height: 50;Label{text: "BLOCK";anchors.centerIn: blckBtn;anchors.left: blckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Blocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Blocked"})}}
                    Button{id:unblckBtn;width: 200;height: 50;Label{text: "UNBLOCK";anchors.centerIn: unblckBtn;anchors.left: unblckBtn.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Unblocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Unblocked"})}}

                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

           GroupBox{
              title: "Changed User with Status"
              width: 800
              height: 450
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

                  TableViewColumn {
                      role: "Username"
                      title: "User Name"
                      width: chngdUsrGrpList.width / 2
                      resizable: false
                      movable: false
                  }
                  TableViewColumn {
                      role: "Status"
                      title: "Status"
                      width: chngdUsrGrpList.width / 2
                      resizable: false
                      movable: false

                  }

//                  frameVisible: false
//                  backgroundVisible: true
//                  alternatingRowColors: false


                  model: ListModel {
                     id: chngdUsrGrpmodel
                  ListElement { Username: ""
                                Status:""
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

                  onCurrentRowChanged: {console.log(chngdUsrGrpmodel.get(__currentRow).Username)}

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
                    onClicked:{blckUnblckDialog.close();circularView.blurScreena("Origin")}
                }
             }

         }




 //           onVisibleChanged:{entryCnt = entryCnt +1;console.log("outside entry count blckUnblck is:"+entryCnt);if(UIStyle.retData=="Blur"){entryCnt = entryCnt +1;console.log("outside entry count blckUnblck is:"+entryCnt);UIStyle.retData = "";}else {if(entryCnt == 4){entryCnt = 0;circularView.blurScreena("Origin")}}}
}


    Dialog {
            id: chngUsrProfileDialog
            width: 1920
            height: chngusrprflgrp.height * 2
         //   standardButtons: StandardButton.Cancel | StandardButton.Ok
            title:  "Change User Profile Window"

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
                    width: 800
                    height: 450
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

                             onCurrentRowChanged: {adminName = chngUsrProfilemodel.get(__currentRow).Username}

                        }
                     }

                    GroupBox{
                        title: "Available User Groups"
                        width: 800
                        height: 450
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
                            model: ListModel {
                               id: avlUsrGrpmodel
                            ListElement { name: "Administrator"; }
                            ListElement { name: "Operator"; }
                            ListElement { name: "Supervisor"; }
                            ListElement { name: "Manager"; }
                            ListElement { name: "Engineer"; }
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

                            onCurrentRowChanged:{adminNameGroup = avlUsrGrpmodel.get(__currentRow).name}

                        }
                  }

                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

                    GroupBox{
                        title: "Selected User Expiry Days"
                        width: 300
                        height: 200
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

                        TextField{id:usrExpiryDays;previewText: "";width: 200;height: 60}
                    }
                    GroupBox{
                        title: "User New Expiry Days"
                        width: 300
                        height: 200
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
                        TextField{id:usrNewExpiryDays;previewText: "";enterKeyAction: EnterKeyAction.Next;width: 200;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                    }
              //      Button{id:chngProfilebtn;text: "CHANGE PROFILE";width: 200;height: 60;onClicked:{savetextfield.overWriteFile(adminNameGroup,adminName);/*loadUpdatedUserList();*/recAddedUsrGrpmodel.append({Username:adminName,GroupName:adminNameGroup})}}
                //    Button{id:setProfilebtn;text: "---->";width: 200;height: 60;onClicked:{}}

                    Button{id:chngProfilebtn;width: 300;height: 60;Label{text: "CHANGE PROFILE";anchors.centerIn: chngProfilebtn;anchors.left: chngProfilebtn.left;font.pointSize: 25}onClicked:{savetextfield.overWriteFile(adminNameGroup,adminName);/*loadUpdatedUserList();*/recAddedUsrGrpmodel.append({Username:adminName,GroupName:adminNameGroup})}}
                    Button{id:setProfilebtn;width: 200;height: 50;Label{text: "---->";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}onClicked:{savetextfield.statusFile(adminName,"Unblocked");chngdUsrGrpmodel.append({Username:adminName,Status:"Unblocked"})}}



                }
                Column{
                    spacing: 50
                    anchors.top: parent.top
                    anchors.topMargin: 30

                GroupBox{
                    title: "Selected User Group"
                    width: 900
                    height: 450
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

                    ListView{
                        width: 200
                        height : 100
                        id:selUsrGrpList
                        model: ListModel {
                            id: selUsrGrpmodel
                            ListElement { text: "" }

                        }


                    }
                }

           GroupBox{
              title: "Recently Added User with Group Name"

              width: 900
              height: 450
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
                  id: recAddedUsrGrpList
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

//                  frameVisible: false
//                  backgroundVisible: true
//                  alternatingRowColors: false


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


                  onCurrentRowChanged: {console.log(recAddedUsrGrpmodel.get(__currentRow).Username)}

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
                    onClicked:{ chngUsrProfileDialog.close();circularView.blurScreena("Origin")}
                 }


             }

         }


  //          onVisibleChanged:{entryCnt = entryCnt +1;console.log("outside entry count changeUserProfile is:"+entryCnt);if(UIStyle.retData=="Blur"){entryCnt = entryCnt +1;console.log("inside entry count changeUserProfile is:"+entryCnt);UIStyle.retData = "";}else {if(entryCnt == 4){entryCnt = 0;circularView.blurScreena("Origin")}}}
}
    Dialog {
            id: addNewUsrDialog
  //          standardButtons: StandardButton.Cancel | StandardButton.Ok
            title:  "New User Entry Window"
       //     width: toolTiplbl.contentWidth
             width: inputPaneladdnewusr.width + 250
             height: inputPaneladdnewusr.height + 100

        contentItem: FocusScope{
            Column {
                id: addNewUsrcolumn
                spacing: 20
                Row{
                    spacing: 80
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"GROUP NAME";color:UIStyle.colorQtGray1}
                    ComboBox {
                        width: 300;height: 60
                        model: ListModel {
                            id: addNewUsrmodel
                            ListElement { text: "Administrator"}
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


                        onCurrentIndexChanged:{ adminNameGroup = addNewUsrmodel.get(currentIndex).text}

                    }

//                    style: ComboBoxStyle {
//                                                        id: comboBoxStyle
//                                                        background: Rectangle {
//                                                            id: rect
//                                                            border.color: "green"
//                                                            color: "white"
//                                                        }
//                                                        label: Text {
//                                                                       verticalAlignment: Text.AlignVCenter
//                                                                       horizontalAlignment: Text.AlignHCenter
//                                                                        color: "black"
//                                                                        text: control.currentText
//                                                                        font.pointSize: 18
//                                                                    }
//                                                        __dropDownStyle: MenuStyle {
//                                                                       frame: Rectangle {
//                                                                           color: "white"
//                                                                           border.width: 1
//                                                                           radius: 5
//                                                                           border.color: "gray"
//                                                                       }

//                                                                       itemDelegate.label: Text {
//                                                                           color: styleData.selected ? "red" : "black"
//                                                                           text: styleData.text
//                                                                           font.pointSize: 18
//                                                                       }
//                                                                   }
//                                            }
                }
                Row{
                    spacing: 120
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USERNAME";color:UIStyle.colorQtGray1}
                   TextField{id:newUserName; previewText: "";enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;onFocusChanged: {inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 50;addNewUsrDialog.height = 900}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {adminName = newUserName.text }}
                }
                Row{
                    spacing: 120
                    Label{id:passTooltip; font.pixelSize:UIStyle.fontSizeXXL;text:"PASSWORD";color:UIStyle.colorQtGray1 }
                   TextField{id:addNewUsrPassword; previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:cnfPassword.focus = true;width: 300;height: 60;onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0;wrnpass.text = ""}else{/*newPassEmpty = 1*/}} onFocusChanged: {inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 50;addNewUsrDialog.height = 900; if(focus){console.log("New password focussed");if(cnfPassEmpty == 1){wrncnfpass.text = "(Field is Empty!!)";console.log("Confirm Password is empty")};if(aceptInput == true){oldPassEmpty = 0;wrnpass.text = ""}else{console.log("New password is empty"); newPassEmpty = 1}; toolTipdialogue.visible = true;addNewUsrDialog.width = inputPaneladdnewusr.width + 250}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {adminPass = addNewUserPass} }
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
                   TextField{id:addNewCnfPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 300;height: 60;onAceptInputChanged:{ if(aceptInput == true){console.log("cnf pass enetered"); wrncnfpass.text = "";cnfPassEmpty = 0}else{/*cnfPassEmpty = 1*/}}onFocusChanged:{inputPaneladdnewusr.visible = true;inputPaneladdnewusr.y = 50;addNewUsrDialog.height = 900;if(focus){console.log("Cnf password is focussed");if(newPassEmpty == 1){wrnpass.text = "(Field is Empty!!)"; console.log("New Password is empty")}; if(addNewCnfPassword.text.length > 0){cnfPassEmpty = 0;wrncnfpass.text = "";console.log("Cnf password is entered")}else{cnfPassEmpty = 1;console.log("Here Cnf password is empty")}}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                    Label{id:wrncnfpass;font.pixelSize:UIStyle.fontSizeXXL;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 20


                    Label{id:warnmsg5;visible: false;font.pixelSize:UIStyle.fontSizeXXL;text:"User is already Exist!!!!";color:UIStyle.colorQtGray1}
                    Label{id:warnmsg6;visible: false;font.pixelSize:UIStyle.fontSizeXXL;text:"User added successfully!!!!";color:UIStyle.colorQtGray1}
                }


                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPaneladdnewusr
                        visible: false
                        z: 89
                        width: 1200
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
                spacing: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
              Row{
                  spacing: 30
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
                    onClicked:{addNewUsrDialog.close();savetextfield.next(adminName);chkPwdComplexity(addNewUserPass);
                        if(pwdValidatefg == "1"){ if(((addNewUserPass == UIStyle.oldPass) && (addNewUserPass == addNewCnfmPass) && (adminName == UIStyle.oldUserName)) | (adminName == UIStyle.oldUserName)){existUsrOkDialog.open()}else{savetextfield.submittFileParam(adminName,adminPass);savetextfield.createLoginNames(adminNameGroup,adminName,addNewUserPass);model.append({listLoginNames:adminName});addUsrOkDialog.open()}}
                        else{pwdFailDialog.open()}}
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
                    onClicked: {addNewUsrDialog.close();circularView.blurScreena("Origin")}
                 }

              }
             }

         }



     //       onAccepted: {savetextfield.next(adminName);chkPwdComplexity(addNewUserPass);if(pwdValidatefg == "1"){ if(((addNewUserPass == UIStyle.oldPass) && (addNewUserPass == addNewCnfmPass) && (adminName == UIStyle.oldUserName)) | (adminName == UIStyle.oldUserName)){existUsrOkDialog.open()}else{savetextfield.submittFileParam(adminName,adminPass);savetextfield.createLoginNames(adminNameGroup,adminName,addNewUserPass);model.append({listLoginNames:adminName});addUsrOkDialog.open()}}else{pwdFailDialog.open()}}
      //      onRejected: console.log("rejected")
      //      onVisibleChanged:{entryCnt = entryCnt +1;console.log("outside entry count new user is:"+entryCnt);if(UIStyle.retData=="Blur"){console.log("inside entry count new user is:"+entryCnt);entryCnt = entryCnt +1;UIStyle.retData = ""}else {if(entryCnt == 4){entryCnt = 0;circularView.blurScreena("Origin")}}}
    }
//    Rectangle{
//        id:toolTipMsg
//        visible: false
//        Image {
//            id: toolTipimg
//            source: "images/tooltip.png"
//        }
//    }


    Dialog {
            id: chngPassDialog
            //width: inputPanelChngPass.width
            //height: inputPanelChngPass.height

            width: inputPanelChngPass.width + 200
            height: inputPanelChngPass.height + 100
            title:  "Change User Password Window"
     //       standardButtons: StandardButton.Cancel | StandardButton.Ok
        contentItem: FocusScope{

            Column {
                id: chngPasscolumn
                spacing: 20
                Row{
                    spacing: 90
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USER NAME     ";color:UIStyle.colorQtGray1;}
                    ComboBox {
                        width: 300;height: 60
                        model: ListModel {
                            id: model
                            ListElement { text: "" }
                        }
                        onCurrentIndexChanged: adminName = model.get(currentIndex).text
                    }
                }
                Row{
                    spacing: 60
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"OLD PASSWORD ";color:UIStyle.colorQtGray1}
                   TextField{id:oldPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:cnfPassword.focus = true;width: 300;height: 60;onAceptInputChanged:{ if(aceptInput == true){newPassEmpty = 0;wrnpass.text = ""}else{/*newPassEmpty = 1*/}} onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900;if(focus){if(cnfPassEmpty == 1){wrncnfpass.text = "(Field is Empty!!)"};if(aceptInput == true){newPassEmpty = 0;wrnpass.text = ""}else{newPassEmpty = 1}; toolTipdialogueC.visible = true;/*chngPassDialog.width = toolTipdialogueC.width+200*/}}validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}onTextChanged: {}}
                   Label{id:wrnOldpass;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }

                Row{
                    spacing: 50
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:" NEW PASSWORD";color:UIStyle.colorQtGray1}
                   TextField{id:newPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900}width: 300;height: 60}
                   Label{id:wrnNewpass;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 50
                    Rectangle{
                        id:toolTipdialogueC
                        visible: false
                        border.color: "Red"
                        border.width: 2
                        width: toolTiplbl.contentWidth;height: UIStyle.prdParamHeight
                        Label{id:toolTiplblC;anchors.centerIn: parent; font.pixelSize:UIStyle.fontSizeM;text:"*Use atleast 6 characters. It must contain Uppercase,Lowercase,Special character and Digit.";color:UIStyle.colorCandyPink}

                    }
                }
                Row{
                    spacing: 20
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:" CONFIRM PASSWORD";color:UIStyle.colorQtGray1}
                   TextField{id:cnfPassword;previewText: "";echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;onFocusChanged: {inputPanelChngPass.visible = true;inputPanelChngPass.y = 50;chngPassDialog.height = 900}width: 300;height:60}
                   Label{id:wrnCnfpassC;font.pixelSize:UIStyle.fontSizeM;text:"";color:UIStyle.colorCandyPink}
                }
                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPanelChngPass
                        visible: false
                        z: 89
                        width: 1200
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
                spacing: 50
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
                         onClicked:{
                             chngPassDialog.close();
                             console.log("the entered old password is:::" + oldPass + '\n'+ "the entered new password is:" + newPass);
                                savetextfield.next(adminName);
                             if((oldPass == UIStyle.oldPass) && (newPass == cnfPass) && (oldPass != newPass))
                             {
                                 console.log("the entered old password iswwwwwwww:" + cnfPass);
                                 savetextfield.submittFileParamOTP(adminName,newPass);
                                 chngUsrOkDialog.open();
                                 savetextfield.remove(adminName);
                                 savetextfield.submittFileParam(adminName,newPass)
                             }
                             else
                             {
                                  console.log("the entered old password istttttt:" + cnfPass);
                                 chngUsrFailDialog.open()
                             }
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
                         onClicked: {chngPassDialog.close();circularView.blurScreena("Origin")}
                    }

                 }


             }

         }


     //       onAccepted: {console.log("the entered old password is:" + oldPass + '\n'+ "the entered new password is:" + newPass); savetextfield.next(adminName);if((oldPass == UIStyle.oldPass) && (newPass == cnfPass) && (oldPass != newPass)){savetextfield.submittFileParamOTP(adminName,newPass);chngUsrOkDialog.open();savetextfield.remove(adminName);savetextfield.submittFileParam(adminName,newPass)}else{chngUsrFailDialog.open()}}
     //       onVisibilityChanged:{inputPanelChngPass.visible = false;inputPanelChngPass.height = 100;entryCnt = entryCnt +1;console.log("outside entry count is:"+entryCnt);if(UIStyle.retData=="Blur"){entryCnt = entryCnt +1;UIStyle.retData = "";console.log("inside entry count is:"+entryCnt);}else {if(entryCnt == 5){entryCnt = 0;circularView.blurScreena("Origin")}}}

    }




    Dialog {
        id: loginDialog
        visible: false
        title:  "User Login Window"
        closePolicy: Popup.CloseOnEscape
        x:200
        y:50
        background: Rectangle{
            color: "aquamarine"
            radius: 5
            border.color: "mediumturquoise"
        }

        header: Rectangle{
            width:inputPanel.width
            height: 40
            color: "mediumturquoise"
            border.color: "aquamarine"
            radius: 5
            Text{
                anchors.centerIn: parent
                text: "User Login Window"
                font.pixelSize: 20
                color: "black"
            }
        }
        width: inputPanel.width + 100
        height:inputPanel.height + 100
        contentItem: FocusScope{
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
                            text: "CANCEL"
                            font.pixelSize: 20
                        }
                        isDefault: true
                        focus: true
                        width: 150
                        height: 80
                        onClicked: {loginDialog.close();circularView.blurScreena("Origin")}
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
                        onClicked: {loginDialog.close();savetextfield.nextOTP(adminName);
                            if(((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){login.visible = false;logout.visible = true;timerOnOff = true;savetextfield.findUserStatus(adminName);if(UIStyle.oldPass != "Blocked"){ savetextfield.findGroupNameUserName(adminName);loginOkDialog.open();UIStyle.scrEnabled = "0"}else{userBlockedDialog.open()}}
                            else{ savetextfield.next(adminName);
                                if(((adminName == loginName) && (adminPass == userNamePass)) |((adminName == UIStyle.oldUserName) && (adminPass == UIStyle.oldPass))){
                                    oldPass = "";newPass = "";cnfPass = "";if(((adminName == "Administrator") && (adminPass == "tepl"))){
                                        UIStyle.oldPass = "ADMIN";loginLblGrpName = "ADMIN";/*loginLblName = "Administrator";*/
                                        login.visible = false;logout.visible = true;usrBlckUnblck.visible = true;usrPrevilage.visible =true;changePass.visible = true; changeUsrProfile.visible = true
                                        timerOnOff = true;loginOkDialog.open();UIStyle.scrEnabled = "2";circularView.blurScreena("Origin");loginDialog.close()}
                                    else{ loadLoginNames();chngPassDialog.open()}}else{loginFailDialog.open()}}}
                    }
                }
            }
            Column {
                id: column
                spacing: 20
                Row{
                    spacing: 20
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"USER NAME";color:UIStyle.colorQtGray1}
                    TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
                }
                Row{
                    spacing: 25
                    Label{font.pixelSize:UIStyle.fontSizeXXL;text:"PASSWORD";color:UIStyle.colorQtGray1}
                    TextField{id:password;previewText: "";onFocusChanged: {inputPanel.visible = true;inputPanel.y = 50;loginDialog.height = 700}echoMode: TextInput.Password; enterKeyAction: EnterKeyAction.Next;width: 300;height: 60;}
                }
                Row{
                    spacing: 25
                    InputPanel {
                        id: inputPanel
                        visible: false
                        z: 89
                        width: 1100
                        y: Qt.inputMethod.visible ?  300 :parent.height
                    }
                }
            }
        }
        //-----------------------------------------------------------------------------------------------------------

    }

//----------------------------------------------


//    Dialog {
//        id: setzeroDialog
//        visible: true
//        title:  "SETZERO WINDOW"
//        closePolicy: Popup.CloseOnEscape


//        x: 360
//        y: 260
//        background: Rectangle{
//            color: "red"
//            radius: 5
//            border.color: "mediumturquoise"
//        }

//        header: Rectangle{
//            width:1300//inputPanel.width
//            height: 60
//            color: "mediumturquoise"
//            border.color: "aquamarine"
//            radius: 5
//            Text{
//                anchors.centerIn: parent
//                text: "SETZERO WINDOW"
//                font.pixelSize: 30
//                color: "black"
//            }
//        }
//        width: 1300//inputPanel.width + 100
//        height:500//inputPanel.height + 100
//        contentItem: FocusScope{
//            Column{
//                anchors.bottom: parent.bottom
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//                anchors.bottomMargin: 20
//               // Row{
//               //     spacing: 20
//                    Button{
//                        //     text: "OK"
//                        Label{
//                            anchors.centerIn: parent
//                            text: "CANCEL"
//                            font.pixelSize: 20
//                        }
//                    //    isDefault: true
//                        focus: true
//                        width: 150
//                        height: 80
//                        onClicked: {setzeroDialog.close()/*;loginDialog.visible = false*/}//;circularView.blurScreena("Origin")}
//                    }
////                            Button{
////                                Label{
////                                    anchors.centerIn: parent
////                                    text: "OK"
////                                    font.pixelSize: 20
////                                }
////                                isDefault: true
////                                focus: true
////                                width: 150
////                                height: 80
////                                onClicked: {loginDialog.close()}
////                            }
//               // }
//            }
//            Column {
//                id: errcolumn
//                spacing: 20
//                Row{
//                    spacing: 20
//                    Label{id:setzd1; visible:false;font.pixelSize:UIStyle.fontSizeXXL;text:;color:UIStyle.colorQtWhite1}
//                  //  TextField{id:userName; previewText: "";onFocusChanged: {inputPanel.visible = true; inputPanel.y = 50;loginDialog.height = 700}enterKeyAction: EnterKeyAction.Next;onEnterKeyClicked:password.focus = true; width: 300;height: 60;validator: RegExpValidator { regExp: /^[0-9A-Za-z\-_*@#%&<>""''()={}~\ ]{1,16}$/}}
//                }
//            }

//        }
//        //-----------------------------------------------------------------------------------------------------------

//    }




//--------------------------------------------

    Dialog {
            id: userBlockedDialog
            visible: false
            height: 300
            width: blkMsg.contentWidth
   //         standardButtons: StandardButton.Ok
            title:  "Add User Window!!!"
         contentItem: FocusScope{
            Column {
                id: userBlockedColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:blkMsg;font.pixelSize:UIStyle.fontSizeM;text:adminName + " IS BLOCKED. PLEASE CONTACT YOUR ADMINISTRATOR!!";color:UIStyle.colorCameaoPink}
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
                    onClicked:{userBlockedDialog.close();adminPass = "";addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";loginDialog.open()}
                }
             }

         }


    //        onAccepted: {adminPass = "";addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";loginDialog.open()}
    //        onVisibleChanged:{entryCnt = entryCnt +1;if(UIStyle.retData=="Blur"){entryCnt = entryCnt +1;UIStyle.retData = "";}else {if(entryCnt == 4){entryCnt = 0;circularView.blurScreena("Origin")}}}
    }


    Rectangle{
        id:passwordDialog
        visible: false
        Label{text: "Password must contain"}
        Image {
            id: toolTipimg1
            source: "Weather/images/tooltip.png"
        }
    }



    Dialog {
            id: addUsrOkDialog
            visible: false
            height: 300
            width: warmMsg6.contentWidth + 200
  //          standardButtons: StandardButton.Ok
            title:  "Add User Window!!!"
        contentItem: FocusScope{
            Column {
                id: addUsrOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg6;font.pixelSize:UIStyle.fontSizeM;text:"User added successfully!!!!";color:UIStyle.colorQtblk}
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
                    onClicked:{addUsrOkDialog.close();savetextfield.statusFile(adminName,"Inactive");addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}
                }
             }

         }
     //       onAccepted: {savetextfield.statusFile(adminName,"Inactive");addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}

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
                    onClicked:{existUsrOkDialog.close();addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}
                }
             }

         }


    //        onAccepted: {addNewUserPass = "";addNewCnfmPass = "";adminName = "";newUserName.text = "";addNewUsrDialog.open()}
    }




    Dialog {
            id: chngUsrOkDialog
            visible: false
            height: 300
            width: warmMsg7.contentWidth + 200
    //        standardButtons: StandardButton.Ok
            title:  "Password Change Window!!!"
        contentItem: FocusScope{
            Column {
                id: chngUsrOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg7;font.pixelSize:UIStyle.fontSizeXXL;text:":Password change Successfully!!!!";color:UIStyle.colorQtblk}
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
                    onClicked:{chngUsrOkDialog.close()}
                }
             }

         }

   //         onAccepted: {}
    }


    Dialog {
            id: chngUsrFailDialog
            visible: false
            height: 300
            width:pwdWrong.contentWidth + 200
  //          standardButtons: StandardButton.Ok
            title:  "Password Change Window!!!"
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
                    onClicked:{chngUsrFailDialog.close();chngPassDialog.open()}
                }
             }

         }


//            onAccepted: {chngPassDialog.open()}

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
                    onClicked:{pwdFailDialog.close();addNewUsrDialog.open()}
                }
             }

         }

    //        onAccepted: {}
    }

    Dialog {
            id: loginOkDialog
            width: warmMsg.contentWidth + 200
            visible: false
           height: 300
       //     standardButtons: StandardButton.Ok
            title:  "Login Success!!!"

//            Label{text: "LOGOUT";anchors.centerIn: parent;anchors.left: parent.left;font.pointSize: 25}
//---------------------------------------------------------------------------------------------------------------------
    contentItem: FocusScope{
            Column {
                id: loginOkColumn
                spacing: 50
                Row{
                    spacing: 50
                    Label{id:warmMsg;font.pixelSize:UIStyle.fontSizeXXL;text: UIStyle.oldPass + " : " + adminName +" is logged in";color:UIStyle.colorQtblk}
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
                    onClicked:{loginOkDialog.close();loginLblGrpName = UIStyle.oldPass; loginLblName = adminName;savetextfield.overWriteFile(loginLblGrpName,loginLblName);savetextfield.statusFile(loginLblName,"Active"); if(UIStyle.scrEnabled == "2"){changePass.visible = true;addNewUserbtn.visible = true};UIStyle.scrEnabled = "0"}
                }
             }

   }

//---------------------------------------------------------------------------------------------------------------------


    //        onAccepted: {loginLblGrpName = UIStyle.oldPass; loginLblName = adminName;savetextfield.overWriteFile(loginLblGrpName,loginLblName);savetextfield.statusFile(loginLblName,"Active"); if(UIStyle.scrEnabled == "2"){changePass.visible = true;addNewUserbtn.visible = true};UIStyle.scrEnabled = "0"}
    }
    Dialog {
            id: logoutOkDialog
            width: warmMsg8.contentWidth + 200
           height: 300
            visible: false
  //          standardButtons: StandardButton.Ok
            title:  "Logout Success!!!"
 contentItem: FocusScope{
            Column {
                id: logoutOkColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{
                        id:warmMsg8;
                        font.pixelSize:UIStyle.fontSizeXXL;
                        text: loginLblGrpName + " : " + loginLblName + " press OK to LOG OUT"; //" is logged out.";
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
                    onClicked:{logoutOkDialog.close();loginLblGrpName = "";loginLblName = "";}
                }
             }

   }

 //           onAccepted: {loginLblGrpName = "";loginLblName = "";}
    }
    Dialog {
            id: loginFailDialog
            width: warmMsg1.contentWidth + 200
            height: 300
            visible: false
  //          standardButtons: StandardButton.Ok
            title:  "Login Failed!!!"
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
                    onClicked:{loginFailDialog.close();loginDialog.open()}
                }
             }

        }

  //          onAccepted: {loginDialog.open()}
    }
    Dialog {
            id: acessDeniedDialog
            width: warmMsg2.contentWidth
            visible: false
           height: 300
   //         standardButtons: StandardButton.Ok
            title:  "Warning....!!!"
     contentItem: FocusScope{
            Column {
                id: acessDeniedColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg2;font.pixelSize:UIStyle.fontSizeXXL;text:"Acess Denied!!";color:UIStyle.colorCandyPink}
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
                    onClicked:{acessDeniedDialog.close()}
                }
             }

         }


    //        onAccepted: {}
    }
    Dialog {
            id: changePassFailDialog
            width: warmMsg3.contentWidth
            height: 300
            visible: false
  //          standardButtons: StandardButton.Ok
            title:  "Login Failed!!!"
        contentItem: FocusScope{
            Column {
                id: changePassFailColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:warmMsg3;font.pixelSize:UIStyle.fontSizeXXL;text:"Something went wrong!!Try again!!";color:UIStyle.colorCandyPink}
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
                    onClicked:{changePassFailDialog.close();chngPassDialog.open()}
                }
             }

        }

 //           onAccepted: {chngPassDialog.open()}
    }

    //------------------toggling the selection file----------------------------------
        function changeSelection(){
            for (var j =0; j<avlUsrGrpmodel.count; ++j)
               {
                   if (avlUsrGrpmodel.get(j).selected){
                       avlUsrGrpmodel.setProperty(j,"selected",false);

                  //     j=0; //read from the start! Because index has changed after removing
                   }
               }

        }
    //-------------------------------------------------------------------------------





    Label{id:loginLblGrpNm;anchors.left: parent.left;anchors.leftMargin:1300;font.pixelSize:UIStyle.fontSizeXXL;text:loginLblGrpName;color: UIStyle.colorQtBrown1}
    Label{id:loginLblNm;anchors.left: parent.left;anchors.leftMargin: 1596;font.pixelSize:UIStyle.fontSizeXXL;text:loginLblName;color: UIStyle.colorQtBrown1}
    //Label{id:dateTimeLbl;font.pixelSize:UIStyle.fontSizeS;text:"TIME: " + timeString;color: UIStyle.colorQtBrown1}
}
