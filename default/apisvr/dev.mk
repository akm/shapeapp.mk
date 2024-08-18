# Requires:
#   - APISVR_DEV_PATH_TO_CONTAINERS
#   - APISVR_DEV_TARGET_PACKAGE
#
# Options:
#   - DEV_TARGET
#   - DEV_ENVS

DEV_TARGET?=apisvr

.PHONY: dev-containers-up
dev-containers-up:
	DEV_TARGET=apisvr $(MAKE) -C $(APISVR_DEV_PATH_TO_CONTAINERS) up

.PHONY: dev-containers-down
dev-containers-down:
	DEV_TARGET=apisvr $(MAKE) -C $(APISVR_DEV_PATH_TO_CONTAINERS) down

.PHONY: dev-run
dev-run:
	$(DEV_ENVS) go run $(APISVR_DEV_TARGET_PACKAGE)
