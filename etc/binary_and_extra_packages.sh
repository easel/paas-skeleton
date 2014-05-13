# !/bin/bash
# lists of packages, that needs to be installed differently on openshift and local machines

# if you place a file or url in BINARY_PACKAGES_EGGS, you must place the corresponding
# packing in EXTRA_PACKAGES. The make infrastructure will introspect the current runtime
# environment and if it is OpenShift it will install the binary egg if it is not OpenShift (local)
# it will simply use pip to gather and build the dependency

# for example:
# BINARY_PACKAGES_EGGS="${PROJECT_HOME_DIR}/lib/lxml-3.3.3-py2.7-linux-x86_64.egg ${PROJECT_HOME_DIR}/lib/M2Crypto-0.22.3-py2.7-linux-x86_64.egg"
# EXTRA_PACKAGES="lxml==3.3.3 M2Crypto==0.22.3"

BINARY_PACKAGES_EGGS=""
EXTRA_PACKAGES=""