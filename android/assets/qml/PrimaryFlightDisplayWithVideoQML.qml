//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//    (c) 2014 Author: Bill Bonney <billbonney@communistech.com>
//

import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtGStreamer 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.2
import "Storage.js" as Settings

import "./components"

Rectangle {
    // Property Defintions
    id:root
    property bool enableBackgroundVideo: true
    property string statusMessage: ""
    property bool showStatusMessage: false
	property bool enableFullScreen: false
	property bool popupVisible: false
    property bool enableConnect: true
    property bool showMessageBox: false
    property string navMode: ""
    property string messageBoxText: ""
    property real zoom: Screen.pixelDensity * zoomSlider.value
    property real mm: Screen.pixelDensity

	Binding { target: root; property: "enableBackgroundVideo"; value: container.videoEnabled }
    Binding { target: root; property: "enableConnect"; value: container.uasConnected }

    function activeUasSet() {
        rollPitchIndicator.rollAngle = Qt.binding(function() { return relpositionoverview.roll})
        rollPitchIndicator.pitchAngle = Qt.binding(function() { return  relpositionoverview.pitch})
        pitchIndicator.rollAngle = Qt.binding(function() { return relpositionoverview.roll})
        pitchIndicator.pitchAngle = Qt.binding(function() { return  relpositionoverview.pitch})
        speedIndicator.groundspeed = Qt.binding(function() { return relpositionoverview.groundspeed})
        informationIndicator.groundSpeed = Qt.binding(function() { return relpositionoverview.groundspeed})
        informationIndicator.airSpeed = Qt.binding(function() { return relpositionoverview.airspeed })
        informationIndicator.batVoltage = Qt.binding(function() { return vehicleoverview.voltage_battery/1000.0 })
        informationIndicator.batCurrent = Qt.binding(function() { return vehicleoverview.current_battery/100.0 })
        informationIndicator.batPercent = Qt.binding(function() { return vehicleoverview.battery_remaining })
        informationIndicator.lat = Qt.binding(function() { return abspositionoverview.lat})
        informationIndicator.lng = Qt.binding(function() { return abspositionoverview.lon})
        informationIndicator.satcount = Qt.binding(function() { return abspositionoverview.satellites_visible})

        compassIndicator.heading = Qt.binding(function() {
            return (relpositionoverview.yaw < 0) ? relpositionoverview.yaw + 360 : relpositionoverview.yaw ;
        })

        compassIndicator.homeHeading = Qt.binding(function()
        {
            var homeHeading = abspositionoverview.homeHeading - relpositionoverview.yaw;
            if (homeHeading > 360) homeHeading = homeHeading - 360;
            if (homeHeading < 0) homeHeading = homeHeading + 360;
            return homeHeading;
        })

        speedIndicator.airspeed = Qt.binding(function() { return relpositionoverview.airspeed } )
        altIndicator.alt = Qt.binding(function() { return abspositionoverview.relative_alt } )

        informationIndicator.gpsstatus = Qt.binding(function()
        {
            switch (abspositionoverview.fix_type)
            {
                case 0:
                case 1:
                    return "No Fix";
                break;
                case 2:
                    return "2D Fix";
                break;
                case 3:
                    return "3D Fix";
                break;
                case 4:
                    return "DGPS";
                break;
                case 5:
                    return "RTK";
                break;
            }

            return "No Fix";
        })

        informationIndicator.watts = Qt.binding(function() { return informationIndicator.batVoltage * informationIndicator.batCurrent })
        informationIndicator.gpshdop = Qt.binding(function() { return currentState.gpshdop})
        informationIndicator.wp_dist = Qt.binding(function() { return currentState.wp_dist})
        informationIndicator.ch3percent = Qt.binding(function() { return currentState.ch3percent})
        informationIndicator.timeInAir = Qt.binding(function() { return currentState.timeInAir})
        informationIndicator.distToHome = Qt.binding(function() { return currentState.DistToHome})
        informationIndicator.distTraveled = Qt.binding(function() { return currentState.distTraveled})
        informationIndicator.armed = Qt.binding(function() { return currentState.armed})
        informationIndicator.distUnit = Qt.binding(function() { return currentState.distUnit})
        informationIndicator.speedUnit = Qt.binding(function() { return currentState.speedUnit})
        informationIndicator.message = Qt.binding(function() { return currentState.message})
    }
    
	Component.onCompleted:
	{
		rollPitchIndicator.enableRollPitch = Settings.get("enableRollPitchIndicator", true) == 0 ? false : true
		pitchIndicator.visible = Settings.get("enablePitchIndicator", true) == 0 ? false : true
		altIndicator.visible = Settings.get("enableAltIndicator", true) == 0 ? false : true
		speedIndicator.visible = Settings.get("enableSpeedIndicator", true) == 0 ? false : true
		compassIndicator.visible = Settings.get("enableCompassIndicator", true) == 0 ? false : true
		informationIndicator.visible = Settings.get("enableInformationIndicator", true) == 0 ? false : true
		brightnessSlider.value = Settings.get("brightness",0);
		contrastSlider.value = Settings.get("contrast",0);
		hueSlider.value = Settings.get("hue",0);
		saturationSlider.value = Settings.get("saturation",0);
        ipOrHost.text = Settings.get("ipOrHost", "");
        zoomSlider.value = Settings.get("zoomFactor",1.0);
        fontsizeSlider.value = Settings.get("fontPointSize", 20.0);
    }
	
	function activeUasUnset() {
        console.log("PFD-QML: Active UAS is now unset");
        //Code to make display show a lack of connection here.
    }

    onShowStatusMessageChanged: {
        statusMessageTimer.start()
    }

    Timer{
        id: statusMessageTimer
        interval: 5000;
        repeat: false;
        onTriggered: showStatusMessage = false
    }

	VideoItem {
		id: video
        objectName: "video"
		visible: enableBackgroundVideo
		width: root.width
		height: root.height
    }

	Menu { 
		id: contextMenu
        
		MenuItem { 
            text: "Video"
			checkable: true
			checked: enableBackgroundVideo
			onTriggered: 
			{
				root.enableBackgroundVideo = !root.enableBackgroundVideo
				container.videoEnabled = root.enableBackgroundVideo 
			}
        }

        MenuItem { 
            text: "Roll/Pitch"
			checkable: true
			checked: rollPitchIndicator.enableRollPitch
			onTriggered: 
			{
				rollPitchIndicator.enableRollPitch = !rollPitchIndicator.enableRollPitch
				Settings.set("enableRollPitchIndicator", rollPitchIndicator.enableRollPitch)
			}
        }

        MenuItem { 
            text: "Pitch"
			checkable: true
			checked: pitchIndicator.visible
			onTriggered:
			{			
				pitchIndicator.visible = !pitchIndicator.visible
				Settings.set("enablePitchIndicator", pitchIndicator.visible)
			}
        }
		
        MenuItem { 
            text: "Altitude"
			checkable: true
			checked: altIndicator.visible
			onTriggered: 
			{
				altIndicator.visible = !altIndicator.visible
				Settings.set("enableAltIndicator", altIndicator.visible)
			}
        }

        MenuItem { 
            text: "Speed"
			checkable: true
			checked: speedIndicator.visible
			onTriggered: 
			{
				speedIndicator.visible = !speedIndicator.visible
				Settings.set("enableSpeedIndicator", speedIndicator.visible)
			}
        }

        MenuItem { 
            text: "Compass"
			checkable: true
			checked: compassIndicator.visible
			onTriggered: 
			{
				compassIndicator.visible = !compassIndicator.visible
				Settings.set("enableCompassIndicator", compassIndicator.visible)
			}
        }

        MenuItem { 
            text: "Information"
			checkable: true
			checked: informationIndicator.visible
			onTriggered: 
			{
				informationIndicator.visible = !informationIndicator.visible
				Settings.set("enableInformationIndicator", informationIndicator.visible)
			}
        }
    }
	
	RollPitchIndicator {
		id: rollPitchIndicator
        zoom: root.zoom
		anchors.centerIn: parent
		rollAngle: 0
		pitchAngle: 0
        enableBackgroundVideo: root.enableBackgroundVideo
    }

    PitchIndicator {
        id: pitchIndicator
        zoom: root.zoom
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        opacity: 0.6

        pitchAngle: 0
        rollAngle: 0
    }

    AltitudeIndicator {
        id: altIndicator
        zoom: root.mm
        anchors.right: parent.right
        width: (10*root.mm)
        alt: 0
    }

    SpeedIndicator {
        id: speedIndicator
        zoom: root.mm
        anchors.left: parent.left
        width: (10*root.mm)
        airspeed: 0
        groundspeed: 0
    }

    CompassIndicator {
        id: compassIndicator
        zoom: root.zoom
        anchors.horizontalCenter: parent.horizontalCenter
        transform: Translate {
            y: 20
        }

        heading: 0
    }

    StatusMessageIndicator  {
        id: statusMessageIndicator
        anchors.fill: parent
        message: statusMessage
        visible: showStatusMessage
    }

    InformationOverlayIndicator{
        id: informationIndicator
        anchors.fill: parent
        airSpeed: 0
        groundSpeed: 0
        batVoltage: 0
        batCurrent: 0
        batPercent: 0
        navMode : root.navMode
        fontPointSize: fontsizeSlider.value
    }
	
	Rectangle
	{
        id: popup
		color: "lightgrey"
        width: parent.width
        height: (63*root.mm)
		z:3
		
        property real rowHeight: (6*root.mm)

		visible: root.popupVisible

		anchors
		{
			left: parent.left; top: parent.top
		}

		Column
		{
			anchors
			{
                left: parent.left; top: parent.top; leftMargin: 10; topMargin: (2.5*root.mm)
			}

			Text 
			{
                height: popup.rowHeight
				text: "Brightness"
			}
			Text 
			{
                height: popup.rowHeight
				text: "Contrast"
			}
			Text 
			{
                height: popup.rowHeight
				text: "Hue"
			}
			Text 
			{
                height: popup.rowHeight
				text: "Saturation"
			}

            Text
            {
                height: popup.rowHeight
                text: "HUD Size"
            }

            Text
            {
                height: popup.rowHeight
                text: "Font Size"
            }

            Text
			{
                height: popup.rowHeight
				text: "Pipeline"
			}

            Text
            {
                height: popup.rowHeight
                text: "MAV Connect"
            }
        }
		
		Column
		{
            id: contentCol
            width: parent.width - (25*root.mm)
			z:3
			anchors
			{
                right: parent.right; top: parent.top; topMargin: (2*root.mm); rightMargin: (2*root.mm)
			}

			Slider
			{
				id: brightnessSlider
				width: parent.width
                height: popup.rowHeight
				z:3
				minimumValue: -100
				maximumValue: 100
				stepSize: 1
				Binding { target: player; property: "brightness"; value: brightnessSlider.value }
				onValueChanged:
				{
					Settings.set("brightness", brightnessSlider.value)
				}
			}
			Slider
			{
				id: contrastSlider
				width: parent.width
                height: popup.rowHeight
				z:3
				minimumValue: -100
				maximumValue: 100
				stepSize: 1
				Binding { target: player; property: "contrast"; value: contrastSlider.value }
				onValueChanged:
				{
					Settings.set("contrast", contrastSlider.value)
				}
			}
			Slider
			{
				id: hueSlider
				width: parent.width
                height: popup.rowHeight
				z:3
				minimumValue: -100
				maximumValue: 100
				stepSize: 1
				Binding { target: player; property: "hue"; value: hueSlider.value }
				onValueChanged:
				{
					Settings.set("hue", hueSlider.value)
				}
			}
			Slider
			{
				id: saturationSlider
				width: parent.width
                height: popup.rowHeight
				z:3
				minimumValue: -100
				maximumValue: 100
				stepSize: 1
				Binding { target: player; property: "saturation"; value: saturationSlider.value }
				onValueChanged:
				{
					Settings.set("saturation", saturationSlider.value)
				}
			}
            Slider
            {
                id: zoomSlider
                width: parent.width
                height: popup.rowHeight
                z:3
                minimumValue: 0.5
                maximumValue: 1.5
                stepSize: 0.1
                onValueChanged:
                {
                    if (value>0.5) Settings.set("zoomFactor", zoomSlider.value)
                }
            }
            Slider
            {
                id: fontsizeSlider
                width: parent.width
                height: popup.rowHeight
                z:3
                minimumValue: 12
                maximumValue: 36
                stepSize: 1
                onValueChanged:
                {
                    if (value>12) Settings.set("fontPointSize", fontsizeSlider.value)
                }
            }

            RowLayout
            {
                width: parent.width
                height: popup.rowHeight
                anchors.left: parent.left
                z:3

                ComboBox
                {
                    id: pipelineString
                    editable: true
                    height: parent.height
                    anchors.right: buttonDeleteString.left
                    anchors.left: parent.left
                    property string stringText
                    property int stringIndex
                    z:3

                    Binding { target: container; property: "pipelineString"; value: pipelineString.currentText }
                    model: ListModel
                    {
                        id: model
                    }
                    onAccepted:
                    {
                        if (find(currentText) === -1)
                        {
                            if (editText.length > 0)
                            {
                                console.log("New pipeline = " + editText)
                                model.append({text: editText})
                                currentIndex = find(editText)

                                // Add to database
                                stringText = ""
                                for (stringIndex=0;; stringIndex++)
                                {
                                    stringText = Settings.get("pipelineString"+stringIndex,"");
                                    if (stringText.length == 0) break;
                                }

                                Settings.set("pipelineString"+stringIndex, currentText);
                            }
                        }

                        if (pipelineString.currentText.length > 0) Settings.set("pipelineString", pipelineString.currentText)
                    }

                    onCurrentIndexChanged:
                    {
                        console.log("Current Text = " + pipelineString.currentText + " Index = " + pipelineString.currentIndex)
                        if (pipelineString.currentText.length > 0) Settings.set("pipelineString", pipelineString.currentText)
                    }

                    Component.onCompleted:
                    {
                        // Get stored values
                        stringText = Settings.get("pipelineString0", "");
                        if (stringText.length == 0)
                        {
                            // Set defaults
                            Settings.set("pipelineString0", "videotestsrc ! queue");
                            Settings.set("pipelineString1", "udpsrc port=9000  buffer-size=60000 ! application/x-rtp,encoding-name=H264,payload=96 ! rtph264depay ! h264parse ! queue ! avdec_h264");
                            Settings.set("pipelineString2", "tcpclientsrc host=localhost port=9000 ! gdpdepay ! rtph264depay ! h264parse ! queue ! avdec_h264");
                        }

                        for (stringIndex=0;; stringIndex++)
                        {
                            // Get stored values
                            stringText = Settings.get("pipelineString" + stringIndex,"");
                            if (stringText.length > 0) model.append({ text: stringText })
                            else break;
                        }

                        pipelineString.currentIndex = pipelineString.find(Settings.get("pipelineString", "videotestsrc ! queue"));
                        console.log("pipelineString current Index = " + pipelineString.currentIndex)
                    }
                }

                Action
                {
                    id: deletePipelineString
                    enabled: pipelineString.currentText.length > 0
                    tooltip: "Delete Current Pipeline String"
                    property int stringIndex
                    property string stringText

                    onTriggered:
                    {
                        // Delete it
                        stringIndex = pipelineString.find(pipelineString.currentText)
                        if (stringIndex >= 0)
                        {
                            // Erase first
                            for (var i=0; i<model.count; i++)
                            {
                                Settings.set("pipelineString" + i,"");
                            }

                            console.log("Deleting Pipeline String = " + pipelineString.currentText);
                            pipelineString.editText = "";
                            model.remove(stringIndex);

                            for (stringIndex=0; stringIndex<model.count; stringIndex++)
                            {
                                var modeltext = pipelineString.model.get(stringIndex);
                                console.log("Saving pipelineString"+stringIndex+","+ modeltext.text);
                                Settings.set("pipelineString"+stringIndex, modeltext.text);
                            }
                        }
                    }
                }

                ToolButton
                {
                    id: buttonDeleteString
                    anchors.right: parent.right
                    height: parent.height
                    width: (6*root.mm)
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/disconnect.svg"
                        sourceSize.height: (6*root.mm)
                        sourceSize.width: (6*root.mm)
                    }
                    action: deletePipelineString
                }
            }

            TextField
            {
                id: ipOrHost
                width: parent.width
                height: popup.rowHeight
                z:3
                Binding { target: container; property: "ipOrHost"; value: ipOrHost.text }
                onEditingFinished:
                {
                    Settings.set("ipOrHost", ipOrHost.text)
                }
            }
		}

        Text
        {
            width: parent.width
            height: popup.rowHeight
            anchors
            {
                left: contentCol.left; top: contentCol.bottom; leftMargin: 10; topMargin: 5
            }

            z:3
            text: "TCP:{ip/host}:{port} or UDP:{port}"
        }

		Action 
		{
			id: play
			enabled: player.stopped || player.paused
			tooltip: "Play"
			onTriggered: player.playing = true
		}

		Action 
		{
			id: pause
			enabled: player.playing
			tooltip: "Pause"
			onTriggered: player.paused = true
		}
		
		Action 
		{
			id: stop
			enabled: player.playing
			tooltip: "Stop"
			onTriggered: player.stopped = true
		}

        Action
        {
            id: reset
            enabled: true
            tooltip: "Reset Defaults"
            onTriggered:
            {
                brightnessSlider.value = 0
                contrastSlider.value = 0
                hueSlider.value = 0
                saturationSlider.value = 0
                zoomSlider.value = 1
                fontsizeSlider.value = 20
            }
        }

        Action
        {
            id: connect
            enabled: !container.uasConnected
            tooltip: "Connect to MavLink"
            onTriggered:
            {
                root.enableConnect = !root.enableConnect
                container.uasConnected = root.enableConnect
            }
        }

        Action
        {
            id: disconnect
            enabled: container.uasConnected
            tooltip: "Disconnect from MavLink"
            onTriggered:
            {
                root.enableConnect = !root.enableConnect
                container.uasConnected = root.enableConnect
            }
        }

		ToolBar 
		{
			z:3
            height: (8*root.mm)
			anchors
			{
				bottom: parent.bottom
			}

            style: ToolBarStyle {
                   background: Rectangle {
                       color: "lightsteelblue"
                   }
            }

			RowLayout 
			{
                id: tbRow
                anchors
                {
                    verticalCenter: parent.verticalCenter
                }
                height : (8*root.mm)
                property real buttonHeight: (6*root.mm)
				z:3
                ToolButton
                {
                    id: buttonPlay
                    action: play
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/play.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }

                ToolButton
                {
                    id: buttonStop
                    anchors.left: buttonPlay.right
                    action: stop
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/stop.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }

                ToolButton
                {
                    id: buttonPause
                    anchors.left: buttonStop.right
                    action: pause
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/pause.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }

                ToolButton
                {
                    id: buttonReset
                    anchors.left: buttonPause.right
                    action: reset
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/reset.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }

                ToolButton
                {
                    id: buttonConnect
                    anchors.left: buttonReset.right
                    action: connect
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/connect.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }

                ToolButton
                {
                    id: buttonDisconnect
                    anchors.left: buttonConnect.right
                    action: disconnect
                    height: parent.height
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "./resources/components/primaryFlightDisplay/disconnect.svg"
                        sourceSize.height: tbRow.buttonHeight
                        sourceSize.width: tbRow.buttonHeight
                    }
                }
            }
		}

		MouseArea
		{
			anchors.fill: parent
			
			onClicked:
			{
			}
		}
	}

	MouseArea
	{
		anchors.fill: parent
		
		onClicked:
		{
			root.popupVisible = false
		}
	}

    RowLayout
    {
        id: topRow
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: (10*root.mm)
        spacing: 0
        property real buttonHeight: (8*root.mm)

        Button
        {
            id: buttonMenu
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top

            style: ButtonStyle
            {
                background: Rectangle
                {
                    implicitWidth: topRow.height
                    implicitHeight: topRow.height
                    color: "transparent"

                    Image
                    {
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.verticalCenter: parent.verticalCenter;
                        source: "./resources/components/primaryFlightDisplay/display.png"
                        width: topRow.buttonHeight
                        height: topRow.buttonHeight
                        sourceSize.height: topRow.buttonHeight
                        sourceSize.width: topRow.buttonHeight
                    }
                }
            }
            onClicked: contextMenu.popup()
        }

        Button
        {
            id: buttonSettings
            height: parent.height
            anchors.right: parent.right
            anchors.top: parent.top

            style: ButtonStyle
            {
                background: Rectangle
                {
                    implicitWidth: topRow.height
                    implicitHeight: topRow.height
                    color: "transparent"

                    Image
                    {
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.verticalCenter: parent.verticalCenter;
                        source: "./resources/components/primaryFlightDisplay/settings.png"
                        width: topRow.buttonHeight
                        height: topRow.buttonHeight
                        sourceSize.height: topRow.buttonHeight
                        sourceSize.width: topRow.buttonHeight
                    }
                }
            }
            onClicked: root.popupVisible = true
        }

        Button
        {
            id: buttonHelp
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            property string url

            style: ButtonStyle
            {
                background: Rectangle
                {
                    implicitWidth: topRow.height
                    implicitHeight: topRow.height
                    color: "transparent"

                    Image
                    {
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.verticalCenter: parent.verticalCenter;
                        source: "./resources/components/primaryFlightDisplay/help.png"
                        width: topRow.buttonHeight
                        height: topRow.buttonHeight
                        sourceSize.height: topRow.buttonHeight
                        sourceSize.width: topRow.buttonHeight
                    }
                }
            }
            onClicked:
            {
                container.openHelp = true
            }
        }

    }

    MessageDialog
    {
        id: messageDialog
        icon : StandardIcon.Warning
        visible: root.showMessageBox
        title: ""
        text: root.messageBoxText
        onAccepted: { root.showMessageBox = false; }
    }
}

