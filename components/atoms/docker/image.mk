# Requires:
# - DOCKER_IMAGE_REPOSITORY
# - DOCKER_IMAGE_NAME
#
# Options:
# - DOCKER_IMAGE_BUILD_DEPS
# - DOCKER_IMAGE_BUILD_OPTS: Default: -f Dockerfile
# - DOCKER_IMAGE_PLATFORM: Default: linux/amd64


DOCKER_IMAGE_BUILD_DEPS?=
DOCKER_IMAGE_BUILD_OPTS?=-f Dockerfile
DOCKER_IMAGE_PLATFORM?=linux/amd64

.PHONY: docker-image-name
docker-image-name:
	@echo $(DOCKER_IMAGE_REPOSITORY)

.PHONY: docker-image-build
docker-image-build: $(DOCKER_IMAGE_BUILD_DEPS)
	docker build \
		-t $(DOCKER_IMAGE_NAME) \
		$(DOCKER_IMAGE_BUILD_OPTS) \
		.

.PHONY: docker-image-buildx
docker-image-buildx: $(DOCKER_IMAGE_BUILD_DEPS)
	docker buildx build \
		--platform $(DOCKER_IMAGE_PLATFORM) \
		-t $(DOCKER_IMAGE_NAME) \
		$(DOCKER_IMAGE_BUILD_OPTS) \
		.
