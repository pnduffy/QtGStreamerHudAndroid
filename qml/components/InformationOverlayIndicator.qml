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

import QtQuick 2.1

Item {
    id: root
    property real airSpeed: 0
    property real groundSpeed: 0
	property real batVoltage: 0
	property real batCurrent: 0
    property real batPercent: 0
	property real watts: 0
	property real gpshdop: 0
	property real satcount: 0
	property real wp_dist: 0
	property real ch3percent: 0
	property real timeInAir: 0
	property real distToHome: 0
	property real distTraveled: 0
	property real lat: 0
	property real lng: 0
	property bool armed: false
	property string distUnit: ""
	property string speedUnit: ""
	property string message: ""
	property string navMode: ""
	property string gpsstatus: ""
    property color color: "white"
    property color colorOutline: "black"

    Column{
        anchors {right: parent.horizontalCenter; bottom: parent.bottom; rightMargin: 120}
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "FM: " + navMode
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "AS: " + airSpeed.toFixed(1)
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "GS: " + groundSpeed.toFixed(1)
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "GPS: " + gpsstatus
        }
	}

    Column{
        anchors {left: parent.horizontalCenter; bottom: parent.bottom; leftMargin: 170}
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "V: " + batVoltage.toFixed(1)
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "I: " + batCurrent.toFixed(1)
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "%: " + batPercent.toFixed(1)
        }
        Text {
            color: root.color
			font.pointSize: 14
            styleColor: root.colorOutline
            style: Text.Outline
            text: "W: " + watts.toFixed(1)
        }
    }
}
