# Requires:
# include $(PATH_TO_SHAPEAPPMK)/components/atoms/text-template-cli/base.mk

SETUP_GOLANG_VERSION=$(shell cat $(PATH_TO_SHAPEAPPMK)/templates/.tool-versions | grep golang | cut -d ' ' -f 2)

.PHONY: setup-golang
setup-golang:
	asdf install golang $(SETUP_GOLANG_VERSION)
	asdf local golang $(SETUP_GOLANG_VERSION)
	$(MAKE) $(TEXT_TEMPLATE_CLI) 

.PHONY: setup
setup: setup-golang
	$(CONFIG_ENVS) $(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/templates --output-directory $(CURDIR)
