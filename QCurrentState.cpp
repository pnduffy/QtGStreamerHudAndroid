#include "QCurrentState.h"

QCurrentState::QCurrentState(QObject *parent) : QObject(parent)
{
    m_roll= 0;
    m_pitch = 0;
    m_yaw = 0;
    m_groundspeed = 0;
    m_airspeed = 0;
    m_batteryVoltage = 0;
    m_batteryCurrent = 0;
    m_batteryRemaining = 0;
    m_altitude = 0;

    m_watts = 0;
    m_gpsstatus = 0;
    m_gpshdop = 0;
    m_satcount = 0;
    m_wp_dist = 0;
    m_ch3percent = 0;
    m_timeInAir = 0;
    m_DistToHome = 0;
    m_distTraveled = 0;
    m_AZToMAV = 0;

    m_lat = 0;
    m_lng = 0;

    m_armed = false;
}

QCurrentState::~QCurrentState()
{
}


