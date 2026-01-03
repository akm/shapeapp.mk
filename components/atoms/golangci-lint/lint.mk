GOLANGCLI_LINT_CLI_VERSION_BASE?=v1
GOLANGCLI_LINT_CLI_VERSION?=latest
GOLANGCLI_LINT_CLI_MODULE_v1=github.com/golangci/golangci-lint/cmd/golangci-lint
GOLANGCLI_LINT_CLI_MODULE_v2=github.com/golangci/golangci-lint/v2/cmd/golangci-lint
GOLANGCLI_LINT_CLI_MODULE=$(GOLANGCLI_LINT_CLI_MODULE_$(GOLANGCLI_LINT_CLI_VERSION_BASE))
GOLANGCLI_LINT_CLI=$(call golang-tool-bin-path,$(GOLANGCLI_LINT_CLI_MODULE))
$(GOLANGCLI_LINT_CLI):
	$(call golang-tool-cli-install-with-prefix,GOLANGCLI_LINT)

.PHONY: golangci-lint-lint
golangci-lint-lint: $(GOLANGCLI_LINT_CLI)
	$(GOLANGCLI_LINT_CLI) run ./...
