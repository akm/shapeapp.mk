# Required variables:
# - PATH_TO_SHAPEAPPMK
#
# included targets:
# - goose/commands.mk

include $(PATH_TO_SHAPEAPPMK)/components/organelles/golang/base.mk

GOOSE_DSN?=root@tcp(localhost:3306)/dbmigrations?charset=utf8mb4&parseTime=True&loc=Local
GOOSE_MAIN_PACKAGE?=./cmd/runner

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

