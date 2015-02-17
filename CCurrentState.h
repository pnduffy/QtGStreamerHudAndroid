/*
   Copyright (C) 2010 Marco Ballesio <gibrovacco@gmail.com>
   Copyright (C) 2011-2013 Collabora Ltd.
     @author George Kiagiadakis <george.kiagiadakis@collabora.co.uk>

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

#ifndef CCurrentState_H
#define CCurrentState_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

#ifndef MAX_PATH
#define MAX_PATH 256
#endif

class CCurrentState
{
public:
	static const int MAX_MESSAGE_LEN = 1024;

    explicit CCurrentState();
    ~CCurrentState();

    float getRoll() { return m_roll; }
	float getPitch() { return m_pitch; }
	float getYaw() { return m_yaw; }
	float getGroundspeed() { return m_groundspeed; }
	float getAirspeed() { return m_airspeed; }
	float getBatteryVoltage() { return m_batteryVoltage; }
	float getBatteryCurrent() { return m_batteryCurrent; }
	float getBatteryRemaining() { return m_batteryRemaining; }
	float getAltitude() { return m_altitude; }
	float getWatts() { return m_watts; }
	float getGpsStatus() { return m_gpsstatus; }
	float getGpsHdop() { return m_gpshdop; }
	float getSatCount() { return m_satcount; }
	float getWpDist() { return m_wp_dist; }
	float getCh3Percent() { return m_ch3percent; }
	float getTimeInAir() { return m_timeInAir; }
	float getDistToHome() { return m_DistToHome; }
	float getDistTravled() { return m_distTraveled; }
	float getAzToMav() { return m_AZToMAV; }
	
	double getLat() { return m_lat; }
	double getLng() { return m_lng; }

	bool getArmed() { return m_armed; }

	wchar_t* getFlightMode() { return m_flightMode; }
	wchar_t* getDistUnit() { return m_distUnit; }
	wchar_t* getSpeedUnit() { return m_speedUnit; }
	wchar_t* getMessage() { return m_message; }

    void setRoll(float roll) { m_roll = roll; }
    void setPitch(float pitch) { m_pitch = pitch; }
    void setYaw(float yaw) { m_yaw = yaw; }
	void setGroundspeed(float speed) { m_groundspeed = speed; }
	void setAirspeed(float speed) { m_airspeed = speed; }
	void setBatteryVoltage(float v) { m_batteryVoltage = v; }
	void setBatteryCurrent(float i) { m_batteryCurrent = i; }
	void setBatteryRemaining(float percent) { m_batteryRemaining = percent; }
	void setAltitude(float alt) { m_altitude = alt; }
    void setFlightMode(const wchar_t *mode) { wcsncpy(m_flightMode, mode, MAX_PATH); }
    void setDistUnit(const wchar_t *unit) { wcsncpy(m_distUnit, unit, MAX_PATH); }
    void setSpeedUnit(const wchar_t *unit) { wcsncpy(m_speedUnit, unit, MAX_PATH); }
    void setMessage(const wchar_t *msg) { wcsncpy(m_message, msg, MAX_MESSAGE_LEN); }
	
	void setWatts(float w) { m_watts = w; }
	void setGpsStatus(float status) { m_gpsstatus = status; }
	void setGpsHdop(float hdop) { m_gpshdop = hdop; }
	void setSatCount(float satcount) { m_satcount = satcount; }
	void setWpDist(float wpdist) { m_wp_dist = wpdist; }
	void setCh3Percent(float percent) { m_ch3percent = percent; }
	void setTimeInAir(float time) { m_timeInAir = time; }
	void setDistToHome(float dist) { m_DistToHome = dist; }
	void setDistTravled(float dist) { m_distTraveled = dist; }
	void setAzToMav(float deg) { m_AZToMAV = deg; }
	
	void setLat(double lat) { m_lat = lat; }
    void setLng(double lng) { m_lng = lng; }

	void setArmed(bool armed) { m_armed = armed; }

private:
	float m_roll;
	float m_pitch;
	float m_yaw;
	float m_groundspeed;
	float m_airspeed;
	float m_batteryVoltage;
	float m_batteryCurrent;
	float m_batteryRemaining;
	float m_altitude;
	float m_watts;
	float m_gpsstatus;
	float m_gpshdop;
	float m_satcount;
	float m_wp_dist;
	float m_ch3percent;
	float m_timeInAir;
	float m_DistToHome;
	float m_distTraveled;
	float m_AZToMAV;
	
	double m_lat;
	double m_lng;

	bool m_armed;

    wchar_t m_flightMode[MAX_PATH];
	wchar_t m_distUnit[MAX_PATH];
	wchar_t m_speedUnit[MAX_PATH];
	wchar_t m_message[MAX_MESSAGE_LEN];
};

#endif
