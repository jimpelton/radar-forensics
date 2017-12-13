import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.3 as C2


// Time sliders
Row {
    id: sliderRow
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.leftMargin: 12
    anchors.bottomMargin: 12
    anchors.rightMargin: 12
    layoutDirection: Qt.LeftToRight
    height: 120


    property var mapSource
    property real fontSize: 14
    property int edge: Qt.BottomEdge

    property color labelBackground : "transparent"
    Connections {
        target: recmod
        onRowsInserted: {
            console.log("rows inserted");
        }
    }

    // Sliders column
    Column {
        height: parent.height;
        width: parent.width;
        C2.Slider {
            id: minTimeSlider
            height: parent.height/2;
            width: parent.width;
            orientation: Qt.Horizontal
            from: 0
            to: 1000
            value: 0
            onValueChanged: {
                if (value > maxTimeSlider.value) {
                    maxTimeSlider.value = value + 1;
                }
                parser.startTimeChanged(value/to);
                // do notify c++ of new start time
            }
            onPressedChanged: {
                if (pressed) {
                    parser.stopTimer();
                } else {
                    parser.startTimer();
                }
            }
        } // timeSlider

        C2.Slider {
            id: maxTimeSlider
            height: parent.height/2;
            width: parent.width;
            orientation: Qt.Horizontal
            from: 0
            to: 1000
            value: 1000
            onValueChanged: {
                if (value < minTimeSlider.value) {
                    minTimeSlider.value = value - 1
                }
                parser.endTimeChanged(value/to);
                // do notify c++ of new start time
            }
            onPressedChanged: {
                if (pressed) {
                    parser.stopTimer();
                } else {
                    parser.startTimer();
                }
            }


        } // maxTimeSlider
    } // Column


    // Labels column
    Column {
        width: 10
       height: parent.height
       spacing: 2

        Rectangle{
            color: labelBackground
            height: parent.height/2
            width: parent.width
//            border.color: sliderContainer.labelBorderColor
            Label {
                id: minTimeLabel
                text: minTimeSlider.value
                font.pixelSize: fontSize
                anchors.centerIn: parent
            }
        }

        Rectangle{
            color: labelBackground
            height: parent.height/2
            width: parent.width
//            border.color: sliderContainer.labelBorderColor
            Label {
                id: maxTimeLabel
                text: maxTimeSlider.value
                font.pixelSize: fontSize
                anchors.centerIn: parent
            }
        }
    }

} // sliderRow
