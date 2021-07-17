import QtQuick 2.7
import QtQuick.Controls 2.0 as QQ2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2


import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
//import QtGraphicalEffects 1.0


import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0

import "weather.js" as WeatherData
import "../Style"


Rectangle {
    QQ2.SwipeView {
        id: svPrdLibContainer

        anchors.fill: parent

        Rectangle {
            id: prdDataPage1
             width: 1920; height: 1080


             Label{

                 anchors.centerIn: parent
                 color: "black"
                 //Font.pixelSize: UIStyle.fontSizeXXL
                 font.pixelSize: UIStyle.fontSizeXS
                 text: "Screen Design is in process."

             }

                 Rectangle {
                     anchors.horizontalCenter: parent.horizontalCenter
                     width: parent.width
                     height: titleRow.height

                     color: UIStyle.colorQtGray9

                     Row {
                         id: titleRow
 //                        spacing: UIStyle.bRadius           // 10
                         spacing: 10
                         anchors.centerIn: parent

                         Image {
                             anchors.verticalCenter: parent.verticalCenter
                             source: "images/prd_lib_small1.png"
                             fillMode: Image.PreserveAspectCrop
                         }
                         Text {
                             anchors.verticalCenter: parent.verticalCenter
                             text: UIStyle.prdLbIconName
                             font.pixelSize: UIStyle.fontSizeM
                             font.letterSpacing: 2
                             color: UIStyle.colorQtGray2
                         }
                     }

                 }



        }
        Rectangle {
            id: prdDataPage2
             width: 800; height: 480
             Rectangle {
                 anchors.horizontalCenter: parent.horizontalCenter
                 width: parent.width
                 height: titleRowPrdPg2.height

                 color: UIStyle.colorQtGray9

                 Row {
                     id: titleRowPrdPg2
                     spacing: 10
                     anchors.centerIn: parent

                     Image {
                         anchors.verticalCenter: parent.verticalCenter
                         source: "images/prd_lib_small1.png"
                         fillMode: Image.PreserveAspectCrop
                     }
                     Text {
                         anchors.verticalCenter: parent.verticalCenter
                         text: UIStyle.prdLbIconName
                         font.pixelSize: UIStyle.fontSizeM
                         font.letterSpacing: 2
                         color: UIStyle.colorQtGray2
                     }
                 }

             }



    }
         }
    QQ2.PageIndicator {
        count: svPrdLibContainer.count
        currentIndex: svPrdLibContainer.currentIndex

        anchors.bottom: svPrdLibContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

}


