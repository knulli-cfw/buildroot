################################################################################
#
# libxkbcommon
#
################################################################################
# batocera (update)
LIBXKBCOMMON_VERSION = 1.13.1
LIBXKBCOMMON_SITE = https://github.com/xkbcommon/libxkbcommon/archive/refs/tags
LIBXKBCOMMON_SOURCE = xkbcommon-$(LIBXKBCOMMON_VERSION).tar.gz
LIBXKBCOMMON_LICENSE = MIT/X11
LIBXKBCOMMON_LICENSE_FILES = LICENSE
LIBXKBCOMMON_CPE_ID_VENDOR = xkbcommon
LIBXKBCOMMON_INSTALL_STAGING = YES
LIBXKBCOMMON_DEPENDENCIES = host-bison host-flex libxml2 # batocera - add libxml2
LIBXKBCOMMON_CONF_OPTS = \
	-Denable-docs=false \
	-Denable-xkbregistry=true # batocera `true` for WINE

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBXKBCOMMON_CONF_OPTS += -Denable-x11=true
LIBXKBCOMMON_DEPENDENCIES += libxcb
else
LIBXKBCOMMON_CONF_OPTS += -Denable-x11=false
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON_TOOLS),y)
LIBXKBCOMMON_CONF_OPTS += -Denable-tools=true
else
LIBXKBCOMMON_CONF_OPTS += -Denable-tools=false
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON_TOOLS)$(BR2_PACKAGE_WAYLAND),yy)
LIBXKBCOMMON_CONF_OPTS += -Denable-wayland=true
LIBXKBCOMMON_DEPENDENCIES += wayland wayland-protocols
else
LIBXKBCOMMON_CONF_OPTS += -Denable-wayland=false
endif

$(eval $(meson-package))
