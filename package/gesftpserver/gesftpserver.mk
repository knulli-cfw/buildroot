################################################################################
#
# gesftpserver
#
################################################################################
# batocera - update, switch site, drop source, use autoreconf
GESFTPSERVER_VERSION = 7cab62566bad3ca49555679276a6137bf914408a
GESFTPSERVER_SITE = $(call github,ewxrjk,sftpserver,$(GESFTPSERVER_VERSION))
GESFTPSERVER_LICENSE = GPL-2.0+
GESFTPSERVER_LICENSE_FILES = COPYING
GESFTPSERVER_AUTORECONF = YES

# "Missing prototype" warning treated as error
GESFTPSERVER_CONF_OPTS = --disable-warnings-as-errors
GESFTPSERVER_CPE_ID_VENDOR = greenend
GESFTPSERVER_CPE_ID_PRODUCT = sftpserver

# forgets to link against pthread when cross compiling
GESFTPSERVER_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) -std=c99" \
	LIBS=-lpthread

# overwrite openssh version if enabled
GESFTPSERVER_DEPENDENCIES += \
	$(if $(BR2_ENABLE_LOCALE),,libiconv) \
	$(if $(BR2_PACKAGE_OPENSSH),openssh)

# Python on the host is only used for tests, which we don't use in
# Buildroot
GESFTPSERVER_CONF_ENV += rjk_cv_python3=false

# openssh/dropbear looks here
define GESFTPSERVER_ADD_SYMLINK
	ln -sf gesftpserver $(TARGET_DIR)/usr/libexec/sftp-server
endef

GESFTPSERVER_POST_INSTALL_TARGET_HOOKS += GESFTPSERVER_ADD_SYMLINK

$(eval $(autotools-package))
