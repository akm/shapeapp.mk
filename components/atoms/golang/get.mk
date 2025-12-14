.PHONY: golang_get_update
golang_get_update:
ifndef GO_MOD_NAME
	go get -u ./...
else ifndef GO_MOD_VERSION
	go get -u ${GO_MOD_NAME}
else
	go get -u ${GO_MOD_NAME}@${GO_MOD_VERSION}
endif
