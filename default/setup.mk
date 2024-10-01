# Requires:
# include $(PATH_TO_SHAPEAPPMK)/text-template-cli/base.mk

SETUP_GOLANG_VERSION=$(shell at default/templates/.tool-versions | grep golang | cut -d ' ' -f 2)

.PHONY: setup
setup: $(TEXT_TEMPLATE_CLI)
	asdf install golang $(SETUP_GOLANG_VERSION)
	asdf shell golang $(SETUP_GOLANG_VERSION)
	$(CONFIG_ENVS) $(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/default/templates --output-directory $(CURDIR)
