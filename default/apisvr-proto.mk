include $(PATH_TO_SHAPEAPPMK)/components/atoms/git/check.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/buf/buf.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/buf/proto/base.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/protobuf/protoc-gen-go.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/connect-go/protoc-gen-connect-go.mk

.PHONY: build
build: $(PROTOC_GEN_CONNECT_GO_CLI) $(PROTOC_GEN_GO_CLI) buf-build

.PHONY: lint
lint: buf-lint

.PHONY: generate
generate: $(PROTOC_GEN_CONNECT_GO_CLI) $(PROTOC_GEN_GO_CLI) buf-generate

include $(PATH_TO_SHAPEAPPMK)/components/atoms/grpcurl/base.mk

.PHONY: test-connections
test-connections: $(GRPCURL_CLI) $(BUF_CLI) build
	./test-connections.sh
