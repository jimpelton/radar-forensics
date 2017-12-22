import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6

Map {
    id: map
    anchors.fill: parent
    center: QtPositioning.coordinate(43.615547786, -116.211697647) // Boise
    zoomLevel: 10

    signal selectMapType(variant mapType)

    MapItemView {
        model: recmod
        delegate: MapQuickItem{
            coordinate:  QtPositioning.coordinate(model.attrs.latitude, model.attrs.longitude)
            visible: true
            zoomLevel: 0
            sourceItem: Rectangle{
                id: image
                visible: true
                width:  8
                height: 8
                radius: height/2.0
                color: model.color
                border.color: "white"
                border.width: 1

                Text{
                    id: markerText
                    visible: true
                    y: image.height/10
                    width: image.width
                    color: "black"
                    font.bold: true
                    font.pixelSize: 10
                    horizontalAlignment: Text.AlignHCenter
                    text: model.attrs.text
                }
            }



        }

    }


    MouseArea {
        id: mouseArea
        //        property variant lastCoordinate
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onPressed: {

            if (pressedButtons & Qt.RightButton){
                console.log("Right button clicked.")
            } else if (pressedButtons & Qt.LeftButton){
                console.log("Left button clicked.")
            }

        }
    }

    onSelectMapType: {
        map.activeMapType = mapType
        map.update()
    }


}
