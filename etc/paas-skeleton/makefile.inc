check-paas-skeleton-env: $(PROJECT_HOME_DIR)/etc/local-environment.sh
ifndef PROJECT_HOME_DIR
	$(error PROJECT_HOME_DIR environment variable is undefined, did you source env.sh?)
endif

$(PROJECT_HOME_DIR)/etc/local-environment.sh:
	echo "# local shell modifications, do not check into source control" >> $@

.PHONY: clean-build
clean-build:
        if [[ "x$(PROJECT_HOME_DIR)x" != "xx" ]]; then rm -rf $(PROJECT_HOME_DIR)/build; fi
