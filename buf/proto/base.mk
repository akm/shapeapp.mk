# Requires:
# include $(PATH_TO_SHAPEAPPMK)/buf/buf.mk

BUF_YAML=buf.yaml
$(BUF_YAML):
	$(MAKE) buf-yaml-gen
.PHONY: buf-yaml-gen
buf-yaml-gen: $(BUF_CLI)
	$(BUF_CLI) config init

.PHONY: buf-setup
buf-setup: $(BUF_YAML)

.PHONY: buf-generate
buf-generate: $(BUF_YAML) $(BUF_CLI)
	$(BUF_CLI) generate

.PHONY: buf-lint
buf-lint: $(BUF_CLI)
	$(BUF_CLI) lint

BUF_PROTOSET_BIN?=protoset.bin
$(BUF_PROTOSET_BIN): build

.PHONY: buf-protoset-path
buf-protoset-path:
	@echo $(BUF_PROTOSET_BIN)

.PHONY: buf-build
buf-build: $(BUF_CLI) $(BUF_YAML)
	$(BUF_CLI) build -o $(BUF_PROTOSET_BIN)

.PHONY: buf-mod-update
buf-mod-update: $(BUF_CLI) $(BUF_YAML)
	$(BUF_CLI) mod update
