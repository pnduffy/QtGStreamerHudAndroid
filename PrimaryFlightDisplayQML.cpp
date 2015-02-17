/*===================================================================
APM_PLANNER Open Source Ground Control Station

(c) 2014 Bill Bonney <billbonney@communistech.com>

This file is part of the APM_PLANNER project

    APM_PLANNER is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    APM_PLANNER is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with APM_PLANNER. If not, see <http://www.gnu.org/licenses/>.

======================================================================*/
#include "PrimaryFlightDisplayQML.h"
#include <QVBoxLayout>
#include <QMessagebox>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickItem>
#include <QtQml/QQmlEngine>
#include <QGst/Init>
#include <QSettings>
#include <QApplication>
#include <QStandardPaths>
#include <QDesktopServices>
#include <QGst/Quick/VideoItem>
#include <QtAndroidExtras/QAndroidJniObject>
#include "LinkManager1.h"
#include "UASManager1.h"

#define ToRad(x) (x*0.01745329252)      // *pi/180
#define ToDeg(x) (x*57.2957795131)      // *180/pi

// Callback to update the custom plugin
void* update_node(void* surface,  void* node, qreal x, qreal y, qreal w, qreal h);

PrimaryFlightDisplayQML::PrimaryFlightDisplayQML(QObject *parent) :
    QObject(parent),
    m_declarativeView(NULL),
    m_uasInterface(NULL),
    m_player(NULL),
    m_showToolAction(NULL),
    m_surface(NULL),
    m_currentState(NULL),
    m_enableGStreamer(true),
    m_videoEnabled(true),
    m_uasConnected(false)
{

    m_enableVideoTimer.setSingleShot(true);
    connect(&m_enableVideoTimer, SIGNAL(timeout()), this, SLOT(onVideoEnabledTimer()));

	m_currentState = new QCurrentState();
    m_declarativeView = new QQuickView();
    m_surface = new QGst::Quick::VideoSurface;
    m_player = new GStreamerPlayer(m_declarativeView);
    m_player->setVideoSink(m_surface->videoSink());

    m_declarativeView->setResizeMode(QQuickView::SizeRootObjectToView);

    connect(m_player, SIGNAL(messageBox(QString)), this,
            SLOT(messageBox(QString)), Qt::UniqueConnection);

    // Default to video display until user selects
    InitializeDisplayWithVideo();

    // Connect with UAS
    connect(UASManager::instance(), SIGNAL(activeUASSet(UASInterface*)), this,
            SLOT(setActiveUAS(UASInterface*)), Qt::UniqueConnection);

}

PrimaryFlightDisplayQML::~PrimaryFlightDisplayQML()
{
    delete m_player;
    m_player = NULL;

	if (m_currentState != NULL)
	{
		delete m_currentState;
		m_currentState = NULL;
	}
}

void PrimaryFlightDisplayQML::setActiveUAS(UASInterface *uas)
{
    if (m_uasInterface) {
        disconnect(uas,SIGNAL(textMessageReceived(int,int,int,QString)),
                this,SLOT(uasTextMessage(int,int,int,QString)));

        disconnect(uas, SIGNAL(navModeChanged(int, int, QString)),
                   this, SLOT(updateNavMode(int, int, QString)));

    }
    m_uasInterface = uas;

    if (m_uasInterface) {
        connect(uas,SIGNAL(textMessageReceived(int,int,int,QString)),
                this,SLOT(uasTextMessage(int,int,int,QString)));
        connect(uas, SIGNAL(navModeChanged(int, int, QString)),
                this, SLOT(updateNavMode(int, int, QString)));

        VehicleOverview *obj = LinkManager::instance()->getUasObject(uas->getUASID())->getVehicleOverview();
        RelPositionOverview *rel = LinkManager::instance()->getUasObject(uas->getUASID())->getRelPositionOverview();
        AbsPositionOverview *abs = LinkManager::instance()->getUasObject(uas->getUASID())->getAbsPositionOverview();
        if (m_declarativeView)
        {
            m_declarativeView->rootContext()->setContextProperty("vehicleoverview",obj);
            m_declarativeView->rootContext()->setContextProperty("relpositionoverview",rel);
            m_declarativeView->rootContext()->setContextProperty("abspositionoverview",abs);
            QMetaObject::invokeMethod(m_declarativeView->rootObject(),"activeUasSet");
        }
    }
}

void PrimaryFlightDisplayQML::uasTextMessage(int uasid, int componentid, int severity, QString text)
{
    Q_UNUSED(uasid);
    Q_UNUSED(componentid);
    if (text.contains("PreArm") || severity == 3)
    {
        if (m_declarativeView)
        {
            QObject *root = m_declarativeView->rootObject();
            root->setProperty("statusMessage", text);
            root->setProperty("showStatusMessage", true);
        }
    }
    qCritical() << text;
}

