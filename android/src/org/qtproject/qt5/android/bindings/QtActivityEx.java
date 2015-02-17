/*
    Copyright (c) 2012-2013, BogDan Vatra <bogdan@kde.org>
    Contact: http://www.qt-project.org/legal

    Commercial License Usage
    Licensees holding valid commercial Qt licenses may use this file in
    accordance with the commercial license agreement provided with the
    Software or, alternatively, in accordance with the terms contained in
    a written agreement between you and Digia.  For licensing terms and
    conditions see http://qt.digia.com/licensing.  For further information
    use the contact form at http://qt.digia.com/contact-us.

    BSD License Usage
    Alternatively, this file may be used under the BSD license as follows:
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package org.qtproject.qt5.android.bindings;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.PowerManager;
import android.view.WindowManager;
import android.widget.Toast;
import org.freedesktop.gstreamer.GStreamer;

import java.io.File;

public class QtActivityEx extends QtActivity
{
    public static QtActivityEx s_activity = null;
    private PowerManager.WakeLock wake_lock;

    // every time you override a method, always make sure you
    // then call super method as well
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        s_activity = this;

        PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
        wake_lock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "qmlplayer2");
        wake_lock.setReferenceCounted(false);

        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON);

        // Initialize GStreamer and warn if it fails
        try {
            System.loadLibrary("gstreamer_android");
            GStreamer.init(this);
        } catch (Exception e) {
            Toast.makeText(this, e.getMessage(), Toast.LENGTH_LONG).show();
            finish();
            return;
        }


        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onResume() {
        wake_lock.acquire();
        super.onResume();
    }

    @Override
    protected void onPause()
    {
        wake_lock.release();
        super.onPause();
    }

    @Override
    protected void onStop()
    {
        wake_lock.release();
        super.onStop();
    }

    @Override
    protected void onDestroy()
    {
        wake_lock.release();
        super.onDestroy();
        s_activity = null;
    }

    public static void openUrl(final String m_url)
    {
        s_activity.runOnUiThread(new Runnable() {
            public void run() {
                Intent intent = new Intent();
                intent.setAction(android.content.Intent.ACTION_VIEW);
                File file = new File(m_url);
                intent.setDataAndType(Uri.fromFile(file), "text/html");
                s_activity.startActivity(intent);
            }
        });
    }
}
