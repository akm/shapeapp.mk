TEXT_TEMPLATE_CLI_VERSION?=latest
TEXT_TEMPLATE_CLI_MODULE=github.com/akm/text-template-cli
TEXT_TEMPLATE_CLI?=$(call golang-tool-bin-path,$(TEXT_TEMPLATE_CLI_MODULE))
$(TEXT_TEMPLATE_CLI):
	$(call golang-tool-cli-install-with-prefix,TEXT_TEMPLATE)
