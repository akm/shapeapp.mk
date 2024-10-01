# Requires:
# include $(PATH_TO_SHAPEAPPMK)/text-template-cli/base.mk

SETUP_GOLANG_VERSION=$(shell cat $(PATH_TO_SHAPEAPPMK)/default/templates/.tool-versions | grep golang | cut -d ' ' -f 2)

.PHONY: setup-golang
setup-golang:
	asdf install golang $(SETUP_GOLANG_VERSION)
	asdf shell golang $(SETUP_GOLANG_VERSION)

.PHONY: setup
setup: setup-golang $(TEXT_TEMPLATE_CLI)
	$(CONFIG_ENVS) $(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/default/templates --output-directory $(CURDIR)
