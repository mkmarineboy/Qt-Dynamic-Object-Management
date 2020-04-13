import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtWebEngine 1.8

Window {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var webPage: null
    property bool buttonToggle: true
    property var component;
    property var sprite;
    property url webSiteUrl: "https://muhammetkucuk.com/"

    function createSpriteObjects() {
        component = Qt.createComponent("WebEngineview.qml");
        if (component.status === Component.Ready)
            finishCreation();
        else
            component.statusChanged.connect(finishCreation);
    }

    function finishCreation() {
        if (component.status === Component.Ready) {
            sprite = component.createObject(appWindow, {"x": 0, "y": 0, "url":webSiteUrl});
            if (sprite === null) {
                // Error Handling
                console.log("Error creating object");
            }
        } else if (component.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    Button {
        z: 1
        id: destroyButton
        anchors.left: parent.left
        anchors.top: parent.top
        width: 150
        text: "close window"
        visible: buttonToggle
        onClicked: {
            sprite.destroy()
            sprite = null
            buttonToggle = false
        }
    }

    Button {
        z: 1
        id: createButton
        anchors.left: parent.left
        anchors.top: parent.top
        width: 150
        text: "open window"
        visible: !buttonToggle
        onClicked: {
            finishCreation()
            buttonToggle = true
        }
    }

    Component.onCompleted: createSpriteObjects()
}
