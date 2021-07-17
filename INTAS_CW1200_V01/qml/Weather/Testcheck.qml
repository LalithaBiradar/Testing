import QtQuick 2.7
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2

import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

import QtQuick.Scene3D 2.0

//import "weather.js" as WeatherData
import "../Style"


Item {
    width: 1920
    height: 1080

    Item{

       id: prdSetup
       anchors.fill: parent
       property bool bImgChange: true
       property bool pressed: true
       width: 1920
       height: 1080

       enabled: UIStyle.idleforfg

       anchors.rightMargin: 1
       anchors.bottomMargin: 89
       anchors.leftMargin: 0
       anchors.topMargin: 0
       Connections{
           target: savetextfield
          onDisablescr1:{
               console.log("login action in fitnesspage")
              if(cnt == 1){
              prdSetup.enabled = false

              }
              if(cnt == 2){
              prdSetup.enabled = true

              }
           }
       }

//       background: Rectangle{
//              gradient: Gradient {
//                  GradientStop { position: 0.0; color: "#ffffff" }
//                  GradientStop { position: 1.0; color: "blue" }
//              }


//    Rectangle {
//        anchors.horizontalCenter: parent.horizontalCenter
//        width: parent.width
//        height: titleRow.height
//        radius: 2
//        border.color: "#d8fa2a"
//        gradient: Gradient {
//            GradientStop {
//                position: 0
//                color: "#ccb0f8"
//            }

//            GradientStop {
//                position: 0.997
//                color: "#ffffff"
//            }

//            GradientStop {
//                position: 1
//                color: "#000000"
//            }

//        }


//        Row {
//            id: titleRow
//            spacing: 10
//            anchors.centerIn: parent

//            Image {
//                anchors.verticalCenter: parent.verticalCenter
//                source: "images/prd_setup11_small.png"
//                fillMode: Image.PreserveAspectCrop
//            }
//            Text {
//                color: "#79554a"
//                anchors.verticalCenter: parent.verticalCenter
//                text: qsTr("PRODUCT SETUP")
//                styleColor: "#21f999"
//                font.capitalization: Font.AllUppercase
//                font.weight: Font.ExtraLight
//                style: Text.Raised
//                fontSizeMode: Text.Fit
//                renderType: Text.NativeRendering
//                horizontalAlignment: Text.AlignHCenter
//                wrapMode: Text.WrapAnywhere
//                font.pixelSize: UIStyle.fontSizeM
//                font.letterSpacing: 1
//            }
//        }

//    }

 //      Item {
//           Text {
//               text: "Click me!"
//               anchors.top: parent.top
//               anchors.topMargin: 10
//               anchors.horizontalCenter: parent.horizontalCenter

//               MouseArea {
//                   anchors.fill: parent
//                   onClicked: animation.start()
//               }
//           }

//           Text {
//               text: "Multisample: " + scene3d.multisample
//               anchors.bottom: parent.bottom
//               anchors.bottomMargin: 10
//               anchors.horizontalCenter: parent.horizontalCenter

//               MouseArea {
//                   anchors.fill: parent
//                   onClicked: scene3d.multisample = !scene3d.multisample
//               }
//           }


//       Rectangle {
//           id: rectangle1
//           y: 0
//           width: 1920
//           anchors.horizontalCenter: prdSetup.horizontalCenter
//           height: 40
//           color: "#ffaa7f"
//           clip: false
//           gradient: Gradient {
//               GradientStop {
//                   position: 0
//                   color: "#76edfc"
//               }

//               GradientStop {
//                   position: 1
//                   color: "#000000"
//               }
//           }

//           anchors.horizontalCenterOffset: 0

//           Row {
//               id: titleRowPage1
//               spacing: 10
//               anchors.centerIn: parent

//               Image {
//                   anchors.verticalCenter: parent.verticalCenter
//                   source: "images/prd_setup11_small.png"
//                   fillMode: Image.PreserveAspectCrop
//               }
//               Text {
//                   color: "#ffffff"
//                   anchors.verticalCenter: parent.verticalCenter
//                   text: qsTr("PRODUCT SETUP")
//                   font.pixelSize: UIStyle.fontSizeM
//                   font.letterSpacing: 2
//               }
//           }
//            Component.onCompleted: savetextfield.disableScreen("1")
//       }

       Label{
           x:750
           y: 50
           text: "PRODUCT SETUP"
           font.pixelSize: 50
           color: "white"
       }



//    Column{
//        x: 176
//        y: 125
//        spacing: 80
 //   Row{
//        spacing: 150
        Button {
        id:backgroundPrdData
        x: 796
        y: 560
   //     width: 247
   //     height: 129
        width: 265
        height: 290
        Text {
            id: name
            x: 20
            y: 255
            color: "red"          //"#faffff"
            text: qsTr("SAVE RECIPE")
            anchors.horizontalCenterOffset: 0
            font.pointSize: 24
            font.family: "Times New Roman"
            font.bold: true

        }

        style: ButtonStyle {

            background: Rectangle {
                id: backImagePrdData
                implicitWidth: backgroundPrdData.width
                implicitHeight: backgroundPrdData.height
                border.color: UIStyle.colorCaribbeanGreen
                color: "blue"
 //               radius: UIStyle.bRadius
                radius: 10


                    Image{
                        id:prdDataImage
                        anchors.centerIn: parent
                     //   source:{ backgroundPrdData.pressed ? "images/product_data_page.png" : "images/product_data_page_small.png"}
                        source:{ backgroundPrdData.pressed ? "images/save_recipe1.png" : "images/save_recipe1.png"}
                        onImplicitHeightChanged: if(backgroundPrdData.pressed == true){backImagePrdData.implicitWidth = backImagePrdData.implicitWidth + 50;backImagePrdData.implicitHeight = backImagePrdData.implicitHeight + 50}else{backImagePrdData.implicitWidth = 145;backImagePrdData.implicitHeight =170}

                    }

                gradient: Gradient {
                 //   GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCameaoPink : UIStyle.colorCandyPink}
                    GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorQtblk : UIStyle.colorQtGray1}
                   }

                }

          }


       //     onClicked:{pageSw(Qt.resolvedUrl("qrc:/qml/Weather/PrdDataPage.qml"))}
            onClicked: {if((UIStyle.prdName.indexOf("2") >= 0)){console.log("param edit btn pressed");pageSw(Qt.resolvedUrl("qrc:/qml/Weather/PrdDataPage.qml"))}else{authFailDialogpg2.open()}}
    }

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

    Button {
        id:backgroundPrdFile
        x: 796
        y: 157
    //    width: 247
    //    height: 129
        width: 247
        height: 250
        Text {
            id: prdFileBtntext
            x: 20
            y: 200
            color: "red"        //"#faffff"
            text: qsTr("CREATE RECIPE")
            anchors.horizontalCenterOffset: 0
            font.pointSize: 22
            font.family: "Times New Roman"
            font.bold: true
            anchors.horizontalCenter:backgroundPrdFile.horizontalCenter
        //    anchors.bottomMargin: UIStyle.labelPos
        }
    //    text: "CREATE RECIPE"
        checkable: true
        checked: true

        style: ButtonStyle {

            background: Rectangle {
                id: backImagePrdLib
                 property bool pressed: true
                 implicitWidth: backgroundPrdFile.width
                 implicitHeight: backgroundPrdFile.height
            //     border.width: control.activeFocus ? 2 : 1
                 border.color: UIStyle.colorCaribbeanGreen
                 color: "gray"
//                 radius: UIStyle.bRadius
                 radius: 10
//                Label{
//                    text: UIStyle.prdLbIconName
//            //        width: backImagePrdLib.implicitWidth
//                    font.pixelSize: UIStyle.fontSizeXS
//                    color: UIStyle.colorQtWhite1
//                    anchors.bottom:  prdLibImage.bottom
//                    anchors.horizontalCenter:prdLibImage.horizontalCenter
//                    anchors.bottomMargin: UIStyle.labelPos
//                }

                Image{
                    id:prdLibImage
                    anchors.centerIn: parent
                //    source:{ backgroundPrdFile.pressed ? "images/prd_lib1.png" : "images/prd_lib_small.png"}
                    source:{ backgroundPrdFile.pressed ? "images/create_recipe1.jpeg" : "images/create_recipe1.jpeg"}
                    onImplicitHeightChanged: if(backgroundPrdFile.pressed == true){backImagePrdLib.implicitWidth = backImagePrdLib.implicitWidth + 20;backImagePrdLib.implicitHeight = backImagePrdLib.implicitHeight + 20}else{backImagePrdLib.implicitWidth = 145;backImagePrdLib.implicitHeight =170}
                    }
                gradient: Gradient {
                //    GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCeladonGreen }
                    GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorQtblk : UIStyle.colorQtGray1}
                   }

                }

          }

       // onClicked:  pageSw(Qt.resolvedUrl("qrc:/qml/Weather/CraeteSavePrdFile.qml"))
        onClicked: {if((UIStyle.prdName.indexOf("8") >= 0)){console.log("CraeteSavePrdFile btn pressed");pageSw(Qt.resolvedUrl("qrc:/qml/Weather/CraeteSavePrdFile.qml"))}else{authFailDialogpg2.open()}}
    }

 //   }



 //   Row{


 //       spacing: 150

