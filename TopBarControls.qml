import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1

RowLayout{


    anchors.top: parent.top
    anchors.left: parent.left
    spacing: 10
    layoutDirection: Qt.LeftToRight



    Row{
        Image {
            id: bsLogo
            source: "images/logo.png"
        }
    }

    Row {
        spacing: 10

        FadeButton {
            id: csvButton
            buttonText: "CSV"
        }
        FadeButton {
            id: centeringButton
            buttonText: "Enable Centering"
            onClicked: {
                console.log("Clicked it!");
            }
        }
        FadeButton {
            id: geoLocateTrackerButton
            buttonText: "Geolocate"
        }
        FadeButton {
            id: clearButton
            buttonText: "Clear Markers"
        }
    }
    Row {
        spacing: 0
        FadeButton {
            id: liveButton
            buttonText: "Live"
        }
        FadeButton {
            id: pauseButton
            buttonText: "Pause"
        }
        FadeButton {
            id: searchButton
            buttonText: "Search"
        }
    }
}

//        Button{ id: centeringbutton
//            property bool on: true
//            text: on ? "Disable Centering" : "Enable Centering"
//            background: Rectangle {
//                anchors.centerIn: parent.Center
//                implicitWidth: 105
//                implicitHeight: 40
//                opacity: centeringButton.hovered ? buttonOpacity2 : buttonOpacity
//                color: centeringButton.on ? "#FFFFaa" : "white"
//                border.color: centeringButton.hovered ? buttonBorderColor1 : buttonBorderColor2
//                border.width: buttonBorderWidth
//                radius: 2
//            }

//            onClicked: {
//                centeringButton.on = ! centeringButton.on
//            }

//        }

//        Button{
//            id: geoLocateTracker
//            text: "Geolocate"
//            background: Rectangle {
//            anchors.centerIn: parent.Center
//            implicitWidth: 100
//            implicitHeight: 40
//            opacity: geoLocateTracker.hovered ? buttonOpacity2 : buttonOpacity
//            border.color: geoLocateTracker.hovered ? buttonBorderColor1 : buttonBorderColor2
//            border.width: buttonBorderWidth
//            radius: 2
//        }

//        }

//        Button {
//           id: clearButton
//           text: "Clear Markers"
//           background: Rectangle {
//            anchors.centerIn: parent.Center
//            implicitWidth: 100
//            implicitHeight: 40
//            opacity: clearButton.hovered ? buttonOpacity2 : buttonOpacity
//            border.color: clearButton.hovered ? buttonBorderColor1 : buttonBorderColor2
//            border.width: buttonBorderWidth
//            radius: 2
//        }


//        }
//    }

//    Row{
//        spacing: 0
//        Button{
//          id: liveButton
//          text: "Live"
//          background: Rectangle {
//            anchors.centerIn: parent.Center
//            implicitWidth: 100
//            implicitHeight: 40
//            opacity: liveButton.hovered ? buttonOpacity2 : buttonOpacity
//            border.color: liveButton.hovered ? buttonBorderColor1 : buttonBorderColor2
//            border.width: buttonBorderWidth
//            radius: 2
//        }


//        }

//        Button{
//            id: pauseButton
//            text: "Pause"
//            background: Rectangle {
//                anchors.centerIn: parent.Center
//                implicitWidth: 100
//                implicitHeight: 40
//                opacity: pauseButton.hovered ? buttonOpacity2 : buttonOpacity
//                border.color: pauseButton.hovered ? buttonBorderColor1 : buttonBorderColor2
//                border.width: buttonBorderWidth
//                radius: 2
//                Behavior on opacity {
//                    OpacityAnimator {
//                        from: pauseButton.hovered ? buttonOpacity2 : buttonOpacity
//                        to: pauseButton.hovered ? buttonOpacity : buttonOpacity2
//                        duration: 200
//                    }
//                }
//            }



//        }

//        Button {
//            id: searchButton
//            text: "Search"
//            background:  Rectangle {
//                anchors.centerIn: parent.Center
//                implicitWidth: 100
//                implicitHeight: 40
//                opacity: searchButton.hovered ? buttonOpacity2 : buttonOpacity
//                border.color: searchButton.hovered ? buttonBorderColor1 : buttonBorderColor2
//                border.width: buttonBorderWidth
//                radius: 2
//            }


//        }
//    }
