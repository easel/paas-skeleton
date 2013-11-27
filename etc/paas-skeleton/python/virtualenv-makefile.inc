# etc/paas-skeleton/python/virtualenv-makefile.inc
# TODO: make this complain if VE_ROOT isn't set
PYTHON_BIN := $(VE_ROOT)/bin/python
#VE_FLAGS := --extra-search-dir $(PWD)/lib/buildout-cache/dist --never-download --use-distribute var/ve; fi
#PIP_FlAGS := --quiet install --no-index --find-links file://$(PWD)/lib/buildout-cache/dist 
VE_FLAGS := --use-distribute 
PIP_FlAGS := 

.PHONY: check-python-virtualenv
check-python-virtualenv: $(PYTHON_BIN)

$(VE_PATH):
	mkdir -p "$(VE_PATH)"

.PHONY: $(VE_ROOT)
$(VE_ROOT): $(VE_PATH)
	if [ ! -f $(PYTHON_BIN) ]; then python2.7 $(PROJECT_HOME_DIR)/etc/paas-skeleton/python/virtualenv.py $(VE_FLAGS) $(VE_ROOT); fi

$(PROJECT_HOME_DIR)/requirements.txt:
	echo "honcho" >> $@

$(VE_ROOT)/lib/python2.7/site-packages: $(VE_ROOT) $(PROJECT_HOME_DIR)/etc/paas-skeleton/python/virtualenv-makefile.inc $(PROJECT_HOME_DIR)/requirements.txt
	$(VE_ROOT)/bin/easy_install readline
	$(VE_ROOT)/bin/pip install $(PIP_FLAGS) -r requirements.txt

$(VE_ROOT)/bin/activate: $(VE_ROOT)/lib/python2.7/site-packages

.PHONY: clean-python-virtualenv
clean-python-virtualenv:
	if [[ "x$(VE_ROOT)x" != "xx" ]]; then rm -rf $(VE_ROOT); fi


$(PYTHON_BIN): $(VE_ROOT)/lib/python2.7/site-packages
