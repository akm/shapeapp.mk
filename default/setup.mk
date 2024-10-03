# Requires:
# include $(PATH_TO_SHAPEAPPMK)/components/atoms/git-exec-cli/base.mk
# include $(PATH_TO_SHAPEAPPMK)/components/atoms/text-template-cli/base.mk

SETUP_GOLANG_VERSION=$(shell cat $(PATH_TO_SHAPEAPPMK)/templates/.tool-versions | grep golang | cut -d ' ' -f 2)

.PHONY: setup-golang
setup-golang:
	asdf install golang $(SETUP_GOLANG_VERSION)
	asdf local golang $(SETUP_GOLANG_VERSION)

.PHONY: setup
setup: setup-golang $(TEXT_TEMPLATE_CLI) $(GIT_EXEC_CLI)
	$(GIT_EXEC_CLI) $(CONFIG_ENVS) $(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/templates --output-directory $(CURDIR)
