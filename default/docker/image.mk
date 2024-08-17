# Requires:
# - DOCKER_IMAGE_REPOSITORY
#
# Options:
# - DOCKER_IMAGE_BUILD_OPTS
#
# Required target:
# - build
#
# Don't include the following:
# - include $(PATH_TO_SHAPEAPPMK)/git/current.mk
# - include $(PATH_TO_SHAPEAPPMK)/docker/image.mk
# - include $(PATH_TO_SHAPEAPPMK)/docker/image-push.mk

include $(PATH_TO_SHAPEAPPMK)/git/current.mk

DOCKER_IMAGE_NAME_COMMIT_HASH=$(DOCKER_IMAGE_REPOSITORY):$(GIT_CURRENT_COMMIT_HASH_SHORT)
DOCKER_IMAGE_NAME?=$(DOCKER_IMAGE_REPOSITORY):$(APP_STAGE_TYPE)

include $(PATH_TO_SHAPEAPPMK)/docker/image.mk
include $(PATH_TO_SHAPEAPPMK)/docker/image-push.mk

.PHONY: push
push: build docker-image-push

