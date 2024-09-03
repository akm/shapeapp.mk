# Required variables: 
# GOLANG_BINARY_TARGET: ex. ./cmd/server
#
# Optional variables:
# GOLANG_BINARY_TARGET: default ./cmd/server
# GOLANG_BINARY_OUTPUT_DIR: default ./bin
# GOLANG_BINARY_OUTPUT_BASE: default ./bin/server
# GOLANG_BINARY_GOOS_FOR_local: default linux
# GOLANG_BINARY_GOOS_FOR_production: default linux
# GOLANG_BINARY_GOARCH_FOR_production: default amd64

GOLANG_BINARY_TARGET?=./cmd/server
GOLANG_BINARY_OUTPUT_DIR?=./bin
GOLANG_BINARY_OUTPUT_BASE?=$(GOLANG_BINARY_OUTPUT_DIR)/$(notdir $(GOLANG_BINARY_TARGET))

golang-binary-word-hyphen = $(word $2,$(subst -, ,$1))

# golang-binary-linux-amd64
# golang-binary-linux-arm64
# golang-binary-darwin-amd64
# golang-binary-darwin-arm64
golang-binary-%:
	CGO_ENABLED=0 \
	GOOS=$(call golang-binary-word-hyphen,$*,1) \
	GOARCH=$(call golang-binary-word-hyphen,$*,2) \
		go build -o $(GOLANG_BINARY_OUTPUT_BASE)-$* $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_OUTPUT_dev=$(GOLANG_BINARY_OUTPUT_BASE)-dev
.PHONY: golang-binary-dev
golang-binary-dev:
	go build -o $(GOLANG_BINARY_OUTPUT_dev) $(GOLANG_BINARY_TARGET)

GOLANG_BINARY_GOOS_FOR_local?=linux
GOLANG_BINARY_GOOS_FOR_production?=linux
GOLANG_BINARY_GOARCH_FOR_production?=amd64

GOLANG_BINARY_PATH_FOR_STAGE_local=$(GOLANG_BINARY_OUTPUT_$(GOLANG_BINARY_GOOS_FOR_local)_$(LOCAL_GOARCH))
$(GOLANG_BINARY_PATH_FOR_STAGE_local):
	$(MAKE) golang-binary-build-for-stage-local
.PHONY: golang-binary-build-for-stage-local
golang-binary-build-for-stage-local: golang-binary-$(GOLANG_BINARY_GOOS_FOR_local)-$(LOCAL_GOARCH)
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

GOLANG_BINARY_PATH_FOR_STAGE_dev=$(GOLANG_BINARY_OUTPUT_$(LOCAL_GOOS)_$(LOCAL_GOARCH))
$(GOLANG_BINARY_PATH_FOR_STAGE_dev):
	$(MAKE) golang-binary-build-for-stage-dev
.PHONY: golang-binary-build-for-stage-dev
golang-binary-build-for-stage-dev: golang-binary-$(LOCAL_GOOS)-$(LOCAL_GOARCH)

.PHONY: golang-binary-path-for-stage-dev
golang-binary-path-for-stage-dev:
	@echo "$(GOLANG_BINARY_PATH_FOR_STAGE_dev)"
