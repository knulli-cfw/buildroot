################################################################################
#
# rtl8189fs
#
################################################################################
# batocera - bump 6.13 kernel
RTL8189FS_VERSION = 6b4cfb5c37f10c099d330ece54436706161c2f2e
RTL8189FS_SITE = $(call github,jwrdegoede,rtl8189ES_linux,$(RTL8189FS_VERSION))
RTL8189FS_LICENSE = GPL-2.0

RTL8189FS_USER_EXTRA_CFLAGS = \
	-UCONFIG_LITTLE_ENDIAN \
	-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN

RTL8189FS_MODULE_MAKE_OPTS = \
	CONFIG_RTL8189FS=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR) \
	USER_EXTRA_CFLAGS="$(RTL8189FS_USER_EXTRA_CFLAGS)"

ifeq ($(BR2_ENABLE_RUNTIME_DEBUG),)
RTL8189FS_MODULE_MAKE_OPTS += CONFIG_RTW_DEBUG=n
endif

define RTL8189FS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
