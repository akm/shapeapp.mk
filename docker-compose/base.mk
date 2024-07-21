DOCKER_COMPOSE_YAML_PATH?=docker-compose.yml
DOCKER_COMPOSE_NAME=$(shell cat $(DOCKER_COMPOSE_YAML_PATH) | yq .name)
DOCKER_COMPOSE_SERVICES_ALL=$(shell cat $(DOCKER_COMPOSE_YAML_PATH) | yq '.services | keys | join(" ")')
DOCKER_COMPOSE_OPTS?=-f $(DOCKER_COMPOSE_YAML_PATH) 

DOCKER_COMPOSE_TARGET_SERVICES?=

.PHONY: docker-compose-run
docker-compose-run:
	$(DOCKER_COMPOSE_ENVS) docker compose $(DOCKER_COMPOSE_OPTS) up $(DOCKER_COMPOSE_TARGET_SERVICES)

.PHONY: docker-compose-up
docker-compose-up:
	$(DOCKER_COMPOSE_ENVS) docker compose $(DOCKER_COMPOSE_OPTS) up -d $(DOCKER_COMPOSE_TARGET_SERVICES)

.PHONY: docker-compose-down
docker-compose-down:
	$(DOCKER_COMPOSE_ENVS) docker compose $(DOCKER_COMPOSE_OPTS) down $(DOCKER_COMPOSE_TARGET_SERVICES)

.PHONY: docker-compose-build
docker-compose-build:
	$(DOCKER_COMPOSE_ENVS) docker compose build

.PHONY: docker-compose-rmi
docker-compose-rmi: docker-compose-down
	for service in $(DOCKER_COMPOSE_SERVICES_ALL); do \
		$(DOCKER_COMPOSE_ENVS) docker rmi $(DOCKER_COMPOSE_NAME)-$$service:latest; \
	done

.PHONY: docker-compose-rebuild
docker-compose-rebuild:
	$(DOCKER_COMPOSE_ENVS) $(MAKE) docker-compose-rmi; \
	$(DOCKER_COMPOSE_ENVS) $(MAKE) docker-compose-build
