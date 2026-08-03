################################################################################
#
# librsvg
#
################################################################################
# batocera - bump (remove patch) and move to meson build
LIBRSVG_VERSION_MAJOR = 2.61
LIBRSVG_VERSION = $(LIBRSVG_VERSION_MAJOR).3
LIBRSVG_SITE = https://download.gnome.org/sources/librsvg/$(LIBRSVG_VERSION_MAJOR)
LIBRSVG_SOURCE = librsvg-$(LIBRSVG_VERSION).tar.xz
LIBRSVG_INSTALL_STAGING = YES
LIBRSVG_LICENSE = LGPL-2.1+
LIBRSVG_LICENSE_FILES = COPYING.LIB
LIBRSVG_CPE_ID_VENDOR = gnome

LIBRSVG_CONF_ENV = \
    $(PKG_CARGO_ENV) \
	LIBS=$(TARGET_NLS_LIBS) \
	RUST_TARGET=$(RUSTC_TARGET_NAME)

# batocera - add ninja env for rust nonsense
LIBRSVG_NINJA_ENV = \
	$(PKG_CARGO_ENV) \
	CARGO_HOME=$(HOST_DIR)/share/cargo \
	PKG_CONFIG_ALLOW_CROSS=1 \
	PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR) \
	PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig \
	PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig:$(STAGING_DIR)/usr/share/pkgconfig \
	RUSTFLAGS="-C link-arg=--sysroot=$(STAGING_DIR)"
	
LIBRSVG_CONF_OPTS = \
	-Dtriplet=$(RUSTC_TARGET_NAME) \
	-Dpkg_config_path=$(STAGING_DIR)/usr/lib/pkgconfig \
	-Dpixbuf-loader=disabled \
	-Dtests=false \
	-Ddocs=disabled \
	-Dvala=disabled \
	-Drsvg-convert=enabled

LIBRSVG_DEPENDENCIES = \
    host-pkgconf \
	cairo \
	gdk-pixbuf \
	host-gdk-pixbuf \
	host-rustc \
	host-cargo-c \
	libglib2 \
	libxml2 \
	pango \
	$(TARGET_NLS_DEPENDENCIES)

# batocera - add ninja env for rust nonsense
HOST_LIBRSVG_NINJA_ENV = \
	CARGO_HOME=$(HOST_DIR)/share/cargo \
	LD_LIBRARY_PATH=$(HOST_DIR)/lib \
	RUSTFLAGS="-C link-arg=-Wl,-rpath,$(HOST_DIR)/lib"

HOST_LIBRSVG_CONF_OPTS = \
    -Dcmake_prefix_path=$(HOST_DIR) \
	-Dpkg_config_path=$(HOST_DIR)/usr/lib/pkgconfig \
    -Dintrospection=disabled \
	-Dtests=false \
	-Ddocs=disabled \
	-Dpixbuf=enabled \
	-Dpixbuf-loader=enabled \
	-Drsvg-convert=enabled

HOST_LIBRSVG_DEPENDENCIES = \
    host-cairo \
	host-gdk-pixbuf \
	host-libglib2 \
	host-libxml2 \
	host-pango \
	host-rustc \
	host-cargo-c \
	host-fontconfig

#ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
#LIBRSVG_CONF_OPTS += -Dintrospection=enabled
#LIBRSVG_DEPENDENCIES += gobject-introspection
#else
LIBRSVG_CONF_OPTS += -Dintrospection=disabled
#endif

ifeq ($(BR2_PACKAGE_GDK_PIXBUF),y)
LIBRSVG_CONF_OPTS += -Dpixbuf=enabled
LIBRSVG_DEPENDENCIES += gdk-pixbuf
else
LIBRSVG_CONF_OPTS += -Dpixbuf=disabled
endif

$(eval $(meson-package))
$(eval $(host-meson-package))
