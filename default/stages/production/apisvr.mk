# Required Variables:
# - GOOGLE_CLOUD_PROJECT
# - APP_FIREBASE_API_KEY
# - PATH_TO_APISVR
# - PATH_TO_SHAPEAPPMK
# - DEPLOY_OPTIONS_BASE


# apisvr-golang-binary-build-for-stage-production
# apisvr-docker-image-build
apisvr-%:
	$(MAKE) -C $(PATH_TO_APISVR) $*

.PHONY: build
build: \
	apisvr-golang-binary-build-for-stage-production \
	apisvr-docker-image-build

DOCKER_IMAGE_REPOSITORY=$(shell $(MAKE) -C $(PATH_TO_APISVR) --no-print-directory docker-image-name)
DOCKER_IMAGE_BUILD_OPTS=\
	--platform linux/amd64 \
	--build-arg APP_BIN_PATH=$(shell $(MAKE) golang-binary-path-for-stage-production --no-print-directory) \
	-f Dockerfile
include $(PATH_TO_SHAPEAPPMK)/components/organelles/docker/image.mk

UISVR_ORIGIN=$(shell $(MAKE) -C ../uisvr --no-print-directory service_url 2>/dev/null || echo "")
.PHONY: uisvr_origin
uisvr_origin:
	@echo $(UISVR_ORIGIN)

ENV_VAR_YAML=./env-vars.yaml
$(ENV_VAR_YAML): $(TEXT_TEMPLATE_CLI)
	UISVR_ORIGIN=$(UISVR_ORIGIN) $(TEXT_TEMPLATE_CLI) $(ENV_VAR_YAML).tmpl > $(ENV_VAR_YAML)

ENV_VARS_CONTENT=$(shell yq '... comments=""' $(ENV_VAR_YAML))

.PHONY: deploy_options
deploy_options:
	@$(MAKE) env_vars_yaml_gen >&2 && \
	echo $(DEPLOY_OPTIONS_BASE) && \
	[ -n "$(ENV_VARS_CONTENT)" ] && echo "--env-vars-file=$(ENV_VAR_YAML)" || echo ""

GOOGLE_CLOUD_RUN_SERVICE_NAME=$(DOCKER_IMAGE_REPOSITORY)
GOOGLE_CLOUD_RUN_DEPLOY_OPTS=$(shell $(MAKE) deploy_options --no-print-directory)
GOOGLE_CLOUD_RUN_DEPLOY_DEPS=push
GOOGLE_CLOUD_RUN_UPDATE_TRAFFIC_OPTS=\
		--to-latest \
		--platform=managed \
		--region=$(GCP_REGION)
include $(PATH_TO_SHAPEAPPMK)/default/google-cloud/cloud-run.mk

.PHONY: test-connections
test-connections:
	SERVER_DOMAIN=$(GOOGLE_CLOUD_RUN_SERVICE_DOMAIN) $(MAKE) -C $(PATH_TO_APISVR) test-connections
