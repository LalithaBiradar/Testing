
import "../Style"

import QtQuick 2.7
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Controls 1.2
//import "Style"

PathView {
    id: circularView1

    signal launched(string page)
//    signal submitTextField1(string text)



    readonly property int cX: width / 2
    readonly property int cY: height / 2
    readonly property int itemSize: size / 4
    readonly property int size: Math.min(width - 80, height)
    readonly property int radius: size / 2 - itemSize / 3

    snapMode: PathView.SnapToItem

    model: ListModel {
        ListElement {
          //    title: qsTr("Machine Setup")
               title: qsTr("Product Data")
               icon: "qrc:/qml/Weather/images/product data11.png"
               page: "qrc:/qml/Weather/PrdDataPage.qml"
        }
        ListElement {
            title: qsTr("Product Library")
          //  icon: "Navigation/images/function_setup22.png"
             icon: "qrc:/qml/Weather/images/product library11.png"
          //  page: "Navigation/NavigationPage.qml"
            page: "qrc:/qml/Weather/PrdLibPage.qml"


        }
        ListElement {
         //    title: qsTr("Product Setup")
             title: qsTr("Statistics")
             icon: "qrc:/qml/Weather/images/statistics11.png"
             page: "qrc:/qml/Weather/StatsPage.qml"
        }

    }



    delegate: QQC2.AbstractButton {
        width: circularView1.itemSize
        height: circularView1.itemSize

        text: model.title
        opacity: PathView.itemOpacity
        padding: 12

        contentItem: Image {
            source: model.icon
            fillMode: Image.Pad
            sourceSize.width: parent.availableWidth
            sourceSize.height: parent.availableHeight
        }

        background: Rectangle {
            radius: width / 2
            border.width: 3
            border.color: parent.PathView.isCurrentItem ? UIStyle.colorQtPrimGreen : UIStyle.colorQtGray4

        }

        onClicked: {
            if (PathView.isCurrentItem)  {
            circularView1.launched(Qt.resolvedUrl(page))
                stackView.rcvedSignal()



            }
             else{
             circularView1.currentIndex = index
            }
        }

    }





    path: Path {
        startX: circularView1.cX
        startY: circularView1.cY
        PathAttribute {
            name: "itemOpacity"
            value: 1.0
        }
        PathLine {
            x: circularView1.cX + circularView1.radius
            y: circularView1.cY
        }
        PathAttribute {
            name: "itemOpacity"
            value: 0.7
        }
        PathArc {
            x: circularView1.cX - circularView1.radius
            y: circularView1.cY
            radiusX: circularView1.radius
            radiusY: circularView1.radius
            useLargeArc: true
            direction: PathArc.Clockwise
        }
        PathAttribute {
            name: "itemOpacity"
            value: 0.5
        }
        PathArc {
            x: circularView1.cX + circularView1.radius
            y: circularView1.cY
            radiusX: circularView1.radius
            radiusY: circularView1.radius
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

        property Item currentItem: circularView1.currentItem

        visible: currentItem ? currentItem.PathView.itemOpacity === 1.0 : 0

        text: currentItem ? currentItem.text : ""
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (circularView1.itemSize + height) / 2

        font.bold: true
        font.pixelSize: circularView1.itemSize / 3
        font.letterSpacing: 1
        color: UIStyle.colorQtGray1
    }
}



/*Pane {

       id: prdSetup
       anchors.fill: parent
       width: 800
       height: 480
       property bool bImgChange: true
       property bool pressed: true
       background: Rectangle{
    //   Rectangle{
                    color: "steelblue"

    TextInput{
        id: checktext
        text: qsTr("how")
        onTextChanged: UIStyle.prd_code1 = checktext.text
    }
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: titleRow.height

        color: UIStyle.colorQtGray9

        Row {
            id: titleRow
            spacing: 10
            anchors.centerIn: parent

            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/prd_setup11_small.png"
                fillMode: Image.PreserveAspectCrop
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("PRODUCT SETUP")
                font.pixelSize: UIStyle.fontSizeM
                font.letterSpacing: 2
                color: UIStyle.colorQtGray2
            }
        }

    }



    Column{
        id:column
        anchors.top: parent.top
        anchors.topMargin: parent.height/5
        anchors.left: parent.left
        anchors.leftMargin: parent.width/25
        spacing: 80
    Row{
        spacing: 100
    Button {
        id:backgroundPrdData
      //  checkable: true
      //  checked: true
        width: UIStyle.bSize
        height:UIStyle.bSize

        style: ButtonStyle {

            background: Rectangle {
                id: backImagePrdData
                implicitWidth: backgroundPrdData.width
                implicitHeight: backgroundPrdData.height
                border.color: UIStyle.colorCaribbeanGreen
                color: "blue"
                radius: UIStyle.bRadius
                Label{
                    id:prdDataIconName
                    text: UIStyle.prdDtIconName
                    font.pixelSize: UIStyle.fontSizeXS
                    color: UIStyle.colorQtWhite1
                    anchors.bottom:  prdDataImage.bottom
                    anchors.horizontalCenter:prdDataImage.horizontalCenter
                    anchors.bottomMargin: UIStyle.labelPos
                }

                    Image{
                        id:prdDataImage
                        anchors.centerIn: parent
                        source:{ backgroundPrdData.pressed ? "images/product_data_page.png" : "images/product_data_page_small.png"}
                        onImplicitHeightChanged: if(backgroundPrdData.pressed == true){backImagePrdData.implicitWidth = backImagePrdData.implicitWidth + 20;backImagePrdData.implicitHeight = backImagePrdData.implicitHeight + 20}else{backImagePrdData.implicitWidth = 145;backImagePrdData.implicitHeight =170}
                    }

                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCameaoPink : UIStyle.colorCandyPink}
                   }

                }

          }

            onClicked: prdDataloader.source = "qrc:/qml/Weather/PrdDataPage.qml"

    }



    Button {
        id:backgroundPrdLib
        width: UIStyle.bSize
        height:UIStyle.bSize
        checkable: true
        checked: true

        style: ButtonStyle {

            background: Rectangle {
                id: backImagePrdLib
                 property bool pressed: true
                 implicitWidth: backgroundPrdLib.width
                 implicitHeight: backgroundPrdLib.height
                 border.width: control.activeFocus ? 2 : 1
                 border.color: UIStyle.colorCaribbeanGreen
                 color: "blue"
                 radius: UIStyle.bRadius
                Label{
                    text: UIStyle.prdLbIconName
                    font.pixelSize: UIStyle.fontSizeXS
                    color: UIStyle.colorQtWhite1
                    anchors.bottom:  prdLibImage.bottom
                    anchors.horizontalCenter:prdLibImage.horizontalCenter
                    anchors.bottomMargin: UIStyle.labelPos
                }

                Image{
                    id:prdLibImage
                    anchors.centerIn: parent
                    source:{ backgroundPrdLib.pressed ? "images/prd_lib1.png" : "images/prd_lib_small.png"}
                    onImplicitHeightChanged: if(backgroundPrdLib.pressed == true){backImagePrdLib.implicitWidth = backImagePrdLib.implicitWidth + 20;backImagePrdLib.implicitHeight = backImagePrdLib.implicitHeight + 20}else{backImagePrdLib.implicitWidth = 145;backImagePrdLib.implicitHeight =170}
                    }
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCeladonGreen }
                   }

                }

          }

        onClicked: prdDataloader.source = "qrc:/qml/Weather/PrdLibPage.qml"
    }

    }



    Row{


        spacing: 100

        Button {
            id:backgroundStats
            checkable: true
            checked: true
            width:UIStyle.bSize
            height:UIStyle.bSize

            style: ButtonStyle {

                background: Rectangle {
                    id: backImageStats
                    implicitWidth: backgroundStats.width
                    implicitHeight: backgroundStats.height
                    border.color: UIStyle.colorCaribbeanGreen
                    color: "blue"
                    radius: UIStyle.bRadius
                    Label{
                        id:statsIconName
                        text: UIStyle.statIconName
                        font.pixelSize: UIStyle.fontSizeXS
                        color: UIStyle.colorQtWhite1
                        anchors.bottom:  statsImage.bottom
                        anchors.horizontalCenter:statsImage.horizontalCenter
                        anchors.bottomMargin: UIStyle.labelPos
                    }

                        Image{
                            id:statsImage
                             anchors.centerIn: parent
                             source:{ backgroundStats.pressed ? "images/statistics1.png" : "images/statistics_small.png"}
                             onImplicitHeightChanged: if(backgroundStats.pressed == true){backImageStats.implicitWidth = backImageStats.implicitWidth + 20;backImageStats.implicitHeight = backImageStats.implicitHeight + 20}else{backImageStats.implicitWidth = 145;backImageStats.implicitHeight =170}
                        }

                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCgBlue }
                       }

                    }

              }
            onClicked: prdDataloader.source = "qrc:/qml/Weather/statsPage.qml"

        }

        Button {
            id:backgroundFeedback
            checkable: true
            checked: true
            width:UIStyle.bSize
            height:UIStyle.bSize

            style: ButtonStyle {

                background: Rectangle {
                    id: backImageFeedback
                    implicitWidth: backgroundFeedback.width
                    implicitHeight: backgroundFeedback.height
                    border.color: UIStyle.colorCaribbeanGreen
                    color: "blue"
                    radius: UIStyle.bRadius
                    Label{
                        id:feedbackIconName
                        text: UIStyle.feedbackIconName
                        font.pixelSize: UIStyle.fontSizeXS
                        color: UIStyle.colorQtWhite1
                        anchors.bottom:  feedbackImage.bottom
                        anchors.horizontalCenter:feedbackImage.horizontalCenter
                        anchors.bottomMargin: UIStyle.labelPos
                    }

                        Image{
                            id:feedbackImage
                             anchors.centerIn: parent
                             source:{ backgroundFeedback.pressed ? "images/feedback_data11.png" : "images/feedbackdata_small.png"}
                             onImplicitHeightChanged: if(backgroundFeedback.pressed == true){backImageFeedback.implicitWidth = backImageFeedback.implicitWidth + 20;backImageFeedback.implicitHeight = backImageFeedback.implicitHeight + 20}else{backImageFeedback.implicitWidth = 145;backImageFeedback.implicitHeight =170}
                        }

                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed  ? UIStyle.colorCadetBlue : UIStyle.colorCgBlue }
                       }

                    }

              }
            onClicked: prdDataloader.source = "qrc:/qml/Weather/statsPage.qml"

        }

    }
}
    Loader{
        id:prdDataloader
        anchors.fill: parent
    }






       }
}*/


