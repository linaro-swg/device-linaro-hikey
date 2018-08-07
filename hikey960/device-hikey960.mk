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

PRODUCT_COPY_FILES +=	$(TARGET_PREBUILT_KERNEL):kernel \
			$(TARGET_PREBUILT_DTB):hi3660-hikey960.dtb

PRODUCT_COPY_FILES +=	$(LOCAL_PATH)/fstab.hikey960:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.hikey960 \
			device/linaro/hikey/init.common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.hikey960.rc \
			device/linaro/hikey/init.hikey960.power.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.hikey960.power.rc \
			device/linaro/hikey/init.common.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.hikey960.usb.rc \
			device/linaro/hikey/ueventd.common.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
			device/linaro/hikey/common.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/hikey960.kl \
			frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
			frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml

# Copy BT firmware
PRODUCT_COPY_FILES += \
	device/linaro/hikey/bt-wifi-firmware-util/TIInit_11.8.32-pcm-960.bts:$(TARGET_COPY_OUT_VENDOR)/firmware/ti-connectivity/TIInit_11.8.32.bts

# Copy wlan firmware
PRODUCT_COPY_FILES += \
	device/linaro/hikey/bt-wifi-firmware-util/wl18xx-fw-4.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ti-connectivity/wl18xx-fw-4.bin \
	device/linaro/hikey/bt-wifi-firmware-util/wl18xx-conf-wl1837mod.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/ti-connectivity/wl18xx-conf.bin

# Copy hifi firmware
PRODUCT_COPY_FILES += \
	device/linaro/hikey/hifi/firmware/hifi-hikey960.img:$(TARGET_COPY_OUT_VENDOR)/firmware/hifi/hifi.img


# Build HiKey960 HDMI audio HAL. Experimental only may not work. FIXME
PRODUCT_PACKAGES += audio.primary.hikey960

PRODUCT_PACKAGES += gralloc.hikey960

#binary blobs from ARM
PRODUCT_PACKAGES +=	libGLES_mali.so \
			vulkan.hikey960.so \
			END_USER_LICENCE_AGREEMENT.txt

PRODUCT_PACKAGES += power.hikey960

PRODUCT_PACKAGES += sensors.hikey960

$(call inherit-product-if-exists, vendor/linaro/hikey960/device-vendor.mk)
