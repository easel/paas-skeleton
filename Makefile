# Makefile - provided by paas-skeleton.git
# 
# This file is designed to be edited locally. Do not check changes into
# paas-skeleton.git without a very good reason.
#

# Set the default makefile target. this line must remain the first line in the makefile
# in order to maintain precedence. It should also always contain "check-paas-skeleton-env" as
# a dependency in order to ensure that things always run in the correct environment.
#
# You can add other targets here as you wish, such as "check-python-virtualenv" to ensure the
# python virtualenv is configured and up to date.
default: check-paas-skeleton-env docs check-python-virtualenv

# Clean target. Add additional things to clean to this list.
clean: clean-python-virtualenv clean-build

# Include the default set of paas-skeleton rules. Do not remove this
# line or change the file, instead, add addition files and include them
# below.
include ${PROJECT_HOME_DIR}/etc/paas-skeleton/makefile.inc
include ${PROJECT_HOME_DIR}/etc/paas-skeleton/asciidoc/makefile.inc

# include dependency specific Makefile extensions here, for example
# include ${PROJECT_HOME_DIR}/etc/paas-skeleton/python/virtualenv-makefile.inc
#
include ${PROJECT_HOME_DIR}/etc/paas-skeleton/python/virtualenv-makefile.inc

