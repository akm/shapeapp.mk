GRPCURL_CLI_VERSION?=latest
GRPCURL_CLI_MODULE=github.com/fullstorydev/grpcurl/cmd/grpcurl
GRPCURL_CLI?=$(call golang-tool-bin-path,$(GRPCURL_CLI_MODULE))
$(GRPCURL_CLI):
	$(call golang-tool-cli-install-with-prefix,GRPCURL)
