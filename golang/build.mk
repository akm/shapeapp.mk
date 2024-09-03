.PHONY: golang-build-all
golang-build-all:
	go build ./...

GOLANG_LOCAL_GOOS?=$(shell go run $(PATH_TO_SHAPEAPPMK)/golang/goos.go)
GOLANG_LOCAL_GOARCH?=$(shell go run $(PATH_TO_SHAPEAPPMK)/golang/goarch.go)

.PHONY: golang-local-goos
golang-local-goos:
	@echo "$(GOLANG_LOCAL_GOOS)"
.PHONY: golang-local-goarch
golang-local-goarch:
	@echo "$(GOLANG_LOCAL_GOARCH)"
