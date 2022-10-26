/*
 * Copyright (C) 2022 Project Kaleidoscope
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

package org.lineageos.settings.keyboard;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;

import androidx.annotation.NonNull;

import java.util.ArrayList;

public class XiaomiKeyboardManager {

    public static final int KEYBOARD_STATE_ON = 1;
    public static final int KEYBOARD_STATE_OFF = 0;

    private KeyboardHandler mHandler;
    private HandlerThread mHandlerThread;
    private SharedPreferences keyboard_prefs;
    private Context context;

    private int mKeyboardState = 0;

    private final ArrayList<KeyboardStateListener> mKeyboardStateListeners = new ArrayList<>();

    public static final String SHARED_KEYBOARD = "shared_keyboard";

    public XiaomiKeyboardManager(Context context) {
        this.context = context;
    }

    public void start() {
        if (mHandlerThread != null && mHandlerThread.isAlive()) return;
        mHandlerThread = new HandlerThread("keyboard_handler");
        mHandlerThread.start();
        mHandler = new KeyboardHandler(mHandlerThread.getLooper());
        mHandler.sendEmptyMessage(KeyboardHandler.MSG_READ_CONNECT_STATE);
    }

    public void stop() {
        if (mHandlerThread != null && mHandlerThread.isAlive()) {
            mHandlerThread.quitSafely();
        }
    }

    private void notifyKeyboardStateListeners(int state) {
        if (mKeyboardState == state) return;
        synchronized (mKeyboardStateListeners) {
            for (KeyboardStateListener listener : mKeyboardStateListeners) {
                listener.onKeyboardStateChanged(state);
            }
        }
        mKeyboardState = state;
    }

    public void addKeyboardStateListener(KeyboardStateListener listener) {
        synchronized (mKeyboardStateListeners) {
            mKeyboardStateListeners.add(listener);
        }
    }

    public void removeKeyboardStateListener(KeyboardStateListener listener) {
        synchronized (mKeyboardStateListeners) {
            mKeyboardStateListeners.remove(listener);
        }
    }

    public void doCheckPartsSwitchState() {
        while(true) {
            keyboard_prefs = context.getSharedPreferences(SHARED_KEYBOARD, Context.MODE_PRIVATE);
            if (keyboard_prefs.getInt(SHARED_KEYBOARD, 1) == 0)
                notifyKeyboardStateListeners(KEYBOARD_STATE_OFF);
            else
                notifyKeyboardStateListeners(KEYBOARD_STATE_ON);
        }
    }

    private class KeyboardHandler extends Handler {
        private static final int MSG_READ_CONNECT_STATE = 1;

        public KeyboardHandler(Looper looper) {
            super(looper);
        }

        @Override
        public void handleMessage(@NonNull Message msg) {
            switch (msg.what) {
                case MSG_READ_CONNECT_STATE:
                    doCheckPartsSwitchState();
                    break;
            }
        }
    }

    public interface KeyboardStateListener {
        void onKeyboardStateChanged(int state);
    }
}
