/*
 * Copyright (C) 2026 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <aidl/android/hardware/power/Boost.h>
#include <aidl/android/hardware/power/Mode.h>
#include <android-base/properties.h>

#include <cstdint>
#include <mutex>

namespace aidl::android::hardware::power::impl {

namespace {

constexpr int kInteractionBoostDurationMs = 100;

// MPCTLV3_GPU_MIN_POWER_LEVEL. Lower pwrlevels request higher frequencies.
constexpr int kGpuMinPowerLevel = 0x42804000;
// pwrlevel 0 requests the highest frequency available to the speed bin.
constexpr int kGpuInteractionPowerLevel = 0;

constexpr char kBackgroundBlurSupportProperty[] =
        "ro.surface_flinger.supports_background_blur";

int sInteractionHandle = 0;
std::mutex sInteractionMutex;

bool isBackgroundBlurSupported() {
    static const bool supported =
            ::android::base::GetBoolProperty(kBackgroundBlurSupportProperty, false);
    return supported;
}

} // namespace

extern "C" int interaction_with_handle(int lockHandle, int duration, int numArgs,
                                         int optList[]);

bool setDeviceSpecificMode(Mode, bool) {
    return false;
}

bool isDeviceSpecificModeSupported(Mode, bool*) {
    return false;
}

bool setDeviceSpecificBoost(Boost type, int32_t durationMs) {
    if (type != Boost::INTERACTION) {
        return false;
    }

    // Avoid the extra GPU boost on devices where SurfaceFlinger blur is disabled.
    if (!isBackgroundBlurSupported()) {
        return false;
    }

    if (durationMs < 0) {
        return true;
    }

    int resources[] = {kGpuMinPowerLevel, kGpuInteractionPowerLevel};
    std::lock_guard<std::mutex> lock(sInteractionMutex);
    sInteractionHandle = interaction_with_handle(
            sInteractionHandle, kInteractionBoostDurationMs,
            sizeof(resources) / sizeof(resources[0]), resources);
    return true;
}

bool isDeviceSpecificBoostSupported(Boost type, bool* supported) {
    if (type != Boost::INTERACTION) {
        return false;
    }

    *supported = isBackgroundBlurSupported();
    return true;
}

} // namespace aidl::android::hardware::power::impl
