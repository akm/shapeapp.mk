TEXT_TEMPLATE_CLI_VERSION?=latest
TEXT_TEMPLATE_CLI?=$(shell go env GOPATH)/bin/text-template-cli
$(TEXT_TEMPLATE_CLI):
	CLI_VERSION=$(TEXT_TEMPLATE_CLI_VERSION) \
	CLI_MODULE=github.com/akm/text-template-cli \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/golang/tool cli-install
