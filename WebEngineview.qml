import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtWebEngine 1.8

WebEngineView {
    id: webEngineview
    anchors.fill: parent
    audioMuted: false

    Component.onCompleted: console.log("component created!")
    Component.onDestruction: console.log("component destroyed!")
}
