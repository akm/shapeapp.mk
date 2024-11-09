# Requires:
#   - PATH_TO_BIZ
#   - PATH_TO_BACKENDS
#
# Optional variables:
#   - APISVR_ENV_VARS
#   - APISVR_ENVS_BASE
#   - APISVR_TEST_ENVS
#   - APISVR_TEST_VARS
#   - APISVR_TEST_PATH_TO_CONTAINERS

APISVR_TEST_PATH_TO_CONTAINERS?=$(PATH_TO_BACKENDS)/test/containers

# TEST_CONTAINERS-mysql-dsn-from-outside
$(call shell-dir-target-vars,$(APISVR_TEST_PATH_TO_CONTAINERS),TEST_CONTAINERS-,mysql-dsn-from-outside)

APISVR_TEST_VARS?=$(APISVR_ENV_VARS)
APISVR_TEST_ENVS?=$(APISVR_ENVS_BASE) \
	DB_DSN='$(TEST_CONTAINERS-mysql-dsn-from-outside)' \
	$(foreach var,$(APISVR_TEST_VARS),$(var)=$($(var)))

.PHONY: test-containers-up
test-containers-up:
	$(MAKE) -C $(APISVR_TEST_PATH_TO_CONTAINERS) up

.PHONY: test-containers-down
test-containers-down:
	$(MAKE) -C $(APISVR_TEST_PATH_TO_CONTAINERS) down

.PHONY: test-run
test-run:
	$(APISVR_TEST_ENVS) go test ./...

.PHONY: test
test: test-containers-up test-run
