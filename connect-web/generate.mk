# Required variables:
# - CONNECT_WEB_PATH_TO_PROTO

.PHONY: connect-web-generate
connect-web-generate:
ifdef GITHUB_ACTIONS
	npx buf generate $(CONNECT_WEB_PATH_TO_PROTO)/**/*.proto
else
	$$SHELL -c 'npx buf generate $(CONNECT_WEB_PATH_TO_PROTO)/**/*.proto'
endif
# make can't treat asterisk as a wildcard, so we need to use shell to expand it
