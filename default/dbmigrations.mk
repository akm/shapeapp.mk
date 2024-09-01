# Required variables:
# - PATH_TO_SHAPEAPPMK
# - APP_ENV
# - APP_STAGE
# - APP_STAGE_TYPE
#
# Optional variables:
# - GOOSE_TARGET_ENV_PATH
#
# included targets:
# - goose/commands.mk

include $(PATH_TO_SHAPEAPPMK)/golang/base.mk

GOOSE_TARGET_ENV_PATH?=$(PATH_TO_ROOT)/stages/local
GOOSE_DSN?=$(shell $(MAKE) -C $(GOOSE_TARGET_ENV_PATH) mysql-dsn)
GOOSE_MAIN_PACKAGE=./cmd/runner
GOOSE_ENVS=\
	APP_ENV=$(APP_ENV) \
	APP_STAGE=$(APP_STAGE) \
	APP_STAGE_TYPE=$(APP_STAGE_TYPE)

include $(PATH_TO_SHAPEAPPMK)/goose/commands.mk

ifeq (new,$(firstword $(MAKECMDGOALS)))
  NEW_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(NEW_ARGS):;@:)
endif
.PHONY: new
new:
	GOOSE_MIGRATION_NAME=$(NEW_ARGS) $(MAKE) goose-create

ifeq (new-go,$(firstword $(MAKECMDGOALS)))
  CREATE_GO_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CREATE_GO_ARGS):;@:)
endif
.PHONY: new-go
new-go:
	GOOSE_MIGRATION_NAME=$(NEW_ARGS) $(MAKE) goose-create-go

.PHONY: up
up: goose-up

.PHONY: down
down: goose-down

.PHONY: state
state: goose-state

.PHONY: reset
reset: goose-reset

DBMIGRATIONS_TEST_PATH_TO_CONTAINERS=$(PATH_TO_BACKENDS)/test/containers

# TEST_CONTAINERS-mysql-dsn
$(call shell-dir-target-vars,TEST_CONTAINERS-,$(DBMIGRATIONS_TEST_PATH_TO_CONTAINERS),mysql-dsn)

.PHONY: test-containers-up
test-containers-up:
	DOCKER_COMPOSE_TARGET_SERVICES=mysql \
		$(MAKE) -C $(DBMIGRATIONS_TEST_PATH_TO_CONTAINERS) up

.PHONY: test-containers-down
test-containers-down:
	$(MAKE) -C $(DBMIGRATIONS_TEST_PATH_TO_CONTAINERS) down

# test-containers-up で dbmigrations の make up が実行されるので
# test-run では すべての down を実行する reset を実行する
.PHONY: test-run
test-run:
	$(MAKE) reset GOOSE_DSN='$(TEST_CONTAINERS-mysql-dsn)'

.PHONY: test
test: test-containers-down test-containers-up test-run

.PHONY: ci-test
ci-test: test-containers-up
