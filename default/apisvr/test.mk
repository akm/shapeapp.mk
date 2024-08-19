# Requires:
#   - APISVR_TEST_PATH_TO_CONTAINERS
# Options:
#   - APISVR_TEST_ENVS

.PHONY: test-containers-up
test-containers-up:
	$(MAKE) -C $(APISVR_TEST_PATH_TO_CONTAINERS) up

.PHONY: test-containers-down
test-containers-down:
	$(MAKE) -C $(APISVR_TEST_PATH_TO_CONTAINERS) down

.PHONY: test-run
test-run:
	$(APISVR_TEST_ENVS) go test ./...
