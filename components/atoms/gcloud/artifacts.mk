# Required:
#   GOOGLE_CLOUD_PROJECT: The Google Cloud project ID.
#   GOOGLE_CLOUD_REGION: The region where the repository will be created.
#   MODULE_NAME: The name of the module or application.
#
# Optional:
#   REPOSITORY_FORMAT: The format of the repository (default is 'docker').
#   REPOSITORY_NAME: The name of the repository (default is $(MODULE_NAME))

REPOSITORY_FORMAT?=docker
REPOSITORY_NAME?=$(MODULE_NAME)

GCLOUD_ARTIFACTS_REPOSITORIES=gcloud --project $(GOOGLE_CLOUD_PROJECT) artifacts repositories

# https://cloud.google.com/run/docs/building/containers?hl=ja#docker
# https://cloud.google.com/sdk/gcloud/reference/artifacts/repositories/create
.PHONY: gcloud-artifacts-repository-create
gcloud-artifacts-repository-create:
	$(GCLOUD_ARTIFACTS_REPOSITORIES) create $(REPOSITORY_NAME) \
        --repository-format=$(REPOSITORY_FORMAT) \
        --location=$(GOOGLE_CLOUD_REGION) \
        --description="DESCRIPTION" \
        --immutable-tags

# gcloud artifacts repositories delete
.PHONY: gcloud-artifacts-repository-delete
gcloud-artifacts-repository-delete:
	$(GCLOUD_ARTIFACTS_REPOSITORIES) delete $(REPOSITORY_NAME) \
		--location=$(GOOGLE_CLOUD_REGION) \
		--quiet

.PHONY: gcloud-artifacts-repository-up
gcloud-artifacts-repository-up:
	( $(GCLOUD_ARTIFACTS_REPOSITORIES) list --format json --location=$(GOOGLE_CLOUD_REGION) | grep $(REPOSITORY_NAME) ) && \
	echo "Repository $(REPOSITORY_NAME) is already up" || \
	$(MAKE) gcloud-artifacts-repository-create

.PHONY: gcloud-artifacts-repository-down
gcloud-artifacts-repository-down:
	( $(GCLOUD_ARTIFACTS_REPOSITORIES) list --format json --location=$(GOOGLE_CLOUD_REGION) | grep $(REPOSITORY_NAME) ) && \
	$(MAKE) gcloud-artifacts-repository-delete || \
	echo "Repository $(REPOSITORY_NAME) is already down or does not exist."
