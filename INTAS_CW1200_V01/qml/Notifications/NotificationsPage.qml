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

//import QtQuick 2.7
//import QtQuick.Controls 2.0 as QQC2

import QtQuick 2.7
import QtQuick.Controls 2.0 as QQ2
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.0

import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.VirtualKeyboard 2.1

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtQuick 2.1 as QQ2

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import "../Style"
//import "notifications.js" as NotificationData

ListView {
    id: missedCallsView

    clip: true
    focus: true
    boundsBehavior: Flickable.StopAtBounds
    snapMode: ListView.SnapToItem
    enabled: UIStyle.idleforfg


    HexButton {
            id: manualOpen
            x: 727
            y: 393
            width: 220
            height: 204
            color: "peru"
            text: "MANUAL"
            fontsize: 20
            onClicked:{
                //savetextfield.manualOpen()
                W.open_manualpdf()

            }
    }

    HexButton {
        id: systeminfo
        x: 1107
        y: 393
        width: 220
        height: 204
        color: "#cd853f"
        text: "SYSTEM INFO"
        fontsize: 20
        onClicked:{
            pageSw(Qt.resolvedUrl("qrc:/qml/Notifications/systeminfo.qml"))
        }
    }







    Component.onCompleted: {

    }
}
