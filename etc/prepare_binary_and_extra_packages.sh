source ${PROJECT_HOME_DIR}/etc/binary_and_extra_packages.sh

if [[ "$PAAS_SKELETON_PLATFORM" == "mac" ]]; then
    export PIP_EXTRAS=$EXTRA_PACKAGES

elif [[ "$PAAS_SKELETON_PLATFORM" == "linux" ]]; then
    if [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_12.04" ]]; then
        export PIP_EXTRAS=$EXTRA_PACKAGES
    elif [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_13.10" ]]; then
        export PIP_EXTRAS=$EXTRA_PACKAGES
    elif [[ "$PAAS_SKELETON_DISTRO" == "debian_7" ]]; then
        export PIP_EXTRAS=$EXTRA_PACKAGES
    else
        # for red hat (openshift)
        export BINARY_PACKAGES=$BINARY_PACKAGES_EGGS
    fi
fi