################################################################################
#
# pixman
#
################################################################################
# batocera - bump (move to meson)
PIXMAN_VERSION = 0.43.4
PIXMAN_SOURCE = pixman-$(PIXMAN_VERSION).tar.xz
PIXMAN_SITE = https://xorg.freedesktop.org/releases/individual/lib
PIXMAN_LICENSE = MIT
PIXMAN_LICENSE_FILES = COPYING
PIXMAN_CPE_ID_VENDOR = pixman

PIXMAN_INSTALL_STAGING = YES
PIXMAN_DEPENDENCIES = host-pkgconf
HOST_PIXMAN_DEPENDENCIES = host-pkgconf

# don't build gtk based demos
PIXMAN_CONF_OPTS = \
	-Dgtk=disabled \
	-Dloongson-mmi=disabled \
	-Diwmmxt=disabled \
	-Dtests=disabled \
	-Ddemos=disabled

# The ARM SIMD code from pixman requires a recent enough ARM core, but
# there is a runtime CPU check that makes sure it doesn't get used if
# the HW doesn't support it. The only case where the ARM SIMD code
# cannot be *built* at all is when the platform doesn't support ARM
# instructions at all, so we have to disable that explicitly.
ifeq ($(BR2_ARM_CPU_HAS_ARM),y)
PIXMAN_CONF_OPTS += -Darm-simd=enabled
else
PIXMAN_CONF_OPTS += -Darm-simd=disabled
endif

ifeq ($(BR2_ARM_CPU_HAS_ARM)$(BR2_ARM_CPU_HAS_NEON),yy)
PIXMAN_CONF_OPTS += -Dneon=enabled
else
PIXMAN_CONF_OPTS += -Dneon=disabled
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON)$(BR2_aarch64),yy)
PIXMAN_CONF_OPTS += -Da64-neon=enabled
else
PIXMAN_CONF_OPTS += -Da64-neon=disabled
endif

$(eval $(meson-package))
$(eval $(host-meson-package))
