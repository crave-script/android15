#!/bin/bash

# Exit script on error
# set -e

timedatectl set-timezone UTC

repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs
# /opt/crave/resync.sh
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# Remove existing directories to avoid conflicts
# rm -rf device/xiaomi/sunny
# rm -rf device/qcom/common
# rm -rf device/qcom/qssi
# rm -rf device/xiaomi/sunny-kernel
# rm -rf vendor/xiaomi/sunny
# rm -rf vendor/qcom/common
# rm -rf vendor/qcom/opensource/core-utils
# rm -rf packages/apps/DisplayFeatures
# rm -rf packages/apps/KProfiles
# rm -rf hardware/xiaomi
# rm -rf hardware/qcom-caf/sm8150/media
# rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-elf
# rm -rf prebuilts/gcc/linux-x86/arm/arm-eabi
# rm -rf packages/apps/ViPER4AndroidFX
# rm -rf vendor/bcr
# rm -rf vendor/xiaomi/mojito-leicacamera
# rm -rf vendor/xiaomi/miuiapps
# rm -rf vendor/xiaomi/dynamicSpot
# rm -rf packages/apps/Updater
# rm -rf vendor/lineage
# rm -rf vendor/lineage-priv/keys
rm -rf frameworks/native

# Clone device-specific repositories
git clone https://github.com/dpenra/device_xiaomi_sunny.git -b lineage-22 device/xiaomi/sunny
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fifteen device/qcom/common
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b vauxite device/qcom/qssi
git clone https://github.com/dpenra/device_xiaomi_sunny-kernel.git --depth 1 -b fifteen device/xiaomi/sunny-kernel

# Clone vendor repositories
git clone https://github.com/dpenra/vendor_xiaomi_sunny.git --depth 1 -b fourteen vendor/xiaomi/sunny
rm vendor/xiaomi/sunny/proprietary/vendor/lib64/android.hardware.camera.provider@2.4-legacy.so
wget -P ./vendor/xiaomi/sunny/proprietary/vendor/lib64/ "https://gitlab.com/pnplusplus/android_vendor_xiaomi_mojito-leicacamera/-/raw/main/proprietary/vendor/lib64/android.hardware.camera.provider@2.4-legacy.so"
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fifteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fifteen vendor/qcom/opensource/core-utils

# Clone package repositories
git clone https://github.com/cyberknight777/android_packages_apps_DisplayFeatures packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles

# Clone hardware repositories
git clone https://github.com/dpenra/hardware_xiaomi.git --depth 1 -b fifteen hardware/xiaomi
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fifteen hardware/qcom-caf/sm8150/media

# Clone prebuilt GCC toolchains
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi

# Add custom repositories for additional features
git clone https://github.com/xiaomi-begonia-dev/android_packages_apps_ViPER4AndroidFX.git --depth 1 -b fourteen packages/apps/ViPER4AndroidFX
git clone https://github.com/Chaitanyakm/vendor_bcr.git --depth 1 -b main vendor/bcr
git clone https://gitlab.com/dpenra/android_vendor_xiaomi_mojito-leicacamera.git --depth 1 -b main vendor/xiaomi/mojito-leicacamera
git clone https://github.com/extra-application/vendor_xiaomi_miuiapps.git --depth 1 -b main vendor/xiaomi/miuiapps
git clone https://github.com/extra-application/vendor_xiaomi_dynamicSpot.git --depth 1 -b main vendor/xiaomi/dynamicSpot
git clone https://github.com/rising-source-mod/android_packages_apps_Updater.git --depth 1 -b fifteen packages/apps/Updater
git clone https://github.com/dpenra/android_frameworks_native.git --depth 1 -b fifteen frameworks/native

# Source modifications and RisingOS-specific keys
git clone https://github.com/rising-source-mod/android_vendor_lineage.git --depth 1 -b fifteen vendor/lineage
git clone https://github.com/private-keys/vendor_lineage-priv_keys.git --depth 1 -b main vendor/lineage-priv/keys

. build/envsetup.sh
export OUT_DIR=/media/dpenra/romout/risingout
export BUILD_USERNAME=dpenra
export BUILD_HOSTNAME=crave
riseup sunny user
rise b