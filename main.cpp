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
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlEngine>
#include <QtOpenGL/QGLFormat>
#include <QGst/Init>
#include <QGst/Quick/VideoSurface>
#include <QGst/Quick/VideoItem>
#include <gst/gst.h>
#include <QThread>
#include <gstqtquick2videosink.h>
#include <PrimaryFlightDisplayQML.h>
#include <LinkManager1.h>
#include <UASManager1.h>

// Needed to manually register plugin
gboolean plugin_init(GstPlugin *plugin);

// Since Qt QML scene rendering is on a rendering thread and not the UI thread, use a 'direct' call instead of the glib 'signal/slot'
// The UI thread blocks during the 'update-node' call, so it's safe to make this direct call on the rendering thread
gpointer gst_qt_quick2_video_sink_update_node(GstQtQuick2VideoSink *self, gpointer node, qreal x, qreal y, qreal w, qreal h);

void* update_node(void* surface,  void* node, qreal x, qreal y, qreal w, qreal h)
{
    return gst_qt_quick2_video_sink_update_node((GstQtQuick2VideoSink*)surface, (gpointer)node, x, y, w, h);
}

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    QGst::init(&argc, &argv);

    qDebug() << "Start Link Manager";
    LinkManager::instance();

    qDebug() << "Start UAS Manager";
    UASManager::instance();

    gboolean success = gst_plugin_register_static (GST_VERSION_MAJOR,
                                GST_VERSION_MINOR ,
                                "qt5videosink",
                                "A video sink that can draw on any Qt surface",
                                &plugin_init,
                                "1.2.0",
                                "LGPL",
                                "libgstqt5videosink.so",
                                "QtGStreamer",
                                "http://gstreamer.freedesktop.org");

    if (!success)
    {
        qCritical() << "Could not register qt5videosink plugin with GStreamer!";
    }

    PrimaryFlightDisplayQML theDisplay;

    // Connect for android sleep signals
    QObject::connect(&app, SIGNAL(applicationStateChanged(Qt::ApplicationState)), &theDisplay,
            SLOT(applicationStateChanged(Qt::ApplicationState)), Qt::UniqueConnection);

    int retVal = app.exec();

    QGst::cleanup();

    return retVal;
}

