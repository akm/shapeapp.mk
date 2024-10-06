UISVR=uisvr

# https://kit.svelte.jp/docs/creating-a-project
$(UISVR):
	npm create svelte@latest $(UISVR)
	cd $(UISVR)
	npm install
	$(MAKE) $(UISVR)/Makefile

$(UISVR)/Makefile:
	cp $(PATH_TO_SHAPEAPPMK)/components/organs/frontends/templates/uisvr-Makefile.mk $(UISVR)/Makefile
