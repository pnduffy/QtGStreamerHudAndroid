/*
    Copyright (C) 2012-2013 Collabora Ltd. <info@collabora.com>
      @author George Kiagiadakis <george.kiagiadakis@collabora.com>
    Copyright (C) 2013 basysKom GmbH <info@basyskom.com>
      @author Benjamin Federau <benjamin.federau@basyskom.com>

    This library is free software; you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published
    by the Free Software Foundation; either version 2.1 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
//import QtGStreamer 1.0

Rectangle {
    id: window
    width: 640
    height: 480

    property alias buttonPlay: buttonPlay
    property alias buttonPause: buttonPause
    property alias buttonStop: buttonStop

//    VideoItem {
//        id: video
//        objectName: "video"

//        width: window.width
//        height: window.height
//        //surface: videoSurface1 //bound on the context from main()
//    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: window.width
        height: 200
        spacing: 5

        Button {
            id: buttonPlay
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: qsTr("Play")
            onClicked: player.play()
        }

        Button {
            anchors.left: buttonPlay.right
            anchors.bottom: parent.bottom
            id: buttonPause
            text: qsTr("Pause")
            onClicked: player.pause()
        }

        Button {
            anchors.left: buttonPause.right
            anchors.bottom: parent.bottom
            id: buttonStop
            text: qsTr("Stop")
            onClicked: player.stop()
        }
    }
}
