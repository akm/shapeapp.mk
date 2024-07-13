# Requires:
# include $(PATH_TO_SHAPEAPPMK)/buf/buf.mk

.PHONY: setup
setup: buf.yaml

buf.yaml: $(BUF_CLI)
	$(BUF_CLI) mod init

.PHONY: generate
generate: buf.yaml $(BUF_CLI)
	$(BUF_CLI) generate

PROTOSET_BIN=protoset.bin
$(PROTOSET_BIN): build

.PHONY: protoset_path
protoset_path:
	@echo $(PROTOSET_BIN)

.PHONY: build
build: buf.yaml $(BUF_CLI)
	$(BUF_CLI) build -o $(PROTOSET_BIN)
