################################################################################
#
# python-sip
#
################################################################################
# batocera - bump
PYTHON_SIP_VERSION = 6.10.0
PYTHON_SIP_SOURCE = sip-$(PYTHON_SIP_VERSION).tar.gz
PYTHON_SIP_SITE = https://files.pythonhosted.org/packages/62/9a/78122735697dbfc6c1db363627309eb0da7e44d8c05ba017b08666530586
PYTHON_SIP_LICENSE = SIP license or GPL-2.0 or GPL-3.0
PYTHON_SIP_LICENSE_FILES = LICENSE LICENSE-GPL2 LICENSE-GPL3
PYTHON_SIP_DEPENDENCIES = host-python-setuptools python3 qt5base
PYTHON_SIP_DEPENDENCIES += host-python-setuptools-scm # batocera
HOST_PYTHON_SIP_DEPENDENCIES = host-python3 host-python-setuptools
HOST_PYTHON_SIP_DEPENDENCIES += host-python-setuptools-scm # batocera
PYTHON_SIP_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
