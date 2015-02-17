#include "VehicleOverview.h"
#include <QVariant>
#include "QGC.h"
VehicleOverview::VehicleOverview(QObject *parent) : QObject(parent)
{
    m_customMode = 0;
    m_type = 0;
    m_autopilot = 0;
    m_baseMode = 0;
    m_systemStatus = 0;
    m_mavlinkVersion = 0;

    //Sys_status
    m_onboardControlSensorsPresent = 0;
    m_onboardControlSensorsEnabled = 0;
    m_onboardControlSensorsHealth = 0;
    m_load = 0;
    m_voltageBattery = 0;
    m_dropRateComm = 0;
    m_errorsComm = 0;
    m_errorsCount1 = 0;
    m_errorsCount2 = 0;
    m_errorsCount3 = 0;
    m_errorsCount4 = 0;

    //nav_controller_output
    m_navRoll = 0;
    m_navPitch = 0;
    m_altError = 0;
    m_aspdError = 0;
    m_xtrackError = 0;
    m_navBearing = 0;
    m_targetBearing = 0;
    m_wpDist = 0;

    //battery_status
    m_currentConsumed = 0;
    m_energyConsumed = 0;
    m_voltageCell1 = 0;
    m_voltageCell2 = 0;
    m_voltageCell3 = 0;
    m_voltageCell4 = 0;
    m_voltageCell5 = 0;
    m_voltageCell6 = 0;
    m_currentBattery = 0;
    m_accuId = 0;
    m_batteryRemaining = 0;

    //power_status
    m_Vcc = 0;
    m_Vservo = 0;
    m_flags = 0;

    //radio_status
    m_rxerrors = 0;
    m_fixed = 0;
    m_rssi = 0;
    m_remrssi = 0;
    m_txbuf = 0;
    m_noise = 0;
    m_remnoise = 0;

    //User Generated
    m_armedState = false;
}

//Heartbeat
//sys_status
//system_time
//NAV_CONTROLLER_OUTPUT
//RADIO_STATUS
//POWER_STATUS
//BATTERY_STATUS
//STATUSTEXT
void VehicleOverview::parseHeartbeat(LinkInterface* ,const mavlink_message_t &, const mavlink_heartbeat_t &state)
{
    // Set new type if it has changed
    if (m_type != state.type)
    {
        /*if (isFixedWing()) {
            setAirframe(UASInterface::QGC_AIRFRAME_EASYSTAR);

        } else if (isMultirotor()) {
            setAirframe(UASInterface::QGC_AIRFRAME_CHEETAH);

        } else if (isGroundRover()) {
            setAirframe(UASInterface::QGC_AIRFRAME_HEXCOPTER);

        } else if (isHelicopter()) {
            setAirframe(UASInterface::QGC_AIRFRAME_HELICOPTER);

        } else {
            QLOG_DEBUG() << "Airframe is set to: " << type;
            setAirframe(UASInterface::QGC_AIRFRAME_GENERIC);
        }*/
        //this->autopilot = state.autopilot;
        //this->setAutopilot(state.autopilot);
        //this->setProperty("autopilot",state.autopilot);

       // emit systemTypeSet(this, type);
    }
    //Set properties to trigger UI updates
    this->setAutopilot(state.autopilot);
    this->setCustomMode(state.custom_mode);
    this->setType(state.type);
    this->setBaseMode(state.base_mode);
    this->setSystemStatus(state.system_status);
    this->setMavlinkVersion(state.mavlink_version);

    bool currentlyArmed = state.base_mode & MAV_MODE_FLAG_DECODE_POSITION_SAFETY;
    if (currentlyArmed != m_armedState)
    {
        if (currentlyArmed)
        {
            //Gone from not armed, to armed
        }
        else
        {
            //Gone from armed, to not armed
        }
        this->setArmedState(currentlyArmed);
    }

}
void VehicleOverview::parseBattery(LinkInterface *, const mavlink_message_t &, const mavlink_battery_status_t &)
{

}
void VehicleOverview::parseSysStatus(LinkInterface *, const mavlink_message_t &, const mavlink_sys_status_t &state)
{
    this->setOnboardControlSensorsEnabled(state.onboard_control_sensors_enabled);
    this->setOnboardControlSensorsHealth(state.onboard_control_sensors_health);
    this->setOnboardControlSensorsPresent(state.onboard_control_sensors_present);
    this->setLoad(state.load);
    this->setErrorsComm(state.errors_comm);
    this->setErrorsCount1(state.errors_count1);
    this->setErrorsCount2(state.errors_count2);
    this->setErrorsCount3(state.errors_count3);
    this->setErrorsCount4(state.errors_count4);
    this->setVoltageBattery(state.voltage_battery);
    this->setBatteryRemaining(state.battery_remaining);
    this->setCurrentBattery(state.current_battery);
    this->setDropRateComm(state.drop_rate_comm);
}

void VehicleOverview::messageReceived(LinkInterface* link,mavlink_message_t message)
{
    switch (message.msgid)
    {
        case MAVLINK_MSG_ID_HEARTBEAT:
        {
            mavlink_heartbeat_t state;
            mavlink_msg_heartbeat_decode(&message, &state);
            parseHeartbeat(link,message,state);
            break;
        }
        case MAVLINK_MSG_ID_BATTERY_STATUS:
        {
            mavlink_battery_status_t state;
            mavlink_msg_battery_status_decode(&message,&state);
            parseBattery(link,message,state);
            break;
        }
        case MAVLINK_MSG_ID_SYS_STATUS:
        {
            mavlink_sys_status_t state;
            mavlink_msg_sys_status_decode(&message,&state);
            parseSysStatus(link,message,state);
            break;
        }


    }
}
