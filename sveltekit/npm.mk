# Requires:
# - PATH_TO_LOCAL_DEV?=...

PATH_TO_NODE_MODULES=node_modules
$(PATH_TO_NODE_MODULES):
	$(MAKE) install

.PHONY: install
install:
	npm install

.PHONY: dev_container_up
dev_container_up:
	$(DEV_ENVS) $(MAKE) -C $(PATH_TO_LOCAL_DEV) up

.PHONY: dev_container_down
dev_container_down:
	$(DEV_ENVS) $(MAKE) -C $(PATH_TO_LOCAL_DEV) down

.PHONY: dev_raw
dev_raw: $(PATH_TO_NODE_MODULES) $(DEV_DEPS)
	$(DEV_ENVS) npm run dev

.PHONY: dev
dev: dev_container_up dev_raw

# TODO npm run build ではなく npm run check を使うように変更
.PHONY: build
build: $(PATH_TO_NODE_MODULES) $(BUILD_DEPS)
	npm run build

.PHONY: preview
preview: $(PATH_TO_NODE_MODULES) $(PREVIEW_DEPS)
	$(DEV_ENVS) npm run preview

.PHONY: test
test: $(PATH_TO_NODE_MODULES) $(TEST_DEPS)
	npm run test

.PHONY: lint
lint: $(PATH_TO_NODE_MODULES) $(LINT_DEPS)
	npm run lint
