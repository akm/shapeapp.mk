# Required variables:
# - CONNECT_WEB_PATH_TO_PROTO

.PHONY: connect-web-generate
connect-web-generate:
	npx buf generate $(CONNECT_WEB_PATH_TO_PROTO)
