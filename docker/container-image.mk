# Requires:
# - DOCKER_IMAGE_NAME
# - DOCKER_IMAGE_TAG
#
# Options:
# - DOCKER_IMAGE_BUILD_DEPS
# - DOCKER_IMAGE_BUILD_OPTS: Default: -f Dockerfile

DOCKER_IMAGE_BUILD_DEPS?=
DOCKER_IMAGE_BUILD_OPTS?=-f Dockerfile

.PHONY: docker-container-image-name
docker-container-image-name:
	@echo $(DOCKER_IMAGE_NAME)

.PHONY: docker-container-image-build
docker-container-image-build: $(DOCKER_IMAGE_BUILD_DEPS)
	docker build \
		-t $(DOCKER_IMAGE_TAG) \
		$(DOCKER_IMAGE_BUILD_OPTS) \
		.
