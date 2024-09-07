################################################################################
#
# libfreeimage
#
################################################################################

LIBFREEIMAGE_VERSION = 3.18.0
LIBFREEIMAGE_SITE = http://downloads.sourceforge.net/freeimage
LIBFREEIMAGE_SOURCE = FreeImage$(subst .,,$(LIBFREEIMAGE_VERSION)).zip
LIBFREEIMAGE_LICENSE = GPL-2.0 or GPL-3.0 or FreeImage Public License
LIBFREEIMAGE_LICENSE_FILES = license-gplv2.txt license-gplv3.txt license-fi.txt
LIBFREEIMAGE_CPE_ID_VENDOR = freeimage_project
LIBFREEIMAGE_CPE_ID_PRODUCT = freeimage
LIBFREEIMAGE_INSTALL_STAGING = YES

define LIBFREEIMAGE_EXTRACT_CMDS
	$(UNZIP) $(LIBFREEIMAGE_DL_DIR)/$(LIBFREEIMAGE_SOURCE) -d $(@D)
	mv $(@D)/FreeImage/* $(@D)
	rmdir $(@D)/FreeImage
endef

# batocera
LIBFREEIMAGE_CFLAGS = $(TARGET_CFLAGS)
LIBFREEIMAGE_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_ARM_CPU_HAS_NEON)$(BR2_ARM_FPU_FP_ARMV8)$(BR2_ARM_CPU_ARMV8A),y)
	LIBFREEIMAGE_CFLAGS += -DPNG_ARM_NEON_OPT=0
endif

# batocera - add -fPIC during cross-compile
ifeq ($(HOSTARCH),aarch64)
ifeq ($(BR2_x86_64),y)
	LIBFREEIMAGE_CFLAGS += -fPIC
	LIBFREEIMAGE_CXXFLAGS += -fPIC
endif
endif

LIBFREEIMAGE_CXXFLAGS += -std=c++11

# batocera - add -fPIC during cross-compile
define LIBFREEIMAGE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(LIBFREEIMAGE_CFLAGS)" \
		CXXFLAGS="$(LIBFREEIMAGE_CXXFLAGS)" $(MAKE) -C $(@D)
endef

define LIBFREEIMAGE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define LIBFREEIMAGE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
