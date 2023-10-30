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

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Attestation
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Audio
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio.delta.refresh=true \
    persist.vendor.audio.misound.disable=true \
    persist.vendor.audio.ring.filter.mask=0 \
    ro.audio.monitorRotation=true \
    ro.config.vc_call_vol_steps=11 \
    ro.vendor.audio.enhance.support=false \
    ro.vendor.audio.gain.support=true \
    ro.vendor.audio.karaok.support=true \
    ro.vendor.audio.ns.support=false \
    ro.vendor.audio.scenario.support=true \
    ro.vendor.audio.soundfx.type=mi \
    ro.vendor.audio.soundfx.usb=true \
    ro.vendor.audio.support.sound.id=true \
    ro.vendor.audio.us.proximity=true \
    ro.vendor.audio.us.type=mius \
    ro.vendor.audio.zoom.support=true \
    ro.vendor.audio.zoom.type=1 \
    vendor.audio.spkcal.copy.inhal=true \
    vendor.audio.usb.disable.sidetone=true

PRODUCT_ODM_PROPERTIES += \
    aaudio.mmap_policy=1 \
    ro.vendor.audio.sdk.fluencetype=fluence \
    vendor.audio.adm.buffering.ms=6 \
    vendor.audio.feature.dynamic_ecns.enable=false \
    vendor.audio.feature.spkr_prot.enable=false \
    vendor.audio.hal.output.suspend.supported=false \
    vendor.audio.offload.multiple.enabled=true \
    vendor.audio.offload.track.enable=false

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

# Bluetooth
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.fflag.override.settings_bluetooth_hearing_aid=true \
    persist.vendor.qcom.bluetooth.a2dp_mcast_test.enabled=false \
    persist.vendor.qcom.bluetooth.aac_frm_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.aptxadaptiver2_1_support=false \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.scram.enabled=false \
    persist.vendor.qcom.bluetooth.soc=hastings \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    ro.vendor.bluetooth.wipower=false \
    vendor.hw.fm.init=0 \
    vendor.qcom.bluetooth.soc=hastings

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.btstack.enable.lpa=true \
    persist.vendor.btstack.enable.twsplus=true \
    persist.vendor.bt.a2dp.aac_whitelist=false

# Boot
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# Camera
PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/camxoverridesettings.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camxoverridesettings.txt

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    libcamera2ndk_vendor \
    libstdc++.vendor \
    vendor.qti.hardware.camera.device@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

# Charging
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.pps.disallowed=1 \
    persist.vendor.hvdcp_opti.disallowed=1

# Config Store
PRODUCT_PACKAGES += \
    disable_configstore

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.display.sensortype=2 \
    vendor.display.qdcm.mode_combine=1

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=4000 \
    ro.surface_flinger.set_touch_timer_ms=4000 \
    ro.surface_flinger.set_display_power_timer_ms=1000 \
    ro.surface_flinger.use_content_detection_for_refresh_rate=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.primary_display_orientation=ORIENTATION_0 \
    debug.sf.ignore_hwc_physical_display_orientation=true \
    ro.bootanim.set_orientation_4630946808805831297=ORIENTATION_90 \
    ro.bootanim.set_orientation_4630946922172900481=ORIENTATION_90

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/display/,$(TARGET_COPY_OUT_VENDOR)/etc)

# DRM
PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# Firmware
$(call inherit-product-if-exists, vendor/xiaomi/firmware/pipa/config.mk)

# FRP
PRODUCT_VENDOR_PROPERTIES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

# Gatekeeper
PRODUCT_VENDOR_PROPERTIES += \
    vendor.gatekeeper.disable_spu=true

# Gboard paddings
# Keyboard height ratio and bottom padding in dp for portrait mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.height_ratio=1.075 \
    ro.com.google.ime.kb_pad_port_b=8

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.pipa.rc \
    init.mi.btmac.sh \
    init.mi.usb.sh \
    init.qti.dcvs.sh \
    init.target.rc \
    ueventd.pipa.rc

# Json
PRODUCT_PACKAGES += \
    libjson

# Keymaster
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.allow_encrypt_override=true \
    ro.crypto.volume.filenames_mode="aes-256-cts" \
    ro.hardware.keystore_desede=true

# LMKD
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.lmk.force_inkernel_lmk=true

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor \
    libcodec2_soft_common.vendor \
    libsfplugin_ccodec_utils.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml

# Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi

# Overlays
PRODUCT_PACKAGES += \
    AOSPAPipaFrameworks \
    AOSPAPipaSystemUI \
    FrameworksRes23043RP34C \
    FrameworksResTarget \
    PipaFlipFlap \
    PipaFrameworks \
    PipaSettings \
    PipaSettingsProvider \
    PipaSystemUI \
    PipaWifiOverlay \
    WifiResTarget

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Platform
TARGET_BOARD_PLATFORM := kona

# QTI
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    charging \
    display \
    init \
    media \
    overlay \
    perf \
    usb \
    wfd \
    wlan

# Sensors
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.sensors.allow_non_default_discovery=true \
    persist.vendor.sensors.sync_request=true

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.sensors.enable.mag_filter=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl-xiaomi \
    android.hardware.sensors@1.0-service \
    libsensorndkbridge

# Setup Wizard
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.setupwizard.rotation_locked=false

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 31

# SoC Property
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.model=SM8250

# Storage
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true \
    ro.incremental.enable=yes

$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Subsystem silent restart
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.ssr.restart_level=ALL_ENABLE

# Tablet
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware.xml

PRODUCT_PACKAGES += \
    FlipFlap \
    RemoveTelephonyPackages

$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Thermal
PRODUCT_VENDOR_PROPERTIES += \
    vendor.sys.thermal.data.path=/data/vendor/thermal/

# Update Engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Vendor Service Manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Vendor
$(call inherit-product, vendor/xiaomi/pipa/pipa-vendor.mk)

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# VNDK
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.keymaster@4.1.vendor \
    android.hardware.neuralnetworks@1.3.vendor \
    android.hardware.wifi.hostapd@1.0.vendor

# VPP tunings
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/tunings.txt:$(TARGET_COPY_OUT_VENDOR)/etc/tunings.txt

# WLAN
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wlan/WCNSS_qcom_cfg_qca6390.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# WFD
PRODUCT_PACKAGES += \
    libwfdaac_vendor:32

# XiaomiParts
PRODUCT_PACKAGES += \
    XiaomiParts
