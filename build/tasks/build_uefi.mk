ifneq ($(filter hikey%, $(TARGET_DEVICE)),)

ifeq ($(TARGET_BUILD_UEFI), true)

BOOTLOADER_DIR ?= device/linaro/hikey/bootloader
DIST_DIR_PRODUCT ?= out/dist
TARGET_TEE_IS_OPTEE ?= false

TOP_ROOT_ABS := $(realpath $(TOP))
CROSS_COMPILE64 := $(TOP_ROOT_ABS)/$(TARGET_TOOLS_PREFIX)
ifneq ($(strip $($(combo_2nd_arch_prefix)TARGET_TOOLS_PREFIX)),)
CROSS_COMPILE32 := $(TOP_ROOT_ABS)/$($(combo_2nd_arch_prefix)TARGET_TOOLS_PREFIX)
endif

HOST_PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

$(DIST_DIR_PRODUCT)/fip.bin: $(BOOTLOADER_DIR)/Makefile
	rm -fr $(DIST_DIR_PRODUCT) $(OPTEE_OS_DIR)/out $(PRODUCT_OUT)/obj/optee
	PATH=$(HOST_PATH):$$PATH CROSS_COMPILE_32=$(CROSS_COMPILE32) CROSS_COMPILE_64=$(CROSS_COMPILE64) $(MAKE) -C $(BOOTLOADER_DIR) DIST_DIR=$(CURDIR)/$(DIST_DIR_PRODUCT) TARGET_TEE_IS_OPTEE=$(TARGET_TEE_IS_OPTEE) -j1 clean
	PATH=$(HOST_PATH):$$PATH CROSS_COMPILE_32=$(CROSS_COMPILE32) CROSS_COMPILE_64=$(CROSS_COMPILE64) $(MAKE) -C $(BOOTLOADER_DIR) DIST_DIR=$(CURDIR)/$(DIST_DIR_PRODUCT) TARGET_TEE_IS_OPTEE=$(TARGET_TEE_IS_OPTEE) all
	cp $@ device/linaro/hikey/installer/hikey

$(DIST_DIR_PRODUCT)/l-loader.bin: $(DIST_DIR_PRODUCT)/fip.bin
	cp $@ device/linaro/hikey/installer/hikey

droidcore: $(DIST_DIR_PRODUCT)/fip.bin $(DIST_DIR_PRODUCT)/l-loader.bin
endif

endif
