# Requires:
# - GCLOUD
# - GCP_REGION
# - GOOGLE_CLOUD_PROJECT
# - GOOGLE_CLOUD_RUN_SERVICE_NAME
#
# Options:
# - GOOGLE_CLOUD_RUN_DEPLOY_DEPS
# - GOOGLE_CLOUD_RUN_DEPLOY_OPTS
# - GOOGLE_CLOUD_RUN_UPDATE_TRAFFIC_OPTS

ifeq ($(GOOGLE_CLOUD_PROJECT),)
.PHONY: deploy
deploy:
	@echo "GOOGLE_CLOUD_PROJECT is not set. Please set GOOGLE_CLOUD_PROJECT to deploy to GCP."
else
.PHONY: deploy
deploy: $(GOOGLE_CLOUD_RUN_DEPLOY_DEPS)
	$(GCLOUD) run deploy $(GOOGLE_CLOUD_RUN_SERVICE_NAME) $(GOOGLE_CLOUD_RUN_DEPLOY_OPTS)
endif

.PHONY: update-traffic
update-traffic:
	$(GCLOUD) run services update-traffic $(GOOGLE_CLOUD_RUN_SERVICE_NAME) \
		$(GOOGLE_CLOUD_RUN_UPDATE_TRAFFIC_OPTS)

.PHONY: inspect_service
inspect_service:
	$(GCLOUD) run services describe $(GOOGLE_CLOUD_RUN_SERVICE_NAME) --region=$(GCP_REGION)

GOOGLE_CLOUD_RUN_SERVICE_URL=$(shell $(GCLOUD) run services describe $(GOOGLE_CLOUD_RUN_SERVICE_NAME) --region=$(GCP_REGION) --format='value(status.url)' )
.PHONY: service_url
service_url:
	@echo $(GOOGLE_CLOUD_RUN_SERVICE_URL)

GOOGLE_CLOUD_RUN_SERVICE_DOMAIN=$(shell echo $(GOOGLE_CLOUD_RUN_SERVICE_URL) | sed -e 's/https:\/\///' | sed -e 's/\/.*//')
.PHONY: service_domain
service_domain:
	@echo $(GOOGLE_CLOUD_RUN_SERVICE_DOMAIN)
