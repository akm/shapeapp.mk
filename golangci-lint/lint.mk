GOLANGCLI_LINT_CLI_VERSION?=latest
GOLANGCLI_LINT_CLI=$(shell go env GOPATH)/bin/golangci-lint
$(GOLANGCLI_LINT_CLI):
	CLI_VERSION=$(GOLANGCLI_LINT_CLI_VERSION) \
	CLI_MODULE=github.com/golangci/golangci-lint/cmd/golangci-lint \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install

.PHONY: golangci-lint-lint
golangci-lint-lint: $(GOLANGCLI_LINT_CLI)
	$(GOLANGCLI_LINT_CLI) run ./...
