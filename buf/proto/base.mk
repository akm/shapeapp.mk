# Requires:
# include $(PATH_TO_SHAPEAPPMK)/buf/buf.mk

.PHONY: setup
setup: buf.yaml

BUF_YAML=buf.yaml
$(BUF_YAML):
	$(BUF_CLI) config init
.PHONY: buf_yaml_gen
buf_yaml_gen: $(BUF_CLI)
	$(BUF_CLI) config init

.PHONY: generate
generate: $(BUF_YAML) $(BUF_CLI)
	$(BUF_CLI) generate

PROTOSET_BIN=protoset.bin
$(PROTOSET_BIN): build

.PHONY: protoset_path
protoset_path:
	@echo $(PROTOSET_BIN)

.PHONY: build
build: $(BUF_CLI) $(BUF_YAML)
	$(BUF_CLI) build -o $(PROTOSET_BIN)
