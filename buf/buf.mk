# Requires:

BUF_CLI_VERSION?=latest
BUF_CLI?=$(shell go env GOPATH)/bin/buf
$(BUF_CLI):
	CLI_VERSION=$(BUF_CLI_VERSION) \
	CLI_MODULE=github.com/bufbuild/buf/cmd/buf \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install
