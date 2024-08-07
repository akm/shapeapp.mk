# Requires: 
# GOLANG_BINARY_TARGET: ex. ./cmd/server
# GOLANG_BINARY_OUTPUT_BASE: ex. ./bin/server
#
# Options:
# GOLANG_BINARY_GOOS_FOR_local: default linux
# GOLANG_BINARY_GOOS_FOR_production: default linux
# GOLANG_BINARY_GOARCH_FOR_production: default amd64

GOLANG_BINARY_OUTPUT_linux_amd64=$(GOLANG_BINARY_OUTPUT_BASE)-linux-amd64
.PHONY: golang-binary-linux-amd64
golang-binary-linux-amd64:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
		go build -o $(GOLANG_BINARY_OUTPUT_linux_amd64) $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_OUTPUT_linux_arm64=$(GOLANG_BINARY_OUTPUT_BASE)-linux-arm64
.PHONY: golang-binary-linux-arm64
golang-binary-linux-arm64:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 \
		go build -o $(GOLANG_BINARY_OUTPUT_linux_arm64) $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_OUTPUT_darwin_arm64=$(GOLANG_BINARY_OUTPUT_BASE)-darwin-arm64
.PHONY: golang-binary-darwin-arm64
golang-binary-darwin-arm64:
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 \
		go build -o $(GOLANG_BINARY_OUTPUT_darwin_arm64) $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_OUTPUT_dev=$(GOLANG_BINARY_OUTPUT_BASE)-dev
.PHONY: golang-binary-dev
golang-binary-dev:
	go build -o $(GOLANG_BINARY_OUTPUT_dev) $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_GOOS_FOR_local?=linux
GOLANG_BINARY_GOOS_FOR_production?=linux
GOLANG_BINARY_GOARCH_FOR_production?=amd64

GOLANG_BINARY_PATH_FOR_STAGE_local=$(GOLANG_BINARY_OUTPUT_$(GOLANG_BINARY_GOOS_FOR_local)_$(LOCAL_GOARCH))
$(GOLANG_BINARY_PATH_FOR_STAGE_local):
	$(MAKE) golang-binary-local
.PHONY: golang-binary-local
golang-binary-local: golang-binary-$(GOLANG_BINARY_GOOS_FOR_local)-$(LOCAL_GOARCH)
.PHONY: golang-binary-path-for-stage-local
golang-binary-path-for-stage-local:
	@echo "$(GOLANG_BINARY_PATH_FOR_STAGE_local)"

GOLANG_BINARY_PATH_FOR_STAGE_production=$(GOLANG_BINARY_OUTPUT_$(GOLANG_BINARY_GOOS_FOR_production)_$(GOLANG_BINARY_GOARCH_FOR_production))
$(GOLANG_BINARY_PATH_FOR_STAGE_production):
	$(MAKE) golang-binary-build-for-stage-production
.PHONY: golang-binary-build-for-stage-production
golang-binary-build-for-stage-production: golang-binary-$(GOLANG_BINARY_GOOS_FOR_production)-$(GOLANG_BINARY_GOARCH_FOR_production)

.PHONY: golang-binary-path-for-stage-production
golang-binary-path-for-stage-production:
	@echo "$(GOLANG_BINARY_PATH_FOR_STAGE_production)"
