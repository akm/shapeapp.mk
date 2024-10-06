UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	npm create svelte@latest $(UISVR)
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-templates --output-directory $(UISVR)
	cd $(UISVR) && npm install
	$(MAKE) -C $(UISVR) connect-web-install connect-node-install
