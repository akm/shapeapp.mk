GRPCURL_CLI_VERSION?=latest
GRPCURL_CLI?=$(shell go env GOPATH)/bin/grpcurl
$(GRPCURL_CLI):
	CLI_VERSION=$(GRPCURL_CLI_VERSION) \
	CLI_MODULE=github.com/fullstorydev/grpcurl/cmd/grpcurl \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install
