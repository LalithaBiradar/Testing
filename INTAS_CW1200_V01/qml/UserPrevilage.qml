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
    id: userPrevilageButton
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
     property string functionNm: ""
    property string functionRec: ""
     property string functionIndex: ""
    property string functionIndexNum: ""
    property string previlageStatus: ""
    property bool functPresent: false
   // property alias adminPass: password.text
  //  property alias oldPass: oldPassword.text
  //  property alias newPass: newPassword.text
  //  property alias cnfPass: cnfPassword.text
  //  property alias addNewUserPass: addNewUsrPassword.text
  //  property alias addNewCnfmPass: addNewCnfPassword.text
    property string adminNameGroup: ""
  //  property alias loginLblGrpName: loginLblGrpNm.text
  //  property alias loginLblName: loginLblNm.text
 //   property bool timerOnOff: false
    property string userNamePass:"tepl"
    property string loginName:"Administrator"

    property int indexNo

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
        text: "USER\nPREVILAGE"
        color: "white"
        font.pointSize: 25
        visible: false
    }

    Repeater {
        id: rpt
        model: 3

        Rectangle {
            id: hex

          //  height: Math.round(userPrevilageButton.width * 0.866 * dummy.scale)
            height: 110 * 0.866 * dummyOff.scale// Math.round(userPrevilageButton.width * 0.866 * dummyOff.scale)
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
         //           userPrevilageButton.clicked()
                    userPrevilageButton.active = !userPrevilageButton.active
                    pulseAnim.running = true
                    if(userPrevilageButton.active == true){
                        userPrevilageButton.passStatus("1")
                        savetextfield.disableScreen("RT")
                        userPrevilageButton.enabled = false
                        UIStyle.scrEnabled = "1"
                        selUsrGrpmodelP.clear(({Group:""}))
                        recAddedUsrGrpPrevilagemodel.clear(({Functionnm:""}))
                        chngUsrGrpPrevilageDialog.open()
                        informationDialog.open()

                    console.log("user previlage dialogue open!!!")
                        dummytext.text = "USER\nPREVILAGE"
                    }
                    else{

                        dummytext.text = "USER\nPREVILAGE"

                    }
                }
                onPressAndHold:
                    userPrevilageButton.pressAndHold()

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
        onStopped: { userPrevilageButton.clicked() }
    }
    Connections{
        target: savetextfield
        onPrevilage_status:{
            previlageStatus = text

            if(previlageStatus == "Success")
            {
            previlagestatusDialog.open()
            addPrevilagebtn.enabled = false
            addGrpbtn.enabled = false
            console.log("userPrevilage")
    //        storePrevilagesBtn.enabled = false
            }

        }
        onClDialogue:{
             console.log("close dialogue after timer end")
            if(text == "1"){
            previlagestatusDialog.close()
            informationDialog.close()
            chngUsrGrpPrevilageDialog.close()
                userPrevilageButton.active = false;
                userPrevilageButton.enabled = true;
                passStatus("0");
                addGrpbtn.enabled = false;
                usrPrevilageListView.enabled = false;
                addPrevilagebtn.enabled = false
            }

         }
    }

    function findIndex(name){
        for(var i = 0; i < usrPrevilagemodel.count; i++) {
            functionNm = usrPrevilagemodel.get(i).functionName;
            if(name === functionNm) {
                console.log("Found it at index : ", i+1);
                functionIndex = i+1;
            }
        }
    }
    function findIndexrec(){
        functionIndex = ""
        functionIndexNum = ""
        for(var i = 0; i < recAddedUsrGrpPrevilagemodel.count; i++) {
            functionNm = recAddedUsrGrpPrevilagemodel.get(i).Functionnm;
            for(var j = 0; j < usrPrevilagemodel.count; j++){
              functionRec =  usrPrevilagemodel.get(j).functionName;
                if(functionNm === functionRec) {
                    console.log("Found it at index : ", j+1);
                    functionIndex = j+1;
                    functionIndexNum = functionIndexNum + functionIndex
                }
            }


        }
         console.log("index of the added function is : "+functionIndexNum);
//        if(functionIndexNum == ""){
//            storePrevilagesBtn.enabled  = false
//        }
    }

    function findFunction(name){
        console.log("count is:" +recAddedUsrGrpPrevilagemodel.count)
        if(recAddedUsrGrpPrevilagemodel.count == 0){
          functPresent = false;
        }

        for(var i = 0; i < recAddedUsrGrpPrevilagemodel.count; i++) {
            functionNm = recAddedUsrGrpPrevilagemodel.get(i).Functionnm;
            if(name === functionNm) {
                console.log("Found it at index : ", i+1);
                functPresent = true
                indexNo = i;
                break;
            }
            else{
                functPresent = false
                console.log("hahahahahaha");
            }
        }

    }
    function updateFunctionList(){

        console.log("the character is:"+UIStyle.oldPass.charAt(0))
        for(var i = 0; i < UIStyle.oldPass.length; i++) {

            functionNm = usrPrevilagemodel.get(UIStyle.oldPass.charAt(i) - 1).functionName;
            recAddedUsrGrpPrevilagemodel.append({Functionnm:functionNm})
        }

    }

    Dialog {
            id: previlagestatusDialog
            width: statusMsg.contentWidth + 200
            height: 200
            x:-400
            y:300
            visible: false
  //          title:  "Logout Success!!!"
  //          closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                       color: "peru"
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
                           text: "STATUS !!!"
                           font.pixelSize: 20
                           color: "black"
                       }
                   }
         contentItem: FocusScope{
            Column {
                id: previlageColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:statusMsg;font.pixelSize:UIStyle.fontSizeXXL;text:previlageStatus ;color:UIStyle.colorQtblk}
                }
            }

        }

    }
    Dialog {
            id: informationDialog
            width: infoMsg.contentWidth + 200
            height: 200
            x:-400
            y:300
            visible: false
  //          title:  "Logout Success!!!"
  //          closePolicy: Popup.CloseOnEscape
            background: Rectangle{
                       color: "peru"
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
                           text: "INFORMATION !!!"
                           font.pixelSize: 20
                           color: "black"
                       }
                   }
         contentItem: FocusScope{
            Column {
                id: infoMsgColumn
                spacing: 20
                Row{
                    spacing: 20
                    Label{id:infoMsg;font.pixelSize:UIStyle.fontSizeXXL;text:"Select group and press ADD GROUP button then\nselect previlages and press ADD PREVILAGES button.";color:UIStyle.colorQtblk}
                }
            }
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
//                    onClicked:{logoutOkDialog.close();loginButton.passName(""); loginLblGrpName = "";loginLblName = "";loginButton.passStatus("0")}
//                }
//             }

        }

    }

    Dialog {
            id: chngUsrGrpPrevilageDialog
            width: 1850
            height:avlUsrgrp.height * 2.6
            x:-750
            y:80
            closePolicy: Popup.CloseOnEscape
  //          title:  "Change User Profile Window"
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
                    id: chngUsrGrpPrevilagecolumn
                    spacing: 10
                    Column{
                        spacing: 50
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        GroupBox{
                            id:avlUsrgrp
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
                                        font.pointSize: 25
                                    }
                                }
                            }

                            TableView {
                                id: previlageView
                                anchors.fill: parent
                                frameVisible: false
                                backgroundVisible: false
                                alternatingRowColors: false
                                sortIndicatorVisible: true
                                clip: true
                                highlightOnFocus: false
                                TableViewColumn {
                                    role: "name"
                                    title: "Group"
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
                                            font.pixelSize: 25
                                        }
                                    }

                                }
                                model: ListModel {
                                    id: avlUsrPrevilagemodel
                                    ListElement { name: "Admin"; }
                                    ListElement { name: "Operator"; }
                                    ListElement { name: "Supervisor"; }
                                    ListElement { name: "Manager"; }
                                    ListElement { name: "Engineer"; }
                                }

                                rowDelegate: Rectangle {
                                    property bool selected : styleData.selected
                                    width: parent.width-2
                                    height: 60
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


                               // onCurrentRowChanged:{adminNameGroup = avlUsrPrevilagemodel.get(__currentRow).name;console.log("adminNameGroup:"+adminNameGroup);if(adminNameGroup.length != 0){console.log("in loop"); addGrpbtn.enabled = true;removePrevilagesBtn.enabled = false}}
                                  onClicked: {savetextfield.disableScreen("RT");adminNameGroup = avlUsrPrevilagemodel.get(__currentRow).name;console.log("adminNameGroup:"+adminNameGroup);if(adminNameGroup.length !== 0){console.log("in loop"); addGrpbtn.enabled = true;removePrevilagesBtn.enabled = false}}

                            }
                        }

                        GroupBox{
                            title: "Previlages"
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
                                        font.pointSize: 25
                                    }
                                }
                            }

                            TableView {
                                id: usrPrevilageListView
                                anchors.fill: parent
                                frameVisible: false
                                backgroundVisible: false
                                alternatingRowColors: false
                                sortIndicatorVisible: true
                                clip: true
                                highlightOnFocus: false
                                enabled: false

                                TableViewColumn {
                                    role: "functionName"
                                    title: "Function List"
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
                                            font.pixelSize: 25
                                        }
                                    }

                                }

                      //      ListView{
                      //          id:funmodel
                      //          clip: true
                     //           currentIndex: -1

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
                                    id: usrPrevilagemodel


                        //            ListElement { functionName: "Statistic Reset"; }
                                    ListElement { functionName: "SET RTC"; }
                                    ListElement { functionName: "SAVE RECIPE"; }
                                    ListElement { functionName: "CALIBRATION"; }
                                    ListElement { functionName: "DYNAMIC COMPENSATION"; }
                                    ListElement { functionName: "BATCH END"; }
                         //           ListElement { functionName: "Feedback ON / OFF"; }
                                    ListElement { functionName: "MODE:"; }
                                    ListElement { functionName: "CW BYPASS ON / OFF"; }
                                  //  ListElement { functionName: "BATCH NUMBER"; }
                                    ListElement { functionName: "CREATE RECIPE"; }
                         //           ListElement { functionName: "SET RTC"; }
                        //            ListElement { functionName: "MODE:"; }

                                }
                    //        }

                                rowDelegate: Rectangle {
                                    property bool selected : styleData.selected
                                    width: parent.width-2
                                    height: 60
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

                          //      onCurrentRowChanged: {if(selUsrGrpmodelP.count > 0){adminName = usrPrevilagemodel.get(__currentRow).functionName;if(adminName.length != 0){ addPrevilagebtn.enabled = true;removePrevilagesBtn.enabled = false}}else{}}
                                 onClicked: {savetextfield.disableScreen("RT");if(selUsrGrpmodelP.count > 0){adminName = usrPrevilagemodel.get(__currentRow).functionName;addPrevilagebtn.enabled = true; if(adminName.length != 0){ addPrevilagebtn.enabled = true;removePrevilagesBtn.enabled = false}}else{}}

                            }
                        }

                    }
                    Column{
                        spacing: 100
                        Button{id:addGrpbtn;enabled: false; width: 300;height: 60;Label{text: "ADD GROUP";anchors.centerIn: addGrpbtn;anchors.left: addGrpbtn.left;font.pointSize: 25}
                            onClicked:{savetextfield.disableScreen("RT");previlageView.selection.clear();addGrpbtn.enabled = false; selUsrGrpmodelP.clear(({Group:""}));recAddedUsrGrpPrevilagemodel.clear(({Functionnm:""})); selUsrGrpmodelP.append({Group:adminNameGroup});
                            if(adminNameGroup === "Admin"){recAddedUsrGrpPrevilagemodel.append({Functionnm:"All functions are available"});recAddedUsrGrpPrevilagesList.enabled = false}else{recAddedUsrGrpPrevilagesList.enabled = true;savetextfield.findPrevilages(adminNameGroup);updateFunctionList();usrPrevilageListView.enabled = true;addPrevilagebtn.enabled = false;usrPrevilageListView.selection.clear()}}}

                        Button{id:addPrevilagebtn;enabled: false; width: 300;height: 60;Label{text: "ADD PREVILAGES";anchors.centerIn: addPrevilagebtn;anchors.left: addPrevilagebtn.left;font.pointSize: 25}
                            onClicked:{savetextfield.disableScreen("RT");findFunction(adminName);if(functPresent == false){console.log("hhhhhhh"); recAddedUsrGrpPrevilagemodel.append({Functionnm:adminName})}addPrevilagebtn.enabled = false;usrPrevilageListView.selection.clear();storePrevilagesBtn.enabled = true}}
                        Button{
                            id:removePrevilagesBtn
                            enabled: false
                            Label{
                                anchors.centerIn: parent
                                text: "REMOVE PREVILAGE"
                                font.pixelSize: 25
                            }
                            isDefault: true
                            focus: true
                            width: 300
                            height: 60
                            onClicked:{savetextfield.disableScreen("RT");if(recAddedUsrGrpPrevilagemodel.count >= 0){storePrevilagesBtn.enabled = true;findFunction(adminName); recAddedUsrGrpPrevilagemodel.remove(indexNo);removePrevilagesBtn.enabled = false;closePrevilagesBtn.enabled = false;recAddedUsrGrpPrevilagesList.selection.clear()}else{removePrevilagesBtn.enabled = false}}
                        }

                        Button{
                            id:storePrevilagesBtn
                            enabled: false
                            Label{
                                anchors.centerIn: parent
                                text: "OK"
                                font.pixelSize: 30
                            }
                            isDefault: true
                            focus: true
                            width: 300
                            height: 60
                            onClicked:{savetextfield.disableScreen("RT");findIndexrec();savetextfield.storePrevilages(adminNameGroup,functionIndexNum);functionIndexNum = "";functionIndex = "";closePrevilagesBtn.enabled = true;removePrevilagesBtn.enabled = false;storePrevilagesBtn.enabled = false}
                        }
                        Button{
                            id:closePrevilagesBtn
                            Label{
                                anchors.centerIn: parent
                                text: "Close"
                                font.pixelSize: 30
                            }
                            isDefault: true
                            focus: true
                            width: 300
                            height: 60
                            onClicked:{savetextfield.disableScreen("RT");previlageView.selection.clear();usrPrevilageListView.selection.clear();recAddedUsrGrpPrevilagesList.selection.clear();functionIndexNum = "";functionIndex = "";UIStyle.scrEnabled = "0";
                                chngUsrGrpPrevilageDialog.close();userPrevilageButton.active = false;userPrevilageButton.enabled = true;userPrevilageButton.passStatus("0");addGrpbtn.enabled = false;usrPrevilageListView.enabled = false;addPrevilagebtn.enabled = false}
                        }
                    }
                    Column{
                        spacing: 50
                        anchors.top: parent.top
                        anchors.topMargin: 30

                        GroupBox{
                            title: "Selected User Group"
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
                                        font.pointSize: 25
                                    }
                                }
                            }


                            TableView {
                                id: selUsrGrp

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
                                    role: "Group"
                                    title: "Group Name"
                                    width: selUsrGrp.width / 2
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


                                model: ListModel {
                                    id: selUsrGrpmodelP
                                    ListElement { Group: "" }

                                }

                                rowDelegate: Rectangle {
                                    property bool selected : styleData.selected
                                    width: parent.width-2
                                    height: 60
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
                                        font.pixelSize: 25
                                    }
                                }

                         //       onCurrentRowChanged: {console.log(selUsrGrpmodelP.get(__currentRow).Group)}

                            }

