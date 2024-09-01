PROTOC_GEN_CONNECT_GO_CLI_VERSION?=latest
PROTOC_GEN_CONNECT_GO_CLI_MODULE=connectrpc.com/connect/cmd/protoc-gen-connect-go
PROTOC_GEN_CONNECT_GO_CLI?=$(call golang-tool-bin-path,$(PROTOC_GEN_CONNECT_GO_CLI_MODULE))
$(PROTOC_GEN_CONNECT_GO_CLI):
	$(call golang-tool-cli-install-with-prefix,PROTOC_GEN_CONNECT_GO)
