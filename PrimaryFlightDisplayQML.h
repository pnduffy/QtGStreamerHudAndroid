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

#ifndef PRIMARYFLIGHTDISPLAYQML_H
#define PRIMARYFLIGHTDISPLAYQML_H

#include "UASInterface1.h"
#include "QCurrentState.h"
#include "CCurrentState.h"
#include <QWidget>
#include <QDialog>
#include <QtQuick/QQuickView>
#include <QGst/Quick/VideoSurface>
#include "GStreamerPlayer.h"


class PrimaryFlightDisplayQML : public QObject
{
    Q_OBJECT

public:
    explicit PrimaryFlightDisplayQML(QObject *parent = 0);
    ~PrimaryFlightDisplayQML();

private slots:
    void setActiveUAS(UASInterface *uas);
    void uasTextMessage(int uasid, int componentid, int severity, QString text);
    void updateNavMode(int uasid, int mode, const QString& text);
    void enableVideo(bool enabled);
    void applicationStateChanged(Qt::ApplicationState state);
    void messageBox(QString text);
    void onVideoEnabledTimer();

signals:
    void videoEnabledChanged();
    void pipelineStringChanged();
    void ipOrHostChanged();
    void uasConnectedChanged();
    void openHelpChanged();

public:

    Q_PROPERTY(bool videoEnabled READ isVideoEnabled WRITE setVideoEnabled NOTIFY videoEnabledChanged)
    Q_PROPERTY(bool uasConnected READ isUasConnected WRITE setUasConnected NOTIFY uasConnectedChanged)
    Q_PROPERTY(bool openHelp READ getOpenHelp WRITE setOpenHelp NOTIFY openHelpChanged)

    void setVideoEnabled(bool value);
    bool isVideoEnabled() const { return m_videoEnabled; }

    void setUasConnected(bool value);
    bool isUasConnected() const { return m_uasConnected; }

    void setOpenHelp (bool value);
    bool getOpenHelp() const { return m_openHelp; }

    Q_PROPERTY(QString pipelineString READ getPipelineString WRITE setPipelineString NOTIFY pipelineStringChanged)
	void setPipelineString(QString pipelineString); 
	QString getPipelineString() const { return m_pipelineString; }

    Q_PROPERTY(QString ipOrHost READ getIpOrHost WRITE setIpOrHost NOTIFY ipOrHostChanged)
    void setIpOrHost(QString ipOrHost);
    QString getIpOrHost() const { return m_ipOrHost; }

    GStreamerPlayer * player() { return m_player; }

    void InitializeDisplayWithVideo();
    void SetCurrentState(CCurrentState &theState);
    void setShowToolAction(QAction *action) { m_showToolAction = action; }

private:

    QQuickView* m_declarativeView;
    UASInterface *m_uasInterface;
    GStreamerPlayer *m_player;
    QString m_pipelineString;
    QString m_ipOrHost;
    QAction *m_showToolAction;
    QGst::Quick::VideoSurface *m_surface;
    QCurrentState *m_currentState;
    QMap<QString,int> m_connectionMap;
    QTimer m_enableVideoTimer;

    bool m_enableGStreamer;
    bool m_videoEnabled;
    bool m_uasConnected;
    bool m_openHelp;

};

#endif // PRIMARYFLIGHTDISPLAYQML_H
