#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Adjust the dalvik heap to be appropriate for a tablet.
$(call inherit-product-if-exists, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := $(ANDROID_PRODUCT_OUT)/kernel_obj/arch/arm64/boot/Image
LOCAL_DTB := $(ANDROID_PRODUCT_OUT)/kernel_obj/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb
LOCAL_FSTAB := fstab.hikey
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
LOCAL_DTB := $(TARGET_PREBUILT_DTB)
LOCAL_FSTAB := $(TARGET_FSTAB)
endif

PRODUCT_COPY_FILES +=   $(LOCAL_KERNEL):kernel \
                        $(LOCAL_DTB):hi6220-hikey.dtb \
			$(LOCAL_PATH)/$(LOCAL_FSTAB):root/fstab.hikey \
			$(LOCAL_PATH)/init.hikey.rc:root/init.hikey.rc \
			$(LOCAL_PATH)/init.hikey.usb.rc:root/init.hikey.usb.rc \
			$(LOCAL_PATH)/ueventd.hikey.rc:root/ueventd.hikey.rc \
			$(LOCAL_PATH)/hikey.kl:system/usr/keylayout/hikey.kl

# Set custom settings
DEVICE_PACKAGE_OVERLAYS := device/linaro/hikey/overlay

# Add openssh support for remote debugging and job submission
PRODUCT_PACKAGES += ssh sftp scp sshd ssh-keygen sshd_config start-ssh uim

# Add wifi-related packages
PRODUCT_PACKAGES += libwpa_client wpa_supplicant hostapd
PRODUCT_PROPERTY_OVERRIDES += wifi.interface=wlan0 \
                              wifi.supplicant_scan_interval=15

# Build and run only ART
PRODUCT_RUNTIMES := runtime_libart_default

# Build BT a2dp audio HAL
PRODUCT_PACKAGES += audio.a2dp.default

# Include USB speed switch App
PRODUCT_PACKAGES += UsbSpeedSwitch

# Build libion
PRODUCT_PACKAGES += libion

# Build gralloc for hikey
PRODUCT_PACKAGES += gralloc.hikey


PRODUCT_PACKAGES += libteec \
					tee-supplicant \
					tee_helloworld \
					xtest

# OP TEE Hello world TA
PRODUCT_PACKAGES += 8aaaf200-2450-11e4-abe20002a5d5c51b.ta
PRODUCT_PACKAGES += e13010e0-2ae1-11e5-896a0002a5d5c51b.ta
PRODUCT_PACKAGES += 5ce0c432-0ab0-40e5-a056782ca0e6aba2.ta
PRODUCT_PACKAGES += c3f6e2c0-3548-11e1-b86c0800200c9a66.ta
PRODUCT_PACKAGES += cb3e5ba0-adf1-11e0-998b0002a5d5c51b.ta
PRODUCT_PACKAGES += 5b9e0e40-2636-11e1-ad9e0002a5d5c51b.ta
PRODUCT_PACKAGES += d17f73a0-36ef-11e1-984a0002a5d5c51b.ta
PRODUCT_PACKAGES += e6a33ed4-562b-463a-bb7eff5e15a493c8.ta
PRODUCT_PACKAGES += b689f2a7-8adf-477a-9f9932e90c0ad0a2.ta
PRODUCT_PACKAGES += f157cda0-550c-11e5-a6fa0002a5d5c51b.ta

# Set zygote config
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote64_32
PRODUCT_COPY_FILES += system/core/rootdir/init.zygote64_32.rc:root/init.zygote64_32.rc

PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += TIInit_11.8.32.bts \
                    wl18xx-fw-4.bin

# Copy hardware config file(s)
PRODUCT_COPY_FILES +=  \
        device/linaro/hikey/etc/permissions/android.hardware.screen.xml:system/etc/permissions/android.hardware.screen.xml \
        frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
        frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
        frameworks/native/data/etc/android.software.backup.xml:system/etc/permissions/android.software.backup.xml \
        frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# Include vendor binaries
$(call inherit-product-if-exists, vendor/linaro/hikey/device-vendor.mk)

# Include BT modules
$(call inherit-product-if-exists, device/linaro/hikey/wpan/ti-wpan-products.mk)

PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
        frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
        frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
        device/linaro/hikey/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
        device/linaro/hikey/android_dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
        device/linaro/hikey/audio/audio_policy.conf:system/etc/audio_policy.conf

# Copy media codecs config file
PRODUCT_COPY_FILES += device/linaro/hikey/etc/media_codecs.xml:system/etc/media_codecs.xml

# Set so that OP-TEE clients can find the installed dev-kit, which
# depends on platform and word-size.
TA_DEV_KIT_DIR := optee/optee_os/out/arm-plat-hikey/export-ta_arm64
