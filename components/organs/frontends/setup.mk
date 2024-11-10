UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	@echo "1. Run 'cd frontends && npx sv create $(UISVR)'"
	@echo "2. Run 'make -C frontends $(UISVR)-setup'"

.PHONY: $(UISVR)-setup
$(UISVR)-setup: $(UISVR)
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-templates --output-directory $(UISVR)
	$(MAKE) -C $(UISVR) npm-install connect-web-install connect-node-install
	cd $(PATH_TO_UISVR) && npm install dotenv && npm install -D @sveltejs/adapter-node
	@cat $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-instruction.txt

# dotenv is required to run on nodejs.
# See https://svelte.dev/docs/kit/adapter-node for more information.
