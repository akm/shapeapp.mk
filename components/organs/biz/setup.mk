# Requires:
# include $(PATH_TO_SHAPEAPPMK)/components/atoms/git-exec-cli/base.mk

.PHONY: setup
setup: $(GIT_EXEC_CLI)
	$(GIT_EXEC_CLI) go mod init dbmigrations