//                            ListView{
//                                width: 200
//                                height : 100
//                                id:selUsrGrpListP
//                                model: ListModel {
//                                    id: selUsrGrpmodelP
//                                    ListElement { Group: "" }

//                                }


//                            }
                        }

                        GroupBox{
                            title: "Group Previlages List"
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
                                        font.pointSize: 25
                                    }
                                }
                            }


                            TableView {
                                id: recAddedUsrGrpPrevilagesList
                                anchors.fill: parent
                                frameVisible: false
                                backgroundVisible: false
                                alternatingRowColors: false
                                sortIndicatorVisible: true
                                clip: true
                                highlightOnFocus: false

                                TableViewColumn {
                                    role: "Functionnm"
                                    title: "Function List"
                                    width: recAddedUsrGrpPrevilagesList.width / 2
                                    resizable: false
                                    movable: false

                                    delegate: Component {
                                        id: recentprevilagedelegate

                                        Text {
                                            color: "Black"
                                            elide: styleData.elideMode
                                            text: styleData.value
                                            font.family: "Arial"
                                            font.pixelSize: 30
                                        }
                                    }

                                }

                                model: ListModel {
                                    id: recAddedUsrGrpPrevilagemodel
                                    ListElement { Functionnm: ""
                                        //     GroupName:""
                                    }
                                }

                                rowDelegate: Rectangle {
                                    id:modelData
                                    property bool selected : styleData.selected
                                    width: parent.width-2
                                    height: 60
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

                       //         onCurrentRowChanged: {if(recAddedUsrGrpPrevilagemodel.count > 0) {adminName = recAddedUsrGrpPrevilagemodel.get(__currentRow).Functionnm}removePrevilagesBtn.enabled = true;
                      //          addGrpbtn.enabled = false;/*addPrevilagebtn.enabled = false;*/console.log("selected is"+adminName)}
                                 onClicked: {savetextfield.disableScreen("RT");if(recAddedUsrGrpPrevilagemodel.count > 0) {adminName = recAddedUsrGrpPrevilagemodel.get(__currentRow).Functionnm}removePrevilagesBtn.enabled = true;
                                addGrpbtn.enabled = false;/*addPrevilagebtn.enabled = false;*/console.log("selected is"+adminName)}

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
//                    Button{
//                        Label{
//                            anchors.centerIn: parent
//                            text: "Cancel"
//                            font.pixelSize: 20
//                        }
//                        isDefault: true
//                        focus: true
//                        width: 150
//                        height: 80
//                        onClicked:{chngUsrGrpPrevilageDialog.close();userPrevilageButton.active = false;userPrevilageButton.passStatus("0")}
//                    }
                }

            }

    }

}


