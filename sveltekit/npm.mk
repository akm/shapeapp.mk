# Optional variables:
# - NPM_RUN_BUILD_DEPS
# - NPM_RUN_DEV_DEPS
# - NPM_RUN_PREVIEW_DEPS
# - NPM_RUN_TEST_DEPS
# - NPM_RUN_LINT_DEPS

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
npm-run-build: $(PATH_TO_NODE_MODULES) $(NPM_RUN_BUILD_DEPS)
	npm run build

.PHONY: npm-run-dev
npm-run-dev: $(PATH_TO_NODE_MODULES) $(NPM_RUN_DEV_DEPS)
	npm run dev

.PHONY: npm-run-preview
npm-run-preview: $(PATH_TO_NODE_MODULES) $(NPM_RUN_PREVIEW_DEPS)
	$(DEV_ENVS) npm run preview

.PHONY: npm-run-test
npm-run-test: $(PATH_TO_NODE_MODULES) $(NPM_RUN_TEST_DEPS)
	npm run test

npm-run-test-%: $(PATH_TO_NODE_MODULES) $(NPM_RUN_TEST_DEPS)
	npm run test:$*

.PHONY: npm-run-lint
npm-run-lint: $(PATH_TO_NODE_MODULES) $(NPM_RUN_LINT_DEPS)
	npm run lint

.PHONY: npm-run-format
npm-run-format: $(PATH_TO_NODE_MODULES) $(NPM_RUN_FORMAT_DEPS)
	npm run format
