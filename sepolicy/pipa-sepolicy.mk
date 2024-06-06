# Copyright (C) 2021 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# QCOM Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/xiaomi/pipa/sepolicy/vendor/qcom

# Xiaomi Sepolicy
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/xiaomi/pipa/sepolicy/private/xiaomi/devicesettings \
    device/xiaomi/pipa/sepolicy/private/xiaomi/display

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/xiaomi/pipa/sepolicy/public/xiaomi/devicesettings \
    device/xiaomi/pipa/sepolicy/public/xiaomi/touchfeature

BOARD_VENDOR_SEPOLICY_DIRS += \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/audio \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/battery \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/bluetooth \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/camera \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/dolby \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/modem \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/peripheralmanager \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/power_supply \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/sensors \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/thermald \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/touch \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/touchfeature \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/usb \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/wireless \
    device/xiaomi/pipa/sepolicy/vendor/xiaomi/wlan
