.PHONY: default
default: build lint test

.PHONY: build
build:
	go build -o /dev/null ./...

CURRENT_BRANCH=$(shell git branch --show-current)

.PHONY: test
test: clobber_test_grounds
	SHAPEAPPMK_BRANCH=$(CURRENT_BRANCH) go test -v ./...

.PHONY: clobber_test_grounds
clobber_test_grounds:
	rm -rf grounds/01_basic

GOLANGCI_LINT_VERSION=v1.61.0
GOLANGCI_LINT = $(shell go env GOPATH)/bin/golangci-lint
$(GOLANGCI_LINT):
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@$(GOLANGCI_LINT_VERSION)

.PHONY: lint
lint: $(GOLANGCI_LINT)
	$(GOLANGCI_LINT) run ./...
