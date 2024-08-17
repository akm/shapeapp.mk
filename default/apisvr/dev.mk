# Requires:
#   - PATH_TO_DEV_CONTAINERS
#   - PATH_TO_DEV_RUN_PACKAGE
#
# Options:
#   - DEV_TARGET
#   - DEV_ENVS

DEV_TARGET?=apisvr

.PHONY: dev-containers-up
dev-containers-up:
	DEV_TARGET=apisvr $(MAKE) -C $(PATH_TO_DEV_CONTAINERS) up

.PHONY: dev-containers-down
dev-containers-down:
	DEV_TARGET=apisvr $(MAKE) -C $(PATH_TO_DEV_CONTAINERS) down

.PHONY: dev-run
dev-run:
	$(DEV_ENVS) go run $(PATH_TO_DEV_RUN_PACKAGE)
