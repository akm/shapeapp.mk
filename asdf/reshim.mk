.PHONY: asdf-reshim
asdf-reshim:
ifdef GITHUB_ACTION
	@echo "SKIP asdf reshim"
else
	asdf reshim
endif
