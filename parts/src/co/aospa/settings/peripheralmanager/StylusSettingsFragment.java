/*
 * Copyright (C) 2023 The LineageOS Project
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
 * limitations under the License.
 */

package co.aospa.settings.peripheralmanager;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Switch;

import androidx.preference.ListPreference;
import androidx.preference.Preference;
import androidx.preference.Preference.OnPreferenceChangeListener;
import androidx.preference.PreferenceFragment;
import androidx.preference.SwitchPreference;

import com.android.settingslib.widget.MainSwitchPreference;

import co.aospa.settings.peripheralmanager.PenUtils;

import co.aospa.settings.R;

public class StylusSettingsFragment extends PreferenceFragment implements
        OnPreferenceChangeListener {

    private static final String STYLUS_KEY = "stylus_switch_key";
    public static final String SHARED_STYLUS = "shared_stylus_force";

    private SwitchPreference mStylusPreference;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        addPreferencesFromResource(R.xml.stylus_settings);

        SharedPreferences preferences = getActivity().getSharedPreferences(SHARED_STYLUS, Context.MODE_PRIVATE);

        mStylusPreference = (SwitchPreference) findPreference(STYLUS_KEY);
        mStylusPreference.setChecked(preferences.getInt(SHARED_STYLUS, 0) == 1);
        mStylusPreference.setEnabled(true);
        mStylusPreference.setOnPreferenceChangeListener(this);
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        if (STYLUS_KEY.equals(preference.getKey())) {
            forceStylus((Boolean) newValue ? 1 : 0);
        }
        return true;
    }

    private void forceStylus(int status) {
        SharedPreferences preferences = getActivity().getSharedPreferences(SHARED_STYLUS, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putInt(SHARED_STYLUS, status);
        editor.commit();
        if (status == 1)
            PenUtils.enablePenMode();
       else
            PenUtils.disablePenMode();
    }
}
