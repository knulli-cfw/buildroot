################################################################################
#
# zstd
#
################################################################################
# batocera - bump (remove 0001-lib-libzstd.mk-fix-typo-in-the-definition-of-LIB_BIN.patch)
ZSTD_VERSION = 1.5.7
ZSTD_SITE = https://github.com/facebook/zstd/releases/download/v$(ZSTD_VERSION)
ZSTD_INSTALL_STAGING = YES
ZSTD_LICENSE = BSD-3-Clause or GPL-2.0
ZSTD_LICENSE_FILES = LICENSE COPYING
ZSTD_CPE_ID_VENDOR = facebook
ZSTD_CPE_ID_PRODUCT = zstandard

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_ZSTD_ADD_CCACHE_DEPENDENCY = NO

# batocera - use cmake
ZSTD_SUBDIR = build/cmake

ZSTD_CONF_OPTS += -DZSTD_LEGACY_SUPPORT=OFF

ifeq ($(BR2_PACKAGE_ZLIB),y)
ZSTD_DEPENDENCIES += zlib
ZSTD_CONF_OPTS += -DZSTD_ZLIB_SUPPORT=ON
else
ZSTD_CONF_OPTS += -DZSTD_ZLIB_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_XZ),y)
ZSTD_DEPENDENCIES += xz
ZSTD_CONF_OPTS += -DZSTD_LZMA_SUPPORT=ON
else
ZSTD_CONF_OPTS += -DZSTD_LZMA_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
ZSTD_DEPENDENCIES += lz4
ZSTD_CONF_OPTS += -DZSTD_LZ4_SUPPORT=ON
else
ZSTD_CONF_OPTS += -DZSTD_LZ4_SUPPORT=OFF
endif

ifeq ($(BR2_STATIC_LIBS),y)
ZSTD_CONF_OPTS += -DZSTD_BUILD_STATIC=ON
else ifeq ($(BR2_SHARED_LIBS),y)
ZSTD_CONF_OPTS += -DZSTD_BUILD_SHARED=ON
endif

# The HAVE_THREAD flag is read by the 'programs' makefile but not by  the 'lib'
# one. Building a multi-threaded binary with a static library (which defaults
# to single-threaded) gives a runtime error when compressing files.
# The 'lib' makefile provides specific '%-mt' and '%-nomt' targets for this
# purpose.
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
ZSTD_CONF_OPTS += -DZSTD_MULTITHREAD_SUPPORT=ON
else
ZSTD_CONF_OPTS += -DZSTD_MULTITHREAD_SUPPORT=OFF
endif

# We may be a ccache dependency, so we can't use ccache; reset the
# options set by the cmake infra.
HOST_ZSTD_CONF_OPTS += \
	-UCMAKE_C_COMPILER_LAUNCHER \
	-UCMAKE_CXX_COMPILER_LAUNCHER

# batocera - use cmake
$(eval $(cmake-package))
$(eval $(host-cmake-package))
