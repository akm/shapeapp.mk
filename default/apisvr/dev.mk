# Required variables:
#   - APISVR_DEV_PATH_TO_CONTAINERS
#   - APISVR_DEV_TARGET_PACKAGE
#
# Optional variables:
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

# DEV_CONTAINERS-mysql-dsn
$(call shell-dir-target-vars,DEV_CONTAINERS-,$(APISVR_DEV_PATH_TO_CONTAINERS),mysql-dsn)

APISVR_DEV_VARS?=$(APISVR_ENV_VARS)
APISVR_DEV_ENVS?=$(APISVR_ENVS_BASE) \
	DB_DSN='$(DEV_CONTAINERS-mysql-dsn)' \
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
