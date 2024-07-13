PROTOC_GEN_CONNECT_GO_CLI_VERSION?=latest
PROTOC_GEN_CONNECT_GO_CLI?=$(shell go env GOPATH)/bin/protoc-gen-connect-go
$(PROTOC_GEN_CONNECT_GO_CLI):
	CLI_VERSION=$(PROTOC_GEN_CONNECT_GO_CLI_VERSION) \
	CLI_MODULE=connectrpc.com/connect/cmd/protoc-gen-connect-go \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install
