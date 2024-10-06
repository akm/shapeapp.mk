include $(PATH_TO_SHAPEAPPMK)/components/atoms/golang/binary.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/golang/module.mk

BINARY_FILE=$(GOLANG_BINARY_PATH_FOR_STAGE_$(APP_STAGE_TYPE))
DOCKER_IMAGE_REPOSITORY=$(APP_BASE_NAME)-$(GOLANG_MODULE_NAME)
DOCKER_IMAGE_NAME?=$(DOCKER_IMAGE_REPOSITORY):$(APP_STAGE_TYPE)
include $(PATH_TO_SHAPEAPPMK)/components/atoms/docker/image.mk
