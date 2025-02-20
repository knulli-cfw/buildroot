################################################################################
#
# libserialport
#
################################################################################

# batocera - update to support vpinball
# remove 0001 patch
LIBSERIALPORT_VERSION = 21b3dfe5f68c205be4086469335fd2fc2ce11ed2
LIBSERIALPORT_SITE = $(call github,sigrokproject,libserialport,$(LIBSERIALPORT_VERSION))
LIBSERIALPORT_LICENSE = LGPL-3.0+
LIBSERIALPORT_LICENSE_FILES = COPYING
LIBSERIALPORT_INSTALL_STAGING = YES
LIBSERIALPORT_DEPENDENCIES = host-pkgconf
LIBSERIALPORT_AUTORECONF = YES

$(eval $(autotools-package))
