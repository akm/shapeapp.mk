# Required:
#   GOOGLE_CLOUD_PROJECT: The Google Cloud project ID.
#   GCLOUD_ARTIFACTS_REPOSITORY_DOMAIN: The domain of the Google Cloud Artifact Registry repository.

.PHONY: gcloud-auth-configure-docker
gcloud-auth-configure-docker:
	gcloud --project $(GOOGLE_CLOUD_PROJECT) auth configure-docker $(GCLOUD_ARTIFACTS_REPOSITORY_DOMAIN)
