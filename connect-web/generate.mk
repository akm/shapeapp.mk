# Required variables:
# - CONNECT_WEB_PATH_TO_PROTO

CONNECT_WEB_PROTO_FILES=$(shell find $(CONNECT_WEB_PATH_TO_PROTO) -name '*.proto')

.PHONY: connect-web-generate
connect-web-generate:
	npx buf generate $(CONNECT_WEB_PROTO_FILES)
