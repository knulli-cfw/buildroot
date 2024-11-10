################################################################################
#
# sdl2_ttf
#
################################################################################

SDL2_TTF_VERSION = 2.22.0
SDL2_TTF_SOURCE = SDL2_ttf-$(SDL2_TTF_VERSION).tar.gz
SDL2_TTF_SITE = http://www.libsdl.org/projects/SDL_ttf/release
SDL2_TTF_LICENSE = Zlib
SDL2_TTF_LICENSE_FILES = LICENSE.txt
SDL2_TTF_INSTALL_STAGING = YES
SDL2_TTF_DEPENDENCIES = sdl2 freetype host-pkgconf
SDL2_TTF_CONF_OPTS = --disable-freetype-builtin --disable-harfbuzz-builtin

#
#   The ttf library for some reason has a broken regex where it adds -linux-gnu
#   as a library to link against, which it pulls from the path.  This is only
#   broken in the cross toolchain.
#
#   Adding a regex to pull out the entire -linux-gnu flag after the regex runs.
#
define SDL2_TTF_FIX_SDL2_CONFIG_CMAKE
        $(SED) '18iget_filename_component(PACKAGE_PREFIX_DIR "$${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)\n' \
                $(STAGING_DIR)/usr/lib/cmake/SDL2_ttf/sdl2_ttf-config.cmake
        $(SED) 's%"/usr"%$${PACKAGE_PREFIX_DIR}%' \
                $(STAGING_DIR)/usr/lib/cmake/SDL2_ttf/sdl2_ttf-config.cmake
	$(SED) '37istring(REGEX REPLACE "\-linux-gnu " "" _sdl2ttf_extra_static_libraries "${_sdl2ttf_extra_static_libraries}")' \
                $(STAGING_DIR)/usr/lib/cmake/SDL2_ttf/sdl2_ttf-config.cmake
	$(SED) '39iset(_sdl2ttf_extra_static_libraries "-lfreetype -lharfbuzz")' \
                $(STAGING_DIR)/usr/lib/cmake/SDL2_ttf/sdl2_ttf-config.cmake
endef

# batocera
define SDL2_TTF_FIX_WAYLAND_SCANNER_PATH
        sed -i "s+/usr/bin/wayland-scanner+$(HOST_DIR)/usr/bin/wayland-scanner+g" $(@D)/Makefile
endef

define SDL2_TTF_FIX_CONFIGURE_PATHS
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/config.log
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/config.status
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/libtool
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/Makefile
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/sdl2_ttf-config
        sed -i "s+/host/bin/\.\.+/host+g" $(@D)/sdl2_ttf.pc
        sed -i "s+-I/.* ++g"              $(@D)/sdl2_ttf.pc
endef

SDL2_TTF_POST_INSTALL_STAGING_HOOKS += SDL2_TTF_FIX_SDL2_CONFIG_CMAKE
SDL2_TTF_POST_CONFIGURE_HOOKS += SDL2_TTF_FIX_WAYLAND_SCANNER_PATH
SDL2_TTF_POST_CONFIGURE_HOOKS += SDL2_TTF_FIX_CONFIGURE_PATHs

ifeq ($(BR2_PACKAGE_HARFBUZZ),y)
SDL2_TTF_DEPENDENCIES += harfbuzz
SDL2_TTF_CONF_OPTS += --enable-harfbuzz
else
SDL2_TTF_CONF_OPTS += --disable-harfbuzz
endif

# x-includes and x-libraries must be set for cross-compiling
# By default x_includes and x_libraries contains unsafe paths.
# (/usr/include and /usr/lib)
ifeq ($(BR2_PACKAGE_SDL2_X11),y)
SDL2_TTF_CONF_OPTS += \
	--with-x \
	--x-includes=$(STAGING_DIR)/usr/include \
	--x-libraries=$(STAGING_DIR)/usr/lib
else
SDL2_TTF_CONF_OPTS += \
	--without-x
endif


$(eval $(autotools-package))
