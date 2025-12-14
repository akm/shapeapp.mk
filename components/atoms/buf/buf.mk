# Requires:

BUF_CLI_VERSION?=latest
BUF_CLI_MODULE=github.com/bufbuild/buf/cmd/buf
BUF_CLI?=$(call golang-tool-bin-path,$(BUF_CLI_MODULE))
$(BUF_CLI):
	$(MAKE) buf-cli-install

.PHONY: buf-cli-install
buf-cli-install:
	$(call golang-tool-cli-install-with-prefix,BUF)
