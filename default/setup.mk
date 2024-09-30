# Requires:
# include $(PATH_TO_SHAPEAPPMK)/text-template-cli/base.mk

.PHONY: setup
setup: $(TEXT_TEMPLATE_CLI)
	$(CONFIG_ENVS) $(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/default/templates --output-directory $(CURDIR)
