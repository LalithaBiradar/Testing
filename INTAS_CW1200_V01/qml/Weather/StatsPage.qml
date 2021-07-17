/*import QtQuick 2.7
import QtQuick.Controls 2.0 as QQ2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2


import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0


import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0
import QtCharts 2.0

import "weather.js" as WeatherData
import "../Style"


Rectangle {
    QQ2.SwipeView {
        id: svStatsContainer

        anchors.fill: parent

        Rectangle {
            id: prdStatsPage
             width: 800; height: 480

             Button{
                     id:switchs
                     x:100
                     y:100
                     text: qsTr("Screen switch!!")

  //                   onClicked:{swi.source = "qrc:/qml/Fitness/FitnessPage.qml"}



                 }



                 Rectangle {
                     anchors.horizontalCenter: parent.horizontalCenter
                     width: parent.width
                     height: titleRow.height

                     color: UIStyle.colorQtGray9

                     Row {
                         id: titleRow
                         spacing: UIStyle.bRadius           // 10
                         anchors.centerIn: parent

                         Image {
                             anchors.verticalCenter: parent.verticalCenter
                             source: "images/statistics_small1.png"
                             fillMode: Image.PreserveAspectCrop
                         }
                         Text {
                             anchors.verticalCenter: parent.verticalCenter
                             text: UIStyle.statIconName
                             font.pixelSize: UIStyle.fontSizeM
                             font.letterSpacing: 2
                             color: UIStyle.colorQtGray2
                         }
                     }

                 }



        }

         }
    QQ2.PageIndicator {
        count: svStatsContainer.count
        currentIndex: svStatsContainer.currentIndex

        anchors.bottom: svStatsContainer.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

}*/
import QtQuick 2.0


import QtCharts 2.2

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

