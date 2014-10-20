# etc/environment.sh
#
# configure the universal environment settings for this container.
# any environment options necessary to properly interact with a supported
# PAAS container should be handled here.
#
# this file will automatically load in scripts that it finds in "etc/environment.d"
# to load per-project and per-environment configurations. You should not need to modify
# this file itself
#

# TODO: create etc/systems_packages.sh on all projects that are using .paas-skeleton
# that file example:
#
# pull in utility functions
source ${PROJECT_HOME_DIR}/.paas-skeleton/functions.sh

if [[ "x${OPENSHIFT_DATA_DIR}x" == "xx" ]]; then
    source ${PROJECT_HOME_DIR}/.paas-skeleton/asciidoc/asciidoc-env.sh
fi

# bail out if we don't know our home directory
if [[ "x${PROJECT_HOME_DIR}x" == "xx" ]]; then
    echo "PROJECT_HOME_DIR is not set, exiting"
    exit 1
fi

# figure out a good location for our working environment
if [[ "x${VIRTUAL_ENV}x" != "xx" ]]; then
    # a python virtualenv is active, use it
    PAAS_SKELETON_WORK_DIR=${VIRTUAL_ENV}

elif [[ "x${OPENSHIFT_DATA_DIR}x" != "xx" ]]; then
    # we are on openshift, use the data dir
    PAAS_SKELETON_WORK_DIR=${OPENSHIFT_DATA_DIR}

elif [[ "x${VE_ROOT}x" != "xx" ]]; then
    # we have a VE_ROOT defined, use it for our work directory
    PAAS_SKELETON_WORK_DIR=${VE_ROOT}

else
    # otherwise, work out of a directory
    PAAS_SKELETON_WORK_DIR=${HOME}/.paas_skeleton/`basename ${PWD}`
fi
export PAAS_SKELETON_WORK_DIR

if [ ! -d ${PAAS_SKELETON_WORK_DIR} ]; then
    echo "Creating skeleton work dir ${PAAS_SKELETON_WORK_DIR}"
    mkdir -p ${PAAS_SKELETON_WORK_DIR}
fi

# figure out what system we have
source ${PROJECT_HOME_DIR}/.paas-skeleton/detect_os.sh

# bring in local configurations from environment.d/*.sh
if [ -d "${PROJECT_HOME_DIR}/etc/environment.d/" ]; then
    for i in ${PROJECT_HOME_DIR}/etc/environment.d/*.sh; do
        if [ -r "$i" ]; then
            . $i
        fi
    done
    unset i
fi

# if the platform we are on requires some packages, check if they
# are installed and help the user to install them
if [[ "$PAAS_SKELETON_PLATFORM" == "mac" ]]; then
        install_brew_packages "${PACKAGES_MAC_OS}"

elif [[ "$PAAS_SKELETON_PLATFORM" == "linux" ]]; then
    if [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_12.04" ]]; then
        install_apt_packages "${PACKAGES_UBUNTU_12_04}"
    elif [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_13.10" ]]; then
        install_apt_packages "${PACKAGES_UBUNTU_13_10}"
    elif [[ "$PAAS_SKELETON_DISTRO" == "debian_7" ]]; then
        install_apt_packages "${PACKAGES_DEBIAN_7}"
    else
        echo "No packages for ${PAAS_SKELETON_DISTRO} should be installed"
    fi
fi


export NEW_RELIC_CONFIG_FILE=${PROJECT_HOME_DIR}/newrelic.ini
export NEW_RELIC_ENVIRONMENT=development
export PROJECT_PROCFILE=${PROJECT_HOME_DIR}/Procfile

if [[ "${WT_DEPLOYED_SERVER_TYPE}xx" != "xx" ]]; then
    export NEW_RELIC_ENVIRONMENT=${WT_DEPLOYED_SERVER_TYPE}
fi

if [[ "${WT_ENABLE_NEW_RELIC}" == "true" ]]; then
    export PROJECT_PROCFILE=${PROJECT_HOME_DIR}/Procfile.newrelic
fi
