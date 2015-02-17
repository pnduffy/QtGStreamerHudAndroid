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

#ifndef QCurrentState_H
#define QCurrentState_H

#include <QObject>

class QCurrentState : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(float roll READ getRoll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(float pitch READ getPitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(float yaw READ getYaw WRITE setYaw NOTIFY yawChanged)
	Q_PROPERTY(float groundspeed READ getGroundspeed WRITE setGroundspeed NOTIFY groundspeedChanged)
	Q_PROPERTY(float airspeed READ getAirspeed WRITE setAirspeed NOTIFY airspeedChanged)
	Q_PROPERTY(float batteryVoltage READ getBatteryVoltage WRITE setBatteryVoltage NOTIFY batteryVoltageChanged)
	Q_PROPERTY(float batteryCurrent READ getBatteryCurrent WRITE setBatteryCurrent NOTIFY batteryCurrentChanged)
	Q_PROPERTY(float batteryRemaining READ getBatteryRemaining WRITE setBatteryRemaining NOTIFY batteryRemainingChanged)
	Q_PROPERTY(float altitude READ getAltitude WRITE setAltitude NOTIFY altitudeChanged)

	Q_PROPERTY(float watts READ getWatts WRITE setWatts NOTIFY wattsChanged)
	Q_PROPERTY(float gpsstatus READ getGpsstatus WRITE setGpsstatus NOTIFY gpsstatusChanged)
	Q_PROPERTY(float gpshdop READ getGpshdop WRITE setGpshdop NOTIFY gpshdopChanged)
	Q_PROPERTY(float satcount READ getSatcount WRITE setSatcount NOTIFY satcountChanged)
	Q_PROPERTY(float wp_dist READ getWp_dist WRITE setWp_dist NOTIFY wp_distChanged)
	Q_PROPERTY(float ch3percent READ getCh3percent WRITE setCh3percent NOTIFY ch3percentChanged)
	Q_PROPERTY(float timeInAir READ getTimeInAir WRITE setTimeInAir NOTIFY timeInAirChanged)
	Q_PROPERTY(float DistToHome READ getDistToHome WRITE setDistToHome NOTIFY DistToHomeChanged)
	Q_PROPERTY(float distTraveled READ getDistTraveled WRITE setDistTraveled NOTIFY distTraveledChanged)
	Q_PROPERTY(float AZToMAV READ getAZToMAV WRITE setAZToMAV NOTIFY AZToMAVChanged)
	
	Q_PROPERTY(double lat READ getLat WRITE setLat NOTIFY latChanged)
	Q_PROPERTY(double lng READ getLng WRITE setLng NOTIFY lngChanged)
	Q_PROPERTY(bool armed READ getArmed WRITE setArmed NOTIFY armedChanged)

	Q_PROPERTY(QString distUnit READ getDistUnit WRITE setDistUnit NOTIFY distUnitChanged)
	Q_PROPERTY(QString speedUnit READ getSpeedUnit WRITE setSpeedUnit NOTIFY speedUnitChanged)
	Q_PROPERTY(QString message READ getMessage WRITE setMessage NOTIFY messageChanged)
	Q_PROPERTY(QString flightMode READ getFlightMode WRITE setFlightMode NOTIFY flightModeChanged)

    explicit QCurrentState(QObject *parent = 0);
    ~QCurrentState();

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
	float getGpsstatus() { return m_gpsstatus; }
	float getGpshdop() { return m_gpshdop; }
	float getSatcount() { return m_satcount; }
	float getWp_dist() { return m_wp_dist; }
	float getCh3percent() { return m_ch3percent; }
	float getTimeInAir() { return m_timeInAir; }
	float getDistToHome() { return m_DistToHome; }
	float getDistTraveled() { return m_distTraveled; }
	float getAZToMAV() { return m_AZToMAV; }
	
	double getLat() { return m_lat; }
	double getLng() { return m_lng; }

	bool getArmed() { return m_armed; }

	QString getDistUnit() { return m_distUnit; }
	QString getSpeedUnit() { return m_speedUnit; }
	QString getMessage() { return m_message; }
	QString getFlightMode() { return m_flightMode; }

    void setRoll(float roll) { m_roll = roll; emit rollChanged(roll); }
    void setPitch(float pitch) { m_pitch = pitch; emit pitchChanged(pitch); }
    void setYaw(float yaw) { m_yaw = yaw; emit yawChanged(yaw); }
    void setGroundspeed(float speed) { m_groundspeed = speed; emit groundspeedChanged(speed); }
    void setAirspeed(float speed) { m_airspeed = speed; emit airspeedChanged(speed); }
    void setBatteryVoltage(float v) { m_batteryVoltage = v; emit batteryVoltageChanged(v); }
    void setBatteryCurrent(float i) { m_batteryCurrent = i; emit batteryCurrentChanged(i); }
    void setBatteryRemaining(float percent) { m_batteryRemaining = percent; emit batteryRemainingChanged(percent); }
    void setAltitude(float alt) { m_altitude = alt; emit altitudeChanged(alt); }
	void setWatts(float watts) { m_watts = watts; emit wattsChanged(watts); }
	void setGpsstatus(float status) { m_gpsstatus = status; emit gpsstatusChanged(status); }
	void setGpshdop(float hdop) { m_gpshdop = hdop; emit gpshdopChanged(hdop); }
	void setSatcount(float count) { m_satcount = count; emit satcountChanged(count); }
	void setWp_dist(float dist) { m_wp_dist = dist; emit wp_distChanged(dist); }
	void setCh3percent(float percent) { m_ch3percent = percent; emit ch3percentChanged(percent); }
	void setTimeInAir(float time) { m_timeInAir = time; emit timeInAirChanged(time); }
	void setDistToHome(float dist) { m_DistToHome = dist; emit DistToHomeChanged(dist); }
	void setDistTraveled(float dist) { m_distTraveled = dist; emit distTraveledChanged(dist); }
	void setAZToMAV(float deg) { m_AZToMAV = deg; emit AZToMAVChanged(deg); }
	
	void setLat(double lat) { m_lat = lat; emit latChanged(lat); }
	void setLng(double lng) { m_lng = lng; emit lngChanged(lng); }

	void setArmed(bool armed) { m_armed = armed; emit armedChanged(armed); }

	void setDistUnit(QString unit) { m_distUnit = unit; emit distUnitChanged(unit); }
	void setSpeedUnit(QString unit) { m_speedUnit = unit; emit speedUnitChanged(unit); }
	void setMessage(QString message) { m_message = message; emit messageChanged(message); }
    void setFlightMode(QString mode) { m_flightMode = mode; emit flightModeChanged(mode); }

signals:
    void rollChanged(float);
	void pitchChanged(float);
	void yawChanged(float);
	void groundspeedChanged(float);
	void airspeedChanged(float);
	void batteryVoltageChanged(float);
	void batteryCurrentChanged(float);
	void batteryRemainingChanged(float);
	void altitudeChanged(float);
	void wattsChanged(float);
	void gpsstatusChanged(float);
	void gpshdopChanged(float);
	void satcountChanged(float);
	void wp_distChanged(float);
	void ch3percentChanged(float);
	void timeInAirChanged(float);
	void DistToHomeChanged(float);
	void distTraveledChanged(float);
	void AZToMAVChanged(float);
	
    void latChanged(double);
	void lngChanged(double);

	void armedChanged(bool);

	void distUnitChanged(QString);
	void speedUnitChanged(QString);
	void messageChanged(QString);
	void flightModeChanged(QString);

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

	QString m_distUnit;
	QString m_speedUnit;
	QString m_message;
	QString m_flightMode;
};

#endif
