# Primary Arch
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a

# Secondary Arch
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a15
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true

TARGET_BOARD_PLATFORM := hikey
WITH_DEXPREOPT ?= true
USE_OPENGL_RENDERER := true
ANDROID_ENABLE_RENDERSCRIPT := true

# BT configs
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := "device/linaro/hikey/bluetooth"
BOARD_HAVE_BLUETOOTH := true

# generic wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
CONFIG_DRIVER_NL80211 := y

ifeq ($(TARGET_KERNEL_USE_4_1), true)
BOARD_KERNEL_CMDLINE := console=ttyAMA3,115200 androidboot.console=ttyAMA3 androidboot.hardware=hikey firmware_class.path=/system/etc/firmware efi=noruntime
else
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.console=ttyFIQ0 androidboot.hardware=hikey firmware_class.path=/system/etc/firmware efi=noruntime
endif

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
TARGET_HARDWARE_3D := true
BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736
ifeq ($(TARGET_USERDATAIMAGE_4GB), true)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1595915776
else
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5588893184
endif
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USE_PAN_DISPLAY := true

# enable to use the CPUSETS feature
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true
# We may want to enable this later
# but right now it doesn't build.
#ENABLE_SCHED_BOOST := true

BOARD_SEPOLICY_DIRS := device/linaro/hikey/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    sepolicy.te


ifeq ($(HOST_OS), linux)
ifeq ($(TARGET_SYSTEMIMAGES_USE_SQUASHFS), true)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
endif
endif

TARGET_BOOTIMAGE_USE_FAT := true
