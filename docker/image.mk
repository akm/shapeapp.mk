# Requires:
# - DOCKER_IMAGE_REPOSITORY
# - DOCKER_IMAGE_TAG
#
# Options:
# - DOCKER_IMAGE_BUILD_DEPS
# - DOCKER_IMAGE_BUILD_OPTS: Default: -f Dockerfile

DOCKER_IMAGE_BUILD_DEPS?=
DOCKER_IMAGE_BUILD_OPTS?=-f Dockerfile

.PHONY: docker-image-name
docker-image-name:
	@echo $(DOCKER_IMAGE_REPOSITORY)

.PHONY: docker-image-build
docker-image-build: $(DOCKER_IMAGE_BUILD_DEPS)
	docker build \
		-t $(DOCKER_IMAGE_TAG) \
		$(DOCKER_IMAGE_BUILD_OPTS) \
		.
