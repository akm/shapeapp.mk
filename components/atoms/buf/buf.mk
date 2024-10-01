# Requires:

BUF_CLI_VERSION?=latest
BUF_CLI_MODULE=github.com/bufbuild/buf/cmd/buf
BUF_CLI?=$(call golang-tool-bin-path,$(BUF_CLI_MODULE))
$(BUF_CLI):
	CLI_VERSION=$(BUF_CLI_VERSION) \
	CLI_MODULE=$(BUF_CLI_MODULE) \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/components/atoms/golang/tool cli-install
