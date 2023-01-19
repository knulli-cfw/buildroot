################################################################################
#
# gssdp
#
################################################################################

GSSDP_VERSION_MAJOR = 1.4
GSSDP_VERSION = $(GSSDP_VERSION_MAJOR).0.1
GSSDP_SOURCE = gssdp-$(GSSDP_VERSION).tar.xz
GSSDP_SITE = https://download.gnome.org/sources/gssdp/$(GSSDP_VERSION_MAJOR)
GSSDP_LICENSE = LGPL-2.1+
GSSDP_LICENSE_FILES = COPYING
GSSDP_INSTALL_STAGING = YES
GSSDP_DEPENDENCIES = host-pkgconf libglib2 libsoup
GSSDP_CONF_OPTS = -Dexamples=false -Dgtk_doc=false -Dsniffer=false

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GSSDP_CONF_OPTS += -Dintrospection=true -Dvapi=true
GSSDP_DEPENDENCIES += host-vala gobject-introspection
else
GSSDP_CONF_OPTS += -Dintrospection=false -Dvapi=false
endif

$(eval $(meson-package))
