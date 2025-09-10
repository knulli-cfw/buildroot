################################################################################
#
# python-sip-qt5
#
################################################################################

# Note about the package version:
# This module version corresponds in fact to the "sip" ABI
# version (not the version of its generator). See:
# https://github.com/Python-SIP/sip/blob/6.8.6/sipbuild/module/source/12/sip.h.in#L43
# The source git repository of this module is located at:
# https://github.com/Python-SIP/sip/tree/main/sipbuild/module/source
# The Python-SIP version/tag which generated a given "sip" module is
# recorded in the PyPI source file "sip.h", in the SIP_VERSION_STR
# macro. For example, PyQt5-sip 12.15.0 was generated with Python-SIP
# 6.8.6.

# batocera - upgrade
PYTHON_PYQT5_SIP_VERSION = 12.17.0
PYTHON_PYQT5_SIP_SITE = https://files.pythonhosted.org/packages/01/79/086b50414bafa71df494398ad277d72e58229a3d1c1b1c766d12b14c2e6d
PYTHON_PYQT5_SIP_SOURCE = pyqt5_sip-$(PYTHON_PYQT5_SIP_VERSION).tar.gz
PYTHON_PYQT5_SIP_LICENSE = BSD-2-Clause
PYTHON_PYQT5_SIP_LICENSE_FILES = LICENSE
PYTHON_PYQT5_SIP_SETUP_TYPE = setuptools

$(eval $(python-package))