void PrimaryFlightDisplayQML::messageBox(QString text)
{
    if (m_declarativeView)
    {
        QObject *root = m_declarativeView->rootObject();
        root->setProperty("messageBoxText", text);
        root->setProperty("showMessageBox", true);
    }

    qCritical() << text;
}

void PrimaryFlightDisplayQML::updateNavMode(int uasid, int mode, const QString& text)
{
    Q_UNUSED(uasid);
    Q_UNUSED(mode);
    if (m_declarativeView)
    {
        QObject *root = m_declarativeView->rootObject();
        root->setProperty("navMode", text);
    }
}

void PrimaryFlightDisplayQML::InitializeDisplayWithVideo()
{
    QUrl url = QUrl(QLatin1String("assets:/qml/PrimaryFlightDisplayWithVideoQML.qml"));
    m_declarativeView->engine()->clearComponentCache();
    m_declarativeView->rootContext()->setContextProperty(QLatin1String("videoSurface1"), m_surface);
    m_declarativeView->rootContext()->setContextProperty(QLatin1String("player"), m_player);
    m_declarativeView->rootContext()->setContextProperty(QLatin1String("container"), this);
    m_declarativeView->rootContext()->setContextProperty(QLatin1String("currentState"), m_currentState);
    m_declarativeView->setSource(url);
    m_declarativeView->show();

    // Wire up video surface manually
    QQuickItem *item = m_declarativeView->rootObject();
    QQuickItem *videoObj = item->findChild<QQuickItem*>("video");
    if (videoObj)
    {
        qCritical() << "Initializing Video Object in QML";
        QGst::Quick::VideoItem *pItem = dynamic_cast<QGst::Quick::VideoItem*>(videoObj);
        if (pItem)
        {
            pItem->setSurface(m_surface);
            pItem->setUpdateNodeCallback(&update_node);
        }
        else
        {
            qCritical() << "Unable to set VideoItem 'surface' property!";
        }
    }
    else
    {
         qCritical() << "Failed to find video object in QML!";
    }

    m_player->play();
    setActiveUAS(UASManager::instance()->getActiveUAS());
    qCritical() << "Showing Video";
}

void PrimaryFlightDisplayQML::enableVideo(bool enabled)
{
    if (enabled) m_player->play();
    else m_player->stop();
}

void PrimaryFlightDisplayQML::onVideoEnabledTimer()
{
    this->enableVideo(m_videoEnabled);
    emit videoEnabledChanged();
}

void PrimaryFlightDisplayQML::setVideoEnabled(bool value) {

    this->m_videoEnabled = value;
    if (!m_enableVideoTimer.isActive())
    {
        m_enableVideoTimer.start(1000);
    }
}

void PrimaryFlightDisplayQML::setOpenHelp(bool value)
{
    this->m_openHelp = value;
    emit openHelpChanged();

    if (this->m_openHelp)
    {
        QString appDataDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
        QString localHelpFile = appDataDir + "/help.html";
        qCritical() << "Local Help File =" << localHelpFile;
        QString assetsHelpFile = "assets:/resources/help.html";
        if (!QFile(localHelpFile).exists())
        {
            qCritical() << "Copying local help file";
            QFile(assetsHelpFile).copy(localHelpFile);
        }

        if (QFile(localHelpFile).exists())
        {
            QAndroidJniObject url = QAndroidJniObject::fromString(localHelpFile);
            QAndroidJniObject::callStaticMethod<void>("org/qtproject/qt5/android/bindings/QtActivityEx", "openUrl", "(Ljava/lang/String;)V",url.object<jstring>());
        }
    }

    this->m_openHelp = false;
    emit openHelpChanged();
}

void PrimaryFlightDisplayQML::applicationStateChanged(Qt::ApplicationState state)
{
    QString strState = "Unknown";
    switch (state)
    {
        case Qt::ApplicationState::ApplicationSuspended:
            strState = "Suspended";
            if (m_player) m_player->stop();
            break;
        case Qt::ApplicationState::ApplicationHidden:
            strState = "Hidden";
            if (m_player) m_player->stop();
            break;
        case Qt::ApplicationState::ApplicationInactive:
            strState = "Inactive";
            if (m_player) m_player->stop();
            break;
        case Qt::ApplicationState::ApplicationActive:
            strState = "Active";
            if (m_player) m_player->play();
            break;
    }

    qDebug() << "Application State Changed to " + strState;
}

