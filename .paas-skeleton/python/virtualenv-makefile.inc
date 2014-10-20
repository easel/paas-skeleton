# .paas-skeleton/python/virtualenv-makefile.inc

# use-mirrors is deprecated http://www.python.org/dev/peps/pep-0449/
# they use CDN now. We can use index-url to provide our own mirror
# if we want/need to
#

PYTHON_BIN := $(VIRTUAL_ENV)/bin/python

ifdef "$PIP_DOWNLOAD_CACHE"
PIP_FLAGS := --quiet --default-timeout=400 --download-cache ${PIP_DOWNLOAD_CACHE}
else
PIP_FLAGS := --quiet --default-timeout=400
endif

.PHONY: check-python-virtualenv
check-python-virtualenv: 
	if [ "xx" != 'x$(BINARY_PACKAGES)x' ]; then for bin_pack in $(BINARY_PACKAGES); do \
	echo "Installing $$bin_pack"; \
	$(VIRTUAL_ENV)/bin/easy_install $$bin_pack; \
	done; fi
	if [ "xx" != 'x$(PIP_EXTRAS)x' ]; then for extra in $(PIP_EXTRAS); do \
	$(VIRTUAL_ENV)/bin/pip install $(PIP_FLAGS) $$extra; \
	echo "Installing $extra"; \
	done; fi
	$(VIRTUAL_ENV)/bin/pip install -r $(PROJECT_HOME_DIR)/requirements.txt $(PIP_FLAGS)

$(PROJECT_HOME_DIR)/requirements.txt:
	echo "honcho" >> $@
	echo "supervisor" >> $@

.PHONY: clean-python-virtualenv
clean-python-virtualenv:
	if [[ "x$(VIRTUAL_ENV)x" != "xx" ]]; then rm -rf $(VIRTUAL_ENV); fi

.PHONY: $(PYTHON_BIN)
$(PYTHON_BIN): ${VIRTUAL_ENV}/lib/python2.7/site-packages
