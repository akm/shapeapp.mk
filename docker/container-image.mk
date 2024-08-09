# Requires:
# - DOCKER_CONTAINER_IMAGE_NAME
# - DOCKER_CONTAINER_IMAGE_TAG
#
# Options:
# - DOCKER_CONTAINER_IMAGE_BUILD_DEPS
# - DOCKER_CONTAINER_IMAGE_BUILD_OPTS: Default: -f Dockerfile

DOCKER_CONTAINER_IMAGE_BUILD_DEPS?=
DOCKER_CONTAINER_IMAGE_BUILD_OPTS?=-f Dockerfile

.PHONY: docker-container-image-name
docker-container-image-name:
	@echo $(DOCKER_CONTAINER_IMAGE_NAME)

.PHONY: docker-container-image-build
docker-container-image-build: $(DOCKER_CONTAINER_IMAGE_BUILD_DEPS)
	docker build \
		-t $(DOCKER_CONTAINER_IMAGE_TAG) \
		$(DOCKER_CONTAINER_IMAGE_BUILD_OPTS) \
		.
