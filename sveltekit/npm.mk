# Requires:
# - PATH_TO_LOCAL_DEV?=...

PATH_TO_NODE_MODULES=node_modules
$(PATH_TO_NODE_MODULES):
	$(MAKE) npm-ci

.PHONY: npm-install
npm-install:
	npm install

.PHONY: npm-ci
npm-ci:
	npm ci

# TODO npm run build ではなく npm run check を使うように変更
.PHONY: npm-run-build
npm-run-build: $(PATH_TO_NODE_MODULES) $(BUILD_DEPS)
	npm run build

.PHONY: npm-run-preview
npm-run-preview: $(PATH_TO_NODE_MODULES) $(PREVIEW_DEPS)
	$(DEV_ENVS) npm run preview

.PHONY: npm-run-test
npm-run-test: $(PATH_TO_NODE_MODULES) $(TEST_DEPS)
	npm run test

.PHONY: npm-run-lint
npm-run-lint: $(PATH_TO_NODE_MODULES) $(LINT_DEPS)
	npm run lint
