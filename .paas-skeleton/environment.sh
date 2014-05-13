# etc/environment.sh
#
# configure the universal environment settings for this container.
# any environment options necessary to properly interact with a supported
# PAAS container should be handled here.
#
# this file will automatically load in "project-environment.sh" and "local-environment.sh"
# to load per-project and per-environment configurations. You should not need to modify
# this file itself
#


# check on presence of a package at system
source ${PROJECT_HOME_DIR}/.paas-skeleton/detect_os.sh
# TODO: create etc/systems_packages.sh on all projects that are using .paas-skeleton
# that file example:
#
# # !/bin/bash
# # List of system pachages for current project
# PACKAGES_UBUNTU_12_04="postgresql postgresql-contrib libpq-dev swig libncurses5-dev xmlsec1"
# PACKAGES_UBUNTU_13_10="postgresql postgresql-contrib libpq-dev swig libncurses5-dev xmlsec1 python-m2crypto"
# PACKAGES_MAC_OS="postgresql postgresql-contrib libpq-dev swig libncurses5-dev xmlsec1"

if [ -f "${PROJECT_HOME_DIR}/etc/systems_packages.sh" ]; then
    source ${PROJECT_HOME_DIR}/.paas-skeleton/install_packages.sh
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

# add BINARY_PACKAGES or PIP_EXTRAS envs with additional python
# packages, which differs between openshift and other systems
source ${PROJECT_HOME_DIR}/etc/prepare_binary_and_extra_packages.sh

# become a python project
source ${PROJECT_HOME_DIR}/.paas-skeleton/python/virtualenv.sh

if [[ "${OPENSHIFT_POSTGRESQL_DB_URL}xx" != "xx" ]]; then
    export DATABASE_URL=$OPENSHIFT_POSTGRESQL_DB_URL/$PGDATABASE
    export DJANGO_SETTINGS_MODULE="${PROJECT_NAME}.settings"
else
    export DJANGO_SETTINGS_MODULE="${PROJECT_NAME}.test_settings"
    export DATABASE_URL="postgres://localhost/${PROJECT_NAME}_test"
fi

if [[ "${OPENSHIFT_PATTON_IP}xx" == "xx" ]]; then
    export OPENSHIFT_PATTON_IP="127.0.0.1"
    export OPENSHIFT_PATTON_PORT="50009"
fi

export ES_CLASSPATH="$VE_ROOT/share/elasticsearch/lib/*"
if [[ "${ELASTICSEARCH_SERVER_URL}xx" != "xx" ]]; then
    export ELASTICSEARCH_SERVER_URL="$ELASTICSEARCH_SERVER_URL"
else
    export ELASTICSEARCH_SERVER_URL="http://localhost:50015"
fi

# bring in local configurations from environment.d/*.sh
if [ -d "${PROJECT_HOME_DIR}/etc/environment.d/" ]; then
    for i in ${PROJECT_HOME_DIR}/etc/environment.d/*.sh; do
      if [ -r "$i" ]; then
        . $i
      fi
    done
    unset i
fi

