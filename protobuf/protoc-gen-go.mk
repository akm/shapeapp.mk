PROTOC_GEN_GO_CLI_VERSION?=latest
PROTOC_GEN_GO_CLI?=$(shell go env GOPATH)/bin/protoc-gen-go
$(PROTOC_GEN_GO_CLI):
	CLI_VERSION=$(PROTOC_GEN_GO_CLI_VERSION) \
	CLI_MODULE=google.golang.org/protobuf/cmd/protoc-gen-go \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install
