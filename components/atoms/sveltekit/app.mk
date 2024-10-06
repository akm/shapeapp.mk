# Requires:
# - include $(PATH_TO_SHAPEAPPMK)/components/atoms/sveltekit/npm.mk

.PHONY: install
install: npm-ci

# TODO npm run build ではなく npm run check を使うように変更
.PHONY: build
build: npm-run-build

.PHONY: preview
preview: npm-run-preview

.PHONY: test
test: npm-run-test

.PHONY: lint
lint: npm-run-lint
