.PHONY: golang-build
golang-build:
	go build ./...

LOCAL_GOOS?=$(shell go run $(PATH_TO_SHAPEAPPMK)/golang/goos.go)
LOCAL_GOARCH?=$(shell go run $(PATH_TO_SHAPEAPPMK)/golang/goarch.go)

.PHONY: golang-local-goos
golang-local-goos:
	@echo "$(LOCAL_GOOS)"
.PHONY: golang-local-goarch
golang-local-goarch:
	@echo "$(LOCAL_GOARCH)"
