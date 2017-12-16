import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick 2.7


Item {
    id: button
    width: innerText.width + 20
    height: innerText.height + 10
    property alias buttonText: innerText.text;
    property color color: "white"
    property color hoverColor: "white"
    property color pressColor: "slategray"
    property real normalOpacity: 0.65
    property real hoverOpacity: 1.0
    property int fontSize: 10
    property int borderWidth: 1
    property int borderRadius: 2
    scale: state === "Pressed" ? 0.96 : 1.0
    onEnabledChanged: state = "Exited"
    signal clicked

    //define a scale animation
    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }

    //Rectangle to draw the button
    Rectangle {
        id: rectangleButton
        anchors.fill: parent
        radius: borderRadius
        color: button.enabled ? button.color : "grey"
        opacity: normalOpacity
        border.width: borderWidth
        border.color: "black"

    }

    Text {
        id: innerText
        opacity: 1.0
        font.pointSize: fontSize
        anchors.centerIn: parent
    }

    //change the color of the button in differen button states
    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: rectangleButton
                color: hoverColor
                opacity: hoverOpacity
            }
        },
        State {
            name: "Exited"
            PropertyChanges {
                target: rectangleButton
                color: color
                opacity: normalOpacity
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: rectangleButton
                color: pressColor
                opacity: hoverOpacity
            }
        }
    ]

    //define transmission for the states
    transitions: [
        Transition {
            from: "Exited"; to: "Hovering"
            OpacityAnimator{ duration: 200 }
        },
        Transition {
            from: "Hovering"; to: "Exited"
            OpacityAnimator{ duration: 200 }
        },
        Transition {
            from: "*"; to: "Pressed"
            ColorAnimation { duration: 10 }
        }
    ]

    //Mouse area to react on click events
    MouseArea {
        hoverEnabled: true
        anchors.fill: button
        onEntered: { button.state='Hovering'}
        onExited: { button.state="Exited" }
        onClicked: { button.clicked(); }
        onPressed: { button.state="Pressed" }
        onReleased: {
            if (containsMouse)
              button.state="Hovering";
            else
              button.state="Exited";
        }
    }
}
