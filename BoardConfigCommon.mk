# Primary Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a

# Secondary Arch
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_USES_64_BIT_BINDER := true

USE_OPENGL_RENDERER := true

# BT configs
BOARD_HAVE_BLUETOOTH := true

# HACK! hikey64_only doesn't build w/ VNDK_VERSION=current
# This is due to software codecs being required but only
# building for 32bit. Remove the conditional once 64bit
# soft-codecs work
ifeq ($(filter hikey64, $(TARGET_DEVICE)),)
# enable Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current
endif

# generic wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
TARGET_HARDWARE_3D := true
BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USE_PAN_DISPLAY := true

TARGET_USES_HWC2 := true

TARGET_AUX_OS_VARIANT_LIST := neonkey argonkey

BOARD_SEPOLICY_DIRS += device/linaro/hikey/sepolicy
BOARD_SEPOLICY_DIRS += system/bt/vendor_libs/linux/sepolicy

DEVICE_MANIFEST_FILE := device/linaro/hikey/manifest.xml
DEVICE_MATRIX_FILE := device/linaro/hikey/compatibility_matrix.xml

ifneq ($(TARGET_SENSOR_MEZZANINE),)
DEVICE_MANIFEST_FILE += device/linaro/hikey/sensorhal/manifest.xml
DEVICE_MANIFEST_FILE += device/linaro/hikey/vr/manifest.xml
endif

ifeq ($(HOST_OS), linux)
ifeq ($(TARGET_SYSTEMIMAGES_USE_SQUASHFS), true)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
endif
endif

ifeq ($(TARGET_BUILD_KERNEL), true)
# Kernel Config
KERNEL_CONFIG := hikey_defconfig
ANDROID_64 := true
# Kernel Source and Device Tree
TARGET_KERNEL_SOURCE ?= kernel/linaro/hisilicon
DEVICE_TREES := hi6220-hikey:hi6220-hikey.dtb
BUILD_KERNEL_MODULES := false
KERNEL_TARGET := Image-dtb
endif
