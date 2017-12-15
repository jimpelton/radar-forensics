import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1

RowLayout{


    anchors.top: parent.top
    anchors.left: parent.left
    spacing: 10
    layoutDirection: Qt.LeftToRight

    property real buttonOpacity: 0.8
    property real buttonBorderWidth: 3


    Row{
//        anchors.top: parent.top
//        anchors.left: parent.left
        Image {
            id: bsLogo
            source: "images/logo.png"
//            anchors.top: parent.top
//            anchors.left: parent.left
//            scale:  0.1
//            fillMode: Image.PreserveAspectFit
//            verticalAlignment: Image.AlignTop
//            horizontalAlignment: Image.AlignLeft

        }

    }

    Row {
        spacing: 10

        Button {
            id: csvButton
            text: "CSV"
            background: Rectangle {
            anchors.centerIn: parent.Center
            implicitWidth: 100
            implicitHeight: 40
            opacity: buttonOpacity
            border.color: csvButton.down ? "#17a81a" : "#21be2b"
            border.width: buttonBorderWidth
            radius: 2
        }
//            onClicked: {

//            }
        }

        Button{
            id: centeringButton
            property bool on: true
            text: on ? "Disable Centering" : "Enable Centering"
            background: Rectangle {
                anchors.centerIn: parent.Center
                implicitWidth: 105
                implicitHeight: 40
                opacity: buttonOpacity
                color: centeringButton.on ? "blue" : "white"
                border.color: centeringButton.down ? "#17a81a" : "#21be2b"
                border.width: buttonBorderWidth
                radius: 2
            }

            onClicked: {
                centeringButton.on = ! centeringButton.on
            }

        }

        Button{
            id: geoLocateTracker
            text: "Geolocate"
            background: Rectangle {
            anchors.centerIn: parent.Center
            implicitWidth: 100
            implicitHeight: 40
            opacity: buttonOpacity
            border.color: geoLocateTracker.down ? "#17a81a" : "#21be2b"
            border.width: buttonBorderWidth
            radius: 2
        }

        }

        Button {
           id: clearButton
           text: "Clear Markers"
           background: Rectangle {
            anchors.centerIn: parent.Center
            implicitWidth: 100
            implicitHeight: 40
            opacity: buttonOpacity
            border.color: clearButton.down ? "#17a81a" : "#21be2b"
            border.width: buttonBorderWidth
            radius: 2
        }


        }
    }

    Row{
        spacing: 0
        Button{
          id: liveButton
          text: "Live"
          background: Rectangle {
            anchors.centerIn: parent.Center
            implicitWidth: 100
            implicitHeight: 40
            opacity: buttonOpacity
            border.color: liveButton.down ? "#17a81a" : "#21be2b"
            border.width: buttonBorderWidth
            radius: 2
        }


        }

        Button{
            id: pauseButton
            text: "Pause"
            background: Rectangle {
                anchors.centerIn: parent.Center
                implicitWidth: 100
                implicitHeight: 40
                opacity: buttonOpacity
                border.color: pauseButton.down ? "#17a81a" : "#21be2b"
                border.width: buttonBorderWidth
                radius: 2
            }



        }

        Button {
            id: searchButton
            text: "Search"
            background:  Rectangle {
                anchors.centerIn: parent.Center
                implicitWidth: 100
                implicitHeight: 40
                opacity: buttonOpacity
                border.color: searchButton.down ? "#17a81a" : "#21be2b"
                border.width: buttonBorderWidth
                radius: 2
            }


        }
    }
} // Row
