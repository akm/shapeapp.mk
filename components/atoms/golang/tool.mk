# Defined variables:
# - GOLANG_TOOL_PATH_TO_BIN
#
# Defined targets:
# - golang-tool-bin-path
# - golang-tool-cli-install-with-prefix

GOLANG_TOOL_GOBIN=$(shell go env GOBIN)
GOLANG_TOOL_GOPATH=$(shell go env GOPATH)
ifneq ($(GOLANG_TOOL_GOBIN),)
GOLANG_TOOL_PATH_TO_BIN=$(GOLANG_TOOL_GOBIN)
else
GOLANG_TOOL_PATH_TO_BIN=$(GOLANG_TOOL_GOPATH)/bin
endif

# arguments:
# $(1): golang module name
#
# example:
# $(call golang-tool-bin-path,github.com/golangci/golangci-lint/cmd/golangci-lint)
define golang-tool-bin-path
$(GOLANG_TOOL_PATH_TO_BIN)/$(notdir $(1))
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

.PHONY: golang-tool-cli-uninstall
golang-tool-cli-uninstall:
ifdef CLI_MODULE
	rm -f $(GOLANG_TOOL_PATH_TO_BIN)/$(CLI_MODULE)
else
	@echo "ERROR: CLI_MODULE is not defined"
	exit 1
endif
