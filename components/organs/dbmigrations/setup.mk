# Requires:

.PHONY: setup
setup:
	go mod init dbmigrations
	go mod tidy