void PrimaryFlightDisplayQML::setUasConnected(bool value) {

    LinkManager *pLinkMgr = LinkManager::instance();

    int iLinkId = -1;
    if (m_connectionMap.contains(m_ipOrHost))
    {
        iLinkId = m_connectionMap.value(m_ipOrHost);
    }

    if (iLinkId >= 0)
    {
        if (value) value = pLinkMgr->connectLink(iLinkId);
        else  pLinkMgr->disconnectLink(iLinkId);
        this->m_uasConnected = value;
        emit uasConnectedChanged();
        return;
    }

    // Not in list, add new
    QStringList split = m_ipOrHost.split(":");
    QString token;
    QString ipOrHost;

    int iToken = 0;
    int iPort = 0;

    bool isTCP = false;
    bool isUDP = false;

    QString text;

    Q_FOREACH(token, split)
    {
        switch (iToken)
        {

        case 0:
            if (token.startsWith("TCP"))
            {
                isTCP = true;
                iToken++;
                break;
            }
            if (token.startsWith("UDP"))
            {
                isUDP = true;
                iToken++;
                break;
            }

            // Error if got here, invalid string
            text = "Invalid connect string '" + m_ipOrHost + "', missing TCP,UDP";
            this->messageBox(text);
            value = false;
            this->m_uasConnected = value;
            emit uasConnectedChanged();
            return;

        case 1:
            if (isTCP)
            {
                ipOrHost = token;
                iToken++;
                break;
            }
            if (isUDP)
            {
                iPort = token.toInt();
                iToken++;
                break;
            }
            break;

        case 2:
            if (isTCP)
            {
                iPort = token.toInt();
                iToken++;
                break;
            }
            break;
        }
    }

    if (isTCP)
    {
        QHostAddress addr(ipOrHost);
        iLinkId = pLinkMgr->addTcpConnection(addr, iPort, false);
        m_connectionMap.insert(m_ipOrHost, iLinkId);
    }
    else if (isUDP)
    {
        iLinkId = pLinkMgr->addUdpConnection(QHostAddress::Any, iPort);
        m_connectionMap.insert(m_ipOrHost, iLinkId);
    }

    if (!pLinkMgr->connectLink(iLinkId))
    {
        text = "Cannot open connection '" + m_ipOrHost + "'!";
        this->messageBox(text);
        value = false;
    }

    this->m_uasConnected = value;
    emit uasConnectedChanged();
}

void PrimaryFlightDisplayQML::setPipelineString(QString pipelineString) 
{ 
    m_pipelineString = pipelineString; emit pipelineStringChanged();
    if (m_player) m_player->setPipelineString(m_pipelineString);

    qDebug() << "GStreamer Pipeline String = " << m_pipelineString;
}

void PrimaryFlightDisplayQML::setIpOrHost(QString ipOrHost)
{
    m_ipOrHost = ipOrHost; emit ipOrHostChanged();
    qDebug() << "IP Address or Host Connect String = " << m_ipOrHost;
}

void PrimaryFlightDisplayQML::SetCurrentState(CCurrentState &theState)
{
	// This method will update the bound state variables in the QML
	m_currentState->setRoll(theState.getRoll());
	m_currentState->setPitch(theState.getPitch());
	m_currentState->setYaw(theState.getYaw());
	m_currentState->setGroundspeed(theState.getGroundspeed());
	m_currentState->setAirspeed(theState.getAirspeed());
	m_currentState->setBatteryVoltage(theState.getBatteryVoltage());
	m_currentState->setBatteryCurrent(theState.getBatteryCurrent());
	m_currentState->setBatteryRemaining(theState.getBatteryRemaining());
	m_currentState->setAltitude(theState.getAltitude());

	m_currentState->setWatts(theState.getWatts());
	m_currentState->setGpsstatus(theState.getGpsStatus());
	m_currentState->setGpshdop(theState.getGpsHdop());
	m_currentState->setSatcount(theState.getSatCount());
	m_currentState->setWp_dist(theState.getWpDist());
	m_currentState->setCh3percent(theState.getCh3Percent());
	m_currentState->setTimeInAir(theState.getTimeInAir());
	m_currentState->setDistToHome(theState.getDistToHome());
	m_currentState->setDistTraveled(theState.getDistTravled());
	m_currentState->setAZToMAV(theState.getAzToMav());
	
	m_currentState->setLat(theState.getLat());
	m_currentState->setLng(theState.getLng());

	m_currentState->setArmed(theState.getArmed());

	m_currentState->setDistUnit(QString::fromWCharArray(theState.getDistUnit()));
	m_currentState->setSpeedUnit(QString::fromWCharArray(theState.getSpeedUnit()));
	m_currentState->setMessage(QString::fromWCharArray(theState.getMessage()));
	m_currentState->setFlightMode(QString::fromWCharArray(theState.getFlightMode()));

}