//        Button {
//            id:backgroundStats
//            x: 290
//            y: 443
//            width: 247
//            height: 129
//            scale: 0.9
//            checkable: true
//            checked: true

//            style: ButtonStyle {

//                background: Rectangle {
//                    id: backImageStats
//                    implicitWidth: backgroundStats.width
//                    implicitHeight: backgroundStats.height
//                    border.color: UIStyle.colorCaribbeanGreen
//                    color: "blue"
//                    radius: UIStyle.bRadius
//                    Label{
//                        id:statsIconName
//                        text: UIStyle.statIconName
//                        font.pixelSize: UIStyle.fontSizeXS
//                        color: UIStyle.colorQtWhite1
//                        anchors.bottom:  statsImage.bottom
//                        anchors.horizontalCenter:statsImage.horizontalCenter
//                        anchors.bottomMargin: UIStyle.labelPos
//                    }

//                        Image{
//                            id:statsImage
//                             anchors.centerIn: parent
//                             source:{ backgroundStats.pressed ? "images/statistics1.png" : "images/statistics_small.png"}
//                             onImplicitHeightChanged: if(backgroundStats.pressed == true){backImageStats.implicitWidth = backImageStats.implicitWidth + 20;backImageStats.implicitHeight = backImageStats.implicitHeight + 20}else{backImageStats.implicitWidth = 145;backImageStats.implicitHeight =170}
//                        }

