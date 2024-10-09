################################################################################
#
# vulkan-tools
#
################################################################################
# batocera - change version
VULKAN_TOOLS_VERSION = v1.3.297
VULKAN_TOOLS_SITE = $(call github,KhronosGroup,Vulkan-Tools,$(VULKAN_TOOLS_VERSION))
VULKAN_TOOLS_LICENSE = Apache-2.0
VULKAN_TOOLS_LICENSE_FILES = LICENSE.txt

VULKAN_TOOLS_DEPENDENCIES = \
	vulkan-headers \
	vulkan-loader \
	vulkan-volk # batocera

VULKAN_TOOLS_CONF_OPTS += \
	-DBUILD_CUBE=OFF \
	-DBUILD_ICD=OFF \
	-DBUILD_VULKANINFO=ON \
	-DUPDATE_DEPS=OFF

ifeq ($(BR2_PACKAGE_DIRECTFB),y)
VULKAN_TOOLS_DEPENDENCIES += directfb
VULKAN_TOOLS_CONF_OPTS += -DBUILD_WSI_DIRECTFB_SUPPORT=ON
else
VULKAN_TOOLS_CONF_OPTS += -DBUILD_WSI_DIRECTFB_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXCB),y)
VULKAN_TOOLS_DEPENDENCIES += libxcb
VULKAN_TOOLS_CONF_OPTS += \
	-DBUILD_WSI_XCB_SUPPORT=ON \
	-DBUILD_WSI_XLIB_SUPPORT=ON
else
VULKAN_TOOLS_CONF_OPTS += \
	-DBUILD_WSI_XCB_SUPPORT=OFF \
	-DBUILD_WSI_XLIB_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
VULKAN_TOOLS_DEPENDENCIES += wayland
VULKAN_TOOLS_CONF_OPTS += -DBUILD_WSI_WAYLAND_SUPPORT=ON
else
VULKAN_TOOLS_CONF_OPTS += -DBUILD_WSI_WAYLAND_SUPPORT=OFF
endif

$(eval $(cmake-package))
