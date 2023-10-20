/*
 * Copyright (C) 2023 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package co.aospa.settings.peripheralmanager;

import android.content.Context;
import android.hardware.input.InputManager;
import android.hardware.input.InputManager.InputDeviceListener;
import android.os.SystemProperties;
import android.util.Log;
import android.view.InputDevice;

import android.content.SharedPreferences;

public class PenUtils {

    private static final String TAG = "XiaomiPeripheralManagerPenUtils";
    private static final boolean DEBUG = true;

    private static InputManager mInputManager;

    public static final String SHARED_STYLUS = "shared_stylus_force";

    private static SharedPreferences preferences;

    public static void setup(Context context) {
        mInputManager = (InputManager) context.getSystemService(Context.INPUT_SERVICE);
        refreshPenMode();
        mInputManager.registerInputDeviceListener(mInputDeviceListener, null);
        SharedPreferences preferences = context.getSharedPreferences(SHARED_STYLUS, Context.MODE_PRIVATE);
    }

    public static void enablePenMode() {
        Log.d(TAG, "enablePenMode: Enable Pen Mode");
        SystemProperties.set("persist.sys.parts.pen", "18");
    }

    public static void disablePenMode() {
        Log.d(TAG, "disablePenMode: Disable Pen Mode");
        SystemProperties.set("persist.sys.parts.pen", "0");
    }

    private static void refreshPenMode() {
        for (int id : mInputManager.getInputDeviceIds()) {
            if (isDeviceXiaomiPen(id) || preferences.getInt(SHARED_STYLUS, 0) == 1) {
                if (DEBUG) Log.d(TAG, "refreshPenMode: Found Xiaomi Pen");
                enablePenMode();
                return;
            }
        }
        if (DEBUG) Log.d(TAG, "refreshPenMode: No Xiaomi Pen found");
        disablePenMode();
    }

    private static boolean isDeviceXiaomiPen(int id) {
        InputDevice inputDevice = mInputManager.getInputDevice(id);
        return inputDevice.getVendorId() == 6421 && inputDevice.getProductId() == 19841;
    }

    private static InputDeviceListener mInputDeviceListener = new InputDeviceListener() {
            @Override
            public void onInputDeviceAdded(int id) {
                refreshPenMode();
            }
            @Override
            public void onInputDeviceRemoved(int id) {
                refreshPenMode();
            }
            @Override
            public void onInputDeviceChanged(int id) {
                refreshPenMode();
            }
        };
}
