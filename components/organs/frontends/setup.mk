UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	@echo "1. Run 'npx sv create $(UISVR)'"
	@echo "2. Run 'make -C frontends $(UISVR)-setup'"

.PHONY: $(UISVR)-setup
$(UISVR)-setup: $(UISVR)
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-templates --output-directory $(UISVR)
	$(MAKE) -C $(UISVR) npm-install connect-web-install connect-node-install
	@cat $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-instruction.txt
