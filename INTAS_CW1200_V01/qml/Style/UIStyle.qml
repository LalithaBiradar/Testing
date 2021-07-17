///****************************************************************************
//**
//** Copyright (C) 2017 The Qt Company Ltd.
//** Contact: https://www.qt.io/licensing/
//**
//** This file is part of the examples of the Qt Toolkit.
//**
//** $QT_BEGIN_LICENSE:BSD$
//** Commercial License Usage
//** Licensees holding valid commercial Qt licenses may use this file in
//** accordance with the commercial license agreement provided with the
//** Software or, alternatively, in accordance with the terms contained in
//** a written agreement between you and The Qt Company. For licensing terms
//** and conditions see https://www.qt.io/terms-conditions. For further
//** information use the contact form at https://www.qt.io/contact-us.
//**
//** BSD License Usage
//** Alternatively, you may use this file under the terms of the BSD license
//** as follows:
//**
//** "Redistribution and use in source and binary forms, with or without
//** modification, are permitted provided that the following conditions are
//** met:
//**   * Redistributions of source code must retain the above copyright
//**     notice, this list of conditions and the following disclaimer.
//**   * Redistributions in binary form must reproduce the above copyright
//**     notice, this list of conditions and the following disclaimer in
//**     the documentation and/or other materials provided with the
//**     distribution.
//**   * Neither the name of The Qt Company Ltd nor the names of its
//**     contributors may be used to endorse or promote products derived
//**     from this software without specific prior written permission.
//**
//**
//** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
//**
//** $QT_END_LICENSE$
//**
//****************************************************************************/

//import QtQuick 2.7

//pragma Singleton




//QtObject {
//    id: uiStyle

//    // Font Sizes
//    readonly property int fontSizeXXS: 10
//    readonly property int fontSizeXS: 25
//    readonly property int fontSizeS: 20
//    readonly property int fontSizeM: 25
//    readonly property int fontSizeL: 30
//    readonly property int fontSizeXL: 35
//    readonly property int fontSizeXXL: 40

//    // Color Scheme
//    // Green
//    readonly property color colorQtPrimGreen: "#41cd52"
//    readonly property color colorQtAuxGreen1: "#21be2b"
//    readonly property color colorQtAuxGreen2: "#17a81a"
//    readonly property color colorCaribbeanGreen: "#00cc99"
//    readonly property color colorCeladonGreen: "#2f847c"


//    // Gray
//    readonly property color colorQtGray1: "#09102b"
//    readonly property color colorQtGray2: "#222840"
//    readonly property color colorQtGray3: "#3a4055"
//    readonly property color colorQtGray4: "#53586b"
//    readonly property color colorQtGray5: "#53586b"
//    readonly property color colorQtGray6: "#848895"
//    readonly property color colorQtGray7: "#9d9faa"
//    readonly property color colorQtGray8: "#b5b7bf"
//    readonly property color colorQtGray9: "#cecfd5"
//    readonly property color colorQtGray10: "#f3f3f4"
//    // yellow
//    readonly property color colorQtYellow1: "yellow"
//    // brown
//    readonly property color colorQtBrown1: "brown"
//    // white
//    readonly property color colorQtWhite1: "white"
//    // pink
//    readonly property color colorCameaoPink: "#efbbcc"
//    readonly property color colorCandyPink: "#e4717a"
//    //blue
//    readonly property color colorCgBlue: "#007aa5"
//    readonly property color colorCadetBlue: "#5f9ea0"
//    //black
//    readonly property color colorQtblk: "black"

//    //fitness page2 parameter locations
//    readonly property int xDistance: 15
//     readonly property int yDistance: 40

//     //product parameter labels
//      property string prd_code:  "PRODUCT CODE      #"
//      property string prd_name:  "PRODUCT NAME      #"
//     readonly property string batch_num: "BATCH NUMBER      #"
//     readonly property string targ_wt:   "TARGEheight: 300T WEIGHT    #"
//     readonly property string tare_wt:   "TARE WEIGHT        #"
//     readonly property string prd_len:   "PRODUCT LENGTH  #"
//     readonly property string up_lmt:    "UPPER LIMIT          #"
//     readonly property string lo_lmt:    "LOWER LIMIT         #"
//     readonly property string speed:     "SPEED                   #"
//     readonly property string opr_dly:   "OPERATE DELAY     #"
//     readonly property string hld_dly:   "HOLD DELAY          #"
//     readonly property string rej_Cnt:   "REJECT COUNT          #"


