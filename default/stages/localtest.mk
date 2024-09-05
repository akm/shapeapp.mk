# Required Variables:
# - GOOGLE_CLOUD_PROJECT_LOCAL
# - APP_FIREBASE_API_KEY
# - APP_MYSQL_DB_NAME
# - APP_PORT_MYSQL_e2e_test
# - MYSQL_HOST
# - MYSQL_DSN
# - PATH_TO_APISVR
# - PATH_TO_UISVR
# - PATH_TO_DBMIGRATIONS
#
# Optional Variables:
# - DEV_TARGET


include $(PATH_TO_SHAPEAPPMK)/docker-compose/base.mk
include $(PATH_TO_SHAPEAPPMK)/golang/build.mk

DEV_TARGET?=all

DOCKER_COMPOSE_ENVS_BASE=\
	$(DEFAULT_PORT_ENVS) \
	GOOGLE_CLOUD_PROJECT=$(GOOGLE_CLOUD_PROJECT_LOCAL) \
	APP_FIREBASE_API_KEY=$(APP_FIREBASE_API_KEY) \
	APP_MYSQL_DB_NAME=$(APP_MYSQL_DB_NAME) \
	APP_MYSQL_DSN='$(shell $(MAKE) mysql-dsn)' \
	APP_BINARY_PATH_IN_APISVR=$(shell $(MAKE) -C $(PATH_TO_APISVR) --no-print-directory golang-binary-path-for-stage-local) \
	DEV_TARGET=$(DEV_TARGET)

APP_UISVR_DOT_ENV_PATH=./uisvr.env
$(APP_UISVR_DOT_ENV_PATH): $(TEXT_TEMPLATE_CLI)
	$(DOCKER_COMPOSE_ENVS_BASE) $(TEXT_TEMPLATE_CLI) ./uisvr.env.template > $@

APP_RPROXY_ENVOY_YAML_TEMPLATE=$(PATH_TO_MIDDLEWARES)/rproxy/local/envoy.yaml.template
APP_RPROXY_ENVOY_YAML=./envoy.yaml
$(APP_RPROXY_ENVOY_YAML): $(TEXT_TEMPLATE_CLI)
	$(DOCKER_COMPOSE_ENVS_BASE) $(TEXT_TEMPLATE_CLI) $(APP_RPROXY_ENVOY_YAML_TEMPLATE) > $@

DOCKER_COMPOSE_ENVS=\
	$(DOCKER_COMPOSE_ENVS_BASE) \
	APP_UISVR_DOT_ENV=$(APP_UISVR_DOT_ENV_PATH) \
	APP_RPROXY_ENVOY_YAML=$(APP_RPROXY_ENVOY_YAML)

# apisvr-golang-binary-build-for-stage-local
apisvr-%:
	$(MAKE) -C $(PATH_TO_APISVR) $*

# uisvr-setup
uisvr-%:
	$(MAKE) -C $(PATH_TO_UISVR) $*

.PHONY: setup
setup: apisvr-golang-binary-build-for-stage-local uisvr-setup

.PHONY: run
run: setup docker-compose-up
.PHONY: up
up: setup docker-compose-upd mysql-wait dbmigration-up
.PHONY: down
down: docker-compose-down
.PHONY: rmi
rmi: docker-compose-rmi
.PHONY: build
build: setup docker-compose-build
.PHONY: rebuild
rebuild: 
	$(MAKE) rmi || true
	$(MAKE) build

MYSQL_ENVS=\
	MYSQL_USER_NAME=root \
	MYSQL_USER_PASSWORD= \
	MYSQL_HOST=127.0.0.1 \
	MYSQL_PORT=$(APP_PORT_MYSQL_e2e_test) \
	MYSQL_DB_NAME=$(APP_MYSQL_DB_NAME)

include $(PATH_TO_SHAPEAPPMK)/mysql/base.mk

.PHONY: dbmigration-up
dbmigration-up:
	GOOSE_DSN='$(MYSQL_DSN)' \
	$(MAKE) -C $(PATH_TO_DBMIGRATIONS) up
