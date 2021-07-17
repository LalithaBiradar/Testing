import QtQuick 2.7
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Controls 1.2
import QtQuick 2.0

//import QtGraphicalEffects 1.0
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0

import QtQuick.Scene3D 2.0

import "qml"
import "qml/Style"



//import QtGraphicalEffects 1.0

QQC2.ApplicationWindow {
    id: window

    property bool headeren:false
    property bool convonsts:false
    property string chngpassen:  " "
    property string chngpassName
    property variant chngPassUsernm: chngpassName.split('\n')
    property int pgNum

    property bool displayfg:false




    visible: true

    width: 1920
    height: 1080
  //  color: "#264c73"

    title: qsTr("CHECKWEIGHER CW1200")

    signal submitTextField(string text)


          function setTextField(text){
                console.log("setTextField:" + text)
         }

         function vlChanged(text){
             console.log("Integer list is:"+text)
             UIStyle.prd_code1 = text
             submitTextField(UIStyle.prd_code1)
         }

         function mainpage(msg){
             console.log("recvd from clock")
              stackView.pop(null)
             stackView.pageSw(Qt.resolvedUrl("qrc:/qml/Fitness/FitnessPage.qml"))


         }

//         function mainstats(text){
//             console.log("STATS parameters are:"+text)
//             UIStyle.fileList = text

//         }


         function updateByteString(byteStr) {
             console.log(byteStr)
             UIStyle.netWt = byteStr + "g"

         }

         function updatedynamicString(byteStr,byteStr1,byteStr2,byteStr3,byteStr4,byteStr5) {
             console.log(byteStr)
             UIStyle.netWt = byteStr + "g"
             UIStyle.uw_counts = byteStr4
            UIStyle.ow_counts = byteStr5
           UIStyle.acp_counts = byteStr1
           UIStyle.std_deviation = byteStr2
           UIStyle.avgxWt = byteStr3

         }


         function updateRTCString(byteStr1,byteStr2,byteStr3) {

             date.text = byteStr2 +"/"+ byteStr1 +"/20"+ byteStr3
             UIStyle.current_date = date.text

         }
         function updateRTCTimeString(byteStr1,byteStr2,byteStr3) {

             time.text = byteStr1 +":"+ byteStr2 +":"+ byteStr3

         }


         function updateUWByteCounts(byteStr) {

             console.log(byteStr)
               UIStyle.uw_counts = byteStr

         }
         function updateOWByteCounts(byteStr) {

             console.log(byteStr)

             UIStyle.ow_counts = byteStr

         }
         function updateOKByteCounts(byteStr,byteStr1,byteStr2,byteStr3,byteStr4) {

             console.log(byteStr)
               UIStyle.uw_counts = byteStr3
              UIStyle.ow_counts = byteStr4
             UIStyle.acp_counts = byteStr
             UIStyle.std_deviation = byteStr1
             UIStyle.avgxWt = byteStr2

         }
         function updateDcompFact(byteStr) {
        //     rxByteVals.text = byteStr + "g";
             console.log(byteStr)
            UIStyle.dycomp_factor = byteStr
             console.log("factor:"+UIStyle.dycomp_factor)


         }


         function handleIntArrList(text){
             console.log("the integer array data recived is:" + text)

         }

         function lineChartData(xVal,yVal){
             console.log("data to linechart for xcordinate is:" + xVal)
             console.log("data to linechart for ycordinate is:" + yVal)
             UIStyle.xCordinate = xVal
             UIStyle.yCordinate = yVal

        }
         function handleSaveTextField(text){
            console.log("handleSaveTextField:" + text)
            UIStyle.fileParam = text;
             console.log("the data recived is:" + UIStyle.fileParam)

    }
         function handleSaveFileList(text){
            console.log("handleSaveTextField:" + text)
            UIStyle.fileList = text;
             console.log("the data recived is:" + UIStyle.fileList)
    }
         function handleUserStatusFile(text){
            console.log("handleUserStatusFile:" + text)
            UIStyle.fileList = text;
             console.log("the data recived for blockUnblk:" + UIStyle.fileList)
    }
         function handleErrorExistFile(text){
            console.log("handleErrorExistFile:" + text)
            UIStyle.fileNameExist = text;
             console.log("the data recived for error display in createRecipe:" + UIStyle.fileList)
    }

         function chkFileExist(text){
            console.log("handleSaveTextField:" + text)
            UIStyle.fileNameExist = text;
             console.log("the msg recived is:" + UIStyle.fileNameExist)
    }
       function handleSubmittFileParam(text1,text2,text3){

        console.log("The Usename is:" + text1)
        console.log("The Password is:" + text2)
           UIStyle.oldUserName = text1;
           UIStyle.oldPass = text2;
           UIStyle.expiry_Days = text3;


    }
       Connections{
           target: savetextfield
           onDisablescr:{
               if(text == "SCRD"){
                       console.log("signal comes from fitness page")
                   console.log("Timer restart....")
                      idlefortm.restart();
               var group = chngpassName.split('\n');
                if(group[0] === "Admin"){
                    UIStyle.prdName = "123456789";
                    console.log("Admin authority is:"+UIStyle.prdName)

                }
                else{

                    savetextfield.sendPrevilageStatus(group[0])
                }

               }
               if(text == "LE"){
                   convonsts = false
                   backButton.visible = true

                    idlefortm.start();
                   logdialogue.visible = true;


               }
               if(text == "LD"){
                   convonsts = true
                   backButton.visible = false

                   idlefortm.stop();
                  logdialogue.visible = false;


               }
               if(text == "RT"){
                   if(convonsts == false)
                   {
                       console.log("Timer restart....")
                          idlefortm.restart();
                   }
               }
               if(text == "LT"){
                console.log("logout time....")
                   idlefortm.restart();
               }

           }
       }



    background: Image {

        id:backimage
        height: 1080
        width: 1920

    //    source: "images/background.png"
        source: "images/backimage6.png"
     //   source: "images/blurbackimage6.png"
//        transform: Rotation {
//            id: sceneRotation
//            axis.x: 1
//            axis.y: 0
//            axis.z: 0
//            origin.x: backimage.width
//            origin.y: backimage.height/2
//        }

//        Scene3D {
//            id: scene3d
//            anchors.fill: parent
//            anchors.margins: 10
//            focus: true
//            aspects: ["input", "logic"]
//            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

//        }

//        SequentialAnimation {
//                       id: animation

//                       RotationAnimation {
//                           to: 45
//                           duration: 1000
//                           target: sceneRotation
//                           property: "angle"
//                           easing.type: Easing.InOutQuad
//                       }
//                       PauseAnimation { duration: 500 }
//                       RotationAnimation {
//                           to: 90
//                           duration: 1000
//                           target: sceneRotation
//                           property: "angle"
//                           easing.type: Easing.InOutQuad
//                       }
//                       PauseAnimation { duration: 500 }
//                       RotationAnimation {
//                           to: 135
//                           duration: 1000
//                           target: sceneRotation
//                           property: "angle"
//                           easing.type: Easing.InOutQuad
//                       }
//                       PauseAnimation { duration: 500 }
//                       NumberAnimation {
//                           to: 0.5
//                           duration: 1000
//                           target: backimage
//                           property: "scale"
//                           easing.type: Easing.OutElastic
//                       }
//                       PauseAnimation { duration: 500 }
//                       NumberAnimation {
//                           to: 1.0
//                           duration: 1000
//                           target: backimage
//                           property: "scale"
//                           easing.type: Easing.OutElastic
//                       }
//                       PauseAnimation { duration: 500 }
//                       RotationAnimation {
//                           to: 0
//                           duration: 1000
//                           target: sceneRotation
//                           property: "angle"
//                           easing.type: Easing.InOutQuad
//                       }
//                   }
//        Timer {
//               interval: 1000; running: true; repeat: true;
//               onTriggered: animation.start();
//             //  triggeredOnStart: animation.start();
//           }

    }


    header:

     //   Row {
    //    spacing: 100
        Rectangle{
        width: 1920
        height: 120
        border.color: "yellow"
        border.width: 2
        color: "transparent"


        Row {
        id:headerRow
        x:100
        spacing: 120

        LoginDialogue{
            id:logdialogue
            width: 100
            height:80
            y:20
            color: "peru"
            onClicked: {}
            onPassStatus: {chngpassen = text; console.log("passStatus is:"+text); if((chngpassen =="1") && (backButton.enabled === false)&& (UIStyle.idleforfg == true)){headeren = true;/*changePass.visible = true*/;changeUsrProfile.visible = true;usrPrevilage.visible = true;usrBlckUnblck.visible = true;addNewUsr.visible = true;loginHeader.visible = true;}
                /*else{headeren = false;changePass.visible = false;changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;addNewUsr.visible = false;expiryDayslbl.visible = false}*/else if((chngpassen == "2") && (backButton.enabled === false)){/*headeren = true;*/loginHeader.visible = true;changePass.visible = true;expiryDayslbl.visible = true}
                else if((chngpassen == "2") && (backButton.enabled === true)){expiryDayslbl.visible = true;loginHeader.visible = true;}else{headeren = false;changePass.visible = false;changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;addNewUsr.visible = false;expiryDayslbl.visible = false}}
            onPassName:{ loginHeader.text = text;console.log("user name:"+loginHeader.text);chngpassName = text;console.log("user name pass:"+chngPassUsernm[0]);if(loginLblGrpName.indexOf("Admin") === 0){UIStyle.prdName = "123456789"}else{savetextfield.sendPrevilageStatus(chngPassUsernm[0])}}

        }
        Addnewuser{
            id:addNewUsr
            visible: false
            width: 100
            height: 40
            y:40
            color: "peru"
            onClicked: { }
            onPassStatus:{calendar_date = date.text;if(sts == "1"){logdialogue.enabled = false;changePass.enabled = false;changeUsrProfile.enabled = false;usrPrevilage.enabled = false;usrBlckUnblck.enabled = false}
                else{logdialogue.enabled = true;changePass.enabled = true;changeUsrProfile.enabled = true;usrPrevilage.enabled = true;usrBlckUnblck.enabled = true}}
        }

        ChangePassword{
            id:changePass
            visible: false
            width: 100
            height: 40
            y:40
            color: "peru"
            onClicked: {adminName = chngPassUsernm[1];adminNameGroup = chngPassUsernm[0]; console.log("the username is:"+chngPassUsernm[1]);console.log("the group name is:"+chngPassUsernm[0])}
            onPassStatuschngPass:{ if(sts == "1"){logdialogue.enabled = false;addNewUsr.enabled = false;changeUsrProfile.enabled = false;usrPrevilage.enabled = false;usrBlckUnblck.enabled = false}
                else if(sts == "0"){changePass.visible = false;logdialogue.active = false;logdialogue.text = "Login";expiryDayslbl.visible = false; }else{logdialogue.enabled = true;addNewUsr.enabled = true;changeUsrProfile.enabled = true;usrPrevilage.enabled = true;usrBlckUnblck.enabled = true}}

        }
        ChangeusrProfile{
            id:changeUsrProfile
            visible: false
            width: 100
            height: 40
            y:40
            color: "peru"
            onPassStatus:{ if(sts == "1"){logdialogue.enabled = false;addNewUsr.enabled = false;changePass.enabled = false;usrPrevilage.enabled = false;usrBlckUnblck.enabled = false}
                else{logdialogue.enabled = true;addNewUsr.enabled = true;changePass.enabled = true;usrPrevilage.enabled = true;usrBlckUnblck.enabled = true}}
        }
        UserPrevilage{
            id:usrPrevilage
            visible: false
            width: 100
            height: 40
            y:40
            color: "peru"
            onPassStatus:{ if(sts == "1"){logdialogue.enabled = false;addNewUsr.enabled = false;changeUsrProfile.enabled = false;changePass.enabled = false;usrBlckUnblck.enabled = false}
                else{logdialogue.enabled = true;addNewUsr.enabled = true;changeUsrProfile.enabled = true;changePass.enabled = true;usrBlckUnblck.enabled = true}}
        }
        Userblckunblck{
            id:usrBlckUnblck
            visible: false
            width: 100
            height: 40
            y:40
            color: "peru"
            onClicked: {}
            onPassStatus:{calendar_date = date.text;if(sts == "1"){logdialogue.enabled = false;addNewUsr.enabled = false;changeUsrProfile.enabled = false;usrPrevilage.enabled = false;changePass.enabled = false}
                else{logdialogue.enabled = true;addNewUsr.enabled = true;changeUsrProfile.enabled = true;usrPrevilage.enabled = true;changePass.enabled = true}}
        }
        Label{id:expiryDayslbl;visible:false; text:"Expired on:"+"\n"+UIStyle.expiry_Days;font.pixelSize: 30;color: "red"}

    }
    }


   // }
//    Rectangle{  //removed overlapping name & image not allowed.
//        x:1400
//        y:-110
//        width: 150
//        height:110
//        Image {
//            id: loginIcon
//            anchors.fill:parent
//            source: "/images/login_icon.jpeg"
//        }
//    }


    Label{id:loginHeader
            x:1400
            y:-90

            text:""
            font.pixelSize: 35
    }
    Label{id:time
        width: 100
        height: 40
        x:1750
        y:-50
        font.pixelSize: 30
        text: ""
        color: "white"
    }

    Label{id:date

        x:1750
        y:-90

        width: 100
        height: 40
        font.pixelSize: 30
           text: ""
           color: "white"
    }
    NaviButton {
            id: backButton
            x:1200
            y:-120
            height: 120
            edge: Qt.TopEdge
            enabled: stackView.depth > 1
            imageSource: "images/back.png"

            onClicked: {if(pgNum == 1){
                   savetextfield.disableScreen1("3");stackView.pop();console.log("from stats to back");
                 }else{ stackView.pop();console.log("from stats");savetextfield.disableScreen1("3");}}
            onEnabledChanged:{console.log("text value is:"+chngpassen); if(backButton.enabled === true){changePass.visible = false;changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;addNewUsr.visible = false;console.log("backbutton Enabled")}
                else{if(((headeren == true) | (chngpassen == "1")) && (UIStyle.idleforfg == true) && (chngpassen.indexOf("2") !== 0) ){/*changePass.visible = true*/;console.log("INout"); changeUsrProfile.visible = true;usrPrevilage.visible = true;usrBlckUnblck.visible = true;addNewUsr.visible = true}
                    else{if((chngpassen == "2") &&(UIStyle.idleforfg == true)){changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;addNewUsr.visible = false;changePass.visible = true;}}; console.log("backbutton disabled")}}

}

    Timer{
        id:idlefortm
     //   interval: 500000;running: UIStyle.idleforfg;repeat:true
        interval: UIStyle.logout_time*60000;running: UIStyle.idleforfg;repeat:true
        onTriggered:{if((stackView.depth > 1) && (displayfg)){}else{stackView.pop(null);} logdialogue.enabled = true; logdialogue.active = false;logdialogue.text = "Login"; UIStyle.idleforfg = false;changePass.visible = false;changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;
            addNewUsr.visible = false;/*loginHeader.text = "";expiryDayslbl.text = "";*/ loginHeader.visible = false;expiryDayslbl.visible = false;console.log("timer end");savetextfield.closeDialogue("1")}
        }







//    header: NaviButton {
// //   NaviButton {
//        id: homeButton

//        edge: Qt.TopEdge
//        enabled: stackView.depth > 1
//        imageSource: "images/home.png"
//        Label{id:date
//            width: 100
//            height: 40
//            font.pixelSize: 30
//               text: "24/04/2018"
//               color: "white"
//        }
//        Label{id:time
//            width: 100
//            height: 40
//            anchors.right:parent.right
//            anchors.rightMargin: 40
//            font.pixelSize: 30
//               text: "04:30:00"
//               color: "white"
//        }


//        onClicked: stackView.pop(null)
//    }

//    footer: NaviButton {
//        id: backButton
//        height: 80
//        edge: Qt.BottomEdge
//        enabled: stackView.depth > 1
//        imageSource: "images/back.png"

//        onClicked: {if(pgNum == 1){
//               savetextfield.disableScreen1("3");stackView.pop()
//             }else{ stackView.pop()}}
//        onEnabledChanged:{console.log("text value is:"+chngpassen); if(backButton.enabled === true){changePass.visible = false;changeUsrProfile.visible = false;usrPrevilage.visible = false;usrBlckUnblck.visible = false;addNewUsr.visible = false;console.log("backbutton Enabled")}else{if((headeren == true) | (chngpassen == "1")){changePass.visible = true;changeUsrProfile.visible = true;usrPrevilage.visible = true;usrBlckUnblck.visible = true;addNewUsr.visible = true}else{if(chngpassen == "2"){changePass.visible = true}}; console.log("backbutton disabled")}}


//    }


    QQC2.StackView {

        id: stackView
        objectName: "stackView"

        focus: true
        anchors.fill: parent

        initialItem: LauncherPage {
            onLaunched: {stackView.push(page);console.log("Initial page is:"+page); if(page == "qrc:/qml/Fitness/FitnessPage.qml" ){displayfg = true; console.log("fitness page open main qml")}else{displayfg = false; console.log("fitness page close")}}
            onBlurScreena: {UIStyle.retData = text;console.log("received is:"+UIStyle.retData); backimage.width =1920;backimage.height = 1080;if(UIStyle.retData == "Blur"){backimage.source = "images/blurbackimage6.png"}else{backimage.source = "images/backimage6.png"}}

        }

        function rcvedSignal(msg){
            console.log("i recieved the signal from other qml")
               submitTextField(msg)

        }
        function pageSw(page){
            console.log("i recieved the signal from other qml")
             stackView.push(page)
            console.log("the page is:"+page)
        }



        function sendText(msg){
            console.log("i recieved the signal from other qml")
              submitTextField(msg)
        }
       function dialogClosed(msg){
   //         console.log("2nd page swipeview closed dialogClosed:"+msg)
            stackView.pop(null)

        }
       function swipeviewpg(msg){
            console.log("2nd page swipeview closed:"+msg)
           pgNum = msg
    //        stackView.pop(null)


        }


    }

}
