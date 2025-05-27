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

include $(PATH_TO_SHAPEAPPMK)/components/organelles/golang/base.mk

GOOSE_TARGET_ENV_PATH?=$(PATH_TO_ROOT)/stages/localdev
GOOSE_DSN?=$(shell $(MAKE) -C $(GOOSE_TARGET_ENV_PATH) mysql-dsn-from-outside)
GOOSE_MAIN_PACKAGE=./cmd/runner
GOOSE_ENVS=\
	APP_ENV=$(APP_ENV) \
	APP_STAGE=$(APP_STAGE) \
	APP_STAGE_TYPE=$(APP_STAGE_TYPE)

include $(PATH_TO_SHAPEAPPMK)/components/atoms/goose/commands.mk

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

.PHONY: down-to-zero
down-to-zero: goose-down-to-zero

.PHONY: state
state: goose-state

.PHONY: reset
reset: goose-reset

