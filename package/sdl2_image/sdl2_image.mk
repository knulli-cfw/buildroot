################################################################################
#
# sdl2_image
#
################################################################################
# batocera - bump and switch to cmake
SDL2_IMAGE_VERSION = 2.8.8
SDL2_IMAGE_SOURCE = SDL2_image-$(SDL2_IMAGE_VERSION).tar.gz
SDL2_IMAGE_SITE = http://www.libsdl.org/projects/SDL_image/release
SDL2_IMAGE_INSTALL_STAGING = YES
SDL2_IMAGE_SUPPORTS_IN_SOURCE_BUILD = NO
SDL2_IMAGE_LICENSE = Zlib
SDL2_IMAGE_LICENSE_FILES = LICENSE.txt
SDL2_IMAGE_CPE_ID_VENDOR = libsdl
SDL2_IMAGE_CPE_ID_PRODUCT = sdl_image

# Unconditionally enable support for image formats that don't require
# any dependency.
SDL2_IMAGE_CONF_OPTS = \
	-DSDL2IMAGE_TESTS=OFF \
	-DSDL2IMAGE_BMP=ON \
	-DSDL2IMAGE_GIF=ON \
	-DSDL2IMAGE_LBM=ON \
	-DSDL2IMAGE_PCX=ON \
	-DSDL2IMAGE_PCX=ON \
	-DSDL2IMAGE_TGA=ON \
	-DSDL2IMAGE_XCF=ON \
	-DSDL2IMAGE_XPM=ON \
	-DSDL2IMAGE_XV=ON

SDL2_IMAGE_DEPENDENCIES = sdl2 host-pkgconf

ifeq ($(BR2_PACKAGE_JPEG),y)
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_JPG=ON
SDL2_IMAGE_DEPENDENCIES += jpeg
else
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_JPG=OFF
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_PNG=ON
SDL2_IMAGE_DEPENDENCIES += libpng
else
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_PNG=OFF
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_TIF=ON
SDL2_IMAGE_DEPENDENCIES += tiff
else
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_TIF=OFF
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_WEBP=ON
SDL2_IMAGE_DEPENDENCIES += webp
else
SDL2_IMAGE_CONF_OPTS += -DSDL2IMAGE_WEBP=OFF
endif

$(eval $(cmake-package))
