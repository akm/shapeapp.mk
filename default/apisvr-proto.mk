include $(PATH_TO_SHAPEAPPMK)/buf/buf.mk
include $(PATH_TO_SHAPEAPPMK)/buf/proto/base.mk
include $(PATH_TO_SHAPEAPPMK)/protobuf/protoc-gen-go.mk
include $(PATH_TO_SHAPEAPPMK)/connect-go/protoc-gen-connect-go.mk

.PHONY: build
build: $(PROTOC_GEN_CONNECT_GO_CLI) buf-build

.PHONY: lint
lint: buf-lint

.PHONY: generate
generate: $(PROTOC_GEN_CONNECT_GO_CLI) buf-generate

include $(PATH_TO_SHAPEAPPMK)/grpcurl/base.mk

.PHONY: test-connections
test-connections: $(GRPCURL_CLI) $(BUF_CLI) build
	./test-connections.sh
