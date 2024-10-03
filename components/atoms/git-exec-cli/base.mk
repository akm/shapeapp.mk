GIT_EXEC_CLI_VERSION?=v0.0.3
GIT_EXEC_CLI_MODULE=github.com/akm/git-exec
GIT_EXEC_CLI?=$(call golang-tool-bin-path,$(GIT_EXEC_CLI_MODULE))
$(GIT_EXEC_CLI):
	$(call golang-tool-cli-install-with-prefix,GIT_EXEC)
