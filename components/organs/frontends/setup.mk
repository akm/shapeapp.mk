UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	npm create svelte@latest $(UISVR)
	$(MAKE) -C uisvr npm-install
	$(TEXT_TEMPLATE_CLI) $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/uisvr-templates --output-directory $(UISVR)
	$(MAKE) -C uisvr connect-web-install
