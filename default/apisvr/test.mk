# Requires:
#   - PATH_TO_BIZ
#   - PATH_TO_BACKENDS
#
# Optional variables:
#   - APISVR_ENV_VARS
#   - APISVR_ENVS_BASE
#   - APISVR_TEST_ENVS
#   - APISVR_TEST_VARS
#   - APISVR_TEST_PATH_TO_FIXTURES
#   - APISVR_TEST_PATH_TO_CONTAINERS

# テストに渡される TEST_PATH_TO_FIXTURES は絶対パス。テストはそれぞれの_test.goファイルのディレクトリで実行されるため。
APISVR_TEST_PATH_TO_FIXTURES?=$(abspath $(PATH_TO_BIZ)/test/fixtures)
APISVR_TEST_PATH_TO_CONTAINERS?=$(PATH_TO_BACKENDS)/test/containers

# TEST_CONTAINERS-mysql-dsn
$(call shell-dir-target-vars,TEST_CONTAINERS-,$(APISVR_TEST_PATH_TO_CONTAINERS),mysql-dsn)

APISVR_TEST_VARS?=$(APISVR_ENV_VARS)
APISVR_TEST_ENVS?=$(APISVR_ENVS_BASE) \
	DB_DSN='$(TEST_CONTAINERS-mysql-dsn)' \
	TEST_PATH_TO_FIXTURES=$(APISVR_TEST_PATH_TO_FIXTURES) \
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
