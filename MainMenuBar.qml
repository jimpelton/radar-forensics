import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.3

MenuBar {
    id: mainMenuBar
    property variant map
    property variant fileDialog

    Menu {
        id: fileMenu
        title: qsTr("File")
        MenuItem{
            text: qsTr("Open")
            onTriggered: fileDialog.open()
        }

        MenuItem {
            text: qsTr("Quit")
            onTriggered: {
                console.log("Goodbye!")
                Qt.quit()
            }
        }
    }

    Menu {
        id: mapTypeMenu
        title: qsTr("Map Type")

        function createMenu(map)
        {
            clear()
            for (var i = 0; i<map.supportedMapTypes.length; i++) {
                createMapTypeMenuItem(map.supportedMapTypes[i]).checked =
                        (map.activeMapType === map.supportedMapTypes[i]);
            }
        }

        function createMapTypeMenuItem(mapType)
        {
            console.log("Creating " + mapType);
            var item = addItem(mapType.name);
            item.checkable = true;
            item.triggered.connect(function(){
                map.selectMapType(mapType);
                for(var i = 0; i < mapTypeMenu.items.length; i++) {
                    if (mapTypeMenu.items[i] !== item) {
                        mapTypeMenu.items[i].checked = false;
                    }
                }
            });
            return item;
        }
        Component.onCompleted: {
            createMenu(map);
        }

    } // Menu : mapTypeMenu


} // menuBar
