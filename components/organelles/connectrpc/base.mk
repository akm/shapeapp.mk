include $(PATH_TO_SHAPEAPPMK)/components/atoms/buf/buf.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/buf/proto/base.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/connect-go/protoc-gen-connect-go.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/protobuf/protoc-gen-go.mk

.PHONY: connectrpc-install-tools
connectrpc-install-tools:
	$(MAKE) $(BUF_CLI)
	$(MAKE) $(PROTOC_GEN_GO_CLI)
	$(MAKE) $(PROTOC_GEN_CONNECT_GO_CLI)

.PHONY: connectrpc-update-tools
connectrpc-update-tools: \
	buf-cli-install \
	protoc-gen-go-cli-install \
	protoc-gen-connect-go-cli-install

.PHONY: connectrpc-build
connectrpc-build: $(PROTOC_GEN_CONNECT_GO_CLI) $(PROTOC_GEN_GO_CLI) buf-build

.PHONY: connectrpc-lint
connectrpc-lint: buf-lint

.PHONY: connectrpc-generate
connectrpc-generate: $(PROTOC_GEN_CONNECT_GO_CLI) $(PROTOC_GEN_GO_CLI) buf-generate