//                    gradient: Gradient {
//                        GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCgBlue }
//                       }

//                    }

//              }
//  //          onClicked: {pageSw(Qt.resolvedUrl("qrc:/qml/Weather/StatsPage.qml"))}


//        }

//        Button {
//            id:backgroundFeedback
//            x: 1254
//            y: 437
//            width: 247
//            height: 129
//            checkable: true
//            checked: true

//            style: ButtonStyle {

//                background: Rectangle {
//                    id: backImageFeedback
//                    implicitWidth: backgroundFeedback.width
//                    implicitHeight: backgroundFeedback.height
//                    border.color: UIStyle.colorCaribbeanGreen
//                    color: "blue"
//                    radius: UIStyle.bRadius
//                    Label{
//                        id:feedbackIconName
//                        text: UIStyle.feedbackIconName
//                        font.pixelSize: UIStyle.fontSizeXS
//                        color: UIStyle.colorQtWhite1
//                        anchors.bottom:  feedbackImage.bottom
//                        anchors.horizontalCenter:feedbackImage.horizontalCenter
//                        anchors.bottomMargin: UIStyle.labelPos
//                    }

//                        Image{
//                            id:feedbackImage
//                             anchors.centerIn: parent
//                             source:{ backgroundFeedback.pressed ? "images/feedback_data11.png" : "images/feedbackdata_small.png"}
//                             onImplicitHeightChanged: if(backgroundFeedback.pressed == true){backImageFeedback.implicitWidth = backImageFeedback.implicitWidth + 20;backImageFeedback.implicitHeight = backImageFeedback.implicitHeight + 20}else{backImageFeedback.implicitWidth = 145;backImageFeedback.implicitHeight =170}
//                        }

//                    gradient: Gradient {
//                        GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCgBlue }
//                       }

//                    }

//              }

//            onClicked: {if((UIStyle.prdName.indexOf("2") >= 0)){console.log("Feedback btn pressed");/*pageSw(Qt.resolvedUrl("qrc:/qml/Weather/CraeteSavePrdFile.qml"))*/}else{authFailDialogpg2.open()}}
//        }

   // }
//}

//       }
    }
    Component.onCompleted: savetextfield.disableScreen("1")
}
