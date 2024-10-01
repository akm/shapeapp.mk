# Required Variables:
# - GOOGLE_CLOUD_PROJECT_LOCAL
# - APP_FIREBASE_API_KEY
# - APP_MYSQL_DB_NAME
# - APP_PORT_MYSQL_dev
# - MYSQL_HOST
# - PATH_TO_APISVR
# - PATH_TO_UISVR
# - PATH_TO_DBMIGRATIONS
#
# Optional Variables:
# - DEV_TARGET


include $(PATH_TO_SHAPEAPPMK)/components/atoms/docker-compose/base.mk
include $(PATH_TO_SHAPEAPPMK)/golang/build.mk

DEV_TARGET?=all

ifeq ("$(DEV_TARGET)","apisvr")
APP_MYSQL_DSN=$(mysql-dsn-from-outside)
else
APP_MYSQL_DSN=$(mysql-dsn-from-inside)
endif

DOCKER_COMPOSE_ENVS_BASE=\
	$(DEFAULT_PORT_ENVS) \
	APP_PORT_RPROXY=$(APP_PORT_RPROXY_dev) \
	APP_PORT_APISVR=$(APP_PORT_APISVR_dev) \
	APP_PORT_UISVR=$(APP_PORT_UISVR_e2e_test) \
	GOOGLE_CLOUD_PROJECT=$(GOOGLE_CLOUD_PROJECT_LOCAL) \
	APP_FIREBASE_API_KEY=$(APP_FIREBASE_API_KEY) \
	APP_MYSQL_DB_NAME=$(APP_MYSQL_DB_NAME) \
	APP_MYSQL_DSN='$(APP_MYSQL_DSN)' \
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

TARGET_SERVICES_FOR_DEV_apisvr=firebase-emulators mysql
TARGET_SERVICES_FOR_DEV_uisvr=$(TARGET_SERVICES_FOR_DEV_apisvr) apisvr
TARGET_SERVICES_FOR_DEV_rproxy=$(TARGET_SERVICES_FOR_DEV_uisvr) uisvr
TARGET_SERVICES_FOR_DEV_all=$(TARGET_SERVICES_FOR_DEV_rproxy) rproxy
DOCKER_COMPOSE_TARGET_SERVICES=$(TARGET_SERVICES_FOR_DEV_$(DEV_TARGET))

ifneq "$(sort $(TARGET_SERVICES_FOR_DEV_all))" "$(sort $(DOCKER_COMPOSE_SERVICES_ALL))"
$(error "services are invalid")
endif

# apisvr-golang-binary-build-for-stage-local
apisvr-%:
	$(MAKE) -C $(PATH_TO_APISVR) $*

# uisvr-setup
uisvr-%:
	$(MAKE) -C $(PATH_TO_UISVR) $*

SETUP_DEPS_FOR_DEV_apisvr=
SETUP_DEPS_FOR_DEV_uisvr=apisvr-golang-binary-build-for-stage-local $(APP_UISVR_DOT_ENV_PATH)
SETUP_DEPS_FOR_DEV_rproxy=$(SETUP_DEPS_FOR_DEV_uisvr) uisvr-setup $(APP_RPROXY_ENVOY_YAML)
SETUP_DEPS_FOR_DEV_all=$(SETUP_DEPS_FOR_DEV_rproxy)
SETUP_DEPS=$(SETUP_DEPS_FOR_DEV_$(DEV_TARGET))

.PHONY: setup
setup: $(SETUP_DEPS)

.PHONY: run
run: setup docker-compose-up
.PHONY: up
up: setup docker-compose-upd
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


MYSQL_USER_NAME?=root
MYSQL_USER_PASSWORD?=
MYSQL_HOST?=mysql
MYSQL_PORT?=$(APP_PORT_MYSQL_dev)
MYSQL_DB_NAME?=$(APP_MYSQL_DB_NAME)

include $(PATH_TO_SHAPEAPPMK)/mysql/default.mk

.PHONY: dbmigration-up
dbmigration-up:
	GOOSE_DSN='$(mysql-dsn-from-outside)' \
	$(MAKE) -C $(PATH_TO_DBMIGRATIONS) up
