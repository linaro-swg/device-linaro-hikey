ifneq ($(filter hikey%, $(TARGET_DEVICE)),)

ifeq ($(TARGET_BUILD_KERNEL), true)
$(PRODUCT_OUT)/hi6220-hikey.dtb: all_dtbs
	cp $(PRODUCT_OUT)/obj/kernel/arch/arm64/boot/hi6220-hikey.dtb $(PRODUCT_OUT)/hi6220-hikey.dtb

endif
endif