//     property string prd_code1:  " "
//     property string prd_code2:  " "
//     property string prd_name1:  " "
//     property string batch_num1:  " "
//     property string fileName:  " "
//     property string fileLibName:  " "
//     property string fileNameExist:  " "
//     property string fileNameCompare:  " "
//     property string xCordinate:  " "
//     property string yCordinate:  " "
//     property string retData:  " "

//     property string scrEnabled:  " "
//     property string oldPass:  " "
//     property string oldUserName:  " "

//     property variant fileParam: []
//     property variant fileParamName: []
//     property variant fileList: []
//     property variant userNameList: []
//   //   property string fileParamv: [""]
//     property variant libParam: ["prdcodF","prdNamF"]

//     //counts parameter locations
////     readonly property string uw_cnts:  "UNDERWIGHT COUNTS #"
////      property string acp_cnts:  "ACCEPT COUNTS          #"
////     readonly property string ow_cnts:  "OVERWEIGHT COUNTS #"

//     property string uw_counts:  ""
//     property string acp_counts:  ""
//     property string ow_counts:  ""

//     property int cwGuageVal:0
//     property int ipGuageVal:0

//     //system parameter locations
//     readonly property string dy_comp:  "DY.COMP.             #"
//     readonly property string dy_comp_fact:  "DY.COMP.FACTOR  #"
//     readonly property string feed_back:  "FEEDBACK             #"

//     //for product setup page
//        readonly property int bSize: 80
//        readonly property int bRadius: 10
//        readonly property int labelPos: -25
//        readonly property string prdDtIconName:   "SAVE PRODUCT FILE"
//        readonly property string prdLbIconName:   "CREATE & SAVE PRODUCT FILE"
//        readonly property string statIconName:   "STATISTICS"
//        readonly property string feedbackIconName:   "FEEDBACK DATA"
//         readonly property string funIconName:   "FUNCTION SETUP"

//        //product parameter on product dada page
//        readonly property string prdCode:  "1.PRODUCT CODE"
//        readonly property string prdName:  "2.PRODUCT NAME"
//        readonly property string batchNum: "3.BATCH NUMBER"
//        readonly property string targWt:   "4.TARGET WEIGHT"
//        readonly property string tareWt:   "5.TARE WEIGHT"
//        readonly property string prdLen:   "6.PRODUCT LENGTH"
//        readonly property string upLmt:    "7.UPPER LIMIT"
//        readonly property string loLmt:    "8.LOWER LIMIT"
//        readonly property string spd:     "9.SPEED"
//        readonly property string oprDly:   "10.OPERATE DELAY"
//        readonly property string hldDly:   "11.HOLD DELAY"
//        readonly property string rejCnt:   "12.REJECT COUNT"

//        readonly property int prdParamWidth: 180
//        readonly property int prdParamHeight: 30

//        property string netWt:   "0.0"



//}


/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.7

pragma Singleton


