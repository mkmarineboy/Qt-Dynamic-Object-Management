import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtWebEngine 1.8

WebEngineView {
    id: webEngineview

    anchors.fill: parent
    audioMuted: false

    Component.onCompleted: console.log("component created!")
    Component.onDestruction: console.log("component destroyed!")
    profile: WebEngineProfile {
        onDownloadRequested: {
            download.downloadDirectory = "/Users/muhammetkucuk/Training/build-webOpenClose-Desktop_Qt_5_14_1_clang_64bit-Debug/appDownloads"
            download.accept()

            console.log(StandardPaths.displayName(StandardPaths.DataLocation))
        }
    }

    onFeaturePermissionRequested: {
        dialog.securityOrigin = securityOrigin
        dialog.feature = feature

        switch (feature){
        case WebEngineView.Geolocation:
            dialog.featureText = "location"
            console.log("location")
            break;
        case WebEngineView.MediaAudioCapture:
            dialog.featureText = "microphone"
            console.log("microphone")
            break;
        case WebEngineView.MediaVideoCapture:
            dialog.featureText = "camera"
            console.log("camera")
            break;
        case WebEngineView.MediaAudioVideoCapture:
            dialog.featureText = "microphone and camera"
            console.log("microphone and camera")
            break;
        case DesktopVideoCapture:
            console.log("desktop screen")
            break;
        case DesktopAudioVideoCapture:
            dialog.featureText = "microphone and desktop screen"
            console.log("microphone and desktop screen")
            break;
        case WebEngineView.Notifications:
            dialog.featureText = "notifications"
            console.log("notifications")
            break;
        default:
            dialog.featureText = "unknown"
            console.log("unknown")
        }
            dialog.open()
    }

    Dialog {
        id: dialog

        property var securityOrigin
        property var feature
        property string featureText

        title: "Permission requested to access camera and microphone"
        Label {
            color: "white"
            text: qsTr("Permission requested to access your " + dialog.featureText)
        }
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            grantFeaturePermission(securityOrigin, WebEngineView.MediaAudioVideoCapture, true)
            dialog.close()
        }
        onRejected: {
            grantFeaturePermission(securityOrigin, WebEngineView.MediaAudioVideoCapture, false)
            dialog.close()
        }
    }

    function printPage(){

    }

}
