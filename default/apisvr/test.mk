# Requires:
#   - PATH_TO_TEST_CONTAINERS
# Options:
#   - TEST_ENVS

.PHONY: test-containers-up
test-containers-up:
	$(MAKE) -C $(PATH_TO_TEST_CONTAINERS) up

.PHONY: test-containers-down
test-containers-down:
	$(MAKE) -C $(PATH_TO_TEST_CONTAINERS) down

.PHONY: test-run
test-run:
	$(TEST_ENVS) go test ./...
