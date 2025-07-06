# Required variables:
# - PATH_TO_SHAPEAPPMK
# - APP_BASE_NAME
# - APP_STAGE_TYPE
# - TEXT_TEMPLATE_CLI
#
# Optional variables:
# - CONFIG_ENVS
# - DEFAULT_PORT_ENVS
# - DOCKER_IMAGE_REPOSITORY
# - DOCKER_IMAGE_NAME

.PHONY: install
install: npm-install connect-web-install connect-node-install

.PHONY: setup
setup: npm-ci

.env: $(TEXT_TEMPLATE_CLI)
	$(CONFIG_ENVS) $(DEFAULT_PORT_ENVS) $(TEXT_TEMPLATE_CLI) .env-template > .env

# build ディレクトリを生成
build: npm-run-build

DOCKER_IMAGE_BUILD_DEPS+=build

# dev-containers-up
# dev-containers-down
dev-containers-%:
	DEV_TARGET=uisvr $(MAKE) -C $(PATH_TO_ROOT)/stages/localdev $*

.PHONY: dev-run
dev-run: setup .env npm-run-dev

.PHONY: dev
dev: dev-containers-up dev-run

include $(PATH_TO_SHAPEAPPMK)/components/atoms/git/check.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/sveltekit/npm.mk
include $(PATH_TO_SHAPEAPPMK)/components/atoms/sveltekit/app.mk

include $(PATH_TO_SHAPEAPPMK)/components/atoms/connect-web/install.mk
CONNECT_WEB_PATH_TO_PROTO=$(PATH_TO_PROTO)
include $(PATH_TO_SHAPEAPPMK)/components/atoms/connect-web/generate.mk

include $(PATH_TO_SHAPEAPPMK)/components/atoms/connect-node/install.mk

.PHONY: generate
generate: connect-web-generate npm-run-format

DOCKER_IMAGE_REPOSITORY?=$(APP_BASE_NAME)-uisvr
DOCKER_IMAGE_NAME?=$(DOCKER_IMAGE_REPOSITORY):$(APP_STAGE_TYPE)
include $(PATH_TO_SHAPEAPPMK)/components/atoms/docker/image.mk

.PHONY: test
test: npm-run-test
