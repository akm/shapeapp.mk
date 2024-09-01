# Requires:
# include $(PATH_TO_SHAPEAPPMK)/text-template-cli/base.mk

SQLC_CLI_VERSION?=latest
SQLC_CLI_MODULE=github.com/sqlc-dev/sqlc/cmd/sqlc
SQLC_CLI?=$(call golang-tool-bin-path,$(SQLC_CLI_MODULE))
$(SQLC_CLI):
	$(call golang-tool-cli-install-with-prefix,SQLC)

SQLC_YAML_TEMPLATE=sqlc.yaml.tmpl
SQLC_YAML=sqlc.yaml
$(SQLC_YAML):
	$(MAKE) sqlc-yaml-gen

.PHONY: sqlc-yaml-gen
sqlc-yaml-gen: $(TEXT_TEMPLATE_CLI)
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/sqlc/$(SQLC_YAML_TEMPLATE) > $(SQLC_YAML)

.PHONY: sqlc-generate
sqlc-generate: $(SQLC_CLI) $(SQLC_YAML)
	$(SQLC_CLI) generate