Page {
    id: sig
//    anchors.fill: parent


    property string axisXmaxVal: axisX.max
    property string axisXminVal: axisX.min
    property string axisYmaxVal: axisY.max
    property string textVal: UIStyle.prd_code1
//    property string labelName: PieSlice.label
    property string myString
    property variant stringList: myString.split('#')
    property string localnetWt

    property int locallimitplus
    property int locallimitminus


    function myQmlFunction(msg) {
          console.log("Got message:", + msg)
        UIStyle.prd_code1 = msg
        console.log("the value saved is:", + UIStyle.prd_code1)
        xCoordinate.text = UIStyle.prd_code1

          return UIStyle.prd_code1
      }

//    function connectExist(text){
//       console.log("the signal recived is:" + text)

//}

    //![1]

    //--------------------to change vaue from cpp -------------------------
        Connections{
            target: handle_loadcellcalls

            onHandleChart_val:{
                UIStyle.xCordinate = cnt //* 1.2
                console.log("Chart Connection:"+UIStyle.xCordinate )
        //        var a = parseInt(UIStyle.xCordinate)
        //        a = a + 4
         //       console.log("Chart int vlue:"+a )
                axisXmaxVal=parseInt(UIStyle.xCordinate) +1
                axisXminVal=parseInt(UIStyle.xCordinate) - 2
                console.log("Chart Connectionddd:"+axisXmaxVal )

                localnetWt = UIStyle.netWt.replace("g","")
             //   netWt.replace("g","")
                lChart.append(UIStyle.xCordinate,localnetWt)
                console.log("Chart Connection:"+localnetWt )

                locallimitplus = cnt1
                locallimitminus = cnt2


            }


        }


    SwipeView {
        id: swipeView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Item {
                id: statsView
                width: 1920
                height: 1080



                function loadUserStatus(){
                  //  savetextfield.loadUserStatusFile()
                    handle_loadcellcalls.read_stats_page();
                    statsViewmodel.clear({StatsParam:""})
                    statsViewmodel.clear({StsParamVal:""})
                    for(var i = 0;i<UIStyle.fileList.length;i++){
                        myString = UIStyle.fileList[i]
                        UIStyle.prd_code1 = stringList[0]
                        UIStyle.prd_code2 = stringList[1]
                        statsViewmodel.append({StatsParam:UIStyle.prd_code1,StsParamVal:UIStyle.prd_code2})
                    }

                }


                GroupBox{
                    id:statsGrp
                    title: "Statistical Data"
                    width: 1920
                    height: 900


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
                            id:stsParam
                            role: "StatsParam"
                            title: "Stats Parameter"


                            width: usrListView.width / 2
                            resizable: false
                            movable: false
                            delegate: Component {
                                                                   id: statsparamDelegate

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
                            id:stsParamVal
                            role: "StsParamVal"
                            title: "Stats Parameter Value"

                            width: usrListView.width / 2
                            resizable: false
                            movable: false
                            delegate: Component {
                                                                   id: statsparamvalDelegate

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
                         id: statsViewmodel
                            ListElement { StatsParam: ""
                                      StsParamVal:""
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
                         //                               Rectangle {
                         //                                   width: 10; height: 10
                         //                                   color: {
                         //                                       if(styleData.pressed)
                         //                                           return "red"
                         //                                       else
                         //                                           return "black"
                         //                                   }
                         //                               }
                                                    }

   //                      onCurrentRowChanged: {adminName = chngUsrProfilemodel.get(__currentRow).Username}

                    }

                 }
Component.onCompleted: {loadUserStatus()}

     }



    Item {
            id: chartView1
            width: 1920
            height: 900

    ChartView {
        title: "DYANMIC WEIGHT TREND"
        titleColor: "Yellow"
                titleFont.pointSize: 20

                anchors.fill: parent
                antialiasing: true
                backgroundColor: "black"

        //Label{id:trendntwt;width:300;height:150;text:UIStyle.netwt;color:"white";font.pixelsize:40;anchor.top:parent.top;anchor.topmargin:60;anchor.right:parent.right;anchor.rightmargin:300};

        LineSeries {
            id:lChart
          //  name: "LineSeries"
            axisX: axisX
            axisY: axisY
            onPressed: console.log("onPressed: " + point.x + ", " + point.y);


        }
    }

//    ChartView {
//        title: "Two Series, Common Axes"
//        anchors.fill: parent
//        legend.visible: false
//        antialiasing: true

        ValueAxis {
            id: axisX
            min: axisXminVal
            max: axisXmaxVal
            tickCount: 5
            labelsFont:Qt.font({pixelSize: 30})
            labelsColor: "white"
        }

        ValueAxis {
            id: axisY
            min: locallimitminus / 100
            max: locallimitplus / 100     //axisYmaxVal
            tickCount: 10
            labelsFont:Qt.font({pixelSize: 30})
            labelsColor: "white"

        }



 //   TextField{id:xCoordinate;x:100;y:100; previewText:"TextField";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
 //   TextField{id:yCoordinate;x:100;y:200;previewText:"TextField";width: UIStyle.prdParamWidth;height: UIStyle.prdParamHeight;validator: RegExpValidator { regExp: /^[0-9]{2,2}$/}onTextChanged:{}}
//    Button{
//        id:passToChart
//        text:"connect"
//        width: 80
//        height: 80
////        onClicked: {savetextfield.connected(xCoordinate.text,yCoordinate.text);axisYmaxVal = UIStyle.xCordinate * 2;axisXmaxVal=UIStyle.yCordinate * 2;lChart.append(UIStyle.xCordinate,UIStyle.yCordinate);console.log("the changed valie is:" + UIStyle.prd_code1)}
//        onClicked: {axisYmaxVal = 500;lChart.append(UIStyle.xCordinate,UIStyle.netWt);console.log("the changed valie is:" + UIStyle.prd_code1)}

//    }
 }

    Item {
            id: chartView2
            width: 1920
            height: 900
  //          anchors.fill: parent
            property variant othersSlice: 0

            //![1]
            ChartView {
                id: chart
                title: "COUNTS"
                titleFont.pointSize: 35
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                legend.font.pixelSize : 30
              //   backgroundColor: "black"

                PieSeries {
                    id: pieSeries
                    PieSlice {label:   "Accept Counts"; value:UIStyle.acp_counts;color: "green"}//;onClicked: pieSeries.find(label).exploded = true}
                    PieSlice {label: "Overweight Counts"; value: UIStyle.ow_counts }
                    PieSlice {label: "Underweight Counts"; value: UIStyle.uw_counts }
              //      PieSlice { label: "Skoda"; value: 8.2 }
              //      PieSlice { label: "Volvo"; value: 6.8 }


                }

            }

            Component.onCompleted: {
                // You can also manipulate slices dynamically
              //  othersSlice = pieSeries.append("Others", 52.0);
             //   pieSeries.find("Accept Counts").exploded = true;

            }

    }
    Item {
        id: chartView3
   //     anchors.fill: parent
        width: 1920
        height: 900



        //![1]
        ChartView {
            title: "Bargraph"
            titleFont.pointSize: 30
            anchors.fill: parent
            legend.alignment: Qt.AlignBottom
            antialiasing: true
            legend.font.pixelSize : 25
           // backgroundColor: "black"


            BarSeries {
                id: mySeries
                //axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
                axisY:axisY1
                BarSet {label: "Accept Counts"; values: [UIStyle.acp_counts];color: "green"}
                BarSet { label: "Underweight Counts"; values: [UIStyle.uw_counts];color: "orange"}
                BarSet { label: "Overweight Counts"; values: [UIStyle.ow_counts];color: "red"}


            }
            ValueAxis {
                id: axisY1
                min: 0              //locallimitminus / 100
                max: parseInt(UIStyle.acp_counts) + parseInt(UIStyle.uw_counts)+parseInt(UIStyle.ow_counts)             //locallimitplus / 100     //axisYmaxVal
                tickCount: 10
                labelsFont:Qt.font({pixelSize: 30})
                labelsColor: "Black"

            }



        }

   //     Component.onCompleted:acpCnts.labelFont = Qt.font({pointSize: 24,bold:true})
        //![1]
    }

    Item {
        id: chartView4
   //     anchors.fill: parent
        width: 1920
        height: 900

        //![1]
        ChartView {
            id:stackedBargraph
            title: "Stacked Bargraph"
            titleFont.pointSize: 30
            anchors.fill: parent
            legend.alignment: Qt.AlignBottom
            legend.font.pixelSize : 30

            antialiasing: true

            StackedBarSeries {
                id: stackedMySeries
//                axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ];
//                    labelsFont: Qt.font({pixelSize: 14}) }

                axisY: axisY2

                BarSet {label: "Accept Counts"; values: [UIStyle.acp_counts];color: "green"}
                BarSet { label: "Underweight Counts"; values: [UIStyle.uw_counts];color: "orange"}
                BarSet { label: "Overweight Counts"; values: [UIStyle.ow_counts];color: "red"}

            }

            ValueAxis {
                id: axisY2
                min: 0              //locallimitminus / 100
                max: parseInt(UIStyle.acp_counts) + parseInt(UIStyle.uw_counts)+parseInt(UIStyle.ow_counts)             //locallimitplus / 100     //axisYmaxVal
                tickCount: 10
                labelsFont:Qt.font({pixelSize: 30})
                labelsColor: "Black"

            }




        }

      //  Component.onCompleted:{stackedBargraph.titleFont = Qt.font({pointSize: 14})}
        //![1]
    }

//    Item {
//        id: chartView5
//   //     anchors.fill: parent
//        width: 1024
//        height: 600

//        //![1]
//        ChartView {
//            id:percentStackedBargraph
//            title: "Percent Stacked Bargraph"
//            titleFont.pointSize: 14
//            anchors.fill: parent
//            legend.alignment: Qt.AlignBottom
//            legend.font.pixelSize : 14

//            antialiasing: true

//            PercentBarSeries {
//                id: percentStackedMySeries
//                axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ];labelsFont: Qt.font({pixelSize: 14}) }

//                BarSet {label: "Accept Counts"; values: [2, 2, 3, 4, 5, 6] }
//                BarSet { label: "Underweight Counts"; values: [5, 1, 2, 4, 1, 7] }
//                BarSet { label: "Overweight Counts"; values: [3, 5, 8, 13, 5, 8] }


//            }



//        }

//      //  Component.onCompleted:{stackedBargraph.titleFont = Qt.font({pointSize: 14})}
//        //![1]
//    }


    //![1]


}


    footer:TabView {
//                Layout.row: 6
//                Layout.columnSpan: 3
                Layout.fillWidth: true
                implicitHeight: 30

        id: tabBar
       currentIndex: swipeView.currentIndex

       Tab {
           title:  "STATISTICS"
       }
        Tab {
            title:  "LineSeries Chart"
        }
        Tab {
            title:  "PieChart"
        }
        Tab {
            title: "Bargraph"
        }
        Tab {
            title: "Stacked Bargraph"
        }
//        Tab {
//            title: "Percent Stacked Bargraph"
//        }
    }
}



