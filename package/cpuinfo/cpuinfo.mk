################################################################################
#
# cpuinfo
#
################################################################################
# batocera - updgrade to Commits on May 1, 2026
CPUINFO_VERSION = 3681f0ce1446167d01dfe125d6db96ba2ac31c3c
CPUINFO_SITE = $(call github,pytorch,cpuinfo,$(CPUINFO_VERSION))
CPUINFO_LICENSE = BSD-2-Clause
CPUINFO_LICENSE_FILES = LICENSE
CPUINFO_INSTALL_STAGING = YES
CPUINFO_CONF_OPTS = \
	-DCPUINFO_BUILD_UNIT_TESTS=OFF \
	-DCPUINFO_BUILD_MOCK_TESTS=OFF \
	-DCPUINFO_BUILD_BENCHMARKS=OFF

$(eval $(cmake-package))
