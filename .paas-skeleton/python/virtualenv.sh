# .paas-skeleton/python-virtualenv.sh - owned by paas-skeleton.git

# TODO: blow up if we can't find a suitable python

# pick up the currently active virtual environment, if defined
if [[ "x${VIRTUAL_ENV}x" != "xx" ]]; then
    VE_ROOT=${VIRTUAL_ENV}
else
    VE_ROOT=${PAAS_SKELETON_WORK_DIR}
    export VIRTUAL_ENV=${PAAS_SKELETON_WORK_DIR}
fi

PYTHON_BIN=${VE_ROOT}/bin/python

# set PIP_DOWNLOAD_CACHE if not already set
if [[ "x${PIP_DOWNLOAD_CACHE}x" == "xx" ]]; then
    PIP_DOWNLOAD_CACHE=${PAAS_SKELETON_WORK_DIR}/.download-cache
fi

# create the virtual environment only if it does not already exist

if [ ! -f ${PYTHON_BIN} ]; then 
    python2.7 ${PROJECT_HOME_DIR}/.paas-skeleton/python/virtualenv.py \
        --no-site-packages \
        --extra-search-dir=${PROJECT_HOME_DIR}/.paas-skeleton/python/virtualenv_support \
        ${VE_ROOT}
    ${VE_ROOT}/bin/easy_install readline
fi

# activate the virtual environment
source $VE_ROOT/bin/activate
