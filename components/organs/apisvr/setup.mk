# Requires:

.PHONY: setup
setup:
	go mod init apisvr
	go mod tidy
	go mod edit -replace applib=../applib
	go mod edit -replace biz=../biz
