# Required variables:
# - PATH_TO_SHAPEAPPMK
#
# Defined targets:
# - build
# - lint
#
# Included .mk files:
# - golang/build.mk
# - golangci-lint/lint.mk

include $(PATH_TO_SHAPEAPPMK)/components/atoms/golang/build.mk
.PHONY: build
build: golang-build-all

include $(PATH_TO_SHAPEAPPMK)/components/atoms/golangci-lint/lint.mk
.PHONY: lint
lint: golangci-lint-lint
