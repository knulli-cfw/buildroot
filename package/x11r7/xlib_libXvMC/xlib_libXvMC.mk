################################################################################
#
# xlib_libXvMC
#
################################################################################
# batocera - bump
XLIB_LIBXVMC_VERSION = 1.0.14
XLIB_LIBXVMC_SOURCE = libXvMC-$(XLIB_LIBXVMC_VERSION).tar.xz
XLIB_LIBXVMC_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXVMC_LICENSE = MIT
XLIB_LIBXVMC_LICENSE_FILES = COPYING
XLIB_LIBXVMC_CPE_ID_VENDOR = x.org
XLIB_LIBXVMC_CPE_ID_PRODUCT = libxvmc
XLIB_LIBXVMC_INSTALL_STAGING = YES
XLIB_LIBXVMC_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXv xorgproto
XLIB_LIBXVMC_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
