UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	npx sv create $(UISVR)
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-templates --output-directory $(UISVR)
	$(MAKE) -C $(UISVR) npm-install connect-web-install connect-node-install
	@cat $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-instruction.txt