QtObject {
    id: uiStyle

    // Font Sizes
    readonly property int fontSizeXXS: 10
    readonly property int fontSizeXS: 25
    readonly property int fontSizeS: 20
    readonly property int fontSizeM: 25
    readonly property int fontSizeL: 30
    readonly property int fontSizeXL: 35
    readonly property int fontSizeXXL: 40

    // Color Scheme
    // Green
    readonly property color colorQtPrimGreen: "#41cd52"
    readonly property color colorQtAuxGreen1: "#21be2b"
    readonly property color colorQtAuxGreen2: "#17a81a"
    readonly property color colorCaribbeanGreen: "#00cc99"
    readonly property color colorCeladonGreen: "#2f847c"


    // Gray
    readonly property color colorQtGray1: "#09102b"
    readonly property color colorQtGray2: "#222840"
    readonly property color colorQtGray3: "#3a4055"
    readonly property color colorQtGray4: "#53586b"
    readonly property color colorQtGray5: "#53586b"
    readonly property color colorQtGray6: "#848895"
    readonly property color colorQtGray7: "#9d9faa"
    readonly property color colorQtGray8: "#b5b7bf"
    readonly property color colorQtGray9: "#cecfd5"
    readonly property color colorQtGray10: "#f3f3f4"
    // yellow
    readonly property color colorQtYellow1: "yellow"
    // brown
    readonly property color colorQtBrown1: "brown"
    // white
    readonly property color colorQtWhite1: "white"
    // pink
    readonly property color colorCameaoPink: "#efbbcc"
    readonly property color colorCandyPink: "#e4717a"
    //blue
    readonly property color colorCgBlue: "#007aa5"
    readonly property color colorCadetBlue: "#5f9ea0"
    //black
    readonly property color colorQtblk: "black"

    //fitness page2 parameter locations
    readonly property int xDistance: 15
     readonly property int yDistance: 40




     //product parameter labels
      property string dycomp_factor:  ""
   //   property string prd_name:  "PRODUCT NAME      #"
     property string expiry_Days:  ""
  //   readonly property string batch_num: "BATCH NUMBER      #"
      property string current_date: ""
     readonly property string targ_wt:   "TARGET WEIGHT    #"
     readonly property string tare_wt:   "TARE WEIGHT        #"
     readonly property string prd_len:   "PRODUCT LENGTH  #"
     readonly property string up_lmt:    "UPPER LIMIT          #"
     readonly property string lo_lmt:    "LOWER LIMIT         #"
     readonly property string speed:     "SPEED                    #"
     readonly property string opr_dly:   "OPERATE DELAY(CW)#"
     readonly property string hld_dly:   "HOLD DELAY         #"
   //    property string rej_Cnt:   "REJECT COUNT          #"


     property string prd_code1:  " "
     property string prd_code2:  " "
     property string prd_name1:  " "
     property string batch_num1:  " "
     property string fileName:  " "
     property string fileLibName:  " "
     property string fileNameExist:  " "
     property string fileNameCompare:  " "
     property string xCordinate:  "1"
     property string yCordinate:  " "
     property string retData:  " "

     property string scrEnabled:  " "
     property string oldPass:  " "
     property string oldUserName:  " "

     property variant fileParam: []
     property variant fileParamName: []
     property variant fileList: []
     property variant userNameList: []
   //   property string fileParamv: [""]
     property variant libParam: ["prdcodF","prdNamF"]

     //counts parameter locations
//     readonly property string uw_cnts:  "UNDERWIGHT COUNTS #"
//      property string acp_cnts:  "ACCEPT COUNTS          #"
//     readonly property string ow_cnts:  "OVERWEIGHT COUNTS #"

     property string uw_counts:  ""
     property string acp_counts:  ""
     property string ow_counts:  ""
     property string std_deviation:  ""


     //system parameter locations
     readonly property string dy_comp:  "DY.COMP.             #"
     readonly property string dy_comp_fact:  "DY.COMP.FACTOR  #"
     readonly property string feed_back:  "FEEDBACK             #"

     //for product setup page
     //   readonly property int bSize: 80
     property bool idleforfg : false
     //   readonly property int bRadius: 10
     property string logout_time: ""
        readonly property int labelPos: -25
        readonly property string prdDtIconName:   "SAVE PRODUCT FILE"
        readonly property string prdLbIconName:   "CREATE & SAVE PRODUCT FILE"
        readonly property string statIconName:   "STATISTICS"
        readonly property string feedbackIconName:   "FEEDBACK DATA"
         readonly property string funIconName:   "FUNCTION SETUP"

        //product parameter on product dada page
        //readonly property string prdCode:  "1.PRODUCT CODE"
       // readonly property string prdName:  "2.PRODUCT NAME"
         property string prdName:  ""
        readonly property string batchNum: "3.BATCH NUMBER"
        readonly property string targWt:   "4.TARGET WEIGHT"
        readonly property string tareWt:   "5.TARE WEIGHT"
         property string prdLen:   "6.PRODUCT LENGTH"
         property string varb1:    "7.UPPER LIMIT"
         property string loLmt:    "8.LOWER LIMIT"
         property string spd:     "9.SPEED"
         property string oprDly:   "10.OPERATE DELAY"
         property string hldDly:   "11.HOLD DELAY"
 //       readonly property string rejCnt:   "12.REJECT COUNT"

        readonly property int prdParamWidth: 350
        readonly property int prdParamHeight: 30

        property string netWt:   "0.0"
        property string avgxWt:   "0.0"

}
