# etc/environment.sh - owned by paas-skeleton-python.git
#
# configure the universal environment settings for this container.
# any environment options necessary to properly interact with a supported
# PAAS container should be handled here.
# 
# this file will automatically load in "project-environment.sh" and "local-environment.sh"
# to load per-project and per-environment configurations. You should not need to modify 
# this file itself
#

# bring in per-project configurations
if [ -f "$PROJECT_HOME_DIR/etc/project-environment.sh" ]; then
    source $PROJECT_HOME_DIR/etc/project-environment.sh
fi

# bring in local configurations
if [ -f "$PROJECT_HOME_DIR/etc/local-environment.sh" ]; then
    source $PROJECT_HOME_DIR/etc/local-environment.sh
fi

