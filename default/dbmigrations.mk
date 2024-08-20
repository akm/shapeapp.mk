# Requires
# - include $(PATH_TO_SHAPEAPPMK)/goose/create.mk

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
