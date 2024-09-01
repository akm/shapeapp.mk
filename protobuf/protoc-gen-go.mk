PROTOC_GEN_GO_CLI_VERSION?=latest
PROTOC_GEN_GO_CLI_MODULE=google.golang.org/protobuf/cmd/protoc-gen-go
PROTOC_GEN_GO_CLI?=$(call golang-tool-bin-path,$(PROTOC_GEN_GO_CLI_MODULE))
$(PROTOC_GEN_GO_CLI):
	$(call golang-tool-cli-install-with-prefix,PROTOC_GEN_GO)
