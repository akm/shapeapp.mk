# Required variables:
#   - PATH_TO_ROOT
#
# Optional variables:
#   - APISVR_DEV_PATH_TO_CONTAINERS
#   - APISVR_DEV_TARGET_PACKAGE
#   - APISVR_ENV_VARS
#   - APISVR_ENVS_BASE
#
# Defined variables:
#   - DEV_TARGET
#   - APISVR_DEV_VARS
#   - APISVR_DEV_ENVS
#
# Defined targets:
#   - dev-containers-up
#   - dev-containers-down
#   - dev-run
#   - run
#   - dev

DEV_TARGET?=apisvr

APISVR_DEV_TARGET_PACKAGE?=./cmd/server
APISVR_DEV_PATH_TO_CONTAINERS?=$(PATH_TO_ROOT)/stages/localdev

# DEV_CONTAINERS-mysql-dsn-from-outside
$(call shell-dir-target-vars,$(APISVR_DEV_PATH_TO_CONTAINERS),DEV_CONTAINERS-,mysql-dsn-from-outside)

APISVR_DEV_VARS?=$(APISVR_ENV_VARS)
APISVR_DEV_ENVS?=$(APISVR_ENVS_BASE) \
	LOG_LEVEL=debug \
	LOG_FORMAT=text \
	DB_DSN='$(DEV_CONTAINERS-mysql-dsn-from-outside)' \
	$(foreach var,$(APISVR_DEV_VARS),$(var)=$($(var)))

.PHONY: dev-containers-up
dev-containers-up:
	DEV_TARGET=apisvr $(MAKE) -C $(APISVR_DEV_PATH_TO_CONTAINERS) up

.PHONY: dev-containers-down
dev-containers-down:
	DEV_TARGET=apisvr $(MAKE) -C $(APISVR_DEV_PATH_TO_CONTAINERS) down

.PHONY: dev-run
dev-run:
	$(APISVR_DEV_ENVS) go run $(APISVR_DEV_TARGET_PACKAGE)

.PHONY: run
run: dev-run

.PHONY: dev
dev: dev-containers-up run
