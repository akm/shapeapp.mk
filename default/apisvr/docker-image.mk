# Required variables:
# - PATH_TO_SHAPEAPPMK
# - BINARY_FILE (defined in golang/binary.mk)
#
# Optional variables:
# - DOCKER_IMAGE_BUILD_DEPS
# - DOCKER_IMAGE_BUILD_OPTS
#
# Included .mk files:
# - golang/docker-image.mk

DOCKER_IMAGE_BUILD_DEPS?=$(BINARY_FILE)
DOCKER_IMAGE_BUILD_OPTS?=\
	--build-arg APP_BIN_PATH=$(BINARY_FILE) \
	-f Dockerfile
include $(PATH_TO_SHAPEAPPMK)/components/organelles/golang/docker-image.mk
