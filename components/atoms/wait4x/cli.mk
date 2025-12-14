# https://github.com/wait4x/wait4x
WAIT4X_CLI_VERSION?=latest
WAIT4X_CLI_MODULE=wait4x.dev/v3/cmd/wait4x
WAIT4X_CLI=$(call golang-tool-bin-path,$(WAIT4X_CLI_MODULE))
$(WAIT4X_CLI):
	$(call golang-tool-cli-install-with-prefix,WAIT4X)
