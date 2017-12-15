/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
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

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtLocation 5.6
import QtLocation 5.3
import QtQuick.Dialogs 1.2
import QtPositioning 5.6
import QtQuick.Controls 2.0 as C2

import QtQuick.Dialogs 1.3

ApplicationWindow {
    id: appWindow
    width: 1280
    height: 720
    visible: true


    MapComponent {
        id: map
        plugin: Plugin {
            id: osmPlugin
            name: "mapboxgl"
            // specify plugin parameters if necessary
            PluginParameter {
                name: "mapboxgl.access_token"
                value: "pk.eyJ1IjoiYmxhY2tzYWdldGVjaCIsImEiOiJnajZJbG1zIn0.h_oq3Rv4WoHHPSNWnQOnow"
            }
        }
    } // MapComponent: map

//        Image{
//            id: bsLogo
//            anchors.top: parent.top
//            anchors.left: parent.left
//            width: bsLogo.width * 0.5
//            height: bsLogo.height * 0.5

//            source: "images/logo.png"
//        }

    TopBarControls{
        id: topBarControls
    }

    menuBar: MainMenuBar{
        map: map
        fileDialog: FileDialog {
            id: fileDialog
            visible: false
            title: "Choose up a file"
            onAccepted: {
                parser.parse(fileUrl)
            }
        }
    }

    ValueSlider{
        mapSource: map
    }
}
