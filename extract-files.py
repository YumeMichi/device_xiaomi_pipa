#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2021-2024 Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import ExtractUtils, ExtractUtilsModule


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libOmxCore',
        'libgrallocutils',
        'libwfdaac_vendor',
    ): lib_fixup_remove,
    (
        'libmmosal',
        'vendor.display.color@1.0',
        'vendor.display.color@1.1',
        'vendor.display.color@1.2',
        'vendor.display.color@1.3',
        'vendor.display.color@1.4',
        'vendor.display.color@1.5',
        'vendor.display.postproc@1.0',
        'vendor.qti.hardware.limits@1.0',
        'vendor.qti.hardware.wifidisplaysession@1.0',
    ): lib_fixup_vendor_suffix,
}


blob_fixups: blob_fixups_user_type = {
    'odm/bin/hw/vendor.dolby_v3_6.hardware.dms360@2.0-service': blob_fixup()
        .add_needed('libstagefright_foundation-v33.so'),
    'vendor/lib/hw/audio.primary.pipa.so': blob_fixup()
        .binary_regex_replace(
            b'/vendor/lib/liba2dpoffload\\.so',
            b'liba2dpoffload_pipa.so\x00\x00\x00\x00\x00\x00\x00',
        )
        .binary_regex_replace(
            b'/vendor/lib/libssrec\\.so',
            b'libssrec_pipa.so\x00\x00\x00\x00\x00\x00\x00',
        ),
    (
        'vendor/lib64/libcodec2_soft_ac4dec.so',
        'vendor/lib64/libcodec2_soft_ddpdec.so',
    ): blob_fixup()
        .replace_needed(
            'libstagefright_foundation.so',
            'libstagefright_foundation-v34_cancunf.so',
        ),
    'vendor/lib64/libdeccfg.so': blob_fixup()
        .replace_needed(
            'libdapparamstorage.so',
            'libdapparamstorage-v34_cancunf.so',
        ),
    (
        'vendor/lib64/mediadrm/libwvdrmengine.so',
        'vendor/lib64/libwvhidl.so',
    ): blob_fixup()
        .add_needed('libcrypto_shim.so'),
}  # fmt: skip


namespace_imports = [
    'device/xiaomi/pipa',
    'hardware/xiaomi',
    'vendor/qcom/common/vendor/adreno/r',
    'vendor/qcom/common/vendor/display',
    'vendor/qcom/common/vendor/display/4.19',
    'vendor/qcom/common/vendor/keymaster',
    'vendor/qcom/common/vendor/media/legacy',
]


module = ExtractUtilsModule(
    'pipa',
    'xiaomi',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)


if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
