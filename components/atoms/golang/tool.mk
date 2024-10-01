# Defined variables:
# - GOLANG_TOOL_PATH_TO_BIN
#
# Defined targets:
# - golang-tool-bin-path
# - golang-tool-cli-install-with-prefix

GOLANG_TOOL_PATH_TO_BIN=$(shell go env GOPATH)

# arguments:
# $(1): golang module name
#
# example:
# $(call golang-tool-bin-path,github.com/golangci/golangci-lint/cmd/golangci-lint)
define golang-tool-bin-path
$(GOLANG_TOOL_PATH_TO_BIN)/bin/$(notdir $(1))
endef

# arguments:
# $(1): CLI VARIABLE PREFIX
#
# Required variables:
# - $(1)_CLI_MODULE
# - $(1)_CLI_VERSION
#
# example:
# $(call golang-tool-cli-install,GOLANGCI_LINT)
define golang-tool-cli-install-with-prefix
	CLI_VERSION=$($(1)_CLI_VERSION) \
	CLI_MODULE=$($(1)_CLI_MODULE) \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/components/atoms/golang/tool cli-install
endef
